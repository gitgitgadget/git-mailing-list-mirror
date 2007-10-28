From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 09/10] push: teach push to pass --verbose option to transport layer
Date: Sun, 28 Oct 2007 18:46:20 +0100
Message-ID: <11935935823496-git-send-email-prohaska@zib.de>
References: <1193593581312-git-send-email-prohaska@zib.de>
 <11935935812741-git-send-email-prohaska@zib.de>
 <1193593581114-git-send-email-prohaska@zib.de>
 <1193593581486-git-send-email-prohaska@zib.de>
 <11935935812185-git-send-email-prohaska@zib.de>
 <11935935822846-git-send-email-prohaska@zib.de>
 <11935935821136-git-send-email-prohaska@zib.de>
 <11935935823045-git-send-email-prohaska@zib.de>
 <11935935821800-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 18:51:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImCI9-0000ou-1Z
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 18:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636AbXJ1RuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 13:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbXJ1RuJ
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 13:50:09 -0400
Received: from mailer.zib.de ([130.73.108.11]:63837 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754375AbXJ1Rtt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 13:49:49 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9SHkMWe016202
	for <git@vger.kernel.org>; Sun, 28 Oct 2007 18:49:47 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9SHkLsd019730;
	Sun, 28 Oct 2007 18:46:22 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11935935821800-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62585>

A --verbose option to push should also be passed to the
transport layer, i.e. git-send-pack, git-http-push.

git push is modified to do so.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 builtin-push.c |    2 ++
 transport.c    |    8 ++++++--
 transport.h    |    1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 9103d57..27eaca5 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -110,10 +110,12 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		}
 		if (!strcmp(arg, "-v")) {
 			verbose=1;
+			flags |= TRANSPORT_PUSH_VERBOSE;
 			continue;
 		}
 		if (!strcmp(arg, "--verbose")) {
 			verbose=1;
+			flags |= TRANSPORT_PUSH_VERBOSE;
 			continue;
 		}
 		if (!prefixcmp(arg, "--repo=")) {
diff --git a/transport.c b/transport.c
index fbdbd0d..e6bca93 100644
--- a/transport.c
+++ b/transport.c
@@ -385,7 +385,7 @@ static int curl_transport_push(struct transport *transport, int refspec_nr, cons
 	int argc;
 	int err;
 
-	argv = xmalloc((refspec_nr + 12) * sizeof(char *));
+	argv = xmalloc((refspec_nr + 13) * sizeof(char *));
 	argv[0] = "http-push";
 	argc = 1;
 	if (flags & TRANSPORT_PUSH_ALL)
@@ -396,6 +396,8 @@ static int curl_transport_push(struct transport *transport, int refspec_nr, cons
 		argv[argc++] = "--dry-run";
 	if (flags & TRANSPORT_PUSH_CREATE)
 		argv[argc++] = "--create";
+	if (flags & TRANSPORT_PUSH_VERBOSE)
+		argv[argc++] = "--verbose";
 	argv[argc++] = transport->url;
 	while (refspec_nr--)
 		argv[argc++] = *refspec++;
@@ -660,7 +662,7 @@ static int git_transport_push(struct transport *transport, int refspec_nr, const
 	int argc;
 	int err;
 
-	argv = xmalloc((refspec_nr + 12) * sizeof(char *));
+	argv = xmalloc((refspec_nr + 13) * sizeof(char *));
 	argv[0] = "send-pack";
 	argc = 1;
 	if (flags & TRANSPORT_PUSH_ALL)
@@ -671,6 +673,8 @@ static int git_transport_push(struct transport *transport, int refspec_nr, const
 		argv[argc++] = "--dry-run";
 	if (flags & TRANSPORT_PUSH_CREATE)
 		argv[argc++] = "--create";
+	if (flags & TRANSPORT_PUSH_VERBOSE)
+		argv[argc++] = "--verbose";
 	if (data->receivepack) {
 		char *rp = xmalloc(strlen(data->receivepack) + 16);
 		sprintf(rp, "--receive-pack=%s", data->receivepack);
diff --git a/transport.h b/transport.h
index 1d6a926..a387eed 100644
--- a/transport.h
+++ b/transport.h
@@ -31,6 +31,7 @@ struct transport {
 #define TRANSPORT_PUSH_FORCE 2
 #define TRANSPORT_PUSH_DRY_RUN 4
 #define TRANSPORT_PUSH_CREATE 8
+#define TRANSPORT_PUSH_VERBOSE 16
 
 /* Returns a transport suitable for the url */
 struct transport *transport_get(struct remote *, const char *);
-- 
1.5.3.4.439.ge8b49
