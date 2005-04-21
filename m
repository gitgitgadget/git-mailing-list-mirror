From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH] Set AUTHOR_DATE in git-tools
Date: Thu, 21 Apr 2005 17:32:16 +1000
Message-ID: <1114068737.29135.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 09:29:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOW7d-00071S-3H
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 09:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVDUHd0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 03:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVDUHdZ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 03:33:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55977 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261463AbVDUHdC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 03:33:02 -0400
Received: from [150.203.247.9] (helo=[172.24.3.18])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DOWBF-0004RK-RA; Thu, 21 Apr 2005 08:33:01 +0100
To: torvalds@osdl.org
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Entirely untested.

Makefile: eca3a5d5256cca06d86ebb85ec9d3218752ffcd2
applypatch: 397e4a0e506f1c5765767057dfe506154b743b83
--- a/applypatch
+++ b/applypatch
@@ -26,6 +26,7 @@ EDIT=${EDIT:-vi}
 
 export AUTHOR_NAME="$(sed -n '/^Author/ s/Author: //p' .dotest/info)"
 export AUTHOR_EMAIL="$(sed -n '/^Email/ s/Email: //p' .dotest/info)"
+export AUTHOR_DATE="$(sed -n '/^Date/ s/Date: //p' .dotest/info)"
 export SUBJECT="$(sed -n '/^Subject/ s/Subject: //p' .dotest/info)"
 
 if [ -n "$signoff" -a -f "$signoff" ]; then
dotest: a3e3d35ae0afa358f01b49eecb358d64c616c3e4
mailinfo.c: c1dcac130530174ec5335d2c752d76403ad1d3ad
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -13,6 +13,7 @@ static char line[1000];
 static char name[1000];
 static char email[1000];
 static char subject[1000];
+static char date[1000];
 
 static char *sanity_check(char *name, char *email)
 {
@@ -83,6 +84,11 @@ static void handle_subject(char *line)
 	strcpy(subject, line);
 }
 
+static void handle_date(char *line)
+{
+	strcpy(date, line);
+}
+
 static void add_subject_line(char *line)
 {
 	while (isspace(*line))
@@ -99,6 +105,11 @@ static void check_line(char *line, int l
 		cont = 0;
 		return;
 	}
+	if (!memcmp(line, "Date:", 5) && isspace(line[5])) {
+		handle_date(line+6);
+		cont = 0;
+		return;
+	}
 	if (!memcmp(line, "Subject:", 8) && isspace(line[8])) {
 		handle_subject(line+9);
 		cont = 1;
@@ -107,7 +118,7 @@ static void check_line(char *line, int l
 	if (isspace(*line)) {
 		switch (cont) {
 		case 0:
-			fprintf(stderr, "I don't do 'From:' line continuations\n");
+			fprintf(stderr, "I don't do 'From:' or 'Date:' header continuations\n");
 			break;
 		case 1:
 			add_subject_line(line);
@@ -215,7 +226,8 @@ static void handle_rest(void)
 	cleanup_space(name);
 	cleanup_space(email);
 	cleanup_space(sub);
-	printf("Author: %s\nEmail: %s\nSubject: %s\n\n", name, email, sub);
+	cleanup_space(date);
+	printf("Author: %s\nEmail: %s\nSubject: %s\nDate: %s\n", name, email, sub, date);
 	FILE *out = cmitmsg;
 
 	do {
mailsplit.c: 9379fbc5e84983e5ea0754a6587cc3490c696c69

-- 
dwmw2

