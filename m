From: exon@op5.se (Andreas Ericsson)
Subject: [PATCH] daemon.c: fix arg parsing bugs
Date: Thu, 17 Nov 2005 00:38:29 +0100 (CET)
Message-ID: <20051116233829.071CC5BF78@nox.op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 17 00:45:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcWwn-0001uk-VA
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 00:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030556AbVKPXoJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 18:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161019AbVKPXoJ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 18:44:09 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:60114 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030556AbVKPXoG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 18:44:06 -0500
Received: from nox.op5.se (1-2-9-7b.gkp.gbg.bostream.se [82.182.116.45])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 32FDC6BCBE
	for <git@vger.kernel.org>; Thu, 17 Nov 2005 00:44:05 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 071CC5BF78; Thu, 17 Nov 2005 00:38:29 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12073>


Allow --init-timeout and --timeout to be specified without falling
through to usage().

Make sure openlog() is called even if implied by --inetd, or messages
will be sent to wherever LOG_USER ends up.

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 daemon.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

applies-to: 1e3fcf60526c196a46433e6947c9104ca236f230
83a3edea8623834fd7827f80cad2af4927f5a19e
diff --git a/daemon.c b/daemon.c
index e184752..2b81152 100644
--- a/daemon.c
+++ b/daemon.c
@@ -594,6 +594,7 @@ int main(int argc, char **argv)
 		}
 		if (!strcmp(arg, "--inetd")) {
 			inetd_mode = 1;
+			log_syslog = 1;
 			continue;
 		}
 		if (!strcmp(arg, "--verbose")) {
@@ -602,7 +603,6 @@ int main(int argc, char **argv)
 		}
 		if (!strcmp(arg, "--syslog")) {
 			log_syslog = 1;
-			openlog("git-daemon", 0, LOG_DAEMON);
 			continue;
 		}
 		if (!strcmp(arg, "--export-all")) {
@@ -611,9 +611,11 @@ int main(int argc, char **argv)
 		}
 		if (!strncmp(arg, "--timeout=", 10)) {
 			timeout = atoi(arg+10);
+			continue;
 		}
 		if (!strncmp(arg, "--init-timeout=", 15)) {
 			init_timeout = atoi(arg+15);
+			continue;
 		}
 		if (!strcmp(arg, "--")) {
 			ok_paths = &argv[i+1];
@@ -626,9 +628,11 @@ int main(int argc, char **argv)
 		usage(daemon_usage);
 	}
 
+	if (log_syslog)
+		openlog("git-daemon", 0, LOG_DAEMON);
+
 	if (inetd_mode) {
 		fclose(stderr); //FIXME: workaround
-		log_syslog = 1;
 		return execute();
 	}
 
---
0.99.9.GIT
