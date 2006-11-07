X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_BCC,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Christian Thaeter <ct@pipapo.org>
Subject: [PATCH] syncing disk in a subprocess with a 60 seconds timeout.
Date: Tue, 7 Nov 2006 10:07:56 +0100
Message-ID: <20061107092208.798A3F7044@mail.pipapo.org>
NNTP-Posting-Date: Tue, 7 Nov 2006 09:22:39 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31056>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhN9r-0004u0-Hv for gcvg-git@gmane.org; Tue, 07 Nov
 2006 10:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754120AbWKGJWM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 04:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754136AbWKGJWM
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 04:22:12 -0500
Received: from pipapo.org ([217.140.77.75]:51722 "EHLO mail.pipapo.org") by
 vger.kernel.org with ESMTP id S1754120AbWKGJWL (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 04:22:11 -0500
Received: from localhost (unknown [10.20.40.100]) by mail.pipapo.org
 (Postfix) with SMTP id 798A3F7044 for <git@vger.kernel.org>; Tue,  7 Nov 2006
 10:22:08 +0100 (CET)
Received: by localhost (sSMTP sendmail emulation); Tue, 07 Nov 2006 10:22:08
 +0100
To: undisclosed-recipients:;
Sender: git-owner@vger.kernel.org

sync() can take excessive long time, up to hours in some circumstances.
(eg. running badblocks on slow disk, dd'ing disk images, packet-writing on optical media)
Running a prune is usually expected to start (and complete) soon, especially
if it is initiated from a cron-script.

This patch forks the sync() in a background process and waits at most 60 seconds for
it's completion. If the sync doesnt complete in time or any other error occurs, prunning
is aborted and can be tried again a later time. Note that the sync() process will get
orphaned and sit around until syncing eventually completes.
---
 builtin-prune-packed.c |   35 +++++++++++++++++++++++++++++++++--
 1 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index 24e3b0a..05ac696 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -1,5 +1,7 @@
 #include "builtin.h"
 #include "cache.h"
+#include <time.h>
+#include <sys/wait.h>
 
 static const char prune_packed_usage[] =
 "git-prune-packed [-n]";
@@ -53,11 +55,16 @@ void prune_packed_objects(int dryrun)
 	}
 }
 
+void sig_nop(int unused){(void)unused;};
+
 int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	int dryrun = 0;
-
+	pid_t syncpid;
+	struct timespec synctimeout;
+	int sleeping;
+		
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
@@ -71,7 +78,31 @@ int cmd_prune_packed(int argc, const cha
 		/* Handle arguments here .. */
 		usage(prune_packed_usage);
 	}
-	sync();
+	
+	synctimeout.tv_sec = 60;
+	synctimeout.tv_nsec = 0;
+		
+	signal(SIGCLD, sig_nop);
+	syncpid = fork();
+	if (syncpid == 0) {
+		sync();
+		return 0;
+	}
+	else if (syncpid > 0) {
+		do {
+			if (waitpid(syncpid, NULL, WNOHANG) > 0)
+				break;
+			sleeping = nanosleep(&synctimeout, &synctimeout);
+			if (sleeping == -1) {
+				if (errno != EINTR)
+					die ("nanosleep error");
+			}
+			else
+				die ("coudn't sync within 60 seconds, nothing pruned");
+		} while (1);
+	}
+	else die("failed to fork sync process");
+	signal(SIGCLD, SIG_DFL);
 	prune_packed_objects(dryrun);
 	return 0;
 }
-- 
1.4.3.2
