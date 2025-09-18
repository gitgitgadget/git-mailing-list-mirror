Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7847E2ECE9C
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182433; cv=none; b=lRia3IVLS0u6yLO3dqmVDqhb1ERhvH45peqDm+9GJrC7lYXt8IUylXkE8tj4YBcpAuW6IRNwB3z5N8iBpLbVEuCSkzGjYn3SKtxr39M7jEEQVlhSA7oELI7tFZ8/rRDaKtwGdyuVu1TSg4LXdNxbxzlfZAd9LPEi93hq2+GQsQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182433; c=relaxed/simple;
	bh=1B7zWd84ffqC3rfHhnnpsPMkIcrp40Y6o0w4HqeWQ9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=g9oDZ0GUEPra7J9gtsHSfp1IjMojWXxiZOcIH/QZMulPcwi78GVXEwgJ1aXvTYCnbON39V9RvMouE7udSl5YN3PU0BK5wiIUzXbQaclDEDUzzJGXo+tDuiahYfbyY6KnGhMdixy/TivCmmetqiz3yk6xs6rY5oRfAL2lCT5I0nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=TO1uZEmv; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="TO1uZEmv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1758182424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2o7MYWeXZK25JJTZ4bVtCPBlTsv5vSO8xVEG23D6Pk0=;
	b=TO1uZEmvyTaSIQL8j0L+vQ9vf+l2d+B+WNfInDHox1uVANe1WvJkalvv0ATIKvFCN0w79J
	2fYQ9EOunlfL/nb0ZTKF4xDQUYPhANPV8oYumnQKLnnWX4XSBTT9iMm8AikGhwC/fcJLRt
	tiMr/rwoDAIS8n6SDNI0K0HhuEnrmxs=
From: Toon Claes <toon@iotcl.com>
Date: Thu, 18 Sep 2025 10:00:08 +0200
Subject: [PATCH v3] last-modified: fix bug when some paths remain unhandled
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-toon-fix-last-modified-v3-1-0c3910e224f6@iotcl.com>
X-B4-Tracking: v=1; b=H4sIAAe8y2gC/3XNwQqDMAyA4VeRntfRZrbqTnuPsYPadAacHW0pG
 +K7rwoDLx7/kHyZWUBPGNi1mJnHRIHclONyKlg/tNMTOZncDAQo0Qjg0bmJW/rwsQ2Rv5whS2h
 4rZWsQGgBWrF8/PaYlzb4/sg9UIjOf7c/Sa7TP1kekUlyyRvZ2boyxmrobuRiP55792IrmWDPq
 EMGMmNq1SCiKUWNe2ZZlh+KHX94AwEAAA==
X-Change-ID: 20250902-toon-fix-last-modified-865172060265
In-Reply-To: <20250905-toon-fix-last-modified-v2-1-d859eeed408e@iotcl.com>
References: <20250905-toon-fix-last-modified-v2-1-d859eeed408e@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, 
 Christian Couder <chriscool@tuxfamily.org>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

The recently introduced new subcommand git-last-modified(1) runs into an
error in some scenarios. It then would exit with the message:

    BUG: paths remaining beyond boundary in last-modified

This seems to happens for example when criss-cross merges are involved.
In that scenario, the function diff_tree_combined() gets called.

The function diff_tree_combined() copies the `struct diff_options` from
the input `struct rev_info` to override some flags. One flag is
`recursive`, which is always set to 1. This has been the case since the
inception of this function in af3feefa1d (diff-tree -c: show a merge
commit a bit more sensibly., 2006-01-24).

This behavior is incompatible with git-last-modified(1), when called
non-recursive (which is the default).

The last-modified machinery uses a hashmap for all the paths it wants to
get the last-modified commit for. Through log_tree_commit() the callback
mark_path() is called. The diff machinery uses diff_tree_combined()
internally, and due to it's recursive behavior the callback receives
entries inside subtrees, but not the subtree entries themselves. So a
directory is never expelled from the hashmap, and the BUG() statement
gets hit.

Because there are many callers calling into diff_tree_combined(), both
directly and indirectly, we cannot simply change it's behavior.

