X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] shortlog: handle email addresses case-insensitively
Date: Sun, 19 Nov 2006 17:29:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611191728580.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 19 Nov 2006 16:29:31 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31838>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlpXi-00010m-W5 for gcvg-git@gmane.org; Sun, 19 Nov
 2006 17:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756757AbWKSQ3Q (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 11:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756758AbWKSQ3Q
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 11:29:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:12974 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1756757AbWKSQ3P (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 11:29:15 -0500
Received: (qmail invoked by alias); 19 Nov 2006 16:29:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp014) with SMTP; 19 Nov 2006 17:29:14 +0100
To: junkio@cox.net, git@vger.kernel.org
Sender: git-owner@vger.kernel.org


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-shortlog.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index afc9456..4775c11 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -34,6 +34,7 @@ static int read_mailmap(const char *file
 	while (fgets(buffer, sizeof(buffer), f) != NULL) {
 		char *end_of_name, *left_bracket, *right_bracket;
 		char *name, *email;
+		int i;
 		if (buffer[0] == '#')
 			continue;
 		if ((left_bracket = strchr(buffer, '<')) == NULL)
@@ -50,7 +51,9 @@ static int read_mailmap(const char *file
 		name = xmalloc(end_of_name - buffer + 1);
 		strlcpy(name, buffer, end_of_name - buffer + 1);
 		email = xmalloc(right_bracket - left_bracket);
-		strlcpy(email, left_bracket + 1, right_bracket - left_bracket);
+		for (i = 0; i < right_bracket - left_bracket - 1; i++)
+			email[i] = tolower(left_bracket[i + 1]);
+		email[right_bracket - left_bracket - 1] = '\0';
 		path_list_insert(email, &mailmap)->util = name;
 	}
 	fclose(f);
@@ -68,6 +71,9 @@ static int map_email(char *email, char *
 		return 0;
 
 	*p = '\0';
+	/* downcase the email address */
+	for (p = email; *p; p++)
+		*p = tolower(*p);
 	item = path_list_lookup(email, &mailmap);
 	if (item != NULL) {
 		const char *realname = (const char *)item->util;
-- 
1.4.4.GIT
