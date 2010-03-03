From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH v4 2/3] git-core: Support retrieving passwords with GIT_ASKPASS
Date: Wed,  3 Mar 2010 19:36:48 +0800
Message-ID: <1267616208-3844-1-git-send-email-lznuaa@gmail.com>
Cc: gitster@pobox.com, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 03 12:37:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmmt4-0007Ub-TR
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 12:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671Ab0CCLhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 06:37:05 -0500
Received: from mail-px0-f188.google.com ([209.85.216.188]:47628 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab0CCLhE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 06:37:04 -0500
Received: by pxi26 with SMTP id 26so450235pxi.1
        for <git@vger.kernel.org>; Wed, 03 Mar 2010 03:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=i6A0TceUgwFBHdWctKXgpzzajjokjYXljjIVWMUyPoI=;
        b=ccD5aeZ8cTor6vec/zTSh9ZlWifQD73YUfyN/NhiOPvyGSvBS/CPxeCrz5r4DSpea8
         HJisq6dbTVZvWaWzSDPU+hcEQ1gDfBDurWmtPM+RQn76X7FYJ4TO312zQn77kIgKMw5Y
         8P3pCGbu70IBr5cT8ug/0ifVnrb4SzQbFqujE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ffkvMpFXuooRcIh/oubNK6X/L7RGnjCM5u8K7dcsJCN5cQyMalCnDlMavqjuG2MZDI
         +O5h12UngYgY4jGlQ3ytnxsUEb/rDrdRpvzNKEr+ova/qQtE5VWvz5Wgr6lNtE0x0nEb
         u/HvdOA6gXCGpO0vT0Z0uND/WS2Hf19umNkj4=
Received: by 10.140.55.17 with SMTP id d17mr4149482rva.10.1267616222159;
        Wed, 03 Mar 2010 03:37:02 -0800 (PST)
Received: from localhost ([114.93.102.82])
        by mx.google.com with ESMTPS id 20sm5724085pzk.11.2010.03.03.03.37.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Mar 2010 03:37:01 -0800 (PST)
X-Mailer: git-send-email 1.6.5.1.1367.gcd48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141444>

imap-send and authority http connect reads passwords from an interactive
terminal. This behavious cause GUIs to hang waiting for git complete.

Fix this problem by allowing a password-retrieving command
to be specified in GIT_ASKPASS

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 cache.h     |    1 +
 connect.c   |   39 +++++++++++++++++++++++++++++++++++++++
 http.c      |    4 ++--
 imap-send.c |    2 +-
 4 files changed, 43 insertions(+), 3 deletions(-)

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
index a37cf6a..8d45ab9 100644
--- a/connect.c
+++ b/connect.c
@@ -647,3 +647,42 @@ int finish_connect(struct child_process *conn)
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
+
+	if (start_command(&pass))
+		exit(1);
+
+	if (strbuf_read(&buffer, pass.out, 20) < 0)
+		exit(1);
+
+	close(pass.out);
+
+	if (finish_command(&pass))
+		exit(1);
+
+	strbuf_setlen(&buffer, strcspn(buffer.buf, "\r\n"));
+
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
1.7.0.86.g013a4.dirty
