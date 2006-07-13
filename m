From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH 4/5] daemon: new option --pid-file=<path> to store the pid
Date: Thu, 13 Jul 2006 12:18:08 +0200
Message-ID: <E1G0znB-0002IZ-7e@moooo.ath.cx>
References: <E1G0zj7-0001c1-8q@moooo.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jul 13 13:55:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0znI-0007Iu-0a
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 13:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWGMLzn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 07:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWGMLzn
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 07:55:43 -0400
Received: from moooo.ath.cx ([85.116.203.178]:15577 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932508AbWGMLzm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 07:55:42 -0400
To: git@vger.kernel.org
In-Reply-To: <E1G0zj7-0001c1-8q@moooo.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23828>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 daemon.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/daemon.c b/daemon.c
index e6b1730..4b85930 100644
--- a/daemon.c
+++ b/daemon.c
@@ -680,6 +680,15 @@ static void sanitize_stdfds(void)
 		close(devnull);
 }
 
+static void store_pid(const char *path)
+{
+	FILE *f = fopen(path, "w");
+	if (!f)
+		die("cannot open pid file %s: %s", path, strerror(errno));
+	fprintf(f, "%d\n", getpid());
+	fclose(f);
+}
+
 static int serve(int port)
 {
 	int socknum, *socklist;
@@ -695,6 +704,7 @@ int main(int argc, char **argv)
 {
 	int port = DEFAULT_GIT_PORT;
 	int inetd_mode = 0;
+	const char *pid_file = NULL;
 	int i;
 
 	/* Without this we cannot rely on waitpid() to tell
@@ -759,6 +769,10 @@ int main(int argc, char **argv)
 			user_path = arg + 12;
 			continue;
 		}
+		if (!strncmp(arg, "--pid-file=", 11)) {
+			pid_file = arg + 11;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			ok_paths = &argv[i+1];
 			break;
@@ -793,5 +807,8 @@ int main(int argc, char **argv)
 
 	sanitize_stdfds();
 
+	if (pid_file)
+		store_pid(pid_file);
+
 	return serve(port);
 }
-- 
1.4.1.gb16f
