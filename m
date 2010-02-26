From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH v2 2/3] git-core: Support retrieving passwords with GIT_ASKPASS
Date: Fri, 26 Feb 2010 08:12:34 +0800
Message-ID: <1267143154-5020-1-git-send-email-lznuaa@gmail.com>
Cc: gitster@pobox.com, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 01:12:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nknp8-00056b-4s
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 01:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934678Ab0BZAMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 19:12:49 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:50427 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934593Ab0BZAMs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 19:12:48 -0500
Received: by pzk2 with SMTP id 2so1884566pzk.22
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 16:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=HZVLy8Q5/5e1nEh37mOd6nLl+DaJ3rQuBrbl8LHrnGs=;
        b=LSBlzV1/iCIcJ3WrqIXn38tTC3tIsQeSTWnrWGHmFsRULEydaBZyj/7yyKfKgQAnTC
         nZMTYVUcvepByBtL5a1UhtsSSBfAKXwxyNhTVXKgEs06WwmwZHcbh/fX+NeTsCoahx7V
         BKIl1DGC8bIZ57VBs0GuuZAlnM/uX060hqk6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=bqE70WjKwZm24YzISrJ1n8hba452SkE0Ri+vTpJxW4uI7KkyW2TUBQvbJZA6wIA5Uo
         it7/Pk0ZrjBJ/72cXSEFloTafcXZ9AxMXUM3NAz53eKtwRVUH/rJN1iF7a1/ISFm+7C4
         YvlDwsCrQ5/2JFV/uuv+WGLBr+66ytTXHsakA=
Received: by 10.115.101.29 with SMTP id d29mr339476wam.20.1267143167622;
        Thu, 25 Feb 2010 16:12:47 -0800 (PST)
Received: from localhost ([114.93.102.82])
        by mx.google.com with ESMTPS id 20sm2693639pzk.15.2010.02.25.16.12.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Feb 2010 16:12:46 -0800 (PST)
X-Mailer: git-send-email 1.6.5.1.1367.gcd48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141081>

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
