From: Jan Engelhardt <jengelh@medozas.de>
Subject: [PATCH 3/3] git-daemon: vhost support
Date: Wed, 14 Jan 2009 11:49:05 +0100 (CET)
Message-ID: <alpine.LSU.2.00.0901141148390.16109@fbirervta.pbzchgretzou.qr>
References: <alpine.LSU.2.00.0901141147120.16109@fbirervta.pbzchgretzou.qr> <alpine.LSU.2.00.0901141148130.16109@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 11:50:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN3Kp-0002IQ-5e
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 11:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbZANKtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 05:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755099AbZANKtI
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 05:49:08 -0500
Received: from sovereign.computergmbh.de ([85.214.69.204]:59912 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183AbZANKtG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 05:49:06 -0500
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 190C21812F9E3; Wed, 14 Jan 2009 11:49:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 181191CBDECE0
	for <git@vger.kernel.org>; Wed, 14 Jan 2009 11:49:05 +0100 (CET)
In-Reply-To: <alpine.LSU.2.00.0901141148130.16109@fbirervta.pbzchgretzou.qr>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105615>


parent v1.6.1

git-daemon: support vhosts

Since git clients usually send the target hostname in the request
similar to the "Host:" HTTP header, one can do virtual hosting.

Signed-off-by: Jan Engelhardt <jengelh@medozas.de>

---
 daemon.c |   22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

Index: git-1.6.1/daemon.c
===================================================================
--- git-1.6.1.orig/daemon.c
+++ git-1.6.1/daemon.c
@@ -2,6 +2,7 @@
 #include "pkt-line.h"
 #include "exec_cmd.h"
 
+#include <stdbool.h>
 #include <syslog.h>
 
 #ifndef HOST_NAME_MAX
@@ -21,7 +22,7 @@ static const char daemon_usage[] =
 "           [--timeout=n] [--init-timeout=n] [--max-connections=n]\n"
 "           [--strict-paths] [--base-path=path] [--base-path-relaxed]\n"
 "           [--user-path | --user-path=path]\n"
-"           [--interpolated-path=path]\n"
+"           [--interpolated-path=path] [--vhost]\n"
 "           [--reuseaddr] [--detach] [--pid-file=file]\n"
 "           [--[enable|disable|allow-override|forbid-override]=service]\n"
 "           [--inetd | [--listen=host_or_ipaddr] [--port=n]\n"
@@ -36,6 +37,7 @@ static int strict_paths;
 static int export_all_trees;
 
 /* Take all paths relative to this one if non-NULL */
+static bool enable_vhosting;
 static char *base_path;
 static char *interpolated_path;
 static int base_path_relaxed;
@@ -309,8 +311,18 @@ static int run_service(char *dir, struct
 		return -1;
 	}
 
-	if (!(path = path_ok(dir)))
-		return -1;
+	if (enable_vhosting) {
+		char vdir[256];
+
+		if (avoid_alias(dir) != 0)
+			return -1;
+		snprintf(vdir, sizeof(vdir), "/%s%s", hostname, dir);
+		if ((path = path_ok(vdir)) == NULL)
+			return -1;
+	} else {
+		if ((path = path_ok(dir)) == NULL)
+			return -1;
+	}
 
 	/*
 	 * Security on the cheap.
@@ -1046,6 +1058,10 @@ int main(int argc, char **argv)
 			make_service_overridable(arg + 18, 0);
 			continue;
 		}
+		if (strcmp(arg, "--vhost") == 0) {
+			enable_vhosting = true;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			ok_paths = &argv[i+1];
 			break;
