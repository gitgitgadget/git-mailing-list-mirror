From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/4] revert: refactor commit code into a new run_git_commit()
	function
Date: Wed, 14 Jul 2010 01:28:13 +0200
Message-ID: <20100713232816.7738.67812.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 11:27:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZKiy-0008Dx-VU
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 11:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932880Ab0GOJ1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 05:27:17 -0400
Received: from smtp2f.orange.fr ([80.12.242.151]:14919 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932874Ab0GOJ1P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 05:27:15 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f14.orange.fr (SMTP Server) with ESMTP id 09C138000599;
	Thu, 15 Jul 2010 11:27:15 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f14.orange.fr (SMTP Server) with ESMTP id ECB188000428;
	Thu, 15 Jul 2010 11:27:14 +0200 (CEST)
Received: from style.boubyland (ANantes-156-1-132-89.w90-12.abo.wanadoo.fr [90.12.251.89])
	by mwinf2f14.orange.fr (SMTP Server) with ESMTP id 5BB6A80005E7;
	Thu, 15 Jul 2010 11:27:14 +0200 (CEST)
X-ME-UUID: 20100715092714375.5BB6A80005E7@mwinf2f14.orange.fr
X-git-sha1: 24735642432a91ace0c23916442838b317e8ffa0 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151065>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   52 +++++++++++++++++++++++++++-------------------------
 1 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index b082bb4..b84b5b8 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -361,6 +361,32 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	return !clean;
 }
 
+/*
+ * If we are cherry-pick, and if the merge did not result in
+ * hand-editing, we will hit this commit and inherit the original
+ * author date and name.
+ * If we are revert, or if our cherry-pick results in a hand merge,
+ * we had better say that the current user is responsible for that.
+ */
+static int run_git_commit(const char *defmsg)
+{
+	/* 6 is max possible length of our args array including NULL */
+	const char *args[6];
+	int i = 0;
+
+	args[i++] = "commit";
+	args[i++] = "-n";
+	if (signoff)
+		args[i++] = "-s";
+	if (!edit) {
+		args[i++] = "-F";
+		args[i++] = defmsg;
+	}
+	args[i] = NULL;
+
+	return run_command_v_opt(args, RUN_GIT_CMD);
+}
+
 static int do_pick_commit(void)
 {
 	unsigned char head[20];
@@ -501,33 +527,9 @@ static int do_pick_commit(void)
 	if (res)
 		return 1;
 
-	/*
-	 *
-	 * If we are cherry-pick, and if the merge did not result in
-	 * hand-editing, we will hit this commit and inherit the original
-	 * author date and name.
-	 * If we are revert, or if our cherry-pick results in a hand merge,
-	 * we had better say that the current user is responsible for that.
-	 */
-
 	if (!no_commit) {
-		/* 6 is max possible length of our args array including NULL */
-		const char *args[6];
-		int res;
-		int i = 0;
-
-		args[i++] = "commit";
-		args[i++] = "-n";
-		if (signoff)
-			args[i++] = "-s";
-		if (!edit) {
-			args[i++] = "-F";
-			args[i++] = defmsg;
-		}
-		args[i] = NULL;
-		res = run_command_v_opt(args, RUN_GIT_CMD);
+		res = run_git_commit(defmsg);
 		free(defmsg);
-
 		return res;
 	}
 
-- 
1.7.2.rc1.215.g2dff2.dirty
