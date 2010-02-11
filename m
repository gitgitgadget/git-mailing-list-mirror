Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 18888 invoked by uid 107); 11 Feb 2010 14:39:21 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Thu, 11 Feb 2010 09:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839Ab0BKOjH (ORCPT <rfc822;peff@peff.net>);
	Thu, 11 Feb 2010 09:39:07 -0500
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:64064 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755583Ab0BKOjF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 09:39:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 1A758EAF5F2;
	Thu, 11 Feb 2010 23:39:02 +0900 (JST)
X-Quarantine-ID: <QvPF0jp2n4jb>
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
X-Amavis-Alert:	BAD HEADER, Duplicate header field: "To"
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QvPF0jp2n4jb; Thu, 11 Feb 2010 23:39:01 +0900 (JST)
Received: from localhost.localdomain (FL1-122-130-141-251.tky.mesh.ad.jp [122.130.141.251])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 80FCBEAF5E9;
	Thu, 11 Feb 2010 23:39:01 +0900 (JST)
From:	Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.org>
Subject: [PATCH v2 1/2] git-imap-send: Add CRAM-MD5 authenticate method support
Date:	Thu, 11 Feb 2010 23:38:54 +0900
Message-Id: <1265899135-11488-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
References: <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
To:	gitster@pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This patch makes git-imap-send CRAM-MD5 authenticate method ready.
In theory, CRAM-MD5 authenticate method doesn't depend on SSL,
but for easy of maintainance, this patch uses base64 and md5 stuffs of OpenSSL.
So if you want to use CRAM-MD5 authenticate method,
you have to build git-imap-send with OpenSSL library.

Cc: Erik Faye-Lund <kusmabite@googlemail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff King <peff@peff.org>
Signed-off-by: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
---
 Documentation/git-imap-send.txt |    4 +
 imap-send.c                     |  144 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 131 insertions(+), 17 deletions(-)

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
index ba72fa4..dcd8a2a 100644
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
@@ -1101,6 +1190,7 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 		}
 #endif
 		imap_info("Logging in...\n");
+
 		if (!srvc->user) {
 			fprintf(stderr, "Skipping server %s, no user\n", srvc->host);
 			goto bail;
@@ -1130,10 +1220,37 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
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
@@ -1258,6 +1375,7 @@ static int read_message(FILE *f, struct msg_data *msg)
 
 	msg->len  = buf.len;
 	msg->data = strbuf_detach(&buf, NULL);
+
 	return msg->len;
 }
 
@@ -1307,21 +1425,10 @@ static int split_msg(struct msg_data *all_msgs, struct msg_data *msg, int *ofs)
 
 	msg->data = xmemdupz(data, msg->len);
 	*ofs += msg->len;
+
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
@@ -1361,6 +1468,9 @@ static int git_imap_config(const char *key, const char *val, void *cb)
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

