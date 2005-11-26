From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/8] peek-remote: honor proxy config even from subdirectory.
Date: Sat, 26 Nov 2005 01:56:41 -0800
Message-ID: <7vd5kn68bq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
	<200511210026.30280.Josef.Weidendorfer@gmx.de>
	<200511221831.03954.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
	<438371E8.2030701@op5.se>
	<Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
	<7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
	<Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
	<43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 26 10:57:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfwnY-0002M4-B0
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 10:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVKZJ4n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 04:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbVKZJ4n
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 04:56:43 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:65455 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750817AbVKZJ4m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2005 04:56:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051126095614.ZPZB3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 26 Nov 2005 04:56:14 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12771>

Introduce setup_git_directory_gently() which does not die() if
called outside a git repository, and use it so that later
git_config() would work as expected even from a subdirectory,
without failing the whole command if run outside a git
repository.

Use it at the beginning of peek-remote so that git:// proxy can
be picked up from the configuration file.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 cache.h       |    1 +
 peek-remote.c |    3 +++
 setup.c       |   11 ++++++++---
 3 files changed, 12 insertions(+), 3 deletions(-)

applies-to: 6afe0a2dc5da18d1090e8d660e45e2c777bfeaaa
1fe3fae4e1dcd864af4010ee572a3bc6de996e95
diff --git a/cache.h b/cache.h
index 62920ce..13806d3 100644
--- a/cache.h
+++ b/cache.h
@@ -147,6 +147,7 @@ extern char *get_graft_file(void);
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
 extern const char **get_pathspec(const char *prefix, const char **pathspec);
+extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
 extern const char *prefix_path(const char *prefix, int len, const char *path);
 extern const char *prefix_filename(const char *prefix, int len, const char *path);
diff --git a/peek-remote.c b/peek-remote.c
index ee49bf3..a90cf22 100644
--- a/peek-remote.c
+++ b/peek-remote.c
@@ -27,6 +27,9 @@ int main(int argc, char **argv)
 	char *dest = NULL;
 	int fd[2];
 	pid_t pid;
+	int nongit = 0;
+
+	setup_git_directory_gently(&nongit);
 
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
diff --git a/setup.c b/setup.c
index 54f6a34..b697bf9 100644
--- a/setup.c
+++ b/setup.c
@@ -107,7 +107,7 @@ static int is_toplevel_directory(void)
 	return 1;
 }
 
-static const char *setup_git_directory_1(void)
+const char *setup_git_directory_gently(int *nongit_ok)
 {
 	static char cwd[PATH_MAX+1];
 	int len, offset;
@@ -154,8 +154,13 @@ static const char *setup_git_directory_1
 			break;
 		chdir("..");
 		do {
-			if (!offset)
+			if (!offset) {
+				if (nongit_ok) {
+					*nongit_ok = 1;
+					return NULL;
+				}
 				die("Not a git repository");
+			}
 		} while (cwd[--offset] != '/');
 	}
 
@@ -171,6 +176,6 @@ static const char *setup_git_directory_1
 
 const char *setup_git_directory(void)
 {
-	const char *retval = setup_git_directory_1();
+	const char *retval = setup_git_directory_gently(NULL);
 	return retval;
 }
---
0.99.9.GIT
