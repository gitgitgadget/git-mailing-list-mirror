X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/3] shortlog: do not crash on parsing "[PATCH"
Date: Sun, 19 Nov 2006 17:28:25 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611191727560.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 19 Nov 2006 16:28:35 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31836>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlpWw-0000r1-Bs for gcvg-git@gmane.org; Sun, 19 Nov
 2006 17:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756754AbWKSQ22 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 11:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756756AbWKSQ22
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 11:28:28 -0500
Received: from mail.gmx.de ([213.165.64.20]:1697 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1756754AbWKSQ21 (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 11:28:27 -0500
Received: (qmail invoked by alias); 19 Nov 2006 16:28:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp029) with SMTP; 19 Nov 2006 17:28:25 +0100
To: junkio@cox.net, git@vger.kernel.org
Sender: git-owner@vger.kernel.org


Annoyingly, it looked for the closing bracket in the author name
instead of in the message, and then accessed the NULL pointer.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-shortlog.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 48a2a0b..26212b0 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -108,13 +108,15 @@ static void insert_author_oneline(struct
 		free(buffer);
 
 	if (!strncmp(oneline, "[PATCH", 6)) {
-		char *eob = strchr(buffer, ']');
-
-		while (isspace(eob[1]) && eob[1] != '\n')
-			eob++;
-		if (eob - oneline < onelinelen) {
-			onelinelen -= eob - oneline;
-			oneline = eob;
+		char *eob = strchr(oneline, ']');
+
+		if (eob) {
+			while (isspace(eob[1]) && eob[1] != '\n')
+				eob++;
+			if (eob - oneline < onelinelen) {
+				onelinelen -= eob - oneline;
+				oneline = eob;
+			}
 		}
 	}
 
-- 
1.4.4.GIT
