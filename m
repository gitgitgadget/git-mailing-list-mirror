From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/7] revert: refactor code to find commit subject in
	find_commit_subject()
Date: Thu, 22 Jul 2010 15:18:30 +0200
Message-ID: <20100722131836.2148.58435.chriscool@tuxfamily.org>
References: <20100722131141.2148.63850.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 15:34:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obvui-00053b-RM
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 15:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759366Ab0GVNeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 09:34:13 -0400
Received: from smtp2f.orange.fr ([80.12.242.152]:57320 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758807Ab0GVNeI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 09:34:08 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 9BBDF8002749;
	Thu, 22 Jul 2010 15:34:07 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 8CF4C80021FE;
	Thu, 22 Jul 2010 15:34:07 +0200 (CEST)
Received: from style.boubyland (ANantes-156-1-132-203.w90-12.abo.wanadoo.fr [90.12.251.203])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 20D608002985;
	Thu, 22 Jul 2010 15:34:02 +0200 (CEST)
X-ME-UUID: 20100722133405134.20D608002985@mwinf2f18.orange.fr
X-git-sha1: 59f81b0d379400b527267c8c19356d6cb388ffd3 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100722131141.2148.63850.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151450>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   34 ++++++++++++++++++++++------------
 1 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 3092233..ed89bba 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -99,10 +99,30 @@ struct commit_message {
 	const char *message;
 };
 
+/* Find beginning and length of commit subject. */
+static int find_commit_subject(const char *commit_buffer, const char **subject)
+{
+	const char *eol;
+	const char *p = commit_buffer;
+
+	while (*p && (*p != '\n' || p[1] != '\n'))
+		p++;
+	if (*p) {
+		p += 2;
+		for (eol = p; *eol && *eol != '\n'; eol++)
+			; /* do nothing */
+	} else
+		eol = p;
+
+	*subject = p;
+
+	return eol - p;
+}
+
 static int get_message(const char *raw_message, struct commit_message *out)
 {
 	const char *encoding;
-	const char *p, *abbrev, *eol;
+	const char *p, *abbrev;
 	char *q;
 	int abbrev_len, oneline_len;
 
@@ -125,17 +145,7 @@ static int get_message(const char *raw_message, struct commit_message *out)
 	abbrev = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
 	abbrev_len = strlen(abbrev);
 
-	/* Find beginning and end of commit subject. */
-	p = out->message;
-	while (*p && (*p != '\n' || p[1] != '\n'))
-		p++;
-	if (*p) {
-		p += 2;
-		for (eol = p; *eol && *eol != '\n'; eol++)
-			; /* do nothing */
-	} else
-		eol = p;
-	oneline_len = eol - p;
+	oneline_len = find_commit_subject(out->message, &p);
 
 	out->parent_label = xmalloc(strlen("parent of ") + abbrev_len +
 			      strlen("... ") + oneline_len + 1);
-- 
1.7.2.rc3.267.g400b3