Instead, add a flag `no_recursive_diff_tree_combined` which supresses
the behavior of diff_tree_combined() to override `recursive` and set
this flag in builtin/last-modified.c.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
git-last-modified(1) was recently merged into 'master', but upon use
I've (well actually Patrick) noticed it has a bug:

    $ git last-modified next
    3f3e11118993fe0500b3957ab798e39caaa3952f	.gitignore
    3f3e11118993fe0500b3957ab798e39caaa3952f	Makefile
    3f3e11118993fe0500b3957ab798e39caaa3952f	builtin.h
    3f3e11118993fe0500b3957ab798e39caaa3952f	command-list.txt
    3f3e11118993fe0500b3957ab798e39caaa3952f	commit-graph.c
    3f3e11118993fe0500b3957ab798e39caaa3952f	git.c
    3f3e11118993fe0500b3957ab798e39caaa3952f	meson.build
    56072ff0384da5d874fc378d36e089a18f28f1e3	fetch-pack.c
    457534d0417d047b943f76a849f256b739894ce9	progress.c
    0d8f4ccfe3b13bb5eb95f030dc5fe76efb255397	for-each-ref.h
    109c3df14ccf372c2438a470bdfb566265399f0a	combine-diff.c
    109c3df14ccf372c2438a470bdfb566265399f0a	diff.c
    109c3df14ccf372c2438a470bdfb566265399f0a	diff.h
    109c3df14ccf372c2438a470bdfb566265399f0a	dir.c
    [snip]
    9e5878fbede57c0499133adf73844261849cd7b2	git-web--browse.sh
    b2fb3911eab730a08168c7f85a7935ad5a330b53	config.mak.in
    36268b762c4aa6a0d4831f69852b20ab545aff4d	LGPL-2.1
    1e58dba142c673c59fbb9d10aeecf62217d4fc9c	aclocal.m4
    9517e6b84357252e1882091343661c34d978771e	levenshtein.h
    703601d6780c32d33dadf19b2b367f2f79e1e34c	COPYING
    BUG: ../builtin/last-modified.c:236: paths remaining beyond boundary in last-modified
    zsh: IOT instruction (core dumped)  git last-modified

This series fixes that issue.
---
Changes in v3:
- Instead of changing diff_tree_combined()'s default behavior, add a
  flag to modify it's behavior.
- Overhaul the commit message to match the change in strategy.
- Link to v2: https://lore.kernel.org/r/20250905-toon-fix-last-modified-v2-1-d859eeed408e@iotcl.com

Changes in v2:
- Do not change behavioral change in `git diff-tree -c`.
- Small change in the test to make it pass on Windows.
- Link to v1: https://lore.kernel.org/r/20250904-toon-fix-last-modified-v1-1-91bf87ddf62b@iotcl.com
---
 builtin/last-modified.c  |  1 +
 combine-diff.c           |  3 ++-
 diff.h                   |  7 +++++++
 t/t8020-last-modified.sh | 16 ++++++++++++++++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 886ba12cb5..ae8b36a2c3 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -265,6 +265,7 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
 	lm->rev.boundary = 1;
 	lm->rev.no_commit_id = 1;
 	lm->rev.diff = 1;
+	lm->rev.diffopt.flags.no_recursive_diff_tree_combined = 1;
 	lm->rev.diffopt.flags.recursive = lm->recursive;
 	lm->rev.diffopt.flags.tree_in_recursive = lm->show_trees;
 
diff --git a/combine-diff.c b/combine-diff.c
index 3878faabe7..e779b86e0b 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1515,8 +1515,9 @@ void diff_tree_combined(const struct object_id *oid,
 
 	diffopts = *opt;
 	copy_pathspec(&diffopts.pathspec, &opt->pathspec);
-	diffopts.flags.recursive = 1;
 	diffopts.flags.allow_external = 0;
+	if (!opt->flags.no_recursive_diff_tree_combined)
+		diffopts.flags.recursive = 1;
 
 	/* find set of paths that everybody touches
 	 *
diff --git a/diff.h b/diff.h
index 9bb939a4f1..df8f7643b0 100644
--- a/diff.h
+++ b/diff.h
@@ -126,6 +126,13 @@ struct diff_flags {
 	unsigned recursive;
 	unsigned tree_in_recursive;
 
+	/*
+	 * Historically diff_tree_combined() overrides recursive to 1. To
+	 * suppress this behavior, set the flag below.
+	 * It has no effect if recursive is already set to 1.
+	 */
+	unsigned no_recursive_diff_tree_combined;
+
 	/* Affects the way how a file that is seemingly binary is treated. */
 	unsigned binary;
 	unsigned text;
diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
index 5eb4cef035..e13aad1439 100755
--- a/t/t8020-last-modified.sh
+++ b/t/t8020-last-modified.sh
@@ -128,6 +128,22 @@ test_expect_success 'only last-modified files in the current tree' '
 	EOF
 '
 
+test_expect_success 'last-modified with subdir and criss-cross merge' '
+	git checkout -b branch-k1 1 &&
+	mkdir -p a k &&
+	test_commit k1 a/file2 &&
+	git checkout -b branch-k2 &&
+	test_commit k2 k/file2 &&
+	git checkout branch-k1 &&
+	test_merge km2 branch-k2 &&
+	test_merge km3 3 &&
+	check_last_modified <<-\EOF
+	km3 a
+	k2 k
+	1 file
+	EOF
+'
+
 test_expect_success 'cross merge boundaries in blaming' '
 	git checkout HEAD^0 &&
 	git rm -rf . &&

---
base-commit: 215033b3ac599432a17d58f18a92b356d98354a9
change-id: 20250902-toon-fix-last-modified-865172060265

Best regards,
--  
Toon Claes <toon@iotcl.com>

