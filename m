From: Brad Roberts <braddr@gameboy2.puremagic.com>
Subject: [PATCH] Add a --prefix option to git-daemon
Date: Tue, 25 Oct 2005 00:08:51 -0700
Message-ID: <200510250708.j9P78pG3024087@gameboy2.puremagic.com>
X-From: git-owner@vger.kernel.org Tue Oct 25 09:09:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUIvg-0000Rq-Qc
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 09:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbVJYHJB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 03:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbVJYHJB
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 03:09:01 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:24811 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S1751477AbVJYHJA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 03:09:00 -0400
Received: from gameboy2.puremagic.com (root@gameboy2.puremagic.com [209.189.198.109])
	by bellevue.puremagic.com (8.13.4/8.13.4/Debian-3) with ESMTP id j9P790KF013854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 25 Oct 2005 00:09:00 -0700
Received: from gameboy2.puremagic.com (braddr@localhost [127.0.0.1])
	by gameboy2.puremagic.com (8.13.5/8.13.5/Debian-3) with ESMTP id j9P78pjt024089
	for <git@vger.kernel.org>; Tue, 25 Oct 2005 00:08:51 -0700
Received: (from braddr@localhost)
	by gameboy2.puremagic.com (8.13.5/8.13.5/Submit) id j9P78pG3024087
	for git@vger.kernel.org; Tue, 25 Oct 2005 00:08:51 -0700
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10568>

Add a --prefix option to git-daemon.  This path is prepended to the search
path for repositories.  In other words, git://hostname/path/to/gitdir will
result in looking for /prefix/path/to/gitdir.

Signed-off-by: Brad Roberts <braddr@puremagic.com>
---

 daemon.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

applies-to: ccef5ac580c68a9714f37dcd8ee433e9691b640a
4ab5253ba31370d151843ca14a8cabcadc37c974
diff --git a/daemon.c b/daemon.c
index 0c6182f..566bec6 100644
--- a/daemon.c
+++ b/daemon.c
@@ -15,7 +15,7 @@ static int verbose;
 
 static const char daemon_usage[] =
 "git-daemon [--verbose] [--syslog] [--inetd | --port=n] [--export-all]\n"
-"           [--timeout=n] [--init-timeout=n] [directory...]";
+"           [--timeout=n] [--init-timeout=n] [--prefix=directory] [directory...]";
 
 /* List of acceptable pathname prefixes */
 static char **ok_paths = NULL;
@@ -27,6 +27,9 @@ static int export_all_trees = 0;
 static unsigned int timeout = 0;
 static unsigned int init_timeout = 0;
 
+/* directory prefix for all repositories */
+static const char *directory_prefix = "";
+
 static void logreport(int priority, const char *err, va_list params)
 {
 	/* We should do a single write so that it is atomic and output
@@ -170,10 +173,10 @@ static int set_dir(const char *dir)
 static int upload(char *dir)
 {
 	/* Try paths in this order */
-	static const char *paths[] = { "%s", "%s/.git", "%s.git", "%s.git/.git", NULL };
+	static const char *paths[] = { "%s%s", "%s%s/.git", "%s%s.git", "%s%s.git/.git", NULL };
 	const char **pp;
 	/* Enough for the longest path above including final null */
-	int buflen = strlen(dir)+10;
+	int buflen = strlen(dir)+strlen(directory_prefix)+10;
 	char *dirbuf = xmalloc(buflen);
 	/* Timeout as string */
 	char timeout_buf[64];
@@ -181,7 +184,7 @@ static int upload(char *dir)
 	loginfo("Request for '%s'", dir);
 
 	for ( pp = paths ; *pp ; pp++ ) {
-		snprintf(dirbuf, buflen, *pp, dir);
+		snprintf(dirbuf, buflen, *pp, directory_prefix, dir);
 		if ( !set_dir(dirbuf) )
 			break;
 	}
@@ -615,6 +618,10 @@ int main(int argc, char **argv)
 		if (!strncmp(arg, "--init-timeout=", 15)) {
 			init_timeout = atoi(arg+15);
 		}
+		if (!strncmp(arg, "--prefix=", 9)) {
+			directory_prefix = arg+9;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			ok_paths = &argv[i+1];
 			break;
---
0.99.8.GIT
