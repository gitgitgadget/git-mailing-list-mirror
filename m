Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6786DC6FD20
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 05:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjCXFyr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 01:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCXFyp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 01:54:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8F020D31
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 22:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679637283; x=1711173283;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5DDeFOsAXAHbJ+KE+AkqBhi3chZEK3dmy+azqu9SCuI=;
  b=MEE3uX39Vyvw0G1pj3Ykoga8nVMOUK9ljVcOZWerwLkmN++8cbbtpPIP
   26S6PEYaUx1EchjpXb9g9YFHRVe8Q7HIkcyAPZv2CCAsmXZEioMmDjlEL
   AxNl+P5Y0uBBGXlddZ0cscDhaIM7zlXqTVDyNjg4cqFw2fcCIaTIl6MNf
   rouClblF3vgntTGt1mhT8cfsQ5ru85STdSpbDsWTK83LxYI1UKMtpN7qY
   OlbwIHIwLGrAnTGve2YlPhHHGb2qtZ32X/qcxN9IEm9aRuvBOwCqqjA+Q
   AqlbDzA6wMxXrk1mQYCOabDZViw+edT8L/gc3rb1VRoB6DDZZsQc0PS0d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="338426523"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="338426523"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 22:54:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="682559325"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="682559325"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 22:54:42 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2] blame: allow --contents to work with non-HEAD commit
Date:   Thu, 23 Mar 2023 22:54:37 -0700
Message-Id: <20230324055437.297401-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.40.0.131.g970374df36d8
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

I suspect this may make it easier to get --reverse to work with --contents,
but I haven't investigated doing so.

 Documentation/blame-options.txt |  9 ++++-----
 Documentation/git-blame.txt     |  2 +-
 blame.c                         | 27 ++++++++++++++++-----------
 t/annotate-tests.sh             | 14 ++++++++++++++
 4 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 9a663535f443..6476dd327377 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -64,11 +64,10 @@ include::line-range-format.txt[]
 	manual page.
 
 --contents <file>::
-	When <rev> is not specified, the command annotates the
-	changes starting backwards from the working tree copy.
-	This flag makes the command pretend as if the working
-	tree copy has the contents of the named file (specify
-	`-` to make the command read from the standard input).
+	Pretend the file being annotated has the contents from the named
+	file instead of using the contents of <rev> or the working tree
+	copy. You may specify '-' to make the command read from standard
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
index e45d8a3bf92a..52fca5a7f5b7 100644
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
 
@@ -2772,22 +2769,30 @@ void setup_scoreboard(struct blame_scoreboard *sb,
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
 		 * "--not A B -- path" without anything positive;
 		 * do not default to HEAD, but use the working tree
 		 * or "--contents".
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

