From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH/RFC (git-core)] update-index --again
Date: Fri, 05 May 2006 22:05:15 -0700
Message-ID: <7vodybvj3o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Sat May 06 07:05:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcEyo-0004EA-P7
	for gcvg-git@gmane.org; Sat, 06 May 2006 07:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWEFFFS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 01:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWEFFFS
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 01:05:18 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:42113 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964889AbWEFFFR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 May 2006 01:05:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060506050516.UQBH25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 6 May 2006 01:05:16 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19646>

After running 'git-update-index' for some paths, you may want to
do the update on the same set of paths again.

The new flag --again checks the paths whose index entries are
are different from the HEAD commit and updates them from the
working tree contents.

This was brought up by Carl Worth on #git.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * I want to reorganize index file to contain both blob and tree
   entries in not so distant future, so I probably should not be
   doing something like this which _would_ need rework when that
   happens, but I think what Carl wanted to do is a reasonable
   thing to ask.

   http://colabti.de/irclogger/irclogger_log/git?date=2006-05-05,Fri&sel=16#l31

 Documentation/git-update-index.txt |    6 ++-
 t/t2101-update-index-reupdate.sh   |   73 ++++++++++++++++++++++++++++++++++++
 update-index.c                     |   56 ++++++++++++++++++++++++++--
 3 files changed, 131 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 57177c7..d043e86 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 	     [--cacheinfo <mode> <object> <file>]\*
 	     [--chmod=(+|-)x]
 	     [--assume-unchanged | --no-assume-unchanged]
-	     [--really-refresh] [--unresolve]
+	     [--really-refresh] [--unresolve] [--again]
 	     [--info-only] [--index-info]
 	     [-z] [--stdin]
 	     [--verbose]
@@ -80,6 +80,10 @@ OPTIONS
 	filesystem that has very slow lstat(2) system call
 	(e.g. cifs).
 
+--again::
+	Runs `git-update-index` itself on the paths whose index
+	entries are different from those from the `HEAD` commit.
+
 --unresolve::
 	Restores the 'unmerged' or 'needs updating' state of a
 	file during a merge if it was cleared by accident.
diff --git a/t/t2101-update-index-reupdate.sh b/t/t2101-update-index-reupdate.sh
new file mode 100755
index 0000000..5c505c6
--- /dev/null
+++ b/t/t2101-update-index-reupdate.sh
@@ -0,0 +1,73 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Junio C Hamano
+#
+
+test_description='git-update-index --again test.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'update-index --add' \
+	'echo hello world >file1 &&
+	 echo goodbye people >file2 &&
+	 git-update-index --add file1 file2 &&
+	 git-ls-files -s >current &&
+	 cmp current - <<\EOF
+100644 3b18e512dba79e4c8300dd08aeb37f8e728b8dad 0	file1
+100644 9db8893856a8a02eaa73470054b7c1c5a7c82e47 0	file2
+EOF'
+
+test_expect_success 'update-index --again' \
+	'rm -f file1 &&
+	echo hello everybody >file2 &&
+	if git-update-index --again
+	then
+		echo should have refused to remove file1
+		exit 1
+	else
+		echo happy - failed as expected
+	fi &&
+	 git-ls-files -s >current &&
+	 cmp current - <<\EOF
+100644 3b18e512dba79e4c8300dd08aeb37f8e728b8dad 0	file1
+100644 9db8893856a8a02eaa73470054b7c1c5a7c82e47 0	file2
+EOF'
+
+test_expect_success 'update-index --remove --again' \
+	'git-update-index --remove --again &&
+	 git-ls-files -s >current &&
+	 cmp current - <<\EOF
+100644 0f1ae1422c2bf43f117d3dbd715c988a9ed2103f 0	file2
+EOF'
+
+test_expect_success 'first commit' 'git-commit -m initial'
+
+test_expect_success 'update-index again' \
+	'mkdir -p dir1 &&
+	echo hello world >dir1/file3 &&
+	echo goodbye people >file2 &&
+	git-update-index --add file2 dir1/file3 &&
+	echo hello everybody >file2
+	echo happy >dir1/file3 &&
+	git-update-index --again &&
+	git-ls-files -s >current &&
+	cmp current - <<\EOF
+100644 53ab446c3f4e42ce9bb728a0ccb283a101be4979 0	dir1/file3
+100644 0f1ae1422c2bf43f117d3dbd715c988a9ed2103f 0	file2
+EOF'
+
+test_expect_success 'update-index --update from subdir' \
+	'echo not so happy >file2 &&
+	cd dir1 &&
+	cat ../file2 >file3 &&
+	git-update-index --again &&
+	cd .. &&
+	git-ls-files -s >current &&
+	cmp current - <<\EOF
+100644 d7fb3f695f06c759dbf3ab00046e7cc2da22d10f 0	dir1/file3
+100644 0f1ae1422c2bf43f117d3dbd715c988a9ed2103f 0	file2
+EOF'
+
+test_done
+
diff --git a/update-index.c b/update-index.c
index 1870ac7..e6c460b 100644
--- a/update-index.c
+++ b/update-index.c
@@ -473,7 +473,7 @@ static void read_index_info(int line_ter
 }
 
 static const char update_index_usage[] =
