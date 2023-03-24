Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04370C6FD20
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 17:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjCXRIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 13:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjCXRIO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 13:08:14 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AAF3586
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 10:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679677685; x=1711213685;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/BHuTIttllbxEMWX5vPCdEUBkE2OBG0rWWIUU8totqo=;
  b=BaFtxISx4lTvdhS+Y+PXhXEOlKGJZmfmL/Rg96AYrEzSvk2vmtn2n66Y
   piM9d2cHMJQA9gfQuCOIM36sTl2Nt2ip/4zzZdNK+u201jD3MK6Gk7dg0
   Md2r+aj10G50Dy0WxkXYL4jKzUaXPyzVqHdH8DJ/kq2XGoEb+mvcIAS7X
   y5zMJnZ3MUpY1tsPno/O1Wm4d+uKIbcpstFvXoSI7KcZZ5c9Hk3sZtVN+
   lDVCPfJLX4di1hBLSfXRXQExbsSIQnlpbU+8HHzv8BYE5wZ7op8oRnLqe
   tGDDo/vy825a//2eXvxjA3iUPE+dSnsX5pcNLjZipCJ0I0wjy/kvB5IHL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="337335275"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="337335275"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 10:08:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="1012343803"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="1012343803"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 10:08:05 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3] blame: allow --contents to work with non-HEAD commit
Date:   Fri, 24 Mar 2023 10:08:00 -0700
Message-Id: <20230324170800.331022-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.40.0.131.gc918699d9952
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

