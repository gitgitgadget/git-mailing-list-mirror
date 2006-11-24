X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Add -v and --abbrev options to git-branch
Date: Fri, 24 Nov 2006 14:45:10 +0100
Message-ID: <1164375910450-git-send-email-hjemli@gmail.com>
NNTP-Posting-Date: Fri, 24 Nov 2006 13:45:32 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32217>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnbMl-0006iI-D1 for gcvg-git@gmane.org; Fri, 24 Nov
 2006 14:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934423AbWKXNpO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 08:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934523AbWKXNpO
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 08:45:14 -0500
Received: from mail49.e.nsc.no ([193.213.115.49]:10466 "EHLO
 mail49.e.nsc.no") by vger.kernel.org with ESMTP id S934423AbWKXNpM (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 08:45:12 -0500
Received: from localhost.localdomain (ti231210a080-2784.bb.online.no
 [80.213.122.226]) by mail49.nsc.no (8.13.8/8.13.5) with ESMTP id
 kAODjAo1007838 for <git@vger.kernel.org>; Fri, 24 Nov 2006 14:45:11 +0100
 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

The new -v option makes git-branch show the abbreviated sha1 + subjectline
for each branch.

Additionally, minimum abbreviation length can be specified with
--abbrev=<length>

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/git-branch.txt |    9 +++++++-
 builtin-branch.c             |   46 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 5376760..4f5b5d5 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -8,7 +8,7 @@ git-branch - List, create, or delete bra
 SYNOPSIS
 --------
 [verse]
-'git-branch' [-r] [-a]
+'git-branch' [-r] [-a] [-v] [--abbrev=<length>]
 'git-branch' [-l] [-f] <branchname> [<start-point>]
 'git-branch' (-d | -D) <branchname>...
 
@@ -52,6 +52,13 @@ OPTIONS
 -a::
 	List both remote-tracking branches and local branches.
 
+-v::
+	Show sha1 and subject message for each head.
+
+--abbrev=<length>::
+	Alter minimum display length for sha1 in output listing,
+	default value is 7.
+
 <branchname>::
 	The name of the branch to create or delete.
 	The new branch name must pass all checks defined by
diff --git a/builtin-branch.c b/builtin-branch.c
index 22e3285..f14d814 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -11,7 +11,7 @@
 #include "builtin.h"
 
 static const char builtin_branch_usage[] =
-"git-branch (-d | -D) <branchname> | [-l] [-f] <branchname> [<start-point>] | [-r] | [-a]";
+"git-branch (-d | -D) <branchname> | [-l] [-f] <branchname> [<start-point>] | [-r | -a] [-v] [--abbrev=<length>] ";
 
 
 static const char *head;
@@ -87,10 +87,11 @@ static void delete_branches(int argc, co
 struct ref_item {
 	char *name;
 	unsigned int kind;
+	unsigned char sha1[20];
 };
 
 struct ref_list {
-	int index, alloc;
+	int index, alloc, maxwidth;
 	struct ref_item *list;
 	int kinds;
 };
@@ -100,6 +101,7 @@ static int append_ref(const char *refnam
 	struct ref_list *ref_list = (struct ref_list*)(cb_data);
 	struct ref_item *newitem;
 	int kind = REF_UNKNOWN_TYPE;
+	int len;
 
 	/* Detect kind */
 	if (!strncmp(refname, "refs/heads/", 11)) {
@@ -128,6 +130,10 @@ static int append_ref(const char *refnam
 	newitem = &(ref_list->list[ref_list->index++]);
 	newitem->name = xstrdup(refname);
 	newitem->kind = kind;
+	memcpy(newitem->sha1, sha1, 20);
+	len = strlen(newitem->name);
+	if (len > ref_list->maxwidth)
+		ref_list->maxwidth = len;
 
 	return 0;
 }
@@ -151,7 +157,24 @@ static int ref_cmp(const void *r1, const
 	return strcmp(c1->name, c2->name);
 }
 
-static void print_ref_list(int kinds)
+static void print_ref_info(const unsigned char *sha1, int abbrev)
+{
+	struct commit *commit;
+	char subject[256];
+
+
+	commit = lookup_commit(sha1);
+	if (commit && !parse_commit(commit))
+		pretty_print_commit(CMIT_FMT_ONELINE, commit, ~0, 
+				    subject, sizeof(subject), 0, 
+				    NULL, NULL, 0);
+	else
+		sprintf(subject, " **** invalid ref ****");
+
+	printf(" %s %s", find_unique_abbrev(sha1, abbrev), subject);
+}
+
+static void print_ref_list(int kinds, int verbose, int abbrev)
 {
 	int i;
 	char c;
@@ -169,9 +192,11 @@ static void print_ref_list(int kinds)
 				!strcmp(ref_list.list[i].name, head))
 			c = '*';
 
-		printf("%c %s\n", c, ref_list.list[i].name);
+		printf("%c %-*s", c, ref_list.maxwidth, ref_list.list[i].name);
+		if (verbose)
+			print_ref_info(ref_list.list[i].sha1, abbrev);
+		printf("\n");	
 	}
-
 	free_ref_list(&ref_list);
 }
 
@@ -215,6 +240,7 @@ static void create_branch(const char *na
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, force_delete = 0, force_create = 0;
+	int verbose = 0, abbrev = DEFAULT_ABBREV;
 	int reflog = 0;
 	int kinds = REF_LOCAL_BRANCH;
 	int i;
@@ -255,6 +281,14 @@ int cmd_branch(int argc, const char **ar
 			reflog = 1;
 			continue;
 		}
+		if (!strncmp(arg, "--abbrev=", 9)) {
+			abbrev = atoi(arg+9);
+			continue;
+		}
+		if (!strcmp(arg, "-v")) {
+			verbose = 1;
+			continue;
+		}
 		usage(builtin_branch_usage);
 	}
 
@@ -268,7 +302,7 @@ int cmd_branch(int argc, const char **ar
 	if (delete)
 		delete_branches(argc - i, argv + i, force_delete);
 	else if (i == argc)
-		print_ref_list(kinds);
+		print_ref_list(kinds, verbose, abbrev);
 	else if (i == argc - 1)
 		create_branch(argv[i], head, force_create, reflog);
 	else if (i == argc - 2)
-- 
1.4.4