-"git-update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--refresh] [--really-refresh] [--cacheinfo] [--chmod=(+|-)x] [--assume-unchanged] [--info-only] [--force-remove] [--stdin] [--index-info] [--unresolve] [--ignore-missing] [-z] [--verbose] [--] <file>...";
+"git-update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--refresh] [--really-refresh] [--cacheinfo] [--chmod=(+|-)x] [--assume-unchanged] [--info-only] [--force-remove] [--stdin] [--index-info] [--unresolve] [--again] [--ignore-missing] [-z] [--verbose] [--] <file>...";
 
 static unsigned char head_sha1[20];
 static unsigned char merge_head_sha1[20];
@@ -488,11 +488,13 @@ static struct cache_entry *read_one_ent(
 	struct cache_entry *ce;
 
 	if (get_tree_entry(ent, path, sha1, &mode)) {
-		error("%s: not in %s branch.", path, which);
+		if (which)
+			error("%s: not in %s branch.", path, which);
 		return NULL;
 	}
 	if (mode == S_IFDIR) {
-		error("%s: not a blob in %s branch.", path, which);
+		if (which)
+			error("%s: not a blob in %s branch.", path, which);
 		return NULL;
 	}
 	size = cache_entry_size(namelen);
@@ -597,6 +599,47 @@ static int do_unresolve(int ac, const ch
 	return err;
 }
 
+static int do_reupdate(int ac, const char **av,
+		       const char *prefix, int prefix_length)
+{
+	/* Read HEAD and run update-index on paths that are
+	 * merged and already different between index and HEAD.
+	 */
+	int pos;
+	int has_head = 1;
+
+	if (read_ref(git_path("HEAD"), head_sha1))
+		/* If there is no HEAD, that means it is an initial
+		 * commit.  Update everything in the index.
+		 */
+		has_head = 0;
+ redo:
+	for (pos = 0; pos < active_nr; pos++) {
+		struct cache_entry *ce = active_cache[pos];
+		struct cache_entry *old = NULL;
+		int save_nr;
+		if (ce_stage(ce))
+			continue;
+		if (has_head)
+			old = read_one_ent(NULL, head_sha1,
+					   ce->name, ce_namelen(ce), 0);
+		if (old && ce->ce_mode == old->ce_mode &&
+		    !memcmp(ce->sha1, old->sha1, 20)) {
+			free(old);
+			continue; /* unchanged */
+		}
+		/* Be careful.  The working tree may not have the
+		 * path anymore, in which case, under 'allow_remove',
+		 * or worse yet 'allow_replace', active_nr may decrease.
+		 */
+		save_nr = active_nr;
+		update_one(ce->name + prefix_length, prefix, prefix_length);
+		if (save_nr != active_nr)
+			goto redo;
+	}
+	return 0;
+}
+
 int main(int argc, const char **argv)
 {
 	int i, newfd, entries, has_errors = 0, line_termination = '\n';
@@ -714,6 +757,13 @@ int main(int argc, const char **argv)
 					active_cache_changed = 0;
 				goto finish;
 			}
+			if (!strcmp(path, "--again")) {
+				has_errors = do_reupdate(argc - i, argv + i,
+							 prefix, prefix_length);
+				if (has_errors)
+					active_cache_changed = 0;
+				goto finish;
+			}
 			if (!strcmp(path, "--ignore-missing")) {
 				not_new = 1;
 				continue;
-- 
1.3.2.g2749
