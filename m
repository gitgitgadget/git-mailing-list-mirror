From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] imap-send: simplify v_issue_imap_cmd() and get_cmd_result()
 using starts_with()
Date: Sat, 30 Aug 2014 18:14:24 +0200
Message-ID: <5401F860.4030902@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 30 18:14:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNlIk-0000oy-MO
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 18:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbaH3QOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 12:14:51 -0400
Received: from mout.web.de ([212.227.17.12]:58064 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbaH3QOu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 12:14:50 -0400
Received: from [192.168.178.27] ([79.253.135.121]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Lqleo-1Y1l0l2anq-00eMAG; Sat, 30 Aug 2014 18:14:41
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-Provags-ID: V03:K0:SXo5mhitjiP65AYfigdizKVDFIdkDIodZbkzTR2/wUkUVr4khjU
 skZPciSeyGGgCrpVtUeJ17KRt9BFX9wm/DP9LB9giGSWX5tEINULo0LAZxMDCCb0/wF1UCY
 jL52v9mp0WEyJdJugVg6JSqk+Hjhi2dC6PeYmGU/mSerK6EFEFXK3AkJGjxKwCEqEArH46D
 phRPG19l+vPBpRkhAcCIw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256258>

Use starts_with() instead of memcmp() to check if NUL-terminated
strings match prefixes.  This gets rid of some magic string length
constants.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 imap-send.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 524fbab..b079a0d 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -524,7 +524,7 @@ static struct imap_cmd *v_issue_imap_cmd(struct imap_store *ctx,
 	if (Verbose) {
 		if (imap->num_in_progress)
 			printf("(%d in progress) ", imap->num_in_progress);
-		if (memcmp(cmd->cmd, "LOGIN", 5))
+		if (!starts_with(cmd->cmd, "LOGIN"))
 			printf(">>> %s", buf);
 		else
 			printf(">>> %d LOGIN <user> <pass>\n", cmd->tag);
@@ -802,7 +802,10 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 				resp = DRV_OK;
 			else {
 				if (!strcmp("NO", arg)) {
-					if (cmdp->cb.create && cmd && (cmdp->cb.trycreate || !memcmp(cmd, "[TRYCREATE]", 11))) { /* SELECT, APPEND or UID COPY */
+					if (cmdp->cb.create && cmd &&
+					    (cmdp->cb.trycreate ||
+					     starts_with(cmd, "[TRYCREATE]"))) {
+						/* SELECT, APPEND or UID COPY */
 						p = strchr(cmdp->cmd, '"');
 						if (!issue_imap_cmd(ctx, NULL, "CREATE \"%.*s\"", (int)(strchr(p + 1, '"') - p + 1), p)) {
 							resp = RESP_BAD;
@@ -827,7 +830,7 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 				} else /*if (!strcmp("BAD", arg))*/
 					resp = RESP_BAD;
 				fprintf(stderr, "IMAP command '%s' returned response (%s) - %s\n",
-					 memcmp(cmdp->cmd, "LOGIN", 5) ?
+					!starts_with(cmdp->cmd, "LOGIN") ?
 							cmdp->cmd : "LOGIN <user> <pass>",
 							arg, cmd ? cmd : "");
 			}
-- 
2.1.0
