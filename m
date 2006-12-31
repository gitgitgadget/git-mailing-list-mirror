From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Force core.filemode to false on Cygwin.
Date: Sat, 30 Dec 2006 23:53:55 -0500
Message-ID: <20061231045355.GA5956@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 05:54:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0shw-0004vo-8l
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 05:54:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739AbWLaEyA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 23:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932744AbWLaEyA
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 23:54:00 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43584 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932739AbWLaEx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 23:53:59 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H0shc-0000rH-NT; Sat, 30 Dec 2006 23:53:44 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E12A420FB65; Sat, 30 Dec 2006 23:53:55 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35666>

Many users have noticed that core.filemode doesn't appear to be
automatically set right on Cygwin when using a repository stored
on NTFS.  The issue is that Cygwin and NTFS correctly supports
the executable mode bit, and Git properly detected that, but most
native Windows applications tend to create files such that Cygwin
sees the executable bit set when it probably shouldn't be.

This is especially bad if the user's favorite editor deletes the
file then recreates it whenever they save (vs. just overwriting)
as now a file that was created with mode 0644 by checkout-index
appears to have mode 0755.

So we introduce NO_TRUSTABLE_FILEMODE, settable at compile time.
Setting this option forces core.filemode to false, even if the
detection code would have returned true.  This option should be
enabled by default on Cygwin.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Makefile          |    7 +++++++
 builtin-init-db.c |   14 ++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 93dc494..fa1a022 100644
--- a/Makefile
+++ b/Makefile
@@ -72,6 +72,9 @@ all:
 # Define NO_FAST_WORKING_DIRECTORY if accessing objects in pack files is
 # generally faster on your platform than accessing the working directory.
 #
+# Define NO_TRUSTABLE_FILEMODE if your filesystem may claim to support
+# the executable mode bit, but doesn't really do so.
+#
 # Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
 #
 # Define NO_SOCKADDR_STORAGE if your platform does not have struct
@@ -361,6 +364,7 @@ ifeq ($(uname_O),Cygwin)
 	NEEDS_LIBICONV = YesPlease
 	NO_C99_FORMAT = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
+	NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
 	# There are conflicting reports about this.
 	# On some boxes NO_MMAP is needed, and not so elsewhere.
 	# Try commenting this out if you suspect MMAP is more efficient
@@ -521,6 +525,9 @@ endif
 ifdef NO_FAST_WORKING_DIRECTORY
 	BASIC_CFLAGS += -DNO_FAST_WORKING_DIRECTORY
 endif
+ifdef NO_TRUSTABLE_FILEMODE
+	BASIC_CFLAGS += -DNO_TRUSTABLE_FILEMODE
+endif
 ifdef NO_IPV6
 	BASIC_CFLAGS += -DNO_IPV6
 endif
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 01f366a..cc4fd21 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -10,6 +10,12 @@
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates/"
 #endif
 
+#ifdef NO_TRUSTABLE_FILEMODE
+#define TEST_FILEMODE 0
+#else
+#define TEST_FILEMODE 1
+#endif
+
 static void safe_create_dir(const char *dir, int share)
 {
 	if (mkdir(dir, 0777) < 0) {
@@ -236,14 +242,14 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	strcpy(path + len, "config");
 
 	/* Check filemode trustability */
-	if (!lstat(path, &st1)) {
+	int filemode = TEST_FILEMODE;
+	if (TEST_FILEMODE && !lstat(path, &st1)) {
 		struct stat st2;
-		int filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
+		filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
 				!lstat(path, &st2) &&
 				st1.st_mode != st2.st_mode);
-		git_config_set("core.filemode",
-			       filemode ? "true" : "false");
 	}
+	git_config_set("core.filemode", filemode ? "true" : "false");
 
 	/* Enable logAllRefUpdates if a working tree is attached */
 	if (!is_bare_git_dir(git_dir))
-- 
1.5.0.rc0.g6bb1
