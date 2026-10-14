Received: from smtp115.iad3a.emailsrvr.com (smtp115.iad3a.emailsrvr.com [173.203.187.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317B43AA1BA
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 03:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791948112; cv=none; b=OmMomonXj5MWFTHyG4RqCc0sHQirKMBnRNMJ2ZgXBDqT4SnxJHlEC8kyugA9D5kulO7nGlL0sGeO56gozJ4kNweHsDiPAiTUmKJL+od2HVYn2+mW+qHCqgeCG+1wTscASBGnbDhIIoZpSK9hlIEhy1ZrCo10uBodZkhdJ0S1wyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791948112; c=relaxed/simple;
	bh=mfU5KzpoZlk2xcPhTl99M5eb0Wh+x+67LeHs1MLfNl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cE1ks8tHJkp+eKqYtKCjGAuUI1KpFDp+/1rV+Va8rYIigAgY6LgPj+kW5CcJTPws/HBk34+mZwwte3emgfdauGzAcuuDrHebb4WrXZBXPyAkCASOFv96lcoVOpI+rze/Dg+jlEmBbfeKvkfUiex7mrcVmkPNfx/DBpNr15WQvks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=incthD7U; arc=none smtp.client-ip=173.203.187.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="incthD7U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791947640;
	bh=mfU5KzpoZlk2xcPhTl99M5eb0Wh+x+67LeHs1MLfNl4=;
	h=From:To:Subject:Date:From;
	b=incthD7UIg1KjCCglMQzzeMlqMOwWdQnQY8BXhv5PYKTYvdxnXBWBU+u9WRLS97mB
	 VglQrCXNSAKgF6Susz8uVzNippRLgi9D03unODoSF2B4EIfEEDcp6l8D9g2c/RPWXL
	 W01c4ltr+QJ081x41pTMxrZHq93/luNr9fhcUOcQ=
X-Auth-ID: jon@jonsimons.org
Received: by smtp23.relay.iad3a.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 7A7642529B;
	Tue, 13 Oct 2026 23:14:00 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH v2 00/12] push: speed up client-side refspec matching
Date: Tue, 13 Oct 2026 23:13:35 -0400
Message-ID: <20261014031347.50433-1-jon@jonsimons.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009192953.81794-1-jon@jonsimons.org>
References: <20261009192953.81794-1-jon@jonsimons.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 20ae8d58-78b7-4215-81c6-d8119c94fa7d-1-1

This series speeds up client-side refspec matching in push, focused on
pushing lots of branch deletes to a server that advertises lots of refs
(100k in the benchmark below).

Before this series, a 'git push --dry-run' of 100 delete refspecs to a
server with 100k refs takes ~2.5s from an empty client and ~6.6s from a
mirror; using one --force-with-lease per refspec takes ~4.8s and ~8.9s
respectively.  After, the same pushes take ~0.15s to ~0.19s.

refname_match() is updated to reuse the existing match_parse_rule(),
and a few client-side linear ref traversals are converted to strmap
lookups in remote.c.

Updates for v2:

 - Commits introducing test_expect_failure have been squashed into
   the later commits that toggle them test_expect_success.

 - An existing memory leak is plugged in send-pack.  This was exposed
   in CI by the fix to reject duplicate destinations on empty remotes.

Guide to changes:

 - Prep refname_match() call sites for behavioral change of mkpath()
   removal, and introduce benchmark:

   (1) remote: validate --force-with-lease <refname> argument
   (2) t/perf: add explicit delete refspec matching test

 - The first speedup, best viewed with `--color-moved`, is where
   refname_match() changes behavior: mkpath() stripped a leading "./"
   from the name being matched, so "./refs/heads/foo" used to match
   "refs/heads/foo".  It no longer does.

   t5516 now asserts that pushing a "./"-prefixed source fails, and
   t5510 now asserts that a "./"-prefixed branch.<name>.merge is not
   matched on fetch.

   (3) refs: stop using mkpath() in refname_match()

 - The next speedup establishes the conversion pattern of using
   expand_ref_prefix() with strmap lookups (the same pattern is
   used in two more spots that follow):

   (4) remote: use strmap for check_push_refs()

 - Fix a long-standing buglet where pushing two refspecs with the same
   destination to an empty remote is not rejected client-side, as it is
   when the remote has any ref.

   Plug an existing leak in send-pack, exposed by the fix in CI.

   t5408 and t5410 now cover server-side duplicate rejection and
   send-pack's handling of a ref reported twice, without relying
   on the client missing the duplicates.

   Fixing this separately keeps the behavior change out of the strmap
   conversion that immediately follows, which would otherwise fix it
   as a side-effect.

   (5) send-pack: plug leak upon match_push_refs failure
   (6) t5408, t5410: test duplicate updates without relying on the client
   (7) t5408: check refspec order with distinct destinations
   (8) remote: reject duplicate destinations on an empty remote

 - Convert match_explicit_refs():

   (9) remote: use strmap for match_explicit_refs()

 - Measure and convert --force-with-lease paths:

   (10) t/perf: measure --force-with-lease in p5516
   (11) remote: restructure apply_push_cas() loops
   (12) remote: use strmap for apply_push_cas()

Numbers:

A new benchmark demonstrates each performance change.  These numbers
were gathered running the final form of p5516 against the earlier
trees on my machine:

  BASELINE             origin/master
  REFNAME_MATCH        (3)  refs: stop using mkpath() in refname_match()
  MAP_CHECK_PUSH_REFS  (4)  remote: use strmap for check_push_refs()
  MAP_EXPLICIT_REFS    (9)  remote: use strmap for match_explicit_refs()
  MAP_APPLY_PUSH_CAS   (12) remote: use strmap for apply_push_cas()

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

Jon Simons (12):
  remote: validate --force-with-lease <refname> argument
  t/perf: add explicit delete refspec matching test
  refs: stop using mkpath() in refname_match()
  remote: use strmap for check_push_refs()
  send-pack: plug leak upon match_push_refs failure
  t5408, t5410: test duplicate updates without relying on the client
  t5408: check refspec order with distinct destinations
  remote: reject duplicate destinations on an empty remote
  remote: use strmap for match_explicit_refs()
  t/perf: measure --force-with-lease in p5516
  remote: restructure apply_push_cas() loops
  remote: use strmap for apply_push_cas()

 builtin/send-pack.c                 |   3 +
 refs.c                              |  88 +++++-----
 remote.c                            | 257 +++++++++++++++++++---------
 t/perf/p5516-push-delete-refspec.sh |  67 ++++++++
 t/t5408-send-pack-stdin.sh          |  56 +++++-
 t/t5410-receive-pack.sh             |  35 ++++
 t/t5510-fetch.sh                    |  44 +++++
 t/t5516-fetch-push.sh               |  42 +++++
 t/t5533-push-cas.sh                 |   9 +
 9 files changed, 468 insertions(+), 133 deletions(-)
 create mode 100755 t/perf/p5516-push-delete-refspec.sh

Range-diff against v1:
 1:  ba72253d95 =  1:  3dc34a5fed remote: validate --force-with-lease <refname> argument
 2:  59d4f1a141 <  -:  ---------- t5516: demonstrate push with "./"-prefixed source
 4:  f553ee88f0 =  2:  501bd80a3c t/perf: add explicit delete refspec matching test
 5:  626d06f9aa !  3:  4726535be0 refs: stop using mkpath() in refname_match()
    @@ Commit message
              could silently canonicalize a syntactically bogus refname into a
              valid one."
     
    -    Tests in t5510 and t5516 that cover the aliasing behavior are toggled
    -    to test_expect_success.
    +    Tests are introduced for the observable behavior change:
    +
    +     - t5516 now asserts that pushing a "./"-prefixed source fails
    +
    +     - t5510 now asserts that fetch does not match a "./"-prefixed
    +       branch.<name>.merge value, either via the default fetch refspec
    +       or against the remote's advertised refs.
     
         Signed-off-by: Jon Simons <jon@jonsimons.org>
     
    @@ t/t5510-fetch.sh: test_expect_success 'LHS of refspec follows ref disambiguation
      	)
      '
      
    --test_expect_failure 'fetch with "./"-prefixed branch.<name>.merge does not mark any ref for merge' '
     +test_expect_success 'fetch with "./"-prefixed branch.<name>.merge does not mark any ref for merge' '
    - 	mkdir dotslash-merge-default-refspec &&
    - 	(
    - 		cd dotslash-merge-default-refspec &&
    -@@ t/t5510-fetch.sh: test_expect_failure 'fetch with "./"-prefixed branch.<name>.merge does not mark
    - 	)
    - '
    - 
    --test_expect_failure 'fetch protocol v0 with "./"-prefixed branch.<name>.merge does not match any remote ref' '
    ++	mkdir dotslash-merge-default-refspec &&
    ++	(
    ++		cd dotslash-merge-default-refspec &&
    ++		git init -b main server &&
    ++		test_commit -C server one &&
    ++		git -C server branch other &&
    ++		test_commit -C server two &&
    ++
    ++		# The bogus ./refs/heads/main should not match the remote refs/heads/main.
    ++		git clone server client &&
    ++		git -C client config branch.main.merge ./refs/heads/main &&
    ++		git -C client fetch &&
    ++		{
    ++			echo "$(git -C server rev-parse main)	not-for-merge" &&
    ++			echo "$(git -C server rev-parse other)	not-for-merge"
    ++		} >expect &&
    ++		cut -f -2 client/.git/FETCH_HEAD >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
     +test_expect_success 'fetch protocol v0 with "./"-prefixed branch.<name>.merge does not match any remote ref' '
    - 	mkdir dotslash-merge-fetch-protocol-v0 &&
    ++	mkdir dotslash-merge-fetch-protocol-v0 &&
    ++	(
    ++		cd dotslash-merge-fetch-protocol-v0 &&
    ++		git init -b main server &&
    ++		test_commit -C server one &&
    ++		git -C server branch other &&
    ++		test_commit -C server two &&
    ++
    ++		# Omit refs/heads/main from the fetch refspec so that the merge
    ++		# source is instead looked up among the refs the remote advertised.
    ++		git clone server client-v0 &&
    ++		git -C client-v0 config remote.origin.fetch \
    ++			+refs/heads/other:refs/remotes/origin/other &&
    ++		git -C client-v0 config branch.main.merge ./refs/heads/main &&
    ++		git -C client-v0 -c protocol.version=0 fetch &&
    ++		echo "$(git -C server rev-parse other)	not-for-merge" >expect &&
    ++		cut -f -2 client-v0/.git/FETCH_HEAD >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
    + test_expect_success 'fetch.writeCommitGraph' '
    + 	git clone three write &&
      	(
    - 		cd dotslash-merge-fetch-protocol-v0 &&
     
      ## t/t5516-fetch-push.sh ##
     @@ t/t5516-fetch-push.sh: test_expect_success 'push with onelevel ref' '
      	test_must_fail git push testrepo HEAD:refs/onelevel
      '
      
    --test_expect_failure 'push with "./"-prefixed src does not match any ref' '
     +test_expect_success 'push with "./"-prefixed src does not match any ref' '
    - 	mk_test testrepo heads/main &&
    - 	test_must_fail git push testrepo ./refs/heads/main:refs/heads/frotz 2>err &&
    - 	test_grep "src refspec ./refs/heads/main does not match any" err
    ++	mk_test testrepo heads/main &&
    ++	test_must_fail git push testrepo ./refs/heads/main:refs/heads/frotz 2>err &&
    ++	test_grep "src refspec ./refs/heads/main does not match any" err
    ++'
    ++
    + test_expect_success 'push with colon-less refspec (1)' '
    + 	mk_test testrepo heads/frotz tags/frotz &&
    + 	git branch -f frotz main &&
 6:  cb5d77cfa6 =  4:  6023a1677f remote: use strmap for check_push_refs()
 3:  ced6177052 !  5:  8d54296988 t5510: document fetch with "./"-prefixed branch.<name>.merge
    @@ Metadata
     Author: Jon Simons <jon@jonsimons.org>
     
      ## Commit message ##
    -    t5510: document fetch with "./"-prefixed branch.<name>.merge
    +    send-pack: plug leak upon match_push_refs failure
     
    -    refname_match() formats each candidate through mkpath(), which strips
    -    a leading "./", so a branch.<name>.merge value of "./refs/heads/main"
    -    matches "refs/heads/main" in both places that fetch compares them:
    -
    -     - branch_merge_matches() when marking fetched refs for merge
    -       in FETCH_HEAD
    -
    -     - find_ref_by_name_abbrev() when the merge source is not covered by the
    -       fetch refspec and is looked up amongst the remote advertised refs
    -
    -    Only a hand-edited config reaches these paths: clone, branch
    -    --set-upstream-to, fetch --set-upstream, and push -u write only names
    -    that have passed check_refname_format(), which rejects a leading "./".
    -
    -    Add two fetch tests asserting that such a "./"-prefixed value does not
    -    match for these cases.  Both are test_expect_failure because the name
    -    matches today:
    -
    -     - The default fetch refspec should not match "./refs/heads/main"
    -       with fetched "refs/heads/main" and mark the ref for merge.
    -
    -     - A protocol v0 fetch with refspec that omits "refs/heads/main"
    -       should not match "./refs/heads/main" against the remote
    -       advertised "refs/heads/main".
    -
    -    An upcoming commit stops using mkpath() in refname_match(), at which
    -    point the tests are toggled to test_expect_success.
    +    Otherwise memory leak tests will flag the missing finish_connect().
     
         Signed-off-by: Jon Simons <jon@jonsimons.org>
     
    - ## t/t5510-fetch.sh ##
    -@@ t/t5510-fetch.sh: test_expect_success 'LHS of refspec follows ref disambiguation rules' '
    - 	)
    - '
    - 
    -+test_expect_failure 'fetch with "./"-prefixed branch.<name>.merge does not mark any ref for merge' '
    -+	mkdir dotslash-merge-default-refspec &&
    -+	(
    -+		cd dotslash-merge-default-refspec &&
    -+		git init -b main server &&
    -+		test_commit -C server one &&
    -+		git -C server branch other &&
    -+		test_commit -C server two &&
    -+
    -+		# The bogus ./refs/heads/main should not match the remote refs/heads/main.
    -+		git clone server client &&
    -+		git -C client config branch.main.merge ./refs/heads/main &&
    -+		git -C client fetch &&
    -+		{
    -+			echo "$(git -C server rev-parse main)	not-for-merge" &&
    -+			echo "$(git -C server rev-parse other)	not-for-merge"
    -+		} >expect &&
    -+		cut -f -2 client/.git/FETCH_HEAD >actual &&
    -+		test_cmp expect actual
    -+	)
    -+'
    -+
    -+test_expect_failure 'fetch protocol v0 with "./"-prefixed branch.<name>.merge does not match any remote ref' '
    -+	mkdir dotslash-merge-fetch-protocol-v0 &&
    -+	(
    -+		cd dotslash-merge-fetch-protocol-v0 &&
    -+		git init -b main server &&
    -+		test_commit -C server one &&
    -+		git -C server branch other &&
    -+		test_commit -C server two &&
    -+
    -+		# Omit refs/heads/main from the fetch refspec so that the merge
    -+		# source is instead looked up among the refs the remote advertised.
    -+		git clone server client-v0 &&
    -+		git -C client-v0 config remote.origin.fetch \
    -+			+refs/heads/other:refs/remotes/origin/other &&
    -+		git -C client-v0 config branch.main.merge ./refs/heads/main &&
    -+		git -C client-v0 -c protocol.version=0 fetch &&
    -+		echo "$(git -C server rev-parse other)	not-for-merge" >expect &&
    -+		cut -f -2 client-v0/.git/FETCH_HEAD >actual &&
    -+		test_cmp expect actual
    -+	)
    -+'
    -+
    - test_expect_success 'fetch.writeCommitGraph' '
    - 	git clone three write &&
    - 	(
    + ## builtin/send-pack.c ##
    +@@ builtin/send-pack.c: int cmd_send_pack(int argc,
    + 	/* match them up */
    + 	if (match_push_refs(local_refs, &remote_refs, &rs, flags)) {
    + 		ret = -1;
    ++		close(fd[1]);
    ++		close(fd[0]);
    ++		finish_connect(conn);
    + 		goto cleanup;
    + 	}
    + 	if (!is_empty_cas(&cas))
 7:  80f4848c53 <  -:  ---------- t5516: test pushing two refspecs creating the same new branch
 8:  48bd4bae79 =  6:  5817b7c16f t5408, t5410: test duplicate updates without relying on the client
 9:  fb042c8e5b =  7:  988373369a t5408: check refspec order with distinct destinations
10:  0760db8240 <  -:  ---------- t5408: expect client-side error for duplicate destinations
11:  37c83838ca !  8:  efeb347be6 remote: reject duplicate destinations on an empty remote
    @@ Commit message
         each loop iteration re-reads '*dst' and detects a destination created
         by an earlier refspec.
     
    -    With this, failing tests in t5408, t5516 now pass and are toggled to
    -    test_expect_success.
    +    Tests are added and updated for the observable behavior change:
    +
    +     - t5408: update to expect the client-side error for duplicate
    +       destinations, change test descriptions to note they have not
    +       been asserting anything about the order of partial ref update,
    +       and fix a missing "2>err"
    +
    +     - t5516: test pushing two refspecs creating the same new branch
     
         Signed-off-by: Jon Simons <jon@jonsimons.org>
     
    @@ t/t5408-send-pack-stdin.sh: test_expect_success '--stdin refs are sent after cmd
      	verify_push A bar
      '
      
    --test_expect_failure 'two cmdline refs for the same destination are rejected' '
    +-test_expect_success 'cmdline refs written in order' '
     +test_expect_success 'two cmdline refs for the same destination are rejected' '
      	clear_remote &&
      	test_must_fail git send-pack remote.git A:foo B:foo 2>err &&
    - 	test_grep "dst ref refs/heads/foo receives from more than one src" err &&
    +-	test_grep "multiple updates for ref ${SQ}refs/heads/foo${SQ} not allowed" err &&
    ++	test_grep "dst ref refs/heads/foo receives from more than one src" err &&
      	test_must_fail git --git-dir=remote.git rev-parse foo
      '
      
    --test_expect_failure 'three cmdline refs for the same destination are rejected' '
    +-test_expect_success 'cmdline refs with multiple duplicates' '
     +test_expect_success 'three cmdline refs for the same destination are rejected' '
      	clear_remote &&
      	test_must_fail git send-pack remote.git A:foo B:foo C:foo 2>err &&
    - 	test_grep "dst ref refs/heads/foo receives from more than one src" err &&
    +-	test_grep "multiple updates for ref ${SQ}refs/heads/foo${SQ} not allowed" err &&
    ++	test_grep "dst ref refs/heads/foo receives from more than one src" err &&
      	test_must_fail git --git-dir=remote.git rev-parse foo
      '
      
    --test_expect_failure 'cmdline and --stdin refs for the same destination are rejected' '
    +-test_expect_success '--stdin refs come after cmdline' '
     +test_expect_success 'cmdline and --stdin refs for the same destination are rejected' '
      	clear_remote &&
      	echo A:foo >input &&
    - 	test_must_fail git send-pack remote.git --stdin B:foo <input 2>err &&
    +-	test_must_fail git send-pack remote.git --stdin B:foo <input &&
    +-	test_grep "multiple updates for ref ${SQ}refs/heads/foo${SQ} not allowed" err &&
    ++	test_must_fail git send-pack remote.git --stdin B:foo <input 2>err &&
    ++	test_grep "dst ref refs/heads/foo receives from more than one src" err &&
    + 	test_must_fail git --git-dir=remote.git rev-parse foo
    + '
    + 
     
      ## t/t5516-fetch-push.sh ##
    -@@ t/t5516-fetch-push.sh: test_expect_success 'push two refspecs targeting the same ref fails' '
    - 	test_grep "dst ref refs/heads/frotz receives from more than one src" err
    +@@ t/t5516-fetch-push.sh: test_expect_success 'push with no ambiguity (2)' '
    + 	check_push_result testrepo $the_commit remotes/origin/main
      '
      
    --test_expect_failure 'push --dry-run two refspecs creating the same ref fails on empty repo' '
    ++test_expect_success 'push --dry-run two refspecs targeting the same ref fails' '
    ++	mk_test testrepo heads/main &&
    ++	test_must_fail git push --dry-run testrepo main:frotz main:frotz 2>err &&
    ++	test_grep "dst ref refs/heads/frotz receives from more than one src" err
    ++'
    ++
    ++test_expect_success 'push two refspecs targeting the same ref fails' '
    ++	mk_test testrepo heads/main &&
    ++	test_must_fail git push testrepo main:frotz main:frotz 2>err &&
    ++	test_grep "dst ref refs/heads/frotz receives from more than one src" err
    ++'
    ++
     +test_expect_success 'push --dry-run two refspecs creating the same ref fails on empty repo' '
    - 	mk_empty testrepo &&
    - 	test_must_fail git push --dry-run testrepo main:frotz main:frotz 2>err &&
    - 	test_grep "dst ref refs/heads/frotz receives from more than one src" err
    - '
    - 
    --test_expect_failure 'push two refspecs creating the same ref fails on empty repo' '
    ++	mk_empty testrepo &&
    ++	test_must_fail git push --dry-run testrepo main:frotz main:frotz 2>err &&
    ++	test_grep "dst ref refs/heads/frotz receives from more than one src" err
    ++'
    ++
     +test_expect_success 'push two refspecs creating the same ref fails on empty repo' '
    - 	mk_empty testrepo &&
    - 	test_must_fail git push testrepo main:frotz main:frotz 2>err &&
    - 	test_grep "dst ref refs/heads/frotz receives from more than one src" err
    - '
    - 
    --test_expect_failure 'push --dry-run abbreviated then full refspec creating the same ref fails on empty repo' '
    ++	mk_empty testrepo &&
    ++	test_must_fail git push testrepo main:frotz main:frotz 2>err &&
    ++	test_grep "dst ref refs/heads/frotz receives from more than one src" err
    ++'
    ++
     +test_expect_success 'push --dry-run abbreviated then full refspec creating the same ref fails on empty repo' '
    - 	mk_empty testrepo &&
    - 	test_must_fail git push --dry-run testrepo main:frotz main:refs/heads/frotz 2>err &&
    - 	test_grep "dst ref refs/heads/frotz receives from more than one src" err
    - '
    - 
    --test_expect_failure 'push abbreviated then full refspec creating the same ref fails on empty repo' '
    ++	mk_empty testrepo &&
    ++	test_must_fail git push --dry-run testrepo main:frotz main:refs/heads/frotz 2>err &&
    ++	test_grep "dst ref refs/heads/frotz receives from more than one src" err
    ++'
    ++
     +test_expect_success 'push abbreviated then full refspec creating the same ref fails on empty repo' '
    - 	mk_empty testrepo &&
    - 	test_must_fail git push testrepo main:frotz main:refs/heads/frotz 2>err &&
    - 	test_grep "dst ref refs/heads/frotz receives from more than one src" err
    ++	mk_empty testrepo &&
    ++	test_must_fail git push testrepo main:frotz main:refs/heads/frotz 2>err &&
    ++	test_grep "dst ref refs/heads/frotz receives from more than one src" err
    ++'
    ++
    + test_expect_success 'push with colon-less refspec, no ambiguity' '
    + 	mk_test testrepo heads/main heads/t/main &&
    + 	git branch -f t/main main &&
12:  c1ad85bd11 =  9:  8c67d9b0a1 remote: use strmap for match_explicit_refs()
13:  0028b05159 = 10:  f45e0e0744 t/perf: measure --force-with-lease in p5516
14:  5a67f95a0c = 11:  356b29fa11 remote: restructure apply_push_cas() loops
15:  4ad96092b2 = 12:  56878f7cef remote: use strmap for apply_push_cas()
-- 
2.55.0

