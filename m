From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Fix filename verification when in a subdirectory
Date: Wed, 26 Apr 2006 10:15:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604261010390.3701@g5.osdl.org>
References: <17483.27938.890830.375324@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0604230906370.3701@g5.osdl.org> <E1FYlwn-0005mf-CL@moooo.ath.cx>
 <Pine.LNX.4.64.0604260832240.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Apr 26 19:16:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYncb-00044c-U9
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 19:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWDZRQH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 13:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWDZRQH
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 13:16:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39073 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932351AbWDZRQG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Apr 2006 13:16:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3QHFutH001598
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 26 Apr 2006 10:15:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3QHFsm4001066;
	Wed, 26 Apr 2006 10:15:55 -0700
To: Junio C Hamano <junkio@cox.net>,
	Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <Pine.LNX.4.64.0604260832240.3701@g5.osdl.org>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19213>


When we are in a subdirectory of a git archive, we need to take the prefix 
of that subdirectory into accoung when we verify filename arguments.

Noted by Matthias Lederhofer

This also uses the improved error reporting for all the other git commands 
that use the revision parsing interfaces, not just git-rev-parse. Also, it 
makes the error reporting for mixed filenames and argument flags clearer 
(you cannot put flags after the start of the pathname list).

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
On Wed, 26 Apr 2006, Linus Torvalds wrote:
> > 
> > Shouldn't git rev-parse try to stat the file (additionally?) in the 
> > current directory instead of the top git directory? git (diff|log|..) 
> > seem to fail everytime in a subdirectory without --.
> 
> Good point. However, the reason for that is that it actually _does_ stat 
> the file in the current directory, but it has done the 
> 
> 	revs->prefix = setup_git_directory();
> 
> in the init path (and it does need to do that, since that's what figures 
> out where the .git directory is, so that we can parse the revisions 
> correctly).
> 
> And that "setup_git_directory()" will chdir() to the root of the project.

diff --git a/cache.h b/cache.h
index 69801b0..4d8fabc 100644
--- a/cache.h
+++ b/cache.h
@@ -134,6 +134,7 @@ extern const char *setup_git_directory_g
 extern const char *setup_git_directory(void);
 extern const char *prefix_path(const char *prefix, int len, const char *path);
 extern const char *prefix_filename(const char *prefix, int len, const char *path);
+extern void verify_filename(const char *prefix, const char *name);
 
 #define alloc_nr(x) (((x)+16)*3/2)
 
diff --git a/rev-parse.c b/rev-parse.c
index 7f66ae2..62e16af 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -160,14 +160,6 @@ static int show_file(const char *arg)
 	return 0;
 }
 
-static void die_badfile(const char *arg)
-{
-	if (errno != ENOENT)
-		die("'%s': %s", arg, strerror(errno));
-	die("'%s' is ambiguous - revision name or file/directory name?\n"
-	    "Please put '--' before the list of filenames.", arg);
-}
-
 int main(int argc, char **argv)
 {
 	int i, as_is = 0, verify = 0;
@@ -177,14 +169,12 @@ int main(int argc, char **argv)
 	git_config(git_default_config);
 
 	for (i = 1; i < argc; i++) {
-		struct stat st;
 		char *arg = argv[i];
 		char *dotdot;
 
 		if (as_is) {
 			if (show_file(arg) && as_is < 2)
-				if (lstat(arg, &st) < 0)
-					die_badfile(arg);
+				verify_filename(prefix, arg);
 			continue;
 		}
 		if (!strcmp(arg,"-n")) {
@@ -350,8 +340,7 @@ int main(int argc, char **argv)
 			continue;
 		if (verify)
 			die("Needed a single revision");
-		if (lstat(arg, &st) < 0)
-			die_badfile(arg);
+		verify_filename(prefix, arg);
 	}
 	show_default();
 	if (verify && revs_count != 1)
diff --git a/revision.c b/revision.c
index f9c7d15..f2a9f25 100644
--- a/revision.c
+++ b/revision.c
@@ -752,17 +752,15 @@ int setup_revisions(int argc, const char
 			arg++;
 		}
 		if (get_sha1(arg, sha1) < 0) {
-			struct stat st;
 			int j;
 
 			if (seen_dashdash || local_flags)
 				die("bad revision '%s'", arg);
 
 			/* If we didn't have a "--", all filenames must exist */
-			for (j = i; j < argc; j++) {
-				if (lstat(argv[j], &st) < 0)
-					die("'%s': %s", argv[j], strerror(errno));
-			}
+			for (j = i; j < argc; j++)
+				verify_filename(revs->prefix, argv[j]);
+
 			revs->prune_data = get_pathspec(revs->prefix, argv + i);
 			break;
 		}
diff --git a/setup.c b/setup.c
index 36ede3d..119ef7d 100644
--- a/setup.c
+++ b/setup.c
@@ -62,6 +62,29 @@ const char *prefix_filename(const char *
 	return path;
 }
 
+/*
+ * Verify a filename that we got as an argument for a pathspec
+ * entry. Note that a filename that begins with "-" never verifies
+ * as true, because even if such a filename were to exist, we want
+ * it to be preceded by the "--" marker (or we want the user to
+ * use a format like "./-filename")
+ */
+void verify_filename(const char *prefix, const char *arg)
+{
+	const char *name;
+	struct stat st;
+
+	if (*arg == '-')
+		die("bad flag '%s' used after filename", arg);
+	name = prefix ? prefix_filename(prefix, strlen(prefix), arg) : arg;
+	if (!lstat(name, &st))
+		return;
+	if (errno == ENOENT);
+		die("ambiguous argument '%s': unknown revision or filename\n"
+		    "Use '--' to separate filenames from revisions", arg);
+	die("'%s': %s", arg, strerror(errno));
+}
+
 const char **get_pathspec(const char *prefix, const char **pathspec)
 {
 	const char *entry = *pathspec;
