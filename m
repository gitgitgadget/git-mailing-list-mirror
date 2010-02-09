From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Subject: [PATCH 3/4] git-imap-send: Implement CRAM-MD5 auth method
Date: Tue,  9 Feb 2010 21:09:04 +0900
Message-ID: <1265717345-2118-4-git-send-email-mitake@dcl.info.waseda.ac.jp>
References: <7vaavj8h1k.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
	Jeremy White <jwhite@codeweavers.com>,
	Robert Shearman <robertshearman@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Feb 09 13:19:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nep3b-0000uz-I5
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 13:19:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896Ab0BIMSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 07:18:51 -0500
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:54578 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257Ab0BIMSt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 07:18:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 54B03E9D874;
	Tue,  9 Feb 2010 21:09:55 +0900 (JST)
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OOmRNqhEcKGw; Tue,  9 Feb 2010 21:09:54 +0900 (JST)
Received: from localhost.localdomain (fw-cisco.dcl.info.waseda.ac.jp [133.9.216.204])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id BA118E9D86A;
	Tue,  9 Feb 2010 21:09:53 +0900 (JST)
X-Mailer: git-send-email 1.7.0.rc1.52.gf7cc2.dirty
In-Reply-To: <7vaavj8h1k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139398>

Some IMAP servers require CRAM-MD5 authenticate method
to their clients for secure connection.

git-imap-send didn't provided this auth method,
so I implemented it. Now git-imap-send users can store
their patches to IMAP server if server requires CRAM-MD5
auth method.

If you want to use it, add line:
	auth-method = CRAM-MD5
to [imap] section of your .gitconfig .

This patch also adds description to Documentation/git-imap-send.txt .

Cc: Jeremy White <jwhite@codeweavers.com>
Cc: Robert Shearman <robertshearman@gmail.com>
Signed-off-by: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
---
 Documentation/git-imap-send.txt |    4 ++
 imap-send.c                     |  107 ++++++++++++++++++++++++++++++++------
 2 files changed, 94 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 57db955..9b2052f 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -71,6 +71,10 @@ imap.preformattedHTML::
 	option causes Thunderbird to send the patch as a plain/text,
 	format=fixed email.  Default is `false`.
 
+imap.auth-method::
+	Specify authenticate method for authentication with IMAP server.
+	Current supported method is 'CRAM-MD5' only.
+
 Examples
 ~~~~~~~~
 
diff --git a/imap-send.c b/imap-send.c
index ba72fa4..3ed9fc2 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -25,10 +25,16 @@
 #include "cache.h"
 #include "exec_cmd.h"
 #include "run-command.h"
+
+#include "base64.h"
+#include "md5_hmac.h"
+
 #ifdef NO_OPENSSL
 typedef void *SSL;
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
@@ -949,6 +972,35 @@ static void imap_close_store(struct store *ctx)
 	free(ctx);
 }
 
+static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd *cmd, const char *prompt)
+{
+	int ret;
+	char digest[DIGEST_HEX_LEN];
+	char buf[256], base64_out[256];
+
+	memset(buf, 0, 256);
+	base64_decode(buf, prompt, strlen(prompt));
+
+	memset(digest, 0, DIGEST_HEX_LEN);
+	md5_hex_hmac(digest, (const unsigned char *)buf, strlen(buf),
+		     (const unsigned char *)server.pass, strlen(server.pass));
+
+	memset(buf, 0, 256);
+	strcpy(buf, server.user);
+	strcpy(buf + strlen(buf), " ");
+	strcpy(buf + strlen(buf), digest);
+	memset(base64_out, 0, 256);
+	base64_encode(base64_out, buf, strlen(buf));
+
+	ret = socket_write(&ctx->imap->buf.sock, base64_out, strlen(base64_out));
+	if (ret != strlen(base64_out)) {
+		fprintf(stderr, "IMAP error: sending response failed\n");
+		return -1;
+	}
+
+	return 0;
+}
+
 static struct store *imap_open_store(struct imap_server_conf *srvc)
 {
 	struct imap_store *ctx;
@@ -1101,6 +1153,7 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 		}
 #endif
 		imap_info("Logging in...\n");
+
 		if (!srvc->user) {
 			fprintf(stderr, "Skipping server %s, no user\n", srvc->host);
 			goto bail;
@@ -1130,10 +1183,37 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
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
@@ -1258,6 +1338,7 @@ static int read_message(FILE *f, struct msg_data *msg)
 
 	msg->len  = buf.len;
 	msg->data = strbuf_detach(&buf, NULL);
+
 	return msg->len;
 }
 
@@ -1307,21 +1388,10 @@ static int split_msg(struct msg_data *all_msgs, struct msg_data *msg, int *ofs)
 
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
@@ -1361,6 +1431,9 @@ static int git_imap_config(const char *key, const char *val, void *cb)
 		server.port = git_config_int(key, val);
 	else if (!strcmp("tunnel", key))
 		server.tunnel = xstrdup(val);
+	else if (!strcmp("auth-method", key))
+		server.auth_method = xstrdup(val);
+
 	return 0;
 }
 
-- 
1.7.0.rc1.52.gf7cc2.dirty
