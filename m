From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3.2/4] daemon: deglobalize variable 'directory'
Date: Sun, 23 Nov 2008 00:21:52 +0100
Message-ID: <49289410.2080001@lsrfire.ath.cx>
References: <4928912A.5050307@lsrfire.ath.cx> <492891FC.6000908@lsrfire.ath.cx> <49289275.7090003@lsrfire.ath.cx> <4928936D.8010404@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jon Loeliger <jdl@freescale.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 23 00:23:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L41op-00042O-Ru
	for gcvg-git-2@gmane.org; Sun, 23 Nov 2008 00:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297AbYKVXV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Nov 2008 18:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753410AbYKVXV7
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Nov 2008 18:21:59 -0500
Received: from india601.server4you.de ([85.25.151.105]:42637 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401AbYKVXV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2008 18:21:58 -0500
Received: from [10.0.1.101] (p57B7B890.dip.t-dialin.net [87.183.184.144])
	by india601.server4you.de (Postfix) with ESMTPSA id B8EB52F8057;
	Sun, 23 Nov 2008 00:21:56 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <4928936D.8010404@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101565>

Remove the global variable 'directory' and pass it as a parameter of
the two functions that use it instead, (almost) restoring their
interface to how it was before 49ba83fb67d9e447b86953965ce5f949c6a93b81.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 daemon.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/daemon.c b/daemon.c
index fbf61ca..1cef309 100644
--- a/daemon.c
+++ b/daemon.c
@@ -57,7 +57,6 @@ static char *hostname;
 static char *canon_hostname;
 static char *ip_address;
 static char *tcp_port;
-static char *directory;
 
 static void logreport(int priority, const char *err, va_list params)
 {
@@ -147,7 +146,7 @@ static int avoid_alias(char *p)
 	}
 }
 
-static char *path_ok(void)
+static char *path_ok(char *directory)
 {
 	static char rpath[PATH_MAX];
 	static char interp_path[PATH_MAX];
@@ -296,12 +295,12 @@ static int git_daemon_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-static int run_service(struct daemon_service *service)
+static int run_service(char *dir, struct daemon_service *service)
 {
 	const char *path;
 	int enabled = service->enabled;
 
-	loginfo("Request %s for '%s'", service->name, directory);
+	loginfo("Request %s for '%s'", service->name, dir);
 
 	if (!enabled && !service->overridable) {
 		logerror("'%s': service not enabled.", service->name);
@@ -309,7 +308,7 @@ static int run_service(struct daemon_service *service)
 		return -1;
 	}
 
-	if (!(path = path_ok()))
+	if (!(path = path_ok(dir)))
 		return -1;
 
 	/*
@@ -555,8 +554,7 @@ static int execute(struct sockaddr *addr)
 	free(canon_hostname);
 	free(ip_address);
 	free(tcp_port);
-	free(directory);
-	hostname = canon_hostname = ip_address = tcp_port = directory = NULL;
+	hostname = canon_hostname = ip_address = tcp_port = NULL;
 
 	if (len != pktlen)
 		parse_extra_args(line + len + 1, pktlen - len - 1);
@@ -571,9 +569,7 @@ static int execute(struct sockaddr *addr)
 			 * Note: The directory here is probably context sensitive,
 			 * and might depend on the actual service being performed.
 			 */
-			free(directory);
-			directory = xstrdup(line + namelen + 5);
-			return run_service(s);
+			return run_service(line + namelen + 5, s);
 		}
 	}
 
-- 
1.6.0.4.755.g6e139
