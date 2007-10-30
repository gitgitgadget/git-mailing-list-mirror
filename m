From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 4/4 v2] Use built-in send-pack.
Date: Mon, 29 Oct 2007 22:03:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710292203150.7357@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Oct 30 03:03:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImgST-0005X9-P6
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 03:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbXJ3CDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 22:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752806AbXJ3CDo
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 22:03:44 -0400
Received: from iabervon.org ([66.92.72.58]:54107 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752793AbXJ3CDn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 22:03:43 -0400
Received: (qmail 1724 invoked by uid 1000); 30 Oct 2007 02:03:42 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Oct 2007 02:03:42 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62647>

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 transport.c |   51 ++++++++++-----------------------------------------
 1 files changed, 10 insertions(+), 41 deletions(-)

diff --git a/transport.c b/transport.c
index 89b73dc..6b1f419 100644
--- a/transport.c
+++ b/transport.c
@@ -6,6 +6,7 @@
 #endif
 #include "pkt-line.h"
 #include "fetch-pack.h"
+#include "send-pack.h"
 #include "walker.h"
 #include "bundle.h"
 #include "dir.h"
@@ -653,48 +654,16 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 static int git_transport_push(struct transport *transport, int refspec_nr, const char **refspec, int flags) {
 	struct git_transport_data *data = transport->data;
-	const char **argv;
-	char *rem;
-	int argc;
-	int err;
+	struct send_pack_args args;
 
-	argv = xmalloc((refspec_nr + 11) * sizeof(char *));
-	argv[0] = "send-pack";
-	argc = 1;
-	if (flags & TRANSPORT_PUSH_ALL)
-		argv[argc++] = "--all";
-	if (flags & TRANSPORT_PUSH_FORCE)
-		argv[argc++] = "--force";
-	if (flags & TRANSPORT_PUSH_DRY_RUN)
-		argv[argc++] = "--dry-run";
-	if (data->receivepack) {
-		char *rp = xmalloc(strlen(data->receivepack) + 16);
-		sprintf(rp, "--receive-pack=%s", data->receivepack);
-		argv[argc++] = rp;
-	}
-	if (data->thin)
-		argv[argc++] = "--thin";
-	rem = xmalloc(strlen(transport->remote->name) + 10);
-	sprintf(rem, "--remote=%s", transport->remote->name);
-	argv[argc++] = rem;
-	argv[argc++] = transport->url;
-	while (refspec_nr--)
-		argv[argc++] = *refspec++;
-	argv[argc] = NULL;
-	err = run_command_v_opt(argv, RUN_GIT_CMD);
-	switch (err) {
-	case -ERR_RUN_COMMAND_FORK:
-		error("unable to fork for %s", argv[0]);
-	case -ERR_RUN_COMMAND_EXEC:
-		error("unable to exec %s", argv[0]);
-		break;
-	case -ERR_RUN_COMMAND_WAITPID:
-	case -ERR_RUN_COMMAND_WAITPID_WRONG_PID:
-	case -ERR_RUN_COMMAND_WAITPID_SIGNAL:
-	case -ERR_RUN_COMMAND_WAITPID_NOEXIT:
-		error("%s died with strange error", argv[0]);
-	}
-	return !!err;
+	args.receivepack = data->receivepack;
+	args.send_all = !!(flags & TRANSPORT_PUSH_ALL);
+	args.force_update = !!(flags & TRANSPORT_PUSH_FORCE);
+	args.use_thin_pack = data->thin;
+	args.verbose = transport->verbose;
+	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
+
+	return send_pack(&args, transport->url, transport->remote, refspec_nr, refspec);
 }
 
 static int disconnect_git(struct transport *transport)
-- 
1.5.3.4.1206.g5f96
