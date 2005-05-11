From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Stop git-rev-list at sha1 match
Date: Wed, 11 May 2005 14:54:11 -0700
Message-ID: <7vis1pqvi4.fsf@assigned-by-dhcp.cox.net>
References: <1115839456.22180.79.camel@tglx>
	<7vy8alr0mz.fsf@assigned-by-dhcp.cox.net>
	<1115843429.22180.90.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 23:48:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVz2z-0002r6-DZ
	for gcvg-git@gmane.org; Wed, 11 May 2005 23:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVEKVyu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 17:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVEKVyu
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 17:54:50 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:29378 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261265AbVEKVyN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 17:54:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050511215412.NTID19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 May 2005 17:54:12 -0400
To: tglx@linutronix.de, <pasky@ucw.cz>
In-Reply-To: <1115843429.22180.90.camel@tglx> (Thomas Gleixner's message of
 "Wed, 11 May 2005 20:30:29 +0000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "TG" == Thomas Gleixner <tglx@linutronix.de> writes:

TG> You moved the stop behind the printf which is inconsistent to the other
TG> stop conditions, but thats a pure cosmetic question as long as it stays
TG> that way for ever. 

While I work on the core GIT changes, I often find myself doing

    $ jit-log -l --since linus
    $ jit-log -l --since git-jc

to see what changes I have in my local work repository, and
seeing the branching point (or origin) at the very end of the
log made me feel assured that I am not losing anything in the
log.  But come to think of it, that is really an unnecessary
thing and stopping _before_ the named commit would make more
sense.

Here is a fixed version.  I am CC'ing pasky hoping he would pick
it up.

------------
Add --stop-at to git-rev-list command.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
--- a/checkout-cache.c
+++ b/checkout-cache.c
@@ -32,6 +32,8 @@
  * of "-a" causing problems (not possible in the above example,
  * but get used to it in scripting!).
  */
+#include <sys/types.h>
+#include <dirent.h>
 #include "cache.h"
 
 static int force = 0, quiet = 0, not_new = 0;
@@ -46,22 +48,67 @@ static void create_directories(const cha
 		len = slash - path;
 		memcpy(buf, path, len);
 		buf[len] = 0;
-		mkdir(buf, 0755);
+		if (mkdir(buf, 0755)) {
+			if (errno == EEXIST) {
+				struct stat st;
+				if (!lstat(buf, &st) && S_ISDIR(st.st_mode))
+					continue; /* ok */
+				if (force && !unlink(buf) && !mkdir(buf, 0755))
+					continue;
+			}
+			die("cannot create directory at %s", buf);
+		}
 	}
 	free(buf);
 }
 
+static void remove_subtree(const char *path)
+{
+	DIR *dir = opendir(path);
+	struct dirent *de;
+	char pathbuf[PATH_MAX];
+	char *name;
+	
+	if (!dir)
+		die("cannot opendir %s", path);
+	strcpy(pathbuf, path);
+	name = pathbuf + strlen(path);
+	*name++ = '/';
+	while ((de = readdir(dir)) != NULL) {
+		struct stat st;
+		if ((de->d_name[0] == '.') &&
+		    ((de->d_name[1] == 0) ||
+		     ((de->d_name[1] == '.') && de->d_name[2] == 0)))
+			continue;
+		strcpy(name, de->d_name);
+		if (lstat(pathbuf, &st))
+			die("cannot lstat %s", pathbuf);
+		if (S_ISDIR(st.st_mode))
+			remove_subtree(pathbuf);
+		else if (unlink(pathbuf))
+			die("cannot unlink %s", pathbuf);
+	}
+	closedir(dir);
+	if (rmdir(path))
+		die("cannot rmdir %s", path);
+}
+
 static int create_file(const char *path, unsigned int mode)
 {
 	int fd;
 
 	mode = (mode & 0100) ? 0777 : 0666;
+	create_directories(path);
 	fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
 	if (fd < 0) {
-		if (errno == ENOENT) {
+		if ((errno == ENOENT) || (errno == ENOTDIR && force)) {
 			create_directories(path);
 			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
 		}
+		else if (errno == EISDIR && force) {
+			remove_subtree(path);
+			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
+		}
 	}
 	return fd;
 }
--- a/rev-list.c
+++ b/rev-list.c
@@ -1,12 +1,21 @@
 #include "cache.h"
 #include "commit.h"
 
+static const char *rev_list_usage = 
+"usage: rev-list [OPTION] commit-id\n"
+"  --max-count=nr\n"
+"  --max-age=epoch\n"
+"  --min-age=epoch\n"
+"  --stop-at=commit\n";
+
 int main(int argc, char **argv)
 {
 	unsigned char sha1[20];
 	struct commit_list *list = NULL;
 	struct commit *commit;
 	char *commit_arg = NULL;
+	unsigned char stop_at[20];
+	int has_stop_at = 0;
 	int i;
 	unsigned long max_age = -1;
 	unsigned long min_age = -1;
@@ -21,16 +30,17 @@ int main(int argc, char **argv)
 			max_age = atoi(arg + 10);
 		} else if (!strncmp(arg, "--min-age=", 10)) {
 			min_age = atoi(arg + 10);
+		} else if (!strncmp(arg, "--stop-at=", 10)) {
+			if (get_sha1(arg + 10, stop_at))
+				usage(rev_list_usage);
+			has_stop_at = 1;
 		} else {
 			commit_arg = arg;
 		}
 	}
 
 	if (!commit_arg || get_sha1(commit_arg, sha1))
