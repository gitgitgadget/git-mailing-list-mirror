From: Bernhard Reiter <ockham@raz.or.at>
Subject: [PATCH v2] imap-send: Use parse options API to determine verbosity
Date: Wed, 05 Nov 2014 23:53:20 +0100
Message-ID: <545AAA60.3040207@raz.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 23:53:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xm9S9-0004ew-C9
	for gcvg-git-2@plane.gmane.org; Wed, 05 Nov 2014 23:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbaKEWxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2014 17:53:21 -0500
Received: from mhub.domainplanet.at ([92.43.99.117]:46048 "EHLO
	mhub.domainplanet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbaKEWxV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2014 17:53:21 -0500
Received: from smtp.domainplanet.at (smtp.domainplanet.at [92.43.99.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mhub.domainplanet.at (Postfix) with ESMTPS id 4623B9B20D4;
	Wed,  5 Nov 2014 23:53:16 +0100 (CET)
Received: from [10.0.0.25] (91-113-40-41.adsl.highway.telekom.at [91.113.40.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.domainplanet.at (Postfix) with ESMTPSA id C920DBFC51;
	Wed,  5 Nov 2014 23:54:13 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Bernhard Reiter <ockham@raz.or.at>
---
In reply to <xmqqk339ibal.fsf@gitster.dls.corp.google.com>.

Thanks for bearing with me. I should've given the corresponding verbosity
values more thought myself in the first place.

 Documentation/git-imap-send.txt | 14 +++++++++++++-
 imap-send.c                     | 25 +++++++++++++++----------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index c7c0d21..0897131 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -9,7 +9,7 @@ git-imap-send - Send a collection of patches from stdin to an IMAP folder
 SYNOPSIS
 --------
 [verse]
-'git imap-send'
+'git imap-send' [-v] [-q]
 
 
 DESCRIPTION
@@ -26,6 +26,18 @@ Typical usage is something like:
 git format-patch --signoff --stdout --attach origin | git imap-send
 
 
+OPTIONS
+-------
+
+-v::
+--verbose::
+	Be verbose.
+
+-q::
+--quiet::
+	Be quiet.
+
+
 CONFIGURATION
 -------------
 
diff --git a/imap-send.c b/imap-send.c
index 70bcc7a..6efaae8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -26,11 +26,19 @@
 #include "credential.h"
 #include "exec_cmd.h"
 #include "run-command.h"
+#include "parse-options.h"
 #ifdef NO_OPENSSL
 typedef void *SSL;
 #endif
 
-static const char imap_send_usage[] = "git imap-send < <mbox>";
+static int verbosity;
+
+static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] < <mbox>", NULL };
+
+static struct option imap_send_options[] = {
+	OPT__VERBOSITY(&verbosity),
+	OPT_END()
+};
 
 #undef DRV_OK
 #define DRV_OK          0
@@ -38,8 +46,6 @@ static const char imap_send_usage[] = "git imap-send < <mbox>";
 #define DRV_BOX_BAD     -2
 #define DRV_STORE_BAD   -3
 
-static int Verbose, Quiet;
-
 __attribute__((format (printf, 1, 2)))
 static void imap_info(const char *, ...);
 __attribute__((format (printf, 1, 2)))
@@ -418,7 +424,7 @@ static int buffer_gets(struct imap_buffer *b, char **s)
 			if (b->buf[b->offset + 1] == '\n') {
 				b->buf[b->offset] = 0;  /* terminate the string */
 				b->offset += 2; /* next line */
-				if (Verbose)
+				if (0 < verbosity)
 					puts(*s);
 				return 0;
 			}
@@ -433,7 +439,7 @@ static void imap_info(const char *msg, ...)
 {
 	va_list va;
 
-	if (!Quiet) {
+	if (verbosity >= 0) {
 		va_start(va, msg);
 		vprintf(msg, va);
 		va_end(va);
@@ -445,7 +451,7 @@ static void imap_warn(const char *msg, ...)
 {
 	va_list va;
 
-	if (Quiet < 2) {
+	if (-2 < verbosity) {
 		va_start(va, msg);
 		vfprintf(stderr, msg, va);
 		va_end(va);
@@ -522,7 +528,7 @@ static struct imap_cmd *issue_imap_cmd(struct imap_store *ctx,
 				  cmd->tag, cmd->cmd, cmd->cb.dlen,
 				  CAP(LITERALPLUS) ? "+" : "");
 
-	if (Verbose) {
+	if (0 < verbosity) {
 		if (imap->num_in_progress)
 			printf("(%d in progress) ", imap->num_in_progress);
 		if (!starts_with(cmd->cmd, "LOGIN"))
@@ -1352,12 +1358,11 @@ int main(int argc, char **argv)
 
 	git_setup_gettext();
 
-	if (argc != 1)
-		usage(imap_send_usage);
-
 	setup_git_directory_gently(&nongit_ok);
 	git_imap_config();
 
+	argc = parse_options(argc, (const char **)argv, "", imap_send_options, imap_send_usage, 0);
+
 	if (!server.port)
 		server.port = server.use_ssl ? 993 : 143;
 
-- 
2.1.2.556.g44ebd84
