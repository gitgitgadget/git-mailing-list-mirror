From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] revised^2: git-daemon extra paranoia, and path DWIM
Date: Tue, 18 Oct 2005 18:09:19 -0700
Message-ID: <43559CBF.2040105@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020806010400090401060107"
X-From: git-owner@vger.kernel.org Wed Oct 19 03:11:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES2Se-0003fe-Ab
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 03:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbVJSBJk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 21:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbVJSBJk
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 21:09:40 -0400
Received: from terminus.zytor.com ([192.83.249.54]:6089 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751479AbVJSBJk
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 21:09:40 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9J19OB1013096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Oct 2005 18:09:24 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10253>

This is a multi-part message in MIME format.
--------------020806010400090401060107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds some extra paranoia to the git-daemon filename test.  In 
particular, it now rejects pathnames containing //; it also adds a 
redundant test for pathname absoluteness (belts and suspenders.)

A single / at the end of the path is still permitted, however, and the 
.git and /.git append DWIM stuff is now handled in an integrated manner, 
which means the resulting path will always be subjected to pathname checks.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

--------------020806010400090401060107
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/daemon.c b/daemon.c
--- a/daemon.c
+++ b/daemon.c
@@ -80,17 +80,30 @@ static int path_ok(const char *dir)
 {
 	const char *p = dir;
 	char **pp;
-	int sl = 1, ndot = 0;
+	int sl, ndot;
+
+	/* The pathname here should be an absolute path. */
+	if ( *p++ != '/' )
+		return 0;
+
+	sl = 1;  ndot = 0;
 
 	for (;;) {
 		if ( *p == '.' ) {
 			ndot++;
-		} else if ( *p == '/' || *p == '\0' ) {
+		} else if ( *p == '\0' ) {
+			/* Reject "." and ".." at the end of the path */
 			if ( sl && ndot > 0 && ndot < 3 )
-				return 0; /* . or .. in path */
+				return 0;
+
+			/* Otherwise OK */
+			break;
+		} else if ( *p == '/' ) {
+			/* Refuse "", "." or ".." */
+			if ( sl && ndot < 3 )
+				return 0;
 			sl = 1;
-			if ( *p == '\0' )
-				break; /* End of string and all is good */
+			ndot = 0;
 		} else {
 			sl = ndot = 0;
 		}
@@ -99,7 +112,7 @@ static int path_ok(const char *dir)
 
 	if ( ok_paths && *ok_paths ) {
 		int ok = 0;
-		int dirlen = strlen(dir); /* read_packet_line can return embedded \0 */
+		int dirlen = strlen(dir);
 
 		for ( pp = ok_paths ; *pp ; pp++ ) {
 			int len = strlen(*pp);
@@ -118,22 +131,16 @@ static int path_ok(const char *dir)
 	return 1;		/* Path acceptable */
 }
 
-static int upload(char *dir, int dirlen)
+static int set_dir(const char *dir)
 {
-	loginfo("Request for '%s'", dir);
-
 	if (!path_ok(dir)) {
-		logerror("Forbidden directory: %s\n", dir);
+		errno = EACCES;
 		return -1;
 	}
 
-	if (chdir(dir) < 0) {
-		logerror("Cannot chdir('%s'): %s", dir, strerror(errno));
+	if ( chdir(dir) )
 		return -1;
-	}
-
-	chdir(".git");
-
+	
 	/*
 	 * Security on the cheap.
 	 *
@@ -141,10 +148,39 @@ static int upload(char *dir, int dirlen)
 	 * a "git-daemon-export-ok" flag that says that the other side
 	 * is ok with us doing this.
 	 */
-	if ((!export_all_trees && access("git-daemon-export-ok", F_OK)) ||
-	    access("objects/", X_OK) ||
-	    access("HEAD", R_OK)) {
-		logerror("Not a valid git-daemon-enabled repository: '%s'", dir);
+	if (!export_all_trees && access("git-daemon-export-ok", F_OK)) {
+		errno = EACCES;
+		return -1;
+	}
+
+	if (access("objects/", X_OK) || access("HEAD", R_OK)) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	/* If all this passed, we're OK */
+	return 0;
+}
+
+static int upload(char *dir)
+{
+	/* Try paths in this order */
+	static const char *paths[] = { "%s", "%s/.git", "%s.git", "%s.git/.git", NULL };
+	const char **pp;
+	/* Enough for the longest path above including final null */
+	int buflen = strlen(dir)+10;
+	char *dirbuf = xmalloc(buflen);
+
+	loginfo("Request for '%s'", dir);
+
+	for ( pp = paths ; *pp ; pp++ ) {
+		snprintf(dirbuf, buflen, *pp, dir);
+		if ( !set_dir(dirbuf) )
+			break;
+	}
+
+	if ( !*pp ) {
+		logerror("Cannot set directory '%s': %s", dir, strerror(errno));
 		return -1;
 	}
 
@@ -170,7 +206,7 @@ static int execute(void)
 		line[--len] = 0;
 
 	if (!strncmp("git-upload-pack /", line, 17))
-		return upload(line + 16, len - 16);
+		return upload(line+16);
 
 	logerror("Protocol error: '%s'", line);
 	return -1;

--------------020806010400090401060107--
