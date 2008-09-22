From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] git-remote: do not use user input in a printf format string
Date: Mon, 22 Sep 2008 13:03:25 +0200
Message-ID: <1222081405-12113-1-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 22 13:06:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhjEn-0002gJ-8f
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 13:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbYIVLDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 07:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752444AbYIVLDa
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 07:03:30 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:45059 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbYIVLD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 07:03:29 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1KhjCQ-0003eW-Dg; Mon, 22 Sep 2008 13:03:26 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 27F166EF; Mon, 22 Sep 2008 13:03:26 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id F3110FA46; Mon, 22 Sep 2008 13:03:25 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.281.g8a3c6
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96472>

'git remote show' substituted the remote name into a string that was later
used as a printf format string. If a remote name contains a printf format
specifier like this:

   $ git remote add foo%sbar .

then the command

   $ git remote show foo%sbar

would print garbage (if you are lucky) or crash. This fixes it.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 builtin-remote.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 01945a8..890a680 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -407,14 +407,15 @@ static int rm(int argc, const char **argv)
 	return i;
 }
 
-static void show_list(const char *title, struct string_list *list)
+static void show_list(const char *title, struct string_list *list,
+		      const char *extra_arg)
 {
 	int i;
 
 	if (!list->nr)
 		return;
 
-	printf(title, list->nr > 1 ? "es" : "");
+	printf(title, list->nr > 1 ? "es" : "", extra_arg);
 	printf("\n    ");
 	for (i = 0; i < list->nr; i++)
 		printf("%s%s", i ? " " : "", list->items[i].string);
@@ -503,18 +504,16 @@ static int show(int argc, const char **argv)
 		}
 
 		if (!no_query) {
-			strbuf_init(&buf, 0);
-			strbuf_addf(&buf, "  New remote branch%%s (next fetch "
-				"will store in remotes/%s)", states.remote->name);
-			show_list(buf.buf, &states.new);
-			strbuf_release(&buf);
+			show_list("  New remote branch%s (next fetch "
+				"will store in remotes/%s)",
+				&states.new, states.remote->name);
 			show_list("  Stale tracking branch%s (use 'git remote "
-				"prune')", &states.stale);
+				"prune')", &states.stale, "");
 		}
 
 		if (no_query)
 			for_each_ref(append_ref_to_tracked_list, &states);
-		show_list("  Tracked remote branch%s", &states.tracked);
+		show_list("  Tracked remote branch%s", &states.tracked, "");
 
 		if (states.remote->push_refspec_nr) {
 			printf("  Local branch%s pushed with 'git push'\n   ",
-- 
1.6.0.1.281.g8a3c6
