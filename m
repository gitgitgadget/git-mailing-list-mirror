From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 2/6] push: teach push to pass --verbose option to transport layer
Date: Sun, 11 Nov 2007 15:01:44 +0100
Message-ID: <11947897081278-git-send-email-prohaska@zib.de>
References: <1194789708646-git-send-email-prohaska@zib.de>
 <11947897083381-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:05:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrDRf-0003eX-J6
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 15:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593AbXKKOEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 09:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752504AbXKKOEy
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 09:04:54 -0500
Received: from mailer.zib.de ([130.73.108.11]:57968 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218AbXKKOEr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 09:04:47 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lABE1nMW021596;
	Sun, 11 Nov 2007 15:04:43 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lABE1mlW027967;
	Sun, 11 Nov 2007 15:01:48 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11947897083381-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64456>

From: Steffen Prohaska <gitster@pobox.com>

A --verbose option to push should also be passed to the
transport layer, i.e. git-send-pack, git-http-push.

git push is modified to do so.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-push.c |    2 ++
 transport.c    |    8 ++++++--
 transport.h    |    1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 2c56195..6d1da07 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -115,6 +115,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		flags |= TRANSPORT_PUSH_FORCE;
 	if (dry_run)
 		flags |= TRANSPORT_PUSH_DRY_RUN;
+	if (verbose)
+		flags |= TRANSPORT_PUSH_VERBOSE;
 	if (tags)
 		add_refspec("refs/tags/*");
 	if (all)
diff --git a/transport.c b/transport.c
index fa5cfbb..e8a2608 100644
--- a/transport.c
+++ b/transport.c
@@ -386,7 +386,7 @@ static int curl_transport_push(struct transport *transport, int refspec_nr, cons
 	int argc;
 	int err;
 
-	argv = xmalloc((refspec_nr + 11) * sizeof(char *));
+	argv = xmalloc((refspec_nr + 12) * sizeof(char *));
 	argv[0] = "http-push";
 	argc = 1;
 	if (flags & TRANSPORT_PUSH_ALL)
@@ -395,6 +395,8 @@ static int curl_transport_push(struct transport *transport, int refspec_nr, cons
 		argv[argc++] = "--force";
 	if (flags & TRANSPORT_PUSH_DRY_RUN)
 		argv[argc++] = "--dry-run";
+	if (flags & TRANSPORT_PUSH_VERBOSE)
+		argv[argc++] = "--verbose";
 	argv[argc++] = transport->url;
 	while (refspec_nr--)
 		argv[argc++] = *refspec++;
@@ -655,7 +657,7 @@ static int git_transport_push(struct transport *transport, int refspec_nr, const
 	int argc;
 	int err;
 
-	argv = xmalloc((refspec_nr + 11) * sizeof(char *));
+	argv = xmalloc((refspec_nr + 12) * sizeof(char *));
 	argv[0] = "send-pack";
 	argc = 1;
 	if (flags & TRANSPORT_PUSH_ALL)
@@ -664,6 +666,8 @@ static int git_transport_push(struct transport *transport, int refspec_nr, const
 		argv[argc++] = "--force";
 	if (flags & TRANSPORT_PUSH_DRY_RUN)
 		argv[argc++] = "--dry-run";
+	if (flags & TRANSPORT_PUSH_VERBOSE)
+		argv[argc++] = "--verbose";
 	if (data->receivepack) {
 		char *rp = xmalloc(strlen(data->receivepack) + 16);
 		sprintf(rp, "--receive-pack=%s", data->receivepack);
diff --git a/transport.h b/transport.h
index df12ea7..2f80ab4 100644
--- a/transport.h
+++ b/transport.h
@@ -30,6 +30,7 @@ struct transport {
 #define TRANSPORT_PUSH_ALL 1
 #define TRANSPORT_PUSH_FORCE 2
 #define TRANSPORT_PUSH_DRY_RUN 4
+#define TRANSPORT_PUSH_VERBOSE 8
 
 /* Returns a transport suitable for the url */
 struct transport *transport_get(struct remote *, const char *);
-- 
1.5.3.5.578.g886d
