From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 1/2] Refactor print-functions in builtin-branch
Date: Wed,  3 Jan 2007 21:10:09 +0100
Message-ID: <11678550112285-git-send-email-hjemli@gmail.com>
References: <11678550103703-git-send-email-hjemli@gmail.com>
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 03 21:08:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2CPC-0002ls-MW
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 21:08:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbXACUII (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 15:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbXACUIH
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 15:08:07 -0500
Received: from mail48.e.nsc.no ([193.213.115.48]:64018 "EHLO mail48.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932070AbXACUIG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 15:08:06 -0500
Received: from localhost.localdomain (ti231210a080-8960.bb.online.no [80.212.179.6])
	by mail48.nsc.no (8.13.8/8.13.5) with ESMTP id l03K806r018889;
	Wed, 3 Jan 2007 21:08:01 +0100 (CET)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.5.0.rc0.ge900
In-Reply-To: <11678550103703-git-send-email-hjemli@gmail.com>
Message-Id: <ec7218855930593c29c5ced76630ff7844947e6b.1167849110.git.hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This moves the guts of print_ref_list() into a revamped print_ref_info(),
which at the same time gets renamed to print_ref_item().

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 builtin-branch.c |   83 ++++++++++++++++++++++++++----------------------------
 1 files changed, 40 insertions(+), 43 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 71f88f2..b9a8bae 100644
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
 
 static void print_ref_list(int kinds, int verbose, int abbrev)
 {
 	int i;
-	char c;
 	struct ref_list ref_list;
-	int color;
 
 	memset(&ref_list, 0, sizeof(ref_list));
 	ref_list.kinds = kinds;
@@ -262,38 +287,10 @@ static void print_ref_list(int kinds, int verbose, int abbrev)
 	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
 
 	for (i = 0; i < ref_list.index; i++) {
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
-
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
+		int current = (ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
+			!strcmp(ref_list.list[i].name, head);
+		print_ref_item(&ref_list.list[i], ref_list.maxwidth, verbose, 
+			       abbrev, current);
 	}
 
 	free_ref_list(&ref_list);
-- 
1.5.0.rc0.ge900
