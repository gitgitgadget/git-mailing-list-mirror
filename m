From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Subject: [PATCH v6 1/2] git-imap-send: Add CRAM-MD5 authenticate method support
Date: Wed, 17 Feb 2010 18:18:43 +0900
Message-ID: <1266398323-11307-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
References: <4B7BB437.1060608@dcl.info.waseda.ac.jp>
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@googlemail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 17 10:19:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhg4D-0001D3-FW
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 10:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506Ab0BQJT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 04:19:27 -0500
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:57962 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932336Ab0BQJT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 04:19:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 90430EDAE5E;
	Wed, 17 Feb 2010 18:19:23 +0900 (JST)
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z7fgNg0FeSFn; Wed, 17 Feb 2010 18:19:23 +0900 (JST)
Received: from localhost.localdomain (fw-cisco.dcl.info.waseda.ac.jp [133.9.216.204])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 248D8EDAE59;
	Wed, 17 Feb 2010 18:19:23 +0900 (JST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <4B7BB437.1060608@dcl.info.waseda.ac.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140222>

From: Junio C Hamano <gitster@pobox.com>

This patch makes git-imap-send CRAM-MD5 authenticate method ready.
CRAM-MD5 authentication ought to be independent from SSL, but NO_OPENSSL
build will not support this because the base64 and md5 code are used from
the OpenSSL library in this implementation.

Cc: Erik Faye-Lund <kusmabite@googlemail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff King <peff@peff.net>
Signed-off-by: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
v6:Cleaning by Junio C Hamano:
 * Use of HMAC_Init() is kept, so people with ancient OpenSSL can use it;

 * Lose "overallocate with xcalloc() and use strlen() to see how long the
   result is" pattern; EVP_DecodeBlock() and EVP_EncodeBlock() should be
   returning the length anyway, so use that directly;

 * Comment style fixes;

 * Lose "fprintf() then exit()"; die() instead; and

 * Call HMAC_CTX_cleanup() when done;

And length for response_64 should not be ENCODED_SIZE(resp_len),
should be ENCODED_SIZE(resp_len) + 1, by Hitoshi Mitake.

 Documentation/git-imap-send.txt |    4 +
 imap-send.c                     |  146 +++++++++++++++++++++++++++++++++++----
 2 files changed, 135 insertions(+), 15 deletions(-)

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
index ba72fa4..3ee25d9 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -27,6 +27,9 @@
 #include "run-command.h"
 #ifdef NO_OPENSSL
 typedef void *SSL;
+#else
+#include <openssl/evp.h>
+#include <openssl/hmac.h>
 #endif
 
 struct store_conf {
@@ -140,6 +143,20 @@ struct imap_server_conf {
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
@@ -214,6 +231,7 @@ enum CAPABILITY {
 	LITERALPLUS,
 	NAMESPACE,
 	STARTTLS,
+	AUTH_CRAM_MD5,
 };
 
 static const char *cap_list[] = {
@@ -222,6 +240,7 @@ static const char *cap_list[] = {
 	"LITERAL+",
 	"NAMESPACE",
 	"STARTTLS",
+	"AUTH=CRAM-MD5",
 };
 
 #define RESP_OK    0
@@ -949,6 +968,87 @@ static void imap_close_store(struct store *ctx)
 	free(ctx);
 }
 
+#ifndef NO_OPENSSL
+
+/*
+ * hexchar() and cram() functions are based on the code from the isync
+ * project (http://isync.sf.net/).
+ */
+static char hexchar(unsigned int b)
+{
+	return b < 10 ? '0' + b : 'a' + (b - 10);
+}
+
+#define ENCODED_SIZE(n) (4*((n+2)/3))
+static char *cram(const char *challenge_64, const char *user, const char *pass)
+{
+	int i, resp_len, encoded_len, decoded_len;
+	HMAC_CTX hmac;
+	unsigned char hash[16];
+	char hex[33];
+	char *response, *response_64, *challenge;
+
+	/*
+	 * length of challenge_64 (i.e. base-64 encoded string) is a good
+	 * enough upper bound for challenge (decoded result).
+	 */
+	encoded_len = strlen(challenge_64);
+	challenge = xmalloc(encoded_len);
+	decoded_len = EVP_DecodeBlock((unsigned char *)challenge,
+				      (unsigned char *)challenge_64, encoded_len);
+	if (decoded_len < 0)
+		die("invalid challenge %s", challenge_64);
+	HMAC_Init(&hmac, (unsigned char *)pass, strlen(pass), EVP_md5());
+	HMAC_Update(&hmac, (unsigned char *)challenge, decoded_len);
+	HMAC_Final(&hmac, hash, NULL);
+	HMAC_CTX_cleanup(&hmac);
+
+	hex[32] = 0;
+	for (i = 0; i < 16; i++) {
+		hex[2 * i] = hexchar((hash[i] >> 4) & 0xf);
+		hex[2 * i + 1] = hexchar(hash[i] & 0xf);
+	}
+
+	/* response: "<user> <digest in hex>" */
+	resp_len = strlen(user) + 1 + strlen(hex) + 1;
+	response = xmalloc(resp_len);
+	sprintf(response, "%s %s", user, hex);
+
+	response_64 = xmalloc(ENCODED_SIZE(resp_len) + 1);
+	encoded_len = EVP_EncodeBlock((unsigned char *)response_64,
+				      (unsigned char *)response, resp_len);
+	if (encoded_len < 0)
+		die("EVP_EncodeBlock error");
+	response_64[encoded_len] = '\0';
+	return (char *)response_64;
+}
+
+#else
+
+static char *cram(const char *challenge_64, const char *user, const char *pass)
+{
+	die("If you want to use CRAM-MD5 authenticate method, "
+	    "you have to build git-imap-send with OpenSSL library.");
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
@@ -1130,9 +1230,34 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
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
 
@@ -1310,18 +1435,6 @@ static int split_msg(struct msg_data *all_msgs, struct msg_data *msg, int *ofs)
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
@@ -1361,6 +1474,9 @@ static int git_imap_config(const char *key, const char *val, void *cb)
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
