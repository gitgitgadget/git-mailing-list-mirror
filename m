From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v5-j6t 2/3] git-core: Support retrieving passwords with GIT_ASKPASS
Date: Thu, 4 Mar 2010 20:59:50 +0100
Message-ID: <201003042059.51516.j6t@kdbg.org>
References: <1267713364-2976-1-git-send-email-lznuaa@gmail.com> <7vd3zk6j01.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 23:37:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnHOF-0000LW-Bp
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 21:11:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757001Ab0CDUBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 15:01:35 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:37946 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756285Ab0CDUBe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 15:01:34 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3CDCE10021;
	Thu,  4 Mar 2010 21:01:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id BD87219F5CA;
	Thu,  4 Mar 2010 20:59:51 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7vd3zk6j01.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141543>

From: Frank Li <lznuaa@gmail.com>

git tries to read a password from the terminal in imap-send and
when talking to a http server that requires authentication.

When a GUI is driving git, however, the end user is not paying
attention to the terminal (there may not even be a terminal).
GUI would appear to hang forever.

Fix this problem by allowing a password-retrieving command
to be specified in GIT_ASKPASS

Signed-off-by: Frank Li <lznuaa@gmail.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Here is a cleaned-up version.

 I changed the code to make struct strbuf buffer itself static and fixed
 the error message. I removed the comment about the memory leak again
 because now the buffer is conceptually static even though behind the
 scenes it points to allocated memory.

 Frank, I did not test it beyond the test suite. Please test and say
 no or go.

 -- Hannes

 cache.h     |    1 +
 connect.c   |   37 +++++++++++++++++++++++++++++++++++++
 http.c      |    4 ++--
 imap-send.c |    2 +-
 4 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index d454b7e..06f3b73 100644
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
index 4748caf..5e9d29c 100644
--- a/connect.c
+++ b/connect.c
@@ -624,3 +624,40 @@ int finish_connect(struct child_process *conn)
 	free(conn);
 	return code;
 }
+
+char *git_getpass(const char *prompt)
+{
+	char *askpass;
+	struct child_process pass;
+	const char *args[3];
+	static struct strbuf buffer = STRBUF_INIT;
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
+
+	if (start_command(&pass))
+		exit(1);
+
+	strbuf_reset(&buffer);
+	if (strbuf_read(&buffer, pass.out, 20) < 0)
+		die("failed to read password from %s\n", askpass);
+
+	close(pass.out);
+
+	if (finish_command(&pass))
+		exit(1);
+
+	strbuf_setlen(&buffer, strcspn(buffer.buf, "\r\n"));
+
+	return buffer.buf;
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
index fa70383..aeb2985 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1207,7 +1207,7 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 		if (!srvc->pass) {
 			char prompt[80];
 			sprintf(prompt, "Password (%s@%s): ", srvc->user, srvc->host);
-			arg = getpass(prompt);
+			arg = git_getpass(prompt);
 			if (!arg) {
 				perror("getpass");
 				exit(1);
-- 
1.7.0.rc2.65.g7b13a
