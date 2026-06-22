Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F263ABD8D
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132130; cv=none; b=AWuyAEwaZ3SUH1HEnpv8Ua83aLwlZ1/mmqILnPezcXYPL1a6rCNwqqyAiXSeNaB7od3e1pFo39Ei7A7QpRD2/1o9W8qskreLVSDB5BwbJbKLhX9HIbjo4eMP/T7xtDshOW0CNM1okXMtqCXksd+VOtD23gMX8Ts5LthLXeWoj+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132130; c=relaxed/simple;
	bh=tRhRqdCZwKxTTwvAB/3ZURXS3bnvlqZoz3eMSoCpt2E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=j0ppHGdxQOt242pDIt2kXklqZJ9DRJ76PRUQh2JLfRHRg5ms9BXuLsnSlh1maVsWr7v+MjL44Qk2zSaWYeuSEuIOZjvq8Pjy/weifmYQ1zBK8UJHX2wv9qosqqf1Uex6lUxKOI/bsDY0VIZAxN1Jn3xWRK1IIn85SRY4M5E4O6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=SUqxw/cb; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="SUqxw/cb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1782132124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZsbLi2hW5wh1E2DdSe8tUvffCBi5ykMZVd//KJDnB2Y=;
	b=SUqxw/cbB28K2Pb5qxS3QTRfatxa29S5G0DoHUpdl7uu0rItUDeMX3VOOv/5vMbHCZiTVy
	j8WxzPq9oM72e1fq3D2tz2vKgmxA0CCUESuPHz01EyI9dpgv/+HrY+lCrSL2Rx6N4ZSOte
	jZY3JoqjZAYAwbs+1IDFjuq5cFP4IaA=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v4 0/3] Teach git-replay(1) to linearize merge commits
Date: Mon, 22 Jun 2026 14:41:54 +0200
Message-Id: <20260622-toon-git-replay-drop-merges-v4-0-ff257f534319@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NSwqDMBSF4a2UjHtLHmq0o+6jdKDxqilqJEmlI
 u690VKQDhweOHz/TBxajY5cTzOxOGqnTR9GdD4R1eR9jaDLsAmnPKEJjcAb00OtPVgc2nyC0po
 BOrQ1OkiprHJK01JkMQnCYLHS702/P77bvYonKr+S66PRzhs7bfmRrb9fKT0sjQwooECUrFIoi
 +imjVftRZmOrKWR7yxGjy0erFiyKJdMJWUq/i2xt5JjSwSLxQIzLLJMIdtby7J8AGPjTHhwAQA
 A
X-Change-ID: 20260604-toon-git-replay-drop-merges-807fa008d395
In-Reply-To: <20260616-toon-git-replay-drop-merges-v3-0-153e9eb99ce1@iotcl.com>
References: <20260616-toon-git-replay-drop-merges-v3-0-153e9eb99ce1@iotcl.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Migadu-Flow: FLOW_OUT

As an alternative to dscho's patch series to replay merges[1], add
option to git-replay(1) to linearize merges. This mimics what
git-rebase(1) does too with --no-rebase-merges (the default).

The first two patches do some refactoring. The third patch implements
the actual change. This patch was kindly provided by Dscho, which I've
tweaked to be upstreamed.

The --linearize option is only added to git-replay(1) and not to
git-history(1) because in my opinion it doesn't make much sense to do
so, but I'm happy to hear if anyone disagrees.

This series might conflict with Kristoffer's series to make
documentation changes[2], but should be trivial to resolve. And I don't
think there's a conflict with Patrick's series on adding "drop" to
git-history(1)[3].

dscho's series to replay merges[1] needs a bit of rework to fit on top
of this, but I'm happy to help figuring that out. We've been discussing
to either name the option --flatten or --linearize, but I've decided on
"linearize" because the documentation of git-rebase(1) also mentions
"linearize".

[1]: <pull.2106.git.1778107405.gitgitgadget@gmail.com>
[2]: <V2_CV_doc_replay_config.767@msgid.xyz>
[3]: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>

---
Changes in v4:
- Use test_grep instead of a bare grep in the range-diff test, to
  prepare for mm/test-grep-lint.
- Link to v3: https://patch.msgid.link/20260616-toon-git-replay-drop-merges-v3-0-153e9eb99ce1@iotcl.com

Changes in v3:
- Add --linearize to Documentation SYNOPSIS, and mention it's
  incompatible with --revert.
- Small language change in help message for --linearize.
- Rephrase comment to include last_commit isn't modified when
  linearizing merges.
- Remove test that was added in earlier versions, but actually is
  a duplicate of 'replaying merge commits is not supported yet'.
- Add test to verify --revert and --linearize are incompatible.
- Properly test that replaying down to root with --linearize works.
- Add test for --linearize with --advance.
- Add test that uses git-range-diff(1) to verify the patches created by
  --linearize are correct.
- Link to v2: https://patch.msgid.link/20260610-toon-git-replay-drop-merges-v2-0-5714a71c6d83@iotcl.com

Changes in v2:
- Restructured the conditions to detect merge commits and added a line
  of comment why the loop continues.
- Rewrote tests to use the history from the setup step and added a few
  test cases.
- Re-added Johannes's Signed-off-by trailer. Johannes gave me the
  patches with this trailer, and if I understand correctly, I can keep
  it. Please let me know if that wrong.
- Link to v1: https://patch.msgid.link/20260608-toon-git-replay-drop-merges-v1-0-e3ee71fce7b4@iotcl.com

---
Johannes Schindelin (1):
      replay: offer an option to linearize the commit topology

Toon Claes (2):
      replay: refactor enum replay_mode into a bool
      replay: add helper to put entry into mapped_commits

 Documentation/git-replay.adoc |   8 ++-
 builtin/replay.c              |   6 ++-
 replay.c                      | 116 ++++++++++++++++++++++++------------------
 replay.h                      |   5 ++
 t/t3650-replay-basics.sh      |  68 ++++++++++++++++++++++++-
 5 files changed, 151 insertions(+), 52 deletions(-)

Range-diff versus v3:

1:  759fa1b52c = 1:  0f0e50c67f replay: refactor enum replay_mode into a bool
2:  68dd5ad77c = 2:  919a6495ee replay: add helper to put entry into mapped_commits
3:  f99aeb3887 ! 3:  bb03e78210 replay: offer an option to linearize the commit topology
    @@ t/t3650-replay-basics.sh: test_expect_success '--onto with --ref rejects multipl
     +	# and the replayed chain (main..tip) must produce identical patches.
     +	git range-diff I..topic-with-merge main..$tip >out &&
     +	test_file_not_empty out &&
    -+	! grep -v "=" out &&
    ++	test_grep ! -v "=" out &&
     +
     +	git log --oneline main..$tip >out &&
     +	test_line_count = 3 out


---
base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
change-id: 20260604-toon-git-replay-drop-merges-807fa008d395

