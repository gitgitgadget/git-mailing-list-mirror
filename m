Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B543265CA8
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569814; cv=none; b=iCRYu02A6FtYM+SXM6iT4/EEsu30Vuh1bgeX4Z4voEcKAIspetU/jSIO/GuXpADKrWW8oW/S3wC87q6dRHHxruLMEBQItLF/Yi1TaXSs3EZztyFhsz5xafWQe/X/7zxMphLA0KJH1yyzxx97qxYSYrMDcwQPXsaNYJ9kEm4MnxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569814; c=relaxed/simple;
	bh=D0srCPksTZIBC9HPBmqdQX8hJ07HdQYkkG/bF7E3LDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XfSqsirZdyeQqsvNjG0B+tYtbRmUHwKF2aZOLCc5GaLqUwI5hCBsp9XEKot9LfCaMsL0YMyssFTSHXOi/NQvvh8vt/0Tlkw1d400VXR1vB/Y3k32vX+JKxS2iyBgDZFeGJ9ePcl8luqWq37oenaWHIv5iZ+7xySHfo0ybNoYM9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=h9KVdMzx; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="h9KVdMzx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768569805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3scA0kUvTyej9aDo+9bqPhWk5ty2AWFMPquetug4HU8=;
	b=h9KVdMzx0KOl8oJqnAfhUZG2EvLnkJ48WQnByu7YUYgZl5KD75WXb38yl0Yx0PS/7c0mFM
	iZ8AA5xhTsP/xMbxrkFMRs6BRCG3jdk33yZqDZ0bJ3dzfh26TsNxivqHBVECvnX1OL7Vsc
	+DQlGdGTTNNugfIFEF+bnqzqmludQ0Q=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 16 Jan 2026 14:22:53 +0100
Subject: [PATCH v2 5/5] last-modified: change default max-depth to 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-toon-last-modified-zzzz-v2-5-79e44f2806fe@iotcl.com>
References: <20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com>
In-Reply-To: <20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Gusted <gusted@codeberg.org>, Toon Claes <toon@iotcl.com>
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
 Documentation/git-last-modified.adoc |  3 ++-
 builtin/last-modified.c              | 16 +++-------------
 t/t8020-last-modified.sh             | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-last-modified.adoc b/Documentation/git-last-modified.adoc
index a3992db3f2..57136baf3b 100644
--- a/Documentation/git-last-modified.adoc
+++ b/Documentation/git-last-modified.adoc
@@ -27,6 +27,7 @@ OPTIONS
 `--recursive`::
 	Instead of showing tree entries, step into subtrees and show all entries
 	inside them recursively.
+	This is identical as setting `--max-depth=-1`.
 
 `-t`::
 `--show-trees`::
@@ -36,7 +37,7 @@ OPTIONS
 `--max-depth=<depth>`::
 	For each pathspec given on the command line, descend at most `<depth>`
 	levels of directories. A negative value means no limit.
-	Setting a positive value implies `--recursive`.
+	The default depth is 0.
 	Cannot be combined with wildcards in the pathspec.
 
 `-z`::
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 842700bc6a..a10e711beb 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -481,14 +481,10 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
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
+	lm->rev.diffopt.max_depth_valid = !lm->recursive && lm->max_depth >= 0;
 
 	argc = setup_revisions(argc, argv, &lm->rev, NULL);
 	if (argc > 1) {
@@ -535,12 +531,6 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
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

