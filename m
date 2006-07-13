From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH 5.1/5] daemon: new option --detach to run git-daemon in background
Date: Thu, 13 Jul 2006 18:47:13 +0200
Message-ID: <E1G14LJ-0007q1-Fa@moooo.ath.cx>
References: <E1G0zj7-0001c1-8q@moooo.ath.cx> <E1G0znB-0002If-8A@moooo.ath.cx> <20060713153703.05f862ee.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 18:47:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G14LP-0003YK-RV
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 18:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWGMQrQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 12:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWGMQrQ
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 12:47:16 -0400
Received: from moooo.ath.cx ([85.116.203.178]:46798 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1030238AbWGMQrP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 12:47:15 -0400
To: Edgar Toernig <froese@gmx.de>
Mail-Followup-To: Edgar Toernig <froese@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060713153703.05f862ee.froese@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23843>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
Edgar Toernig <froese@gmx.de> wrote:
> Hmm... leaks devnull.  Why not simply close(0/1/2) and
> let sanitize_stdfds take care of the rest?
---
 daemon.c |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/daemon.c b/daemon.c
index cdc4266..e4ec676 100644
--- a/daemon.c
+++ b/daemon.c
@@ -674,6 +674,24 @@ static void sanitize_stdfds(void)
 		close(fd);
 }
 
+static void daemonize(void)
+{
+	switch (fork()) {
+		case 0:
+			break;
+		case -1:
+			die("fork failed: %s", strerror(errno));
+		default:
+			exit(0);
+	}
+	if (setsid() == -1)
+		die("setsid failed: %s", strerror(errno));
+	close(0);
+	close(1);
+	close(2);
+	sanitize_stdfds();
+}
+
 static void store_pid(const char *path)
 {
 	FILE *f = fopen(path, "w");
@@ -699,6 +717,7 @@ int main(int argc, char **argv)
 	int port = DEFAULT_GIT_PORT;
 	int inetd_mode = 0;
 	const char *pid_file = NULL;
+	int detach = 0;
 	int i;
 
 	/* Without this we cannot rely on waitpid() to tell
@@ -767,6 +786,11 @@ int main(int argc, char **argv)
 			pid_file = arg + 11;
 			continue;
 		}
+		if (!strcmp(arg, "--detach")) {
+			detach = 1;
+			log_syslog = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			ok_paths = &argv[i+1];
 			break;
@@ -799,7 +823,10 @@ int main(int argc, char **argv)
 		return execute(peer);
 	}
 
-	sanitize_stdfds();
+	if (detach)
+		daemonize();
+	else
+		sanitize_stdfds();
 
 	if (pid_file)
 		store_pid(pid_file);
-- 
1.4.1.g8b4b
