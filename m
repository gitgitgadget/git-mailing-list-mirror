From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 2/2] git-branch: show detached HEAD
Date: Wed,  3 Jan 2007 21:10:10 +0100
Message-ID: <11678550122079-git-send-email-hjemli@gmail.com>
References: <11678550103703-git-send-email-hjemli@gmail.com>
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 03 21:08:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2CPK-0002o0-Na
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 21:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbXACUIJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 15:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbXACUII
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 15:08:08 -0500
Received: from mail48.e.nsc.no ([193.213.115.48]:64019 "EHLO mail48.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932071AbXACUIG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 15:08:06 -0500
Received: from localhost.localdomain (ti231210a080-8960.bb.online.no [80.212.179.6])
	by mail48.nsc.no (8.13.8/8.13.5) with ESMTP id l03K806s018889;
	Wed, 3 Jan 2007 21:08:02 +0100 (CET)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.5.0.rc0.ge900
In-Reply-To: <11678550103703-git-send-email-hjemli@gmail.com>
Message-Id: <2ffb0289d95e442df58ba3c3082b31b81f59399c.1167849110.git.hjemli@gmail.com>
In-Reply-To: <ec7218855930593c29c5ced76630ff7844947e6b.1167849110.git.hjemli@gmail.com>
References: <ec7218855930593c29c5ced76630ff7844947e6b.1167849110.git.hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This makes git-branch show a detached HEAD as '* (no branch)'.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 builtin-branch.c |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index b9a8bae..f04718d 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -275,7 +275,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 	}
 }
 
-static void print_ref_list(int kinds, int verbose, int abbrev)
+static void print_ref_list(int kinds, int detached, int verbose, int abbrev)
 {
 	int i;
 	struct ref_list ref_list;
@@ -286,8 +286,20 @@ static void print_ref_list(int kinds, int verbose, int abbrev)
 
 	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
 
+	detached = (detached && (kinds & REF_LOCAL_BRANCH));
+	if (detached) {
+		struct ref_item item;
+		item.name = "(no branch)";
+		item.kind = REF_LOCAL_BRANCH;
+		hashcpy(item.sha1, head_sha1);
+		if (strlen(item.name) > ref_list.maxwidth)
+			      ref_list.maxwidth = strlen(item.name);
+		print_ref_item(&item, ref_list.maxwidth, verbose, abbrev, 1);
+	}
+
 	for (i = 0; i < ref_list.index; i++) {
-		int current = (ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
+		int current = !detached &&
+			(ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
 			!strcmp(ref_list.list[i].name, head);
 		print_ref_item(&ref_list.list[i], ref_list.maxwidth, verbose, 
 			       abbrev, current);
@@ -377,7 +389,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, force_delete = 0, force_create = 0;
 	int rename = 0, force_rename = 0;
-	int verbose = 0, abbrev = DEFAULT_ABBREV;
+	int verbose = 0, abbrev = DEFAULT_ABBREV, detached = 0;
 	int reflog = 0;
 	int kinds = REF_LOCAL_BRANCH;
 	int i;
@@ -455,8 +467,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (!head)
 		die("Failed to resolve HEAD as a valid ref.");
 	if (!strcmp(head, "HEAD")) {
-		/* detached HEAD */
-		;
+		detached = 1;
 	}
 	else {
 		if (strncmp(head, "refs/heads/", 11))
@@ -467,7 +478,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (delete)
 		return delete_branches(argc - i, argv + i, force_delete, kinds);
 	else if (i == argc)
-		print_ref_list(kinds, verbose, abbrev);
+		print_ref_list(kinds, detached, verbose, abbrev);
 	else if (rename && (i == argc - 1))
 		rename_branch(head, argv[i], force_rename);
 	else if (rename && (i == argc - 2))
-- 
1.5.0.rc0.ge900