The --contents option can be used with git blame to blame the file as if
it had the contents from the specified file. This is akin to copying the
contents into the working tree and then running git blame. This option
has been supported since 1cfe77333f27 ("git-blame: no rev means start
from the working tree file.")

The --contents option always blames the file as if it was based on the
current HEAD commit. If you try to pass a revision while using
--contents, you get the following error:

  fatal: cannot use --contents with final commit object name

This is because the blame process generates a fake working tree commit
which always uses the HEAD object as its sole parent.

Enhance fake_working_tree_commit to take the object ID to use for the
parent instead of always using the HEAD object. Then, always generate a
fake commit when we have contents provided, even if we have a final
object. Remove the check to disallow --contents and a final revision.

Note that the behavior of generating a fake working commit is still
skipped when a revision is provided but --contents is not provided.
Generating such a commit in that case would combine the currently
checked out file contents with the provided revision, which breaks
normal blame behavior and produces unexpected results.

This enables use of --contents with an arbitrary revision, rather than
forcing the use of the local HEAD commit. This makes the --contents
option significantly more flexible, as it is no longer required to check
out the working tree to the desired commit before using --contents.

Reword the documentation so that its clear that --contents can be used
with <rev>.

Add tests for the --contents option to the annotate-tests.sh test
script.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
Changes since v1:
* Reword commit message slightly, based on Junio's review comments.

Changes since v2:
* Improved commit message further
* Re-wrote documentation for --contents. I really had trouble figuring out a
  good succinct way to explain the behavior, so hopefully this is good.
* Updated the comment in setup_scoreboard.

I ran into this because I use --contents in a process I'm working on for
comparing differences between two forks of a project. I use blame --contents
where I point blame to the contents from the other repository. It is useful
to be able to do with at arbitrary commits. Currently I have to switch the
working tree to the commit rather than being able to target a commit by its
oid.

With this change I can more easily run this process without the need to
actually check the contents out in the working tree. Its relatively simple
to make --contents work with a revision, since I just need to generate the
fake contents starting from that revision instead of starting from HEAD.


 Documentation/blame-options.txt | 10 ++++-----
 Documentation/git-blame.txt     |  2 +-
 blame.c                         | 40 +++++++++++++++++++++------------
 t/annotate-tests.sh             | 14 ++++++++++++
 4 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 9a663535f443..95599bd6e5f4 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -64,11 +64,11 @@ include::line-range-format.txt[]
 	manual page.
 
 --contents <file>::
-	When <rev> is not specified, the command annotates the
-	changes starting backwards from the working tree copy.
-	This flag makes the command pretend as if the working
-	tree copy has the contents of the named file (specify
-	`-` to make the command read from the standard input).
+	Pretend the file being annotated has a commit with the
+	contents from the named file and a parent of <rev>,
+	defaulting to HEAD when no <rev> is specified. You may
+	specify '-' to make the command read from the standard
+	input for the file contents.
 
 --date <format>::
 	Specifies the format used to output dates. If --date is not
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 4400a17330b4..f69a871a96f7 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
 	    [--ignore-rev <rev>] [--ignore-revs-file <file>]
 	    [--color-lines] [--color-by-age] [--progress] [--abbrev=<n>]
-	    [<rev> | --contents <file> | --reverse <rev>..<rev>] [--] <file>
+	    [ --contents <file> ] [<rev> | --reverse <rev>..<rev>] [--] <file>
 
 DESCRIPTION
 -----------
diff --git a/blame.c b/blame.c
index e45d8a3bf92a..2d02cf0636ca 100644
--- a/blame.c
+++ b/blame.c
@@ -177,12 +177,12 @@ static void set_commit_buffer_from_strbuf(struct repository *r,
 static struct commit *fake_working_tree_commit(struct repository *r,
 					       struct diff_options *opt,
 					       const char *path,
-					       const char *contents_from)
+					       const char *contents_from,
+					       struct object_id *oid)
 {
 	struct commit *commit;
 	struct blame_origin *origin;
 	struct commit_list **parent_tail, *parent;
-	struct object_id head_oid;
 	struct strbuf buf = STRBUF_INIT;
 	const char *ident;
 	time_t now;
@@ -198,10 +198,7 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 	commit->date = now;
 	parent_tail = &commit->parents;
 
-	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
-		die("no such ref: HEAD");
-
-	parent_tail = append_parent(r, parent_tail, &head_oid);
+	parent_tail = append_parent(r, parent_tail, oid);
 	append_merge_parents(r, parent_tail);
 	verify_working_tree_path(r, commit, path);
 
@@ -2772,22 +2769,37 @@ void setup_scoreboard(struct blame_scoreboard *sb,
 		sb->commits.compare = compare_commits_by_reverse_commit_date;
 	}
 
-	if (sb->final && sb->contents_from)
-		die(_("cannot use --contents with final commit object name"));
-
 	if (sb->reverse && sb->revs->first_parent_only)
 		sb->revs->children.name = NULL;
 
-	if (!sb->final) {
+	if (sb->contents_from || !sb->final) {
+		struct object_id head_oid, *parent_oid;
+
 		/*
-		 * "--not A B -- path" without anything positive;
-		 * do not default to HEAD, but use the working tree
-		 * or "--contents".
+		 * Build a fake commit at the top of the history, when
+		 * (1) "git blame ^A ^B --path", i.e. without any positive end
+		 *     end of the history range, in which case we build such
+		 *     a fake commit on top of the HEAD to blame in-tree
+		 *     modifications.
+		 * (2) "git blame --contents=file [A] -- path", with or
+		 *     without positive end of the history range but with
+		 *     --contents, in which case we pretend that there is
+		 *     a fake commit on top of the positive end (defaulting to
+		 *     HEAD) that has the given contents in the path.
 		 */
+		if (sb->final) {
+			parent_oid = &sb->final->object.oid;
+		} else {
+			if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
+				die("no such ref: HEAD");
+			parent_oid = &head_oid;
+		}
+
 		setup_work_tree();
 		sb->final = fake_working_tree_commit(sb->repo,
 						     &sb->revs->diffopt,
-						     sb->path, sb->contents_from);
+						     sb->path, sb->contents_from,
+						     parent_oid);
 		add_pending_object(sb->revs, &(sb->final->object), ":");
 	}
 
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index f1b9a6ce4dae..b35be20cf327 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -72,6 +72,16 @@ test_expect_success 'blame 1 author' '
 	check_count A 2
 '
 
+test_expect_success 'blame with --contents' '
+	check_count --contents=file A 2
+'
+
+test_expect_success 'blame with --contents changed' '
+	echo "1A quick brown fox jumps over the" >contents &&
+	echo "another lazy dog" >>contents &&
+	check_count --contents=contents A 1 "Not Committed Yet" 1
+'
+
 test_expect_success 'blame in a bare repo without starting commit' '
 	git clone --bare . bare.git &&
 	(
@@ -98,6 +108,10 @@ test_expect_success 'blame 2 authors' '
 	check_count A 2 B 2
 '
 
+test_expect_success 'blame with --contents and revision' '
+	check_count -h testTag --contents=file A 2 "Not Committed Yet" 2
+'
+
 test_expect_success 'setup B1 lines (branch1)' '
 	git checkout -b branch1 main &&
 	echo "3A slow green fox jumps into the" >>file &&
-- 
2.40.0.131.g970374df36d8