-		usage("usage: rev-list [OPTION] commit-id\n"
-		      "  --max-count=nr\n"
-		      "  --max-age=epoch\n"
-		      "  --min-age=epoch\n");
+		usage(rev_list_usage);
 
 	commit = lookup_commit(sha1);
 	if (!commit || parse_commit(commit) < 0)
@@ -46,6 +56,8 @@ int main(int argc, char **argv)
 			break;
 		if (max_count != -1 && !max_count--)
 			break;
+		if (has_stop_at && !memcmp(stop_at, commit->object.sha1, 20))
+			break;
 		printf("%s\n", sha1_to_hex(commit->object.sha1));
 	} while (list);
 	return 0;
Created: t/t0000.sh (mode:100755)
--- /dev/null
+++ b/t/t0000.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+
+case "${verbose+set}" in
+set)	say= ;;
+*)	say=: ;;
+esac
+
+export LANG C
+unset AUTHOR_DATE
+unset AUTHOR_EMAIL
+unset AUTHOR_NAME
+unset COMMIT_AUTHOR_EMAIL
+unset COMMIT_AUTHOR_NAME
+unset GIT_ALTERNATE_OBJECT_DIRECTORIES
+unset GIT_AUTHOR_DATE
+unset GIT_AUTHOR_EMAIL
+unset GIT_AUTHOR_NAME
+unset GIT_COMMITTER_EMAIL
+unset GIT_COMMITTER_NAME
+unset GIT_DIFF_OPTS
+unset GIT_DIR
+unset GIT_EXTERNAL_DIFF
+unset GIT_INDEX_FILE
+unset GIT_OBJECT_DIRECTORY
+unset SHA1_FILE_DIRECTORIES
+unset SHA1_FILE_DIRECTORY
+
+# Test the binaries we have just built.
+PATH=$(pwd)/..:$PATH
+
+# Test repository
+test=test-repo
+rm -fr "$test"
+mkdir "$test"
+cd "$test"
Created: t/t1000-checkout-cache.sh (mode:100755)
--- /dev/null
+++ b/t/t1000-checkout-cache.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+. ./t0000.sh
+git-init-db 2>/dev/null || exit
+date >path0
+mkdir path1
+date >path1/file1
+git-update-cache --add path0 path1/file1
+$say git-ls-files --stage
+
+rm -fr path0 path1
+mkdir path0
+date >path0/file0
+date >path1
+$say git-ls-files --stage
+$say find path*
+
+echo >&2 "* checkout-cache sans -f"
+git-checkout-cache -a
+case "$?" in
+0)	echo >&2 "*** bug: should not have succeeded." ;;
+*)	echo >&2 "*** ok: failed as expected." ;;
+esac
+$say find path*
+
+echo >&2 "* checkout-cache with -f"
+git-checkout-cache -f -a
+case "$?" in
+0)	echo >&2 "*** ok: succeeded as expected." ;;
+*)	echo >&2 "*** bug: should have succeeded." ;;
+esac
+$say find path*
+if test -f path0 && test -d path1 && test -f path1/file1
+then
+	echo >&2 "*** ok: checked out correctly."
+else
+	echo >&2 "*** bug: checkout failed."
+	exit 1
+fi
Created: t/t1001-checkout-cache.sh (mode:100755)
--- /dev/null
+++ b/t/t1001-checkout-cache.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+
+. ./t0000.sh
+git-init-db 2>/dev/null || exit
+
+show_files() {
+	find path? -ls |
+	sed -e 's/^[0-9]* * [0-9]* * \([-bcdl]\)[^ ]* *[0-9]* *[^ ]* *[^ ]* *[0-9]* [A-Z][a-z][a-z] [0-9][0-9] [^ ]* /fs: \1 /'
+	git-ls-files --stage |
+	sed -e 's/^\([0-9]*\) [0-9a-f]* [0-3] /ca: \1 /'
+	git-ls-tree -r "$1" |
+	sed -e 's/^\([0-9]*\)	[^ ]*	[0-9a-f]*	/tr: \1 /'
+}
+
+mkdir path0
+date >path0/file0
+git-update-cache --add path0/file0
+echo >&2 "* initial state: one file under one directory"
+tree1=$(git-write-tree)
+$say show_files $tree1
+
+mkdir path1
+date >path1/file1
+git-update-cache --add path1/file1
+echo >&2 "* two directories with one file each"
+tree2=$(git-write-tree)
+$say show_files $tree2
+
+rm -fr path1
+git-read-tree -m $tree1
+git-checkout-cache -f -a
+echo >&2 "* go back to initial state"
+$say show_files $tree1
+
+ln -s path0 path1
+git-update-cache --add path1
+echo >&2 "* a symlink where the other side would create a directory."
+tree3=$(git-write-tree)
+$say show_files $tree3
+
+# Morten says "Got that?" here.
+
+git-read-tree $tree2
+git-checkout-cache -f -a
+case "$?" in
+0)	echo >&2 "*** ok: succeeded as expected." ;;
+*)	echo >&2 "*** bug: should have succeeded." ;;
+esac
+echo >&2 "* read tree2 and checkout"
+$say show_files $tree2
+
+if test ! -h path0 && test -d path0 &&
+   test ! -h path1 && test -d path1 &&
+   test ! -h path0/file0 && test -f path0/file0 &&
+   test ! -h path1/file1 && test -f path1/file1
+then
+    echo >&2 "*** ok: checked out correctly."
+else
+    echo >&2 "*** bug: did not check out correctly."
+    exit 1
+fi
------------------------------------------------


