From: Tony Finch <dot@dotat.at>
Subject: [PATCH 2/2] imap-send: create target mailbox if it is missing
Date: Thu, 31 Jul 2014 09:14:34 +0100
Message-ID: <alpine.LSU.2.00.1407310914320.13901@hermes-1.csi.cam.ac.uk>
References: <alpine.LSU.2.00.1407310910230.10413@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 10:14:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XClVc-0005LW-Fy
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 10:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089AbaGaIOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 04:14:40 -0400
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:47013 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756040AbaGaIOi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 04:14:38 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:36171)
	by ppsw-41.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpa (EXTERNAL:fanf2) id 1XClVS-0002Kf-ST (Exim 4.82_3-c0e5623) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 31 Jul 2014 09:14:34 +0100
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1XClVS-00060d-NI (Exim 4.72) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 31 Jul 2014 09:14:34 +0100
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
In-Reply-To: <alpine.LSU.2.00.1407310910230.10413@hermes-1.csi.cam.ac.uk>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254540>

Some MUAs delete their "drafts" folder when it is empty, so
git imap-send should be able to create it if necessary.

This change checks that the folder exists immediately after
login and tries to create it if it is missing.

There was some vestigial code to handle a [TRYCREATE] response
from the server when an APPEND target is missing. However this
code never ran (the create and trycreate flags were never set)
and when I tried to make it run I found that the code had already
thrown away the contents of the message it was trying to append.

Signed-off-by: Tony Finch <dot@dotat.at>
---
 imap-send.c | 56 +++++++++++++++++++++++++-------------------------------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 524fbab..5e4a24e 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -128,7 +128,6 @@ struct imap_cmd_cb {
 	char *data;
 	int dlen;
 	int uid;
-	unsigned create:1, trycreate:1;
 };

 struct imap_cmd {
@@ -714,8 +713,8 @@ static int parse_response_code(struct imap_store *ctx, struct imap_cmd_cb *cb,
 static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 {
 	struct imap *imap = ctx->imap;
-	struct imap_cmd *cmdp, **pcmdp, *ncmdp;
-	char *cmd, *arg, *arg1, *p;
+	struct imap_cmd *cmdp, **pcmdp;
+	char *cmd, *arg, *arg1;
 	int n, resp, resp2, tag;

 	for (;;) {
@@ -801,30 +800,9 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 			if (!strcmp("OK", arg))
 				resp = DRV_OK;
 			else {
-				if (!strcmp("NO", arg)) {
-					if (cmdp->cb.create && cmd && (cmdp->cb.trycreate || !memcmp(cmd, "[TRYCREATE]", 11))) { /* SELECT, APPEND or UID COPY */
-						p = strchr(cmdp->cmd, '"');
-						if (!issue_imap_cmd(ctx, NULL, "CREATE \"%.*s\"", (int)(strchr(p + 1, '"') - p + 1), p)) {
-							resp = RESP_BAD;
-							goto normal;
-						}
-						/* not waiting here violates the spec, but a server that does not
-						   grok this nonetheless violates it too. */
-						cmdp->cb.create = 0;
-						if (!(ncmdp = issue_imap_cmd(ctx, &cmdp->cb, "%s", cmdp->cmd))) {
-							resp = RESP_BAD;
-							goto normal;
-						}
-						free(cmdp->cmd);
-						free(cmdp);
-						if (!tcmd)
-							return 0;	/* ignored */
-						if (cmdp == tcmd)
-							tcmd = ncmdp;
-						continue;
-					}
+				if (!strcmp("NO", arg))
 					resp = RESP_NO;
-				} else /*if (!strcmp("BAD", arg))*/
+				else /*if (!strcmp("BAD", arg))*/
 					resp = RESP_BAD;
 				fprintf(stderr, "IMAP command '%s' returned response (%s) - %s\n",
 					 memcmp(cmdp->cmd, "LOGIN", 5) ?
@@ -833,7 +811,6 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 			}
 			if ((resp2 = parse_response_code(ctx, &cmdp->cb, cmd)) > resp)
 				resp = resp2;
-		normal:
 			if (cmdp->cb.done)
 				cmdp->cb.done(ctx, cmdp, resp);
 			free(cmdp->cb.data);
@@ -944,7 +921,7 @@ static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd *cmd, const cha
 	return 0;
 }

-static struct imap_store *imap_open_store(struct imap_server_conf *srvc)
+static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *folder)
 {
 	struct credential cred = CREDENTIAL_INIT;
 	struct imap_store *ctx;
@@ -1156,6 +1133,25 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc)
 		credential_approve(&cred);
 	credential_clear(&cred);

+	/* check the target mailbox exists */
+	ctx->name = folder;
+	switch (imap_exec(ctx, NULL, "EXAMINE \"%s\"", ctx->name)) {
+	case RESP_OK:
+		/* ok */
+		break;
+	case RESP_BAD:
+		fprintf(stderr, "IMAP error: could not check mailbox\n");
+		goto bail;
+	case RESP_NO:
+		if (imap_exec(ctx, NULL, "CREATE \"%s\"", ctx->name) == RESP_OK) {
+			imap_info("Created missing mailbox\n");
+		} else {
+			fprintf(stderr, "IMAP error: could not create missing mailbox\n");
+			goto bail;
+		}
+		break;
+	}
+
 	ctx->prefix = "";
 	return ctx;

@@ -1219,7 +1215,6 @@ static int imap_store_msg(struct imap_store *ctx, struct strbuf *msg)

 	box = ctx->name;
 	prefix = !strcmp(box, "INBOX") ? "" : ctx->prefix;
-	cb.create = 0;
 	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\" ", prefix, box);
 	imap->caps = imap->rcaps;
 	if (ret != DRV_OK)
@@ -1418,14 +1413,13 @@ int main(int argc, char **argv)
 	}

 	/* write it to the imap server */
-	ctx = imap_open_store(&server);
+	ctx = imap_open_store(&server, imap_folder);
 	if (!ctx) {
 		fprintf(stderr, "failed to open store\n");
 		return 1;
 	}

 	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
-	ctx->name = imap_folder;
 	while (1) {
 		unsigned percent = n * 100 / total;

-- 
2.1.0.rc0.229.gaee38de
