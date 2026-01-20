Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200913D301B
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768945676; cv=none; b=DZy7/vv5vtSsIImW/rvxzEtLtTa5QS7ICYd3zu08nU0IO0l+P1XxBue6KMg/PoT95nPYgW2xx4Fr51Y9EPVO/ia1CmpHL5WqVEQ5XQg+cimz6Rh7hMqtYolf05MbjPW1TK2M1PJ6LercZ+kQT+D5DRPtTfaP0QT2QniFgRCPJxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768945676; c=relaxed/simple;
	bh=2x1FbiJqYrhYDVSA6IG5/rZ3Zaf+U8fkJbXjDIzbu4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kVbwxHhpZ657zRtaoSlj9+AzWD+FwhjKt1Qg4aiDLsCYjT8BY/FOIBaSQ4Jcr9gCIsilT1JMSvz6WHOnd8M8k52Q3zTLmEWLMVzmpZAJjAZIlnYkzzpbQtaseXde8y6XYIDGmWp/UPlhiqnrUx6sRo8irF0J7ySgw0xqtZ2II0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=gGZPb4OA; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="gGZPb4OA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768945668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hCezt+TraOHPbCzIBrNO4FQGqNZJqVo8wnI8Z4v8MF0=;
	b=gGZPb4OAQj0gsvN6eyX/xOOUPWNn9qtwXm6H4LGjl3Z/LKO/R4wOrvsTQBeWMfqa8ruSeD
	60B2I+I9U5HmELHC3K8RSSmjYbZe3QaYN1+L5lh+lVOxtH1/N4qIPzAWX84ReTIze55WRf
	mMaK+ZqCXwG9UGyDc7/yop7XtxzFO0w=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 20 Jan 2026 22:47:11 +0100
Subject: [PATCH v3 4/4] last-modified: change default max-depth to 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-toon-last-modified-zzzz-v3-4-9bffd4968b0e@iotcl.com>
References: <20260120-toon-last-modified-zzzz-v3-0-9bffd4968b0e@iotcl.com>
In-Reply-To: <20260120-toon-last-modified-zzzz-v3-0-9bffd4968b0e@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

By default git-last-modified(1) doesn't recurse into subtrees. So when
the pathspec contained a path in a subtree, the command would only print
the commit information about the parent tree of the path, like:

    $ git last-modified -- path/file
    aaa0aab1bbb2bcc3ccc4ddd5dde6eee7eff8fff9	path

Change the default behavior to give commit information about the exact
path instead:

    $ git last-modified -- path/file
    aaa0aab1bbb2bcc3ccc4ddd5dde6eee7eff8fff9	path/file

To achieve this, the default max-depth is changed to 0 and recursive is
always enabled.

The handling of option '-r' is modified to disable a max-depth,
resulting in the behavior of this option to remain unchanged.

No existing tests were modified, because there didn't exist any tests
covering the example above. But more tests are added to cover this now.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Documentation/git-last-modified.adoc |  9 +++++----
 builtin/last-modified.c              | 21 +++++----------------
 t/t8020-last-modified.sh             | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-last-modified.adoc b/Documentation/git-last-modified.adoc
index 6f9b119bb6..d7d16fc4f7 100644
--- a/Documentation/git-last-modified.adoc
+++ b/Documentation/git-last-modified.adoc
@@ -25,13 +25,14 @@ OPTIONS
 
 `-r`::
 `--recursive`::
-	Instead of showing tree entries, step into subtrees and show all entries
-	inside them recursively.
+	Recursively traverse into all subtrees. By default, the command only
+	shows tree entries matching the `<pathspec>`. With this option, it
+	descends into subtrees and displays all entries within them.
+	Equivalent to `--max-depth=-1`.
 
 `-t`::
 `--show-trees`::
-	Show tree entries even when recursing into them. It has no effect
-	without `--recursive`.
+	Show tree entries even when recursing into them.
 
 `--max-depth=<depth>`::
 	For each pathspec given on the command line, traverse at most `<depth>`
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 28fc77a0f8..f7f4c5109c 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -53,7 +53,6 @@ define_commit_slab(active_paths_for_commit, struct bitmap *);
 struct last_modified {
 	struct hashmap paths;
 	struct rev_info rev;
-	bool recursive;
 	bool show_trees;
 	bool nul_termination;
 	int max_depth;
@@ -481,14 +480,10 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
 	lm->rev.no_commit_id = 1;
 	lm->rev.diff = 1;
 	lm->rev.diffopt.flags.no_recursive_diff_tree_combined = 1;
-	lm->rev.diffopt.flags.recursive = lm->recursive;
+	lm->rev.diffopt.flags.recursive = 1;
 	lm->rev.diffopt.flags.tree_in_recursive = lm->show_trees;
-
-	if (lm->max_depth >= 0) {
-		lm->rev.diffopt.flags.recursive = 1;
-		lm->rev.diffopt.max_depth = lm->max_depth;
-		lm->rev.diffopt.max_depth_valid = 1;
-	}
+	lm->rev.diffopt.max_depth = lm->max_depth;
+	lm->rev.diffopt.max_depth_valid = lm->max_depth >= 0;
 
 	argc = setup_revisions(argc, argv, &lm->rev, NULL);
 	if (argc > 1) {
@@ -524,8 +519,8 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
 	};
 
 	struct option last_modified_options[] = {
-		OPT_BOOL('r', "recursive", &lm.recursive,
-			 N_("recurse into subtrees")),
+		OPT_SET_INT('r', "recursive", &lm.max_depth,
+			    N_("recurse into subtrees"), -1),
 		OPT_BOOL('t', "show-trees", &lm.show_trees,
 			 N_("show tree entries when recursing into subtrees")),
 		OPT_INTEGER_F(0, "max-depth", &lm.max_depth,
@@ -535,12 +530,6 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
 		OPT_END()
 	};
 
-	/*
-	 * Set the default of a max-depth to "unset". This will change in a
-	 * subsequent commit.
-	 */
-	lm.max_depth = -1;
-
 	argc = parse_options(argc, argv, prefix, last_modified_options,
 			     last_modified_usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT |
diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
index 50f4312f71..3944d2e153 100755
--- a/t/t8020-last-modified.sh
+++ b/t/t8020-last-modified.sh
@@ -93,6 +93,41 @@ test_expect_success 'last-modified subdir recursive' '
 	EOF
 '
 
+test_expect_success 'last-modified subdir non-recursive' '
+	check_last_modified a <<-\EOF
+	3 a
+	EOF
+'
+
+test_expect_success 'last-modified path in subdir non-recursive' '
+	check_last_modified a/file <<-\EOF
+	2 a/file
+	EOF
+'
+
+test_expect_success 'last-modified subdir with wildcard non-recursive' '
+	check_last_modified a/* <<-\EOF
+	3 a/b
+	2 a/file
+	EOF
+'
+
+test_expect_success 'last-modified with negative max-depth' '
+	check_last_modified --max-depth=-1 <<-\EOF
+	3 a/b/file
+	2 a/file
+	1 file
+	EOF
+'
+
+test_expect_success 'last-modified with max-depth of 1' '
+	check_last_modified --max-depth=1 <<-\EOF
+	3 a/b
+	2 a/file
+	1 file
+	EOF
+'
+
 test_expect_success 'last-modified from non-HEAD commit' '
 	check_last_modified HEAD^ <<-\EOF
 	2 a

-- 
2.52.0

