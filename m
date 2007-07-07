From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] Use /etc/mailname for the hostname part of the email address.
Date: Fri,  6 Jul 2007 19:21:05 -0700
Message-ID: <11837748652889-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <kraai@asturias.ftbfs.org>, Matt Kraai <kraai@ftbfs.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 07 04:21:27 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6zvG-0002un-47
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 04:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614AbXGGCVL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 22:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753602AbXGGCVK
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 22:21:10 -0400
Received: from neon.ftbfs.org ([83.168.236.214]:57555 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753574AbXGGCVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 22:21:09 -0400
Received: from pool-71-104-149-201.lsanca.dsl-w.verizon.net ([71.104.149.201] helo=asturias.ftbfs.org)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1I703r-0007F6-8C; Fri, 06 Jul 2007 19:30:16 -0700
Received: from kraai by asturias.ftbfs.org with local (Exim 4.67)
	(envelope-from <kraai@ftbfs.org>)
	id 1I6zuz-0005Sb-7O; Fri, 06 Jul 2007 19:21:05 -0700
X-Mailer: git-send-email 1.5.2.3
X-Spam-Score: -3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51800>

From: Matt Kraai <kraai@asturias.ftbfs.org>

/etc/mailname contains the hostname to be used on outgoing email
messages generated locally on Debian systems (cf.
http://www.debian.org/doc/debian-policy/ch-customized-programs.html).
If it available, use it instead of gethostname or gethostbyname.

Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---

	If this is only appropriate for the Debian package, I
	apologize.  Please let me know if this is the case and I'll
	submit it to the Debian maintainer.

 ident.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/ident.c b/ident.c
index 6612d17..3d05ae2 100644
--- a/ident.c
+++ b/ident.c
@@ -43,6 +43,27 @@ static void copy_gecos(const struct passwd *w, char *name, size_t sz)
 
 }
 
+static int getmailname(char *name, size_t len)
+{
+	FILE *f = fopen("/etc/mailname", "r");
+	int i;
+
+	if (!f)
+		return -1;
+	if (!fgets(name, len, f)) {
+		fclose(f);
+		return -1;
+	}
+	fclose(f);
+	for (i = 0; !isspace(name[i]); i++)
+		;
+	if (name[i - 1] != '.')
+		name[i] = '\0';
+	else
+		name[i - 1] = '\0';
+	return 0;
+}
+
 static void copy_email(const struct passwd *pw)
 {
 	/*
@@ -54,7 +75,10 @@ static void copy_email(const struct passwd *pw)
 		die("Your sysadmin must hate you!");
 	memcpy(git_default_email, pw->pw_name, len);
 	git_default_email[len++] = '@';
-	gethostname(git_default_email + len, sizeof(git_default_email) - len);
+	if (getmailname(git_default_email + len,
+			sizeof(git_default_email) - len) < 0)
+		gethostname(git_default_email + len,
+			    sizeof(git_default_email) - len);
 	if (!strchr(git_default_email+len, '.')) {
 		struct hostent *he = gethostbyname(git_default_email + len);
 		char *domainname;
-- 
1.5.2.3
