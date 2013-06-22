From: Andreas Krey <a.krey@gmx.de>
Subject: [PATCH] git-daemon: have --no-syslog
Date: Sat, 22 Jun 2013 19:41:22 +0200
Message-ID: <20130622174122.GA6496@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 19:41:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqRor-0006Bu-Rl
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 19:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893Ab3FVRld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 13:41:33 -0400
Received: from continuum.iocl.org ([217.140.74.2]:40250 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862Ab3FVRl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 13:41:28 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r5MHfMB18378;
	Sat, 22 Jun 2013 19:41:22 +0200
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228716>

Some people run inetds that collect stderr of the spawned programs.
Give them 'git-daemon --inetd --no-syslog' to keep error output
on stderr.

Signed-off-by: Andreas Krey <a.krey@gmx.de>
---
 Documentation/git-daemon.txt |  4 ++++
 daemon.c                     | 14 +++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 223f731..007d3fc 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -113,6 +113,10 @@ OPTIONS
 	Log to syslog instead of stderr. Note that this option does not imply
 	--verbose, thus by default only error conditions will be logged.
 
+--no-syslog::
+	Disable the implicit --syslog of --inetd and --deatch, thus keeping
+	error output on stderr.
+
 --user-path::
 --user-path=<path>::
 	Allow {tilde}user notation to be used in requests.  When
diff --git a/daemon.c b/daemon.c
index 6aeddcb..2f5d5bf 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1196,7 +1196,6 @@ int main(int argc, char **argv)
 		}
 		if (!strcmp(arg, "--inetd")) {
 			inetd_mode = 1;
-			log_syslog = 1;
 			continue;
 		}
 		if (!strcmp(arg, "--verbose")) {
@@ -1207,6 +1206,10 @@ int main(int argc, char **argv)
 			log_syslog = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--no-syslog")) {
+			log_syslog = -1;
+			continue;
+		}
 		if (!strcmp(arg, "--export-all")) {
 			export_all_trees = 1;
 			continue;
@@ -1263,7 +1266,6 @@ int main(int argc, char **argv)
 		}
 		if (!strcmp(arg, "--detach")) {
 			detach = 1;
-			log_syslog = 1;
 			continue;
 		}
 		if (!prefixcmp(arg, "--user=")) {
@@ -1309,6 +1311,12 @@ int main(int argc, char **argv)
 		usage(daemon_usage);
 	}
 
+	if ((inetd_mode || detach) && log_syslog == 0)
+		log_syslog = 1;
+
+	if (log_syslog == -1)
+		log_syslog = 0;
+
 	if (log_syslog) {
 		openlog("git-daemon", LOG_PID, LOG_DAEMON);
 		set_die_routine(daemon_die);
@@ -1337,7 +1345,7 @@ int main(int argc, char **argv)
 		die("base-path '%s' does not exist or is not a directory",
 		    base_path);
 
-	if (inetd_mode) {
+	if (inetd_mode && log_syslog) {
 		if (!freopen("/dev/null", "w", stderr))
 			die_errno("failed to redirect stderr to /dev/null");
 	}
-- 
1.8.3.1.485.g9704416.dirty
