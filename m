X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Lars Hjemli <hjemli@gmail.com>
Subject: [RFC] Teach git-branch howto rename a branch
Date: Sat, 25 Nov 2006 00:03:49 +0100
Message-ID: <1164409429445-git-send-email-hjemli@gmail.com>
NNTP-Posting-Date: Fri, 24 Nov 2006 23:04:05 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32245>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gnk5M-0004SR-Jz for gcvg-git@gmane.org; Sat, 25 Nov
 2006 00:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966260AbWKXXDx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 18:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757622AbWKXXDw
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 18:03:52 -0500
Received: from mail48.e.nsc.no ([193.213.115.48]:3740 "EHLO mail48.e.nsc.no")
 by vger.kernel.org with ESMTP id S1757552AbWKXXDw (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 18:03:52 -0500
Received: from localhost.localdomain (ti231210a080-2784.bb.online.no
 [80.213.122.226]) by mail48.nsc.no (8.13.8/8.13.5) with ESMTP id
 kAON3nLl018939 for <git@vger.kernel.org>; Sat, 25 Nov 2006 00:03:50 +0100
 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This adds a '--rename' option to git branch. If specified, branch
creation becomes branch renaming.

With a single branchname, the current branch is renamed and .git/HEAD is
updated.

With two branchnames, the second name is renamed to the first.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 builtin-branch.c |  117 +++++++++++++++++++++++++++++++++++------------------
 1 files changed, 77 insertions(+), 40 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index f14d814..e714569 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -11,7 +11,7 @@
 #include "builtin.h"
 
 static const char builtin_branch_usage[] =
-"git-branch (-d | -D) <branchname> | [-l] [-f] <branchname> [<start-point>] | [-r | -a] [-v] [--abbrev=<length>] ";
+"git-branch (-d | -D) <branchname> | [-l] [-f] [--rename] <branchname> [<start-point>] | [-r | -a] [-v] [--abbrev=<length>] ";
 
 
 static const char *head;
@@ -36,47 +36,55 @@ static int in_merge_bases(const unsigned
 	return ret;
 }
 
-static void delete_branches(int argc, const char **argv, int force)
+static void delete_branch(const char *branch, int force, struct commit *head_rev)
 {
-	struct commit *rev, *head_rev;
-	unsigned char sha1[20];
+	struct commit *rev;
 	char *name;
-	int i;
+	unsigned char sha1[20];
 
-	head_rev = lookup_commit_reference(head_sha1);
-	for (i = 0; i < argc; i++) {
-		if (!strcmp(head, argv[i]))
-			die("Cannot delete the branch you are currently on.");
-
-		name = xstrdup(mkpath("refs/heads/%s", argv[i]));
-		if (!resolve_ref(name, sha1, 1, NULL))
-			die("Branch '%s' not found.", argv[i]);
-
-		rev = lookup_commit_reference(sha1);
-		if (!rev || !head_rev)
-			die("Couldn't look up commit objects.");
-
-		/* This checks whether the merge bases of branch and
-		 * HEAD contains branch -- which means that the HEAD
-		 * contains everything in both.
-		 */
-
-		if (!force &&
-		    !in_merge_bases(sha1, rev, head_rev)) {
-			fprintf(stderr,
-				"The branch '%s' is not a strict subset of your current HEAD.\n"
-				"If you are sure you want to delete it, run 'git branch -D %s'.\n",
-				argv[i], argv[i]);
-			exit(1);
-		}
+	if (!strcmp(head, branch))
+		die("Cannot delete the branch you are currently on.");
+
+	name = xstrdup(mkpath("refs/heads/%s", branch));
+	if (!resolve_ref(name, sha1, 1, NULL))
+		die("Branch '%s' not found.", branch);
+
+	rev = lookup_commit_reference(sha1);
+	if (!rev)
+		die("Couldn't look up commit objects for %s", branch);
+
+	/* This checks whether the merge bases of branch and
+	 * HEAD contains branch -- which means that the HEAD
+	 * contains everything in both.
+	 */
+
+	if (head_rev && !force &&
+	    !in_merge_bases(sha1, rev, head_rev)) {
+		fprintf(stderr,
+			"The branch '%s' is not a strict subset of your current HEAD.\n"
+			"If you are sure you want to delete it, run 'git branch -D %s'.\n",
+			branch, branch);
+		exit(1);
+	}
 
-		if (delete_ref(name, sha1))
-			printf("Error deleting branch '%s'\n", argv[i]);
-		else
-			printf("Deleted branch %s.\n", argv[i]);
+	if (delete_ref(name, sha1))
+		printf("Error deleting branch '%s'\n", branch);
+	else
+		printf("Deleted branch %s.\n", branch);
 
-		free(name);
-	}
+	free(name);
+}
+
+static void delete_branches(int argc, const char **argv, int force)
+{
+	struct commit *head_rev;
+	int i;
+	
+	head_rev = lookup_commit_reference(head_sha1);
+	if (!head_rev)
+		die("Couldn't look up commit object for current HEAD.");
+	for (i = 0; i < argc; i++) 
+		delete_branch(argv[i], force, head_rev);
 }
 
 #define REF_UNKNOWN_TYPE    0x00
@@ -200,15 +208,18 @@ static void print_ref_list(int kinds, in
 	free_ref_list(&ref_list);
 }
 
-static void create_branch(const char *name, const char *start,
+static char *create_branch(const char *name, const char *start,
 			  int force, int reflog)
 {
 	struct ref_lock *lock;
 	struct commit *commit;
 	unsigned char sha1[20];
-	char ref[PATH_MAX], msg[PATH_MAX + 20];
+	char *ref, msg[PATH_MAX + 20];
+	int reflen;
 
-	snprintf(ref, sizeof ref, "refs/heads/%s", name);
+	reflen = strlen(name) + 12;
+	ref = xmalloc(reflen+1);
+	snprintf(ref, reflen, "refs/heads/%s", name);
 	if (check_ref_format(ref))
 		die("'%s' is not a valid branch name.", name);
 
@@ -235,12 +246,30 @@ static void create_branch(const char *na
 
 	if (write_ref_sha1(lock, sha1, msg) < 0)
 		die("Failed to write ref: %s.", strerror(errno));
+	return ref;
+}
+
+static void rename_branch(const char *newname, const char *oldname, int force, int reflog)
+{
+	char ref[PATH_MAX];
+
+	snprintf(ref, sizeof ref, "refs/heads/%s", oldname);
+	if (check_ref_format(ref))
+		die("'%s' is not a valid branch name.", oldname);
+
+	newname = create_branch(newname, oldname, force, reflog);
+	if (!strcmp(oldname, head)) {
+		create_symref("HEAD", newname);
+		head = newname + 11;
+	}
+	delete_branch(oldname, force, NULL);
 }
 
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, force_delete = 0, force_create = 0;
 	int verbose = 0, abbrev = DEFAULT_ABBREV;
+	int rename = 0;
 	int reflog = 0;
 	int kinds = REF_LOCAL_BRANCH;
 	int i;
@@ -269,6 +298,10 @@ int cmd_branch(int argc, const char **ar
 			force_create = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--rename")) {
+			rename = 1;
+			continue;
+		}
 		if (!strcmp(arg, "-r")) {
 			kinds = REF_REMOTE_BRANCH;
 			continue;
@@ -303,6 +336,10 @@ int cmd_branch(int argc, const char **ar
 		delete_branches(argc - i, argv + i, force_delete);
 	else if (i == argc)
 		print_ref_list(kinds, verbose, abbrev);
+	else if (rename && (i == argc - 1))
+		rename_branch(argv[i], head, force_create, reflog);
+	else if (rename && (i == argc - 2))
+		rename_branch(argv[i], argv[i + 1], force_create, reflog);
 	else if (i == argc - 1)
 		create_branch(argv[i], head, force_create, reflog);
 	else if (i == argc - 2)
-- 
1.4.4
