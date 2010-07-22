From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 7/7] blame: use find_commit_subject() instead of custom code
Date: Thu, 22 Jul 2010 15:18:35 +0200
Message-ID: <20100722131836.2148.2717.chriscool@tuxfamily.org>
References: <20100722131141.2148.63850.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 15:35:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obvvv-0005i6-Mf
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 15:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759423Ab0GVNet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 09:34:49 -0400
Received: from smtp2f.orange.fr ([80.12.242.152]:62546 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759060Ab0GVNer (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 09:34:47 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id A274480027CC;
	Thu, 22 Jul 2010 15:34:46 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 9361280028A5;
	Thu, 22 Jul 2010 15:34:46 +0200 (CEST)
Received: from style.boubyland (ANantes-156-1-132-203.w90-12.abo.wanadoo.fr [90.12.251.203])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 0D57880027CC;
	Thu, 22 Jul 2010 15:34:44 +0200 (CEST)
X-ME-UUID: 20100722133446547.0D57880027CC@mwinf2f18.orange.fr
X-git-sha1: 400b32dae9c83e5f86379d7c5b010161ac2a328a 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100722131141.2148.63850.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151454>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/blame.c |   22 +++++++---------------
 1 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 01e62fd..437b1a4 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1407,7 +1407,8 @@ static void get_commit_info(struct commit *commit,
 			    int detailed)
 {
 	int len;
-	char *tmp, *endp, *reencoded, *message;
+	const char *subject;
+	char *reencoded, *message;
 	static char author_name[1024];
 	static char author_mail[1024];
 	static char committer_name[1024];
@@ -1449,22 +1450,13 @@ static void get_commit_info(struct commit *commit,
 		    &ret->committer_time, &ret->committer_tz);
 
 	ret->summary = summary_buf;
-	tmp = strstr(message, "\n\n");
-	if (!tmp) {
-	error_out:
+	len = find_commit_subject(message, &subject);
+	if (len && len < sizeof(summary_buf)) {
+		memcpy(summary_buf, subject, len);
+		summary_buf[len] = 0;
+	} else {
 		sprintf(summary_buf, "(%s)", sha1_to_hex(commit->object.sha1));
-		free(reencoded);
-		return;
 	}
-	tmp += 2;
-	endp = strchr(tmp, '\n');
-	if (!endp)
-		endp = tmp + strlen(tmp);
-	len = endp - tmp;
-	if (len >= sizeof(summary_buf) || len == 0)
-		goto error_out;
-	memcpy(summary_buf, tmp, len);
-	summary_buf[len] = 0;
 	free(reencoded);
 }
 
-- 
1.7.2.rc3.267.g400b3
