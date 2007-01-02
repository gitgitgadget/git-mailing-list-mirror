From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] git-branch: show detached HEAD
Date: Wed,  3 Jan 2007 00:22:11 +0100
Message-ID: <1167780131528-git-send-email-hjemli@gmail.com>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 03 06:12:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1yQF-0008K2-C8
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 06:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964AbXACFMN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 00:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753623AbXACFMN
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 00:12:13 -0500
Received: from mail49.e.nsc.no ([193.213.115.49]:38993 "EHLO mail49.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752964AbXACFML (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 00:12:11 -0500
X-Greylist: delayed 21126 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 00:12:10 EST
Received: from localhost.localdomain (ti231210a080-8960.bb.online.no [80.212.179.6])
	by mail49.nsc.no (8.13.8/8.13.5) with ESMTP id l02NK0jZ029678;
	Wed, 3 Jan 2007 00:20:00 +0100 (CET)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.5.0.rc0.g76033
In-Reply-To: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35841>

This makes git-branch show a detached HEAD as '* (no branch)'.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

This might be a premature patch. But if/when we allow HEAD to be detached, 
git-branch should tell us that HEAD is the current 'branch'.

 builtin-branch.c |  103 +++++++++++++++++++++++++++++-------------------------
 1 files changed, 55 insertions(+), 48 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 71f88f2..16f86cc 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -231,29 +231,54 @@ static int ref_cmp(const void *r1, const void *r2)
 	return strcmp(c1->name, c2->name);
 }
 
-static void print_ref_info(const unsigned char *sha1, int abbrev)
+static void print_ref_item(struct ref_item *item, int maxwidth, int verbose, 
+			   int abbrev, int current)
 {
+	char c;
+	int color;
 	struct commit *commit;
 	char subject[256];
 
+	switch (item->kind) {
+	case REF_LOCAL_BRANCH:
+		color = COLOR_BRANCH_LOCAL;
+		break;
+	case REF_REMOTE_BRANCH:
+		color = COLOR_BRANCH_REMOTE;
+		break;
+	default:
+		color = COLOR_BRANCH_PLAIN;
+		break;
+	}
 
-	commit = lookup_commit(sha1);
-	if (commit && !parse_commit(commit))
-		pretty_print_commit(CMIT_FMT_ONELINE, commit, ~0,
-				    subject, sizeof(subject), 0,
-				    NULL, NULL, 0);
-	else
-		strcpy(subject, " **** invalid ref ****");
+	c = ' ';
+	if (current) {
+		c = '*';
+		color = COLOR_BRANCH_CURRENT;
+	}
 
-	printf(" %s %s\n", find_unique_abbrev(sha1, abbrev), subject);
+	if (verbose) {
+		commit = lookup_commit(item->sha1);
+		if (commit && !parse_commit(commit))
+			pretty_print_commit(CMIT_FMT_ONELINE, commit, ~0,
+					    subject, sizeof(subject), 0,
+					    NULL, NULL, 0);
+		else
+			strcpy(subject, " **** invalid ref ****");
+		printf("%c %s%-*s%s %s %s\n", c, branch_get_color(color),
+		       maxwidth, item->name,
+		       branch_get_color(COLOR_BRANCH_RESET),
+		       find_unique_abbrev(item->sha1, abbrev), subject);
+	} else {
+		printf("%c %s%s%s\n", c, branch_get_color(color), item->name,
+		       branch_get_color(COLOR_BRANCH_RESET));
+	}
 }
 
-static void print_ref_list(int kinds, int verbose, int abbrev)
+static void print_ref_list(int kinds, int verbose, int abbrev, int detached)
 {
 	int i;
-	char c;
 	struct ref_list ref_list;
-	int color;
 
 	memset(&ref_list, 0, sizeof(ref_list));
 	ref_list.kinds = kinds;
@@ -261,39 +286,22 @@ static void print_ref_list(int kinds, int verbose, int abbrev)
 
 	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
 
-	for (i = 0; i < ref_list.index; i++) {
-		switch( ref_list.list[i].kind ) {
-			case REF_LOCAL_BRANCH:
-				color = COLOR_BRANCH_LOCAL;
-				break;
-			case REF_REMOTE_BRANCH:
-				color = COLOR_BRANCH_REMOTE;
-				break;
-			default:
-				color = COLOR_BRANCH_PLAIN;
-				break;
-		}
-
-		c = ' ';
-		if (ref_list.list[i].kind == REF_LOCAL_BRANCH &&
-				!strcmp(ref_list.list[i].name, head)) {
-			c = '*';
-			color = COLOR_BRANCH_CURRENT;
-		}
+	if (detached && (kinds & REF_LOCAL_BRANCH)) {
+		struct ref_item item;
+		item.name = "(no branch)";
+		item.kind = REF_LOCAL_BRANCH;
+		hashcpy(item.sha1, head_sha1);
+		if (strlen(item.name) > ref_list.maxwidth)
+			      ref_list.maxwidth = strlen(item.name);
+		print_ref_item(&item, ref_list.maxwidth, verbose, abbrev, 1);
+	}
 
-		if (verbose) {
-			printf("%c %s%-*s%s", c,
-					branch_get_color(color),
-					ref_list.maxwidth,
-					ref_list.list[i].name,
-					branch_get_color(COLOR_BRANCH_RESET));
-			print_ref_info(ref_list.list[i].sha1, abbrev);
-		}
-		else
-			printf("%c %s%s%s\n", c,
-					branch_get_color(color),
-					ref_list.list[i].name,
-					branch_get_color(COLOR_BRANCH_RESET));
+	for (i = 0; i < ref_list.index; i++) {
+		int current = !(detached && (kinds & REF_LOCAL_BRANCH)) &&
+			(ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
+			!strcmp(ref_list.list[i].name, head);
+		print_ref_item(&ref_list.list[i], ref_list.maxwidth, verbose, 
+			       abbrev, current);
 	}
 
 	free_ref_list(&ref_list);
@@ -380,7 +388,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, force_delete = 0, force_create = 0;
 	int rename = 0, force_rename = 0;
-	int verbose = 0, abbrev = DEFAULT_ABBREV;
+	int verbose = 0, abbrev = DEFAULT_ABBREV, detached = 0;
 	int reflog = 0;
 	int kinds = REF_LOCAL_BRANCH;
 	int i;
@@ -458,8 +466,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (!head)
 		die("Failed to resolve HEAD as a valid ref.");
 	if (!strcmp(head, "HEAD")) {
-		/* detached HEAD */
-		;
+		detached = 1;
 	}
 	else {
 		if (strncmp(head, "refs/heads/", 11))
@@ -470,7 +477,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (delete)
 		return delete_branches(argc - i, argv + i, force_delete, kinds);
 	else if (i == argc)
-		print_ref_list(kinds, verbose, abbrev);
+		print_ref_list(kinds, verbose, abbrev, detached);
 	else if (rename && (i == argc - 1))
 		rename_branch(head, argv[i], force_rename);
 	else if (rename && (i == argc - 2))
-- 
1.5.0.rc0.g76033
