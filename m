From: Linus Torvalds <torvalds@osdl.org>
Subject: Make .git directory validation code test HEAD
Date: Sat, 27 Aug 2005 13:54:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508271334320.3317@g5.osdl.org>
References: <874q9bcu6d.fsf@litku.valo.iki.fi> <46a038f905082708371719121c@mail.gmail.com>
 <87zmr39svy.fsf@litku.valo.iki.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kalle Valo <Kalle.Valo@iki.fi>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 27 22:55:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E97ha-00081k-BA
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 22:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVH0Uy4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Aug 2005 16:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVH0Uyz
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Aug 2005 16:54:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5525 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750774AbVH0Uyz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Aug 2005 16:54:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7RKshjA028671
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 27 Aug 2005 13:54:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7RKsgWJ016118;
	Sat, 27 Aug 2005 13:54:42 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <87zmr39svy.fsf@litku.valo.iki.fi>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7854>


Inspired by a report by Kalle Valo, this changes git-sh-setup-script and
the "setup_git_directory()" function to test that $GIT_DIR/HEAD is a
symlink, since a number of core git features depend on that these days.

We used to allow a regular file there, but git-fsck-cache has been 
complaining about that for a while, and anything that uses branches 
depends on the HEAD file being a symlink, so let's just encode that as a 
fundamental requirement.

Before, a non-symlink HEAD file would appear to work, but have subtle bugs 
like not having the HEAD show up as a valid reference (because it wasn't 
under "refs"). Now, we will complain loudly, and the user can fix it up 
trivially instead of getting strange behaviour.

This also removes the tests for "$GIT_DIR" and "$GIT_OBJECT_DIRECTORY" 
being directories, since the other tests will implicitly test for that 
anyway (ie the tests for HEAD, refs and 00 would fail).

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

On Sat, 27 Aug 2005, Kalle Valo wrote:
> 
> I investigated it and realized that this was my mistake. I had copied
> the imported git repository from my laptop to my desktop using 'scp
> -r' and it changed .git/HEAD to a file, not a link as it should have
> been. I copied it again, this time with tar to preserve symbolic
> links, and cvsimport started to work again. So this was just a PEBCAK.

diff --git a/git-sh-setup-script b/git-sh-setup-script
--- a/git-sh-setup-script
+++ b/git-sh-setup-script
@@ -11,7 +11,6 @@ die() {
 	exit 1
 }
 
-[ -d "$GIT_DIR" ] &&
+[ -h "$GIT_DIR/HEAD" ] &&
 [ -d "$GIT_DIR/refs" ] &&
-[ -d "$GIT_OBJECT_DIRECTORY" ] &&
 [ -d "$GIT_OBJECT_DIRECTORY/00" ]
diff --git a/setup.c b/setup.c
--- a/setup.c
+++ b/setup.c
@@ -72,6 +72,24 @@ const char **get_pathspec(const char *pr
 	return (const char **) pathspec;
 }
 
+/*
+ * Test it it looks like we're at the top
+ * level git directory. We want to see a
+ *
+ *  - a HEAD symlink and a refs/ directory under ".git"
+ *  - either a .git/objects/ directory _or_ the proper
+ *    GIT_OBJECT_DIRECTORY environment variable
+ */
+static int is_toplevel_directory(void)
+{
+	struct stat st;
+
+	return	!lstat(".git/HEAD", &st) &&
+		S_ISLNK(st.st_mode) &&
+		!access(".git/refs/", X_OK) &&
+		(gitenv(DB_ENVIRONMENT) || !access(".git/objects/", X_OK));
+}
+
 const char *setup_git_directory(void)
 {
 	static char cwd[PATH_MAX+1];
@@ -89,17 +107,8 @@ const char *setup_git_directory(void)
 
 	offset = len = strlen(cwd);
 	for (;;) {
-		/*
-		 * We always want to see a .git/refs/ subdirectory
-		 */
-		if (!access(".git/refs/", X_OK)) {
-			/*
-			 * Then we need either a GIT_OBJECT_DIRECTORY define
-			 * or a .git/objects/ directory
-			 */
-			if (gitenv(DB_ENVIRONMENT) || !access(".git/objects/", X_OK))
-				break;
-		}
+		if (is_toplevel_directory())
+			break;
 		chdir("..");
 		do {
 			if (!offset)
