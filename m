From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH 2/3] git-core: Support retrieving passwords with GIT_ASKPASS
Date: Wed, 24 Feb 2010 23:14:45 +0800
Message-ID: <1267024485-4076-1-git-send-email-lznuaa@gmail.com>
Cc: gitster@pobox.com, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 16:15:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkIx7-0007C5-49
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 16:15:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119Ab0BXPPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 10:15:00 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61668 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755994Ab0BXPO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 10:14:59 -0500
Received: by pwj8 with SMTP id 8so4896910pwj.19
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 07:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=HZVLy8Q5/5e1nEh37mOd6nLl+DaJ3rQuBrbl8LHrnGs=;
        b=iGhiS0GoDsEe+rUXoMrCTeSHSZn3WVwbIWP4BrkJFQhrvxOjTf1FJy6FXNn9CCUWT2
         hpvpRNkBXAPcjcA0a3G/Qz8DIYov+pdtDZUYna/Z4AcUNuk/F1UiTHDBIhd8UkDYge5h
         VnOgT1N/jgcrfpx6Z0RG4+ZTdQ8JAas0baDh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MzChzP/KbZA6TbbTur0DpiWu+ZMw4bBjoJq/0MWOFZ9c7EJ8+gT6L+brXPyB1Ft8qI
         UV65G2FJaKl2tWEALk+3Tc/rdAMHtTVTzQvF9nhSquMG05R9a7lw5MSv3B5rWrK8/hfZ
         VqY/aAUgtQgcrcKbVQb5NdatB3p+awVysv+CQ=
Received: by 10.114.188.31 with SMTP id l31mr734936waf.119.1267024498412;
        Wed, 24 Feb 2010 07:14:58 -0800 (PST)
Received: from localhost ([114.93.102.82])
        by mx.google.com with ESMTPS id 22sm912457pzk.13.2010.02.24.07.14.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 07:14:57 -0800 (PST)
X-Mailer: git-send-email 1.6.5.1.1367.gcd48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140946>

imap-send and authority http connect reads passwords from an interactive
terminal. This behavious cause GUIs to hang waiting for git complete.

Fix this problem by allowing a password-retrieving command
to be specified in GIT_ASKPASS

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 connect.c   |   40 ++++++++++++++++++++++++++++++++++++++++
 http.c      |    4 ++--
 imap-send.c |    2 +-
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/connect.c b/connect.c
index a37cf6a..6a8e3ab 100644
--- a/connect.c
+++ b/connect.c
@@ -647,3 +647,43 @@ int finish_connect(struct child_process *conn)
 	free(conn);
 	return code;
 }
+
+char *git_getpass(char *prompt)
+{
+	char *askpass;
+	struct child_process pass;
+	const char *args[3];
+	struct strbuf buffer = STRBUF_INIT;
+	int i = 0;
+
+	askpass = getenv("GIT_ASKPASS");
+	if (askpass && strlen(askpass) != 0) {
+		args[0] = getenv("GIT_ASKPASS");
+		args[1]	= prompt;
+		args[2] = NULL;
+
+		memset(&pass, 0, sizeof(pass));
+		pass.argv = args;
+		pass.out = -1;
+		pass.no_stdin = 1;
+		pass.no_stderr = 1;
+
+		if (start_command(&pass)) {
+			error("could not run %s\n", askpass);
+			return getpass(prompt);
+		}
+
+		strbuf_read(&buffer, pass.out, 20);
+		close(pass.out);
+		for (i = 0; i < buffer.len; i++)
+			if (buffer.buf[i] == '\n' || buffer.buf[i] == '\r') {
+				buffer.buf[i] = '\0';
+				buffer.len = i;
+		}
+		return strbuf_detach(&buffer, NULL);
+
+	} else {
+		return getpass(prompt);
+	}
+	return NULL;
+}
diff --git a/http.c b/http.c
index deab595..4814217 100644
--- a/http.c
+++ b/http.c
@@ -204,7 +204,7 @@ static void init_curl_http_auth(CURL *result)
 	if (user_name) {
 		struct strbuf up = STRBUF_INIT;
 		if (!user_pass)
-			user_pass = xstrdup(getpass("Password: "));
+			user_pass = xstrdup(git_getpass("Password: "));
 		strbuf_addf(&up, "%s:%s", user_name, user_pass);
 		curl_easy_setopt(result, CURLOPT_USERPWD,
 				 strbuf_detach(&up, NULL));
@@ -219,7 +219,7 @@ static int has_cert_password(void)
 		return 0;
 	/* Only prompt the user once. */
 	ssl_cert_password_required = -1;
-	ssl_cert_password = getpass("Certificate Password: ");
+	ssl_cert_password = git_getpass("Certificate Password: ");
 	if (ssl_cert_password != NULL) {
 		ssl_cert_password = xstrdup(ssl_cert_password);
 		return 1;
diff --git a/imap-send.c b/imap-send.c
index 5631930..5254b2a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1107,7 +1107,7 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 		if (!srvc->pass) {
 			char prompt[80];
 			sprintf(prompt, "Password (%s@%s): ", srvc->user, srvc->host);
-			arg = getpass(prompt);
+			arg = git_getpass(prompt);
 			if (!arg) {
 				perror("getpass");
 				exit(1);
-- 
1.7.0.85.g37fda.dirty
