From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/3] builtin-branch: use strbuf in fill_tracking_info()
Date: Mon, 17 Nov 2008 21:48:36 +0100
Message-ID: <5dee4e908190e7a4ed4a693fdf0fb3b3af88fc57.1226954771.git.vmiklos@frugalware.org>
References: <cover.1226954771.git.vmiklos@frugalware.org>
 <b3716161b2a3d508ec4306623c5c8889d9367e1d.1226954771.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 21:49:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2B1v-00027S-Gt
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 21:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178AbYKQUrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 15:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752207AbYKQUrh
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 15:47:37 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:52935 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbYKQUrd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 15:47:33 -0500
Received: from vmobile.example.net (dsl5401C78D.pool.t-online.hu [84.1.199.141])
	by yugo.frugalware.org (Postfix) with ESMTPA id B119B446CD0;
	Mon, 17 Nov 2008 21:47:31 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 1305319D92B; Mon, 17 Nov 2008 21:48:38 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <b3716161b2a3d508ec4306623c5c8889d9367e1d.1226954771.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1226954771.git.vmiklos@frugalware.org>
References: <cover.1226954771.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101243>

This is just about using the API, though in case of ~ 10^100 commits,
this would fix the problem of writing to unallocated memory as well. ;-)

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-branch.c |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index b9149b7..c8a8e2a 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -279,7 +279,7 @@ static int ref_cmp(const void *r1, const void *r2)
 	return strcmp(c1->name, c2->name);
 }
 
-static void fill_tracking_info(char *stat, const char *branch_name)
+static void fill_tracking_info(struct strbuf *stat, const char *branch_name)
 {
 	int ours, theirs;
 	struct branch *branch = branch_get(branch_name);
@@ -287,11 +287,11 @@ static void fill_tracking_info(char *stat, const char *branch_name)
 	if (!stat_tracking_info(branch, &ours, &theirs) || (!ours && !theirs))
 		return;
 	if (!ours)
-		sprintf(stat, "[behind %d] ", theirs);
+		strbuf_addf(stat, "[behind %d] ", theirs);
 	else if (!theirs)
-		sprintf(stat, "[ahead %d] ", ours);
+		strbuf_addf(stat, "[ahead %d] ", ours);
 	else
-		sprintf(stat, "[ahead %d, behind %d] ", ours, theirs);
+		strbuf_addf(stat, "[ahead %d, behind %d] ", ours, theirs);
 }
 
 static int matches_merge_filter(struct commit *commit)
@@ -334,11 +334,8 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 	}
 
 	if (verbose) {
-		struct strbuf subject = STRBUF_INIT;
+		struct strbuf subject = STRBUF_INIT, stat = STRBUF_INIT;
 		const char *sub = " **** invalid ref ****";
-		char stat[128];
-
-		stat[0] = '\0';
 
 		commit = item->commit;
 		if (commit && !parse_commit(commit)) {
@@ -348,13 +345,14 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 		}
 
 		if (item->kind == REF_LOCAL_BRANCH)
-			fill_tracking_info(stat, item->name);
+			fill_tracking_info(&stat, item->name);
 
 		printf("%c %s%-*s%s %s %s%s\n", c, branch_get_color(color),
 		       maxwidth, item->name,
 		       branch_get_color(COLOR_BRANCH_RESET),
 		       find_unique_abbrev(item->commit->object.sha1, abbrev),
-		       stat, sub);
+		       stat.buf, sub);
+		strbuf_release(&stat);
 		strbuf_release(&subject);
 	} else {
 		printf("%c %s%s%s\n", c, branch_get_color(color), item->name,
-- 
1.6.0.2
