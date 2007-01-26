From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 6/7] add logref support to git-symbolic-ref
Date: Fri, 26 Jan 2007 17:26:10 -0500
Message-ID: <1169850372410-git-send-email-nico@cam.org>
References: <1169850371517-git-send-email-nico@cam.org>
 <11698503712588-git-send-email-nico@cam.org>
 <11698503712998-git-send-email-nico@cam.org>
 <1169850372648-git-send-email-nico@cam.org>
 <11698503722922-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 23:26:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAZWm-0004YX-Kl
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 23:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbXAZW0S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 17:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbXAZW0R
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 17:26:17 -0500
Received: from relais.videotron.ca ([24.201.245.36]:60997 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbXAZW0P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 17:26:15 -0500
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCH00AEPYBNA4H0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 26 Jan 2007 17:26:13 -0500 (EST)
In-reply-to: <11698503722922-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.0.rc2.g6e2c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37892>

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 Documentation/git-symbolic-ref.txt |    6 +++++-
 builtin-branch.c                   |    3 ++-
 builtin-init-db.c                  |    2 +-
 builtin-symbolic-ref.c             |   16 ++++++++++++++--
 cache.h                            |    2 +-
 refs.c                             |   14 ++++++++++++--
 6 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.txt
index f93b79a..a88f722 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -7,7 +7,7 @@ git-symbolic-ref - Read and modify symbolic refs
 
 SYNOPSIS
 --------
-'git-symbolic-ref' [-q] <name> [<ref>]
+'git-symbolic-ref' [-q] [-m <reason>] <name> [<ref>]
 
 DESCRIPTION
 -----------
@@ -31,6 +31,10 @@ OPTIONS
 	symbolic ref but a detached HEAD; instead exit with
 	non-zero status silently.
 
+-m::
+	Update the reflog for <name> with <reason>.  This is valid only
+	when creating or updating a symbolic ref.
+
 NOTES
 -----
 In the past, `.git/HEAD` was a symbolic link pointing at
diff --git a/builtin-branch.c b/builtin-branch.c
index 25ffa54..52a9250 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -381,7 +381,8 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	if (rename_ref(oldref, newref, logmsg))
 		die("Branch rename failed");
 
-	if (!strcmp(oldname, head) && create_symref("HEAD", newref))
+	/* no need to pass logmsg here as HEAD didn't really move */
+	if (!strcmp(oldname, head) && create_symref("HEAD", newref, NULL))
 		die("Branch renamed to %s, but HEAD is not updated!", newname);
 }
 
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 1865489..12e43d0 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -231,7 +231,7 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	strcpy(path + len, "HEAD");
 	reinit = !read_ref("HEAD", sha1);
 	if (!reinit) {
-		if (create_symref("HEAD", "refs/heads/master") < 0)
+		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
 			exit(1);
 	}
 
diff --git a/builtin-symbolic-ref.c b/builtin-symbolic-ref.c
index 227c9d4..d41b406 100644
--- a/builtin-symbolic-ref.c
+++ b/builtin-symbolic-ref.c
@@ -3,7 +3,7 @@
 #include "refs.h"
 
 static const char git_symbolic_ref_usage[] =
-"git-symbolic-ref [-q] name [ref]";
+"git-symbolic-ref [-q] [-m <reason>] name [ref]";
 
 static void check_symref(const char *HEAD, int quiet)
 {
@@ -25,6 +25,7 @@ static void check_symref(const char *HEAD, int quiet)
 int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 {
 	int quiet = 0;
+	const char *msg = NULL;
 
 	git_config(git_default_config);
 
@@ -34,6 +35,17 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 			break;
 		else if (!strcmp("-q", arg))
 			quiet = 1;
+		else if (!strcmp("-m", arg)) {
+			argc--;
+			argv++;
+			if (argc <= 1)
+				break;
+			msg = argv[1];
+			if (!*msg)
+				die("Refusing to perform update with empty message");
+			if (strchr(msg, '\n'))
+				die("Refusing to perform update with \\n in message");
+		}
 		else if (!strcmp("--", arg)) {
 			argc--;
 			argv++;
@@ -50,7 +62,7 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 		check_symref(argv[1], quiet);
 		break;
 	case 3:
-		create_symref(argv[1], argv[2]);
+		create_symref(argv[1], argv[2], msg);
 		break;
 	default:
 		usage(git_symbolic_ref_usage);
diff --git a/cache.h b/cache.h
index 9486132..6472608 100644
--- a/cache.h
+++ b/cache.h
@@ -302,7 +302,7 @@ extern int read_ref(const char *filename, unsigned char *sha1);
 extern const char *resolve_ref(const char *path, unsigned char *sha1, int, int *);
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
 
-extern int create_symref(const char *ref, const char *refs_heads_master);
+extern int create_symref(const char *ref, const char *refs_heads_master, const char *logmsg);
 extern int validate_headref(const char *ref);
 
 extern int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
diff --git a/refs.c b/refs.c
index f91e853..f632d49 100644
--- a/refs.c
+++ b/refs.c
@@ -979,18 +979,23 @@ int write_ref_sha1(struct ref_lock *lock,
 	return 0;
 }
 
-int create_symref(const char *ref_target, const char *refs_heads_master)
+int create_symref(const char *ref_target, const char *refs_heads_master,
+		  const char *logmsg)
 {
 	const char *lockpath;
 	char ref[1000];
 	int fd, len, written;
 	const char *git_HEAD = git_path("%s", ref_target);
+	unsigned char old_sha1[20], new_sha1[20];
+
+	if (logmsg && read_ref(ref_target, old_sha1))
+		hashclr(old_sha1);
 
 #ifndef NO_SYMLINK_HEAD
 	if (prefer_symlink_refs) {
 		unlink(git_HEAD);
 		if (!symlink(refs_heads_master, git_HEAD))
-			return 0;
+			goto done;
 		fprintf(stderr, "no symlink - falling back to symbolic ref\n");
 	}
 #endif
@@ -1019,6 +1024,11 @@ int create_symref(const char *ref_target, const char *refs_heads_master)
 		error("Unable to fix permissions on %s", lockpath);
 		return -4;
 	}
+
+	done:
+	if (logmsg && !read_ref(refs_heads_master, new_sha1))
+		log_ref_write(ref_target, old_sha1, new_sha1, logmsg);
+
 	return 0;
 }
 
-- 
1.5.0.rc2.g6e2c
