From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH v3 2/3] git-core: Support retrieving passwords with GIT_ASKPASS
Date: Tue,  2 Mar 2010 19:50:57 +0800
Message-ID: <1267530657-4848-1-git-send-email-lznuaa@gmail.com>
Cc: gitster@pobox.com, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 02 12:58:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmQkQ-0003mv-N4
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 12:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795Ab0CBL6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 06:58:41 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:40542 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478Ab0CBL6k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 06:58:40 -0500
Received: by pva4 with SMTP id 4so44656pva.19
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 03:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=6MR5ccoEjm72x7sgacUaZNYVNoZ5/G5JEcO0S99ogfo=;
        b=rW8JEzyQgdBfJ5QpSlxbO/FrToyukBXDtwmYm2maEhNHx1mvP0wCdNOTRVEROkcOTq
         4X9dmcr/h64B7Ds3i2NwIIAHI8OK7vRZ8CWyLQ/fpFe8STC1u1a3o73mfNVUJBGIZG9J
         MWXSw2YHEzkTW6q0Jh6XopMHCnNjMIjuTV1CE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=V8JJrIKOxA6Rvt2FqqXSbWqrpRvI9IYXZK/eebQL/IDOQ9ldUclcyGEN29MxWxT6kb
         nm3k7+0tp+oxxq9TIuu9eL1eMFChoHxlQX4wWlC1sEOqUWC1DPf3P9YCHOZre80jP1R8
         MXd8L1yR5TEAXmXp7wdm7eEVbUXX6LSweSrbU=
Received: by 10.140.247.17 with SMTP id u17mr3224434rvh.246.1267530674345;
        Tue, 02 Mar 2010 03:51:14 -0800 (PST)
Received: from localhost ([114.93.102.82])
        by mx.google.com with ESMTPS id 21sm4598205pzk.4.2010.03.02.03.51.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Mar 2010 03:51:13 -0800 (PST)
X-Mailer: git-send-email 1.6.5.1.1367.gcd48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141391>

imap-send and authority http connect reads passwords from an interactive
terminal. This behavious cause GUIs to hang waiting for git complete.

Fix this problem by allowing a password-retrieving command
to be specified in GIT_ASKPASS

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 cache.h     |    1 +
 connect.c   |   41 +++++++++++++++++++++++++++++++++++++++++
 http.c      |    4 ++--
 imap-send.c |    2 +-
 4 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index d478eff..a25d269 100644
--- a/cache.h
+++ b/cache.h
@@ -877,6 +877,7 @@ struct ref {
 extern struct ref *find_ref_by_name(const struct ref *list, const char *name);
 
 #define CONNECT_VERBOSE       (1u << 0)
+extern char *git_getpass(const char *prompt);
 extern struct child_process *git_connect(int fd[2], const char *url, const char *prog, int flags);
 extern int finish_connect(struct child_process *conn);
 extern int path_match(const char *path, int nr, char **match);
diff --git a/connect.c b/connect.c
index a37cf6a..3fd0c16 100644
--- a/connect.c
+++ b/connect.c
@@ -647,3 +647,44 @@ int finish_connect(struct child_process *conn)
 	free(conn);
 	return code;
 }
+
+char *git_getpass(const char *prompt)
+{
+	char *askpass;
+	struct child_process pass;
+	const char *args[3];
+	struct strbuf buffer = STRBUF_INIT;
+	int i = 0;
+
+	askpass = getenv("GIT_ASKPASS");
+
+	if (!askpass || !(*askpass))
+		return getpass(prompt);
+
+	args[0] = askpass;
+	args[1]	= prompt;
+	args[2] = NULL;
+
+	memset(&pass, 0, sizeof(pass));
+	pass.argv = args;
+	pass.out = -1;
+	pass.use_shell = 1;
+
+	if (start_command(&pass)) {
+		error("could not run %s\n", askpass);
+		exit(1);
+	}
+
+	strbuf_read(&buffer, pass.out, 20);
+	close(pass.out);
+	finish_command(&pass);
+
+	for (i = 0; i < buffer.len; i++)
+		if (buffer.buf[i] == '\n' || buffer.buf[i] == '\r') {
+			buffer.buf[i] = '\0';
+			buffer.len = i;
+		}
+	/*it maybe memory leak because getpass return a static buffer*/
+	return strbuf_detach(&buffer, NULL);
+}
+
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
1.7.0.86.g45191
