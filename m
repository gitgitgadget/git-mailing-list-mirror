Received: from smtp94.iad3b.emailsrvr.com (smtp94.iad3b.emailsrvr.com [146.20.161.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B16445FFC3
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574640; cv=none; b=Od+kw43PhO22Nwod2yaChk/AkUs/iRginoKocHx3QNK9kiHxlPwF+gTUXioCsNnjd2gsU7Sb+1Rr/1JWgl3IphouI1qN4NAkoX+NW4yqcv4wW2j/wpuhnYy+JrI/jrc0YGV/pkDUNaSeE0RoNeuDKHivkycGFL1Xu2nO8as06GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574640; c=relaxed/simple;
	bh=xOpGh1C14FkOz1QwnVA+jRNJTFhIb6IORjpCyR8FkSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kbws4pA/+ub64BsE+REIy65qAJu09QArwkHiIwcREVy9Bur3AapE7QiaONdUU0mxFQ+e8vKsXvO90llTVjPlumAhCu4nNIlOZxllddc2PcO/lsSOvtMvZAAeSDVK/SynQKAtj+yV7Gm35iQBl5YBboUfcYgPiH8W9BrmgMgzNWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=hb1GexGX; arc=none smtp.client-ip=146.20.161.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="hb1GexGX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791574219;
	bh=xOpGh1C14FkOz1QwnVA+jRNJTFhIb6IORjpCyR8FkSc=;
	h=From:To:Subject:Date:From;
	b=hb1GexGXpsa02NPhs6/Sz24PIFLpPhtFyd+6r40EToq35CVbiWwS5ykA1LqLeDTVx
	 sTPHF80UvDwnvE2WSch15ooq007C9qOcYTleMBhNt9NyHRYI35VdA2gwn43t3/yvnQ
	 d8jI3zOMmWmh0hxvwv8h3a26r+N9I4tNT5hO/C2I=
X-Auth-ID: jon@jonsimons.org
Received: by smtp4.relay.iad3b.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 784B120382;
	Fri,  9 Oct 2026 15:30:19 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH 00/15] push: speed up client-side refspec matching
Date: Fri,  9 Oct 2026 15:29:38 -0400
Message-ID: <20261009192953.81794-1-jon@jonsimons.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 523ad08c-aaf2-41d9-9ffc-58ea03a01763-1-1

This series speeds up client-side refspec matching in push, focused on
pushing lots of branch deletes to a server that advertises lots of refs
(100k in the benchmark below).

Before this series, a 'git push --dry-run' of 100 delete refspecs to a
server with 100k refs takes ~2.5s from an empty client and ~6.6s from a
mirror; using one --force-with-lease per refspec takes ~4.8s and ~8.9s
respectively.  After, the same pushes take ~0.15s to ~0.19s.

refname_match() is updated to reuse the existing match_parse_rule(),
and a few client-side linear ref traversals are converted to
strmap lookups in remote.c.

Guide to changes:

 - Commits are ordered to introduce failing tests for behavioral
   changes and bugfixes, before the code change that fixes them.

 - Prep refname_match() call sites for behavioral change of mkpath()
   removal, and introduce benchmark:

   (1) remote: validate --force-with-lease <refname> argument
   (2) t5516: demonstrate push with "./"-prefixed source
   (3) t5510: document fetch with "./"-prefixed branch.<name>.merge
   (4) t/perf: add explicit delete refspec matching test

 - The first speedup, best viewed with `--color-moved`, is where
   refname_match() changes behavior: mkpath() stripped a leading "./"
   from the name being matched, so "./refs/heads/foo" used to match
   "refs/heads/foo".  It no longer does.

   (5) refs: stop using mkpath() in refname_match()

 - The next speedup establishes the conversion pattern of using
   expand_ref_prefix() with strmap lookups (the same pattern is used
   in two more spots that follow):

   (6) remote: use strmap for check_push_refs()

 - Fix a long-standing buglet where pushing two refspecs with the same
   destination to an empty remote is not rejected client-side, as it is
   when the remote has any ref.

   t5408 and t5410 now cover server-side duplicate rejection and
   send-pack's handling of a ref reported twice, without relying
   on the client missing the duplicates.

   Fixing this separately keeps the behavior change out of the strmap
   conversion that immediately follows, which would otherwise fix it
   as a side-effect:

   (7) t5516: test pushing two refspecs creating the same new branch
   (8) t5408, t5410: test duplicate updates without relying on the client
   (9) t5408: check refspec order with distinct destinations
   (10) t5408: expect client-side error for duplicate destinations
   (11) remote: reject duplicate destinations on an empty remote

 - Convert match_explicit_refs():

   (12) remote: use strmap for match_explicit_refs()

 - Measure and convert --force-with-lease paths:

   (13) t/perf: measure --force-with-lease in p5516
   (14) remote: restructure apply_push_cas() loops
   (15) remote: use strmap for apply_push_cas()

Numbers:

A new benchmark demonstrates each performance change.  These numbers
were gathered running the final form of p5516 against the earlier
trees on my machine:

  BASELINE             origin/master
  REFNAME_MATCH        (5)  refs: stop using mkpath() in refname_match()
  MAP_CHECK_PUSH_REFS  (6)  remote: use strmap for check_push_refs()
  MAP_EXPLICIT_REFS    (12) remote: use strmap for match_explicit_refs()
  MAP_APPLY_PUSH_CAS   (15) remote: use strmap for apply_push_cas()

  Test                           BASELINE          REFNAME_MATCH            MAP_CHECK_PUSH_REFS      MAP_EXPLICIT_REFS        MAP_APPLY_PUSH_CAS
  --------------------------------------------------------------------------------------------------------------------------------------------------
  5516.3: empty:refspecs:1       0.16(0.09+0.11)   0.14(0.07+0.11) -12.5%   0.14(0.07+0.11) -12.5%   0.14(0.07+0.11) -12.5%   0.14(0.08+0.11) -12.5%
  5516.5: empty:refspecs:10      0.37(0.30+0.11)   0.17(0.10+0.11) -54.1%   0.17(0.11+0.11) -54.1%   0.13(0.07+0.11) -64.9%   0.14(0.07+0.11) -62.2%
  5516.7: empty:refspecs:100     2.48(2.41+0.11)   0.49(0.43+0.11) -80.2%   0.47(0.40+0.11) -81.0%   0.15(0.08+0.11) -94.0%   0.15(0.09+0.11) -94.0%
  5516.9: mirror:refspecs:1      0.22(0.15+0.11)   0.16(0.09+0.11) -27.3%   0.16(0.09+0.11) -27.3%   0.16(0.09+0.11) -27.3%   0.17(0.10+0.11) -22.7%
  5516.11: mirror:refspecs:10    0.81(0.74+0.11)   0.26(0.19+0.11) -67.9%   0.23(0.16+0.11) -71.6%   0.16(0.09+0.11) -80.2%   0.17(0.10+0.12) -79.0%
  5516.13: mirror:refspecs:100   6.64(6.57+0.12)   1.21(1.13+0.12) -81.8%   0.86(0.79+0.12) -87.0%   0.18(0.11+0.11) -97.3%   0.18(0.11+0.11) -97.3%
  5516.16: empty:lease:1         0.17(0.11+0.11)   0.14(0.07+0.11) -17.6%   0.14(0.07+0.11) -17.6%   0.14(0.07+0.11) -17.6%   0.15(0.08+0.11) -11.8%
  5516.19: empty:lease:10        0.71(0.65+0.11)   0.20(0.14+0.11) -71.8%   0.20(0.13+0.11) -71.8%   0.17(0.10+0.11) -76.1%   0.15(0.08+0.11) -78.9%
  5516.22: empty:lease:100       4.79(4.71+0.12)   0.78(0.71+0.12) -83.7%   0.80(0.73+0.12) -83.3%   0.45(0.38+0.11) -90.6%   0.16(0.09+0.11) -96.7%
  5516.25: mirror:lease:1        0.24(0.17+0.11)   0.17(0.10+0.11) -29.2%   0.17(0.10+0.12) -29.2%   0.17(0.10+0.12) -29.2%   0.18(0.11+0.12) -25.0%
  5516.28: mirror:lease:10       1.04(0.97+0.11)   0.29(0.22+0.11) -72.1%   0.26(0.19+0.12) -75.0%   0.20(0.13+0.11) -80.8%   0.18(0.11+0.12) -82.7%
  5516.31: mirror:lease:100      8.93(8.85+0.12)   1.47(1.40+0.12) -83.5%   1.11(1.04+0.12) -87.6%   0.49(0.42+0.12) -94.5%   0.19(0.12+0.12) -97.9%

Jon Simons (15):
  remote: validate --force-with-lease <refname> argument
  t5516: demonstrate push with "./"-prefixed source
  t5510: document fetch with "./"-prefixed branch.<name>.merge
  t/perf: add explicit delete refspec matching test
  refs: stop using mkpath() in refname_match()
  remote: use strmap for check_push_refs()
  t5516: test pushing two refspecs creating the same new branch
  t5408, t5410: test duplicate updates without relying on the client
  t5408: check refspec order with distinct destinations
  t5408: expect client-side error for duplicate destinations
  remote: reject duplicate destinations on an empty remote
  remote: use strmap for match_explicit_refs()
  t/perf: measure --force-with-lease in p5516
  remote: restructure apply_push_cas() loops
  remote: use strmap for apply_push_cas()

 refs.c                              |  88 +++++-----
 remote.c                            | 257 +++++++++++++++++++---------
 t/perf/p5516-push-delete-refspec.sh |  67 ++++++++
 t/t5408-send-pack-stdin.sh          |  56 +++++-
 t/t5410-receive-pack.sh             |  35 ++++
 t/t5510-fetch.sh                    |  44 +++++
 t/t5516-fetch-push.sh               |  42 +++++
 t/t5533-push-cas.sh                 |   9 +
 8 files changed, 465 insertions(+), 133 deletions(-)
 create mode 100755 t/perf/p5516-push-delete-refspec.sh

-- 
2.55.0

