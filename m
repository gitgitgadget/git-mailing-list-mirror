Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 10428 invoked by uid 107); 13 Feb 2010 06:58:46 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sat, 13 Feb 2010 01:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575Ab0BMG4x (ORCPT <rfc822;peff@peff.net>);
	Sat, 13 Feb 2010 01:56:53 -0500
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:49972 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325Ab0BMG4w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 01:56:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 1EA96EC0453;
	Sat, 13 Feb 2010 15:56:51 +0900 (JST)
X-Quarantine-ID: <xxrXIrKCGDDf>
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
X-Amavis-Alert:	BAD HEADER, Duplicate header field: "To"
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xxrXIrKCGDDf; Sat, 13 Feb 2010 15:56:50 +0900 (JST)
Received: from localhost.localdomain (fw-cisco.dcl.info.waseda.ac.jp [133.9.216.204])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id B48A1EC044F;
	Sat, 13 Feb 2010 15:56:50 +0900 (JST)
From:	Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
To:	gitster@pobox.com
Cc:	Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>
Subject: [PATCH v5 1/2] git-imap-send: Add CRAM-MD5 authenticate method support
Date:	Sat, 13 Feb 2010 15:56:40 +0900
Message-Id: <1266044200-11925-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <4B764B67.1020402@dcl.info.waseda.ac.jp>
References: <4B764B67.1020402@dcl.info.waseda.ac.jp>
To:	gitster@pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This patch makes git-imap-send CRAM-MD5 authenticate method ready.
In theory, CRAM-MD5 authenticate method doesn't depend on SSL.
But for easiness of maintainance, this patch uses base64 and md5 stuffs of OpenSSL.
So if you want to use CRAM-MD5 authenticate method,
you have to build git-imap-send with OpenSSL library.

Cc: Erik Faye-Lund <kusmabite@googlemail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff King <peff@peff.net>
Signed-off-by: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
---

v3: Erik noticed that there were some garbage lines in this patch.
I removed these. And 2/2 wasn't changed, I'm sending 1/2 only.

v4: Based on Junio's indication, I cleaned up some points of imap-send.c .

v5: Based on Erik's advice, cram() now uses die() if git-imap-send
is built with NO_OPENSSL.
And based on Junio's indication, some error checking code are added.

 Documentation/git-imap-send.txt |    4 +
 imap-send.c                     |  154 +++++++++++++++++++++++++++++++++++----
 2 files changed, 143 insertions(+), 15 deletions(-)

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
index ba72fa4..20f18b2 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -25,8 +25,12 @@
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
 
 struct store_conf {
@@ -140,6 +144,20 @@ struct imap_server_conf {
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
@@ -214,6 +232,7 @@ enum CAPABILITY {
 	LITERALPLUS,
 	NAMESPACE,
 	STARTTLS,
+	AUTH_CRAM_MD5,
 };
 
 static const char *cap_list[] = {
@@ -222,6 +241,7 @@ static const char *cap_list[] = {
 	"LITERAL+",
 	"NAMESPACE",
 	"STARTTLS",
+	"AUTH=CRAM-MD5",
 };
 
 #define RESP_OK    0
@@ -949,6 +969,94 @@ static void imap_close_store(struct store *ctx)
 	free(ctx);
 }
 
+#ifndef NO_OPENSSL
+
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
+#define ENCODED_SIZE(n) (4 * ((n + 2) / 3))
+static char *cram(const char *challenge_64, const char *user, const char *pass)
+{
+	int i, ret, resp_len;
+	HMAC_CTX hmac;
+	unsigned char hash[16];
+	char hex[33];
+	char *challenge, *response;
+	char *response_64;
+
+	/*
+	 * challenge must be shorter than challenge_64
+	 * because we are decoding base64
+	 */
+	challenge = xcalloc(strlen(challenge_64) + 1, sizeof(char));
+	ret = EVP_DecodeBlock((unsigned char *)challenge,
+			      (unsigned char *)challenge_64, strlen(challenge_64));
+	if (ret != strlen(challenge) + 1) {
+		free(challenge);
+		return NULL;
+	}
+	HMAC_Init(&hmac, (unsigned char *)pass, strlen(pass), EVP_md5());
+	HMAC_Update(&hmac, (unsigned char *)challenge, strlen(challenge));
+	HMAC_Final(&hmac, hash, NULL);
+	HMAC_CTX_cleanup(&hmac);
+	free(challenge);
+
+	hex[32] = 0;
+	for (i = 0; i < 16; i++) {
+		hex[2 * i] = hexchar((hash[i] >> 4) & 0xf);
+		hex[2 * i + 1] = hexchar(hash[i] & 0xf);
+	}
+
+	/* length: "<user> <digest in hex>" */
+	resp_len = strlen(user) + 1 + strlen(hex) + 1;
+	response = xcalloc(resp_len, sizeof(char));
+	snprintf(response, resp_len, "%s %s", user, hex);
+
+	response_64 = xcalloc(ENCODED_SIZE(resp_len), sizeof(char));
+	ret = EVP_EncodeBlock((unsigned char *)response_64,
+			      (unsigned char *)response, strlen(response));
+	if (ret != strlen(response_64)) {
+		free(response_64);
+		return NULL;
+	}
+	return response_64;
+}
+
+#else
+
+static char *cram(const char *challenge_64, const char *user, const char *pass)
+{
+	die("If you want to use CRAM-MD5 authenticate method,"
+	    "you have to build git-imap-send with OpenSSL library\n");
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
+	if (!response)
+		return error("IMAP error: generating response failed\n");
+
+	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
+	if (ret != strlen(response))
+		return error("IMAP error: sending response failed\n");
+
+	free(response);
+
+	return 0;
+}
+
 static struct store *imap_open_store(struct imap_server_conf *srvc)
 {
 	struct imap_store *ctx;
@@ -1130,9 +1238,34 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
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
+			} else {
+				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
+				goto bail;
+			}
+		} else {
+			if (imap_exec(ctx, NULL, "LOGIN \"%s\" \"%s\"", srvc->user, srvc->pass) != RESP_OK) {
+				fprintf(stderr, "IMAP error: LOGIN failed\n");
+				goto bail;
+			}
 		}
 	} /* !preauth */
 
@@ -1310,18 +1443,6 @@ static int split_msg(struct msg_data *all_msgs, struct msg_data *msg, int *ofs)
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
@@ -1361,6 +1482,9 @@ static int git_imap_config(const char *key, const char *val, void *cb)
 		server.port = git_config_int(key, val);
 	else if (!strcmp("tunnel", key))
 		server.tunnel = xstrdup(val);
+	else if (!strcmp("authmethod", key))
+		server.auth_method = xstrdup(val);
+
 	return 0;
 }
 
-- 
1.7.0.rc1.52.gf7cc2.dirty

