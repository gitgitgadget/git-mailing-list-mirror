From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Subject: [PATCH v3 1/2] git-imap-send: Add CRAM-MD5 authenticate method support
Date: Fri, 12 Feb 2010 00:06:25 +0900
Message-ID: <1265900785-12044-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
References: <40aa078e1002110655n120b14b9y242a57d0e1bd3e96@mail.gmail.com>
Cc: git@vger.kernel.org, Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 11 16:06:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfacm-00059s-Jf
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 16:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756297Ab0BKPGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 10:06:31 -0500
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:64376 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756258Ab0BKPGa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 10:06:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id CFEE3EAF9E2;
	Fri, 12 Feb 2010 00:06:29 +0900 (JST)
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6jjiaqulUwwG; Fri, 12 Feb 2010 00:06:29 +0900 (JST)
Received: from localhost.localdomain (FL1-122-130-141-251.tky.mesh.ad.jp [122.130.141.251])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 5FE93EAF9DB;
	Fri, 12 Feb 2010 00:06:29 +0900 (JST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <40aa078e1002110655n120b14b9y242a57d0e1bd3e96@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139605>

This patch makes git-imap-send CRAM-MD5 authenticate method ready.
In theory, CRAM-MD5 authenticate method doesn't depend on SSL,
but for easy of maintainance, this patch uses base64 and md5 stuffs of OpenSSL.
So if you want to use CRAM-MD5 authenticate method,
you have to build git-imap-send with OpenSSL library.

v3: Erik's noticed that there were some garbage lines in this patch.
I removed these. And 2/2 wasn't changed, I'm sending 1/2 only.

Cc: Erik Faye-Lund <kusmabite@googlemail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff King <peff@peff.net>
Signed-off-by: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
---
 Documentation/git-imap-send.txt |    4 +
 imap-send.c                     |  141 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 128 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 57db955..6cafbe2 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -71,6 +71,10 @@ imap.preformattedHTML::
 	option causes Thunderbird to send the patch as a plain/text,
 	format=fixed email.  Default is `false`.
 
+imap.authMethod::
+	Specify authenticate method for authentication with IMAP server.
+	Current supported method is 'CRAM-MD5' only.
+
 Examples
 ~~~~~~~~
 
diff --git a/imap-send.c b/imap-send.c
index ba72fa4..caa4e1b 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -25,10 +25,16 @@
 #include "cache.h"
 #include "exec_cmd.h"
 #include "run-command.h"
+
 #ifdef NO_OPENSSL
 typedef void *SSL;
+#else
+#include <openssl/evp.h>
+#include <openssl/hmac.h>
 #endif
 
+static int login;
+
 struct store_conf {
 	char *name;
 	const char *path; /* should this be here? its interpretation is driver-specific */
@@ -140,6 +146,20 @@ struct imap_server_conf {
 	int use_ssl;
 	int ssl_verify;
 	int use_html;
+	char *auth_method;
+};
+
+static struct imap_server_conf server = {
+	NULL,	/* name */
+	NULL,	/* tunnel */
+	NULL,	/* host */
+	0,	/* port */
+	NULL,	/* user */
+	NULL,	/* pass */
+	0,   	/* use_ssl */
+	1,   	/* ssl_verify */
+	0,   	/* use_html */
+	NULL,	/* auth_method */
 };
 
 struct imap_store_conf {
@@ -214,6 +234,7 @@ enum CAPABILITY {
 	LITERALPLUS,
 	NAMESPACE,
 	STARTTLS,
+	AUTH_CRAM_MD5,
 };
 
 static const char *cap_list[] = {
@@ -222,6 +243,7 @@ static const char *cap_list[] = {
 	"LITERAL+",
 	"NAMESPACE",
 	"STARTTLS",
+	"AUTH=CRAM-MD5",
 };
 
 #define RESP_OK    0
@@ -526,8 +548,9 @@ static struct imap_cmd *v_issue_imap_cmd(struct imap_store *ctx,
 		get_cmd_result(ctx, NULL);
 
 	bufl = nfsnprintf(buf, sizeof(buf), cmd->cb.data ? CAP(LITERALPLUS) ?
-			   "%d %s{%d+}\r\n" : "%d %s{%d}\r\n" : "%d %s\r\n",
-			   cmd->tag, cmd->cmd, cmd->cb.dlen);
+			  "%d %s{%d+}\r\n" : "%d %s{%d}\r\n" : "%d %s\r\n",
+			  cmd->tag, cmd->cmd, cmd->cb.dlen);
+
 	if (Verbose) {
 		if (imap->num_in_progress)
 			printf("(%d in progress) ", imap->num_in_progress);
@@ -949,6 +972,72 @@ static void imap_close_store(struct store *ctx)
 	free(ctx);
 }
 
+/*
+ * hexchar() and cram() functions are
+ * based on ones of isync project ... http://isync.sf.net/
+ * Thanks!
+ */
+static char hexchar(unsigned int b)
+{
+	return b < 10 ? '0' + b : 'a' + (b - 10);
+}
+
+#ifndef NO_OPENSSL
+
+static char *cram(const char *challenge_64, const char *user, const char *pass)
+{
+	int i;
+	HMAC_CTX hmac;
+	char hash[16], hex[33], challenge[256], response[256];
+	char *response_64;
+
+	memset(challenge, 0, 256);
+	EVP_DecodeBlock((unsigned char *)challenge, (unsigned char *)challenge_64, strlen(challenge_64));
+	HMAC_Init(&hmac, (unsigned char *)pass, strlen(pass), EVP_md5());
+	HMAC_Update(&hmac, (unsigned char *)challenge, strlen(challenge));
+	HMAC_Final(&hmac, (unsigned char *)hash, NULL);
+
+	hex[32] = 0;
+	for (i = 0; i < 16; i++) {
+		hex[2 * i] = hexchar((hash[i] >> 4) & 0xf);
+		hex[2 * i + 1] = hexchar(hash[i] & 0xf);
+	}
+
+	memset(response, 0, 256);
+	snprintf(response, 256, "%s %s", user, hex);
+
+	response_64 = calloc(256 , sizeof(char));
+	EVP_EncodeBlock((unsigned char *)response_64, (unsigned char *)response, strlen(response));
+	return response_64;
+}
+
+#else
+
+static char *cram(const char *challenge_64 __used, const char *user __used, const char *pass __used)
+{
+	fprintf(stderr, "If you want to use CRAM-MD5 authenticate method,"
+		"you have to build git-imap-send with OpenSSL library\n");
+	exit(0);
+}
+
+#endif
+
+static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd *cmd, const char *prompt)
+{
+	int ret;
+	char *response;
+
+	response = cram(prompt, server.user, server.pass);
+	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
+	if (ret != strlen(response)) {
+		fprintf(stderr, "IMAP error: sending response failed\n");
+		return -1;
+	}
+	free(response);
+
+	return 0;
+}
+
 static struct store *imap_open_store(struct imap_server_conf *srvc)
 {
 	struct imap_store *ctx;
@@ -1130,10 +1219,37 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 		if (!imap->buf.sock.ssl)
 			imap_warn("*** IMAP Warning *** Password is being "
 				  "sent in the clear\n");
-		if (imap_exec(ctx, NULL, "LOGIN \"%s\" \"%s\"", srvc->user, srvc->pass) != RESP_OK) {
-			fprintf(stderr, "IMAP error: LOGIN failed\n");
-			goto bail;
+
+		if (srvc->auth_method) {
+			struct imap_cmd_cb cb;
+
+			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
+				if (!CAP(AUTH_CRAM_MD5)) {
+					fprintf(stderr, "You specified"
+						"CRAM-MD5 as authentication method, "
+						"but %s doesn't support it.\n", srvc->host);
+					goto bail;
+				}
+				/* CRAM-MD5 */
+
+				memset(&cb, 0, sizeof(cb));
+				cb.cont = auth_cram_md5;
+				if (imap_exec(ctx, &cb, "AUTHENTICATE CRAM-MD5") != RESP_OK) {
+					fprintf(stderr, "IMAP error: AUTHENTICATE CRAM-MD5 failed\n");
+					goto bail;
+				}
+				login = 1;
+			} else {
+				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
+				goto bail;
+			}
 		}
+
+		if (!login)
+			if (imap_exec(ctx, NULL, "LOGIN \"%s\" \"%s\"", srvc->user, srvc->pass) != RESP_OK) {
+				fprintf(stderr, "IMAP error: LOGIN failed\n");
+				goto bail;
+			}
 	} /* !preauth */
 
 	ctx->prefix = "";
@@ -1310,18 +1426,6 @@ static int split_msg(struct msg_data *all_msgs, struct msg_data *msg, int *ofs)
 	return 1;
 }
 
-static struct imap_server_conf server = {
-	NULL,	/* name */
-	NULL,	/* tunnel */
-	NULL,	/* host */
-	0,	/* port */
-	NULL,	/* user */
-	NULL,	/* pass */
-	0,   	/* use_ssl */
-	1,   	/* ssl_verify */
-	0,   	/* use_html */
-};
-
 static char *imap_folder;
 
 static int git_imap_config(const char *key, const char *val, void *cb)
@@ -1361,6 +1465,9 @@ static int git_imap_config(const char *key, const char *val, void *cb)
 		server.port = git_config_int(key, val);
 	else if (!strcmp("tunnel", key))
 		server.tunnel = xstrdup(val);
+	else if (!strcmp("authmethod", key))
+		server.auth_method = xstrdup(val);
+
 	return 0;
 }
 
-- 
1.6.5.2
