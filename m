From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH 1/5] daemon: use a custom die routine with syslog
Date: Thu, 13 Jul 2006 12:02:29 +0200
Message-ID: <E1G0znB-0002IH-5K@moooo.ath.cx>
References: <E1G0zj7-0001c1-8q@moooo.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jul 13 13:55:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0znJ-0007Iu-46
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 13:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbWGMLzp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 07:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbWGMLzp
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 07:55:45 -0400
Received: from moooo.ath.cx ([85.116.203.178]:14809 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932484AbWGMLzm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 07:55:42 -0400
To: git@vger.kernel.org
In-Reply-To: <E1G0zj7-0001c1-8q@moooo.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23827>

Removed the git-daemon prefix from die() because no other call to die
does this.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 daemon.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/daemon.c b/daemon.c
index e096bd7..a7636bc 100644
--- a/daemon.c
+++ b/daemon.c
@@ -95,6 +95,12 @@ static void loginfo(const char *err, ...
 	va_end(params);
 }
 
+static void NORETURN daemon_die(const char *err, va_list params)
+{
+	logreport(LOG_ERR, err, params);
+	exit(1);
+}
+
 static int avoid_alias(char *p)
 {
 	int sl, ndot;
@@ -746,17 +752,14 @@ int main(int argc, char **argv)
 		usage(daemon_usage);
 	}
 
-	if (log_syslog)
+	if (log_syslog) {
 		openlog("git-daemon", 0, LOG_DAEMON);
-
-	if (strict_paths && (!ok_paths || !*ok_paths)) {
-		if (!inetd_mode)
-			die("git-daemon: option --strict-paths requires a whitelist");
-
-		logerror("option --strict-paths requires a whitelist");
-		exit (1);
+		set_die_routine(daemon_die);
 	}
 
+	if (strict_paths && (!ok_paths || !*ok_paths))
+		die("option --strict-paths requires a whitelist");
+
 	if (inetd_mode) {
 		struct sockaddr_storage ss;
 		struct sockaddr *peer = (struct sockaddr *)&ss;
-- 
1.4.1.gb16f
