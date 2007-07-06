From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Enable "git rerere" by the config variable rerere.enabled
Date: Fri, 6 Jul 2007 13:05:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707061303450.4093@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 06 14:13:16 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6mgT-00046A-Sw
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 14:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759915AbXGFMNL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 08:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759842AbXGFMNK
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 08:13:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:51442 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759896AbXGFMNH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 08:13:07 -0400
Received: (qmail invoked by alias); 06 Jul 2007 12:13:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp023) with SMTP; 06 Jul 2007 14:13:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18vofllpNwvyT6f49Qxyi7ZlwOia+3CU923nmUw0w
	Yhu82Iv+6Dyyyy
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51742>


Earlier, "git rerere" was enabled by creating the directory
.git/rr-cache.  That is definitely not in line with most other
features, which are enabled by a config variable.

So, check the config variable "rerere.enabled". If it is set
to "false" explicitely, do not activate rerere, even if
.git/rr-cache exists. This should help when you want to disable
rerere temporarily.

If "rerere.enabled" is not set at all, fall back to detection
of the directory .git/rr-cache.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Touches quite some parts, doesn't it?

	And yeah, the git-gui part should be factored out, I guess. Shawn?

 Documentation/config.txt     |    5 +++++
 Documentation/git-rerere.txt |    4 ++--
 builtin-rerere.c             |   31 +++++++++++++++++++++++++++----
 contrib/emacs/git.el         |    3 +--
 git-am.sh                    |   15 +++------------
 git-commit.sh                |    5 +----
 git-gui/lib/commit.tcl       |    4 +---
 git-merge.sh                 |    5 +----
 git-rebase.sh                |   12 +++---------
 t/t4200-rerere.sh            |   23 ++++++++++++++++++++---
 10 files changed, 64 insertions(+), 43 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 66a55b0..4b67f0a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -448,6 +448,11 @@ gc.rerereunresolved::
 	kept for this many days when `git rerere gc` is run.
 	The default is 15 days.  See gitlink:git-rerere[1].
 
+rerere.enabled::
+	Activate recording of resolved conflicts, so that identical
+	conflict hunks can be resolved automatically, should they
+	be encountered again.  See gitlink:git-rerere[1].
+
 gitcvs.enabled::
 	Whether the cvs server interface is enabled for this repository.
 	See gitlink:git-cvsserver[1].
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 7ff9b05..c4d4263 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -23,7 +23,7 @@ initial manual merge, and later by noticing the same automerge
 results and applying the previously recorded hand resolution.
 
 [NOTE]
-You need to create `$GIT_DIR/rr-cache` directory to enable this
+You need to set the config variable rerere.enabled to enable this
 command.
 
 
@@ -171,7 +171,7 @@ records it if it is a new conflict, or reuses the earlier hand
 resolve when it is not.  `git-commit` also invokes `git-rerere`
 when recording a merge result.  What this means is that you do
 not have to do anything special yourself (Note: you still have
-to create `$GIT_DIR/rr-cache` directory to enable this command).
+to set the config variable rerere.enabled to enable this command).
 
 In our example, when you did the test merge, the manual
 resolution is recorded, and it will be reused when you do the
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 29fb075..af4d35a 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -12,6 +12,9 @@ static const char git_rerere_usage[] =
 static int cutoff_noresolve = 15;
 static int cutoff_resolve = 60;
 
+/* if rerere_enabled == -1, fall back to detection of .git/rr-cache */
+static int rerere_enabled = -1;
+
 static char *merge_rr_path;
 
 static const char *rr_path(const char *name, const char *file)
@@ -387,21 +390,40 @@ static int git_rerere_config(const char *var, const char *value)
 		cutoff_resolve = git_config_int(var, value);
 	else if (!strcmp(var, "gc.rerereunresolved"))
 		cutoff_noresolve = git_config_int(var, value);
+	else if (!strcmp(var, "rerere.enabled"))
+		rerere_enabled = git_config_bool(var, value);
 	else
 		return git_default_config(var, value);
 	return 0;
 }
 
-int cmd_rerere(int argc, const char **argv, const char *prefix)
+int is_rerere_enabled(void)
 {
-	struct path_list merge_rr = { NULL, 0, 0, 1 };
-	int i, fd = -1;
 	struct stat st;
+	const char *rr_cache = git_path("rr-cache");
+	int rr_cache_exists;
 
-	if (stat(git_path("rr-cache"), &st) || !S_ISDIR(st.st_mode))
+	if (!rerere_enabled)
 		return 0;
 
+	rr_cache_exists = !stat(rr_cache, &st) && S_ISDIR(st.st_mode);
+	if (rerere_enabled < 0)
+		return rr_cache_exists;
+
+	if (!rr_cache_exists && (mkdir(rr_cache, 0777) ||
+			adjust_shared_perm(rr_cache)))
+		die("Could not create directory %s", rr_cache);
+	return 1;
+}
+
+int cmd_rerere(int argc, const char **argv, const char *prefix)
+{
+	struct path_list merge_rr = { NULL, 0, 0, 1 };
+	int i, fd = -1;
+
 	git_config(git_rerere_config);
+	if (!is_rerere_enabled())
+		return 0;
 
 	merge_rr_path = xstrdup(git_path("rr-cache/MERGE_RR"));
 	fd = hold_lock_file_for_update(&write_lock, merge_rr_path, 1);
@@ -411,6 +433,7 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 		return do_plain_rerere(&merge_rr, fd);
 	else if (!strcmp(argv[1], "clear")) {
 		for (i = 0; i < merge_rr.nr; i++) {
+			struct stat st;
 			const char *name = (const char *)merge_rr.items[i].util;
 			if (!stat(git_path("rr-cache/%s", name), &st) &&
 					S_ISDIR(st.st_mode) &&
diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index f600179..457f95f 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -681,8 +681,7 @@ and returns the process output as a string."
                             (condition-case nil (delete-file ".git/MERGE_MSG") (error nil))
                             (with-current-buffer buffer (erase-buffer))
                             (git-set-files-state files 'uptodate)
-                            (when (file-directory-p ".git/rr-cache")
-                              (git-run-command nil nil "rerere"))
+                            (git-run-command nil nil "rerere")
                             (git-refresh-files)
                             (git-refresh-ewoc-hf git-status)
                             (message "Committed %s." commit)
diff --git a/git-am.sh b/git-am.sh
index d57a3e2..e5e6f2c 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -95,10 +95,7 @@ It does not apply to blobs recorded in its index."
     eval GITHEAD_$his_tree='"$SUBJECT"'
     export GITHEAD_$his_tree
     git-merge-recursive $orig_tree -- HEAD $his_tree || {
-	    if test -d "$GIT_DIR/rr-cache"
-	    then
-		git rerere
-	    fi
+	    git rerere
 	    echo Failed to merge in the changes.
 	    exit 1
     }
@@ -252,10 +249,7 @@ last=`cat "$dotest/last"`
 this=`cat "$dotest/next"`
 if test "$skip" = t
 then
-	if test -d "$GIT_DIR/rr-cache"
-	then
-		git rerere clear
-	fi
+	git rerere clear
 	this=`expr "$this" + 1`
 	resume=
 fi
@@ -420,10 +414,7 @@ do
 			stop_here_user_resolve $this
 		fi
 		apply_status=0
-		if test -d "$GIT_DIR/rr-cache"
-		then
-			git rerere
-		fi
+		git rerere
 		;;
 	esac
 
diff --git a/git-commit.sh b/git-commit.sh
index f866f95..9106a74 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -610,10 +610,7 @@ rm -f "$GIT_DIR/COMMIT_MSG" "$GIT_DIR/COMMIT_EDITMSG" "$GIT_DIR/SQUASH_MSG"
 
 cd_to_toplevel
 
-if test -d "$GIT_DIR/rr-cache"
-then
-	git rerere
-fi
+git rerere
 
 if test "$ret" = 0
 then
diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
index f9791f6..578bef8 100644
--- a/git-gui/lib/commit.tcl
+++ b/git-gui/lib/commit.tcl
@@ -331,9 +331,7 @@ A rescan will be automatically started now.
 
 	# -- Let rerere do its thing.
 	#
-	if {[file isdirectory [gitdir rr-cache]]} {
-		catch {git rerere}
-	}
+	catch {git rerere}
 
 	# -- Run the post-commit hook.
 	#
diff --git a/git-merge.sh b/git-merge.sh
index 4852530..5ccf282 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -496,9 +496,6 @@ Conflicts:
 		sed -e 's/^[^	]*	/	/' |
 		uniq
 	} >>"$GIT_DIR/MERGE_MSG"
-	if test -d "$GIT_DIR/rr-cache"
-	then
-		git rerere
-	fi
+	git rerere
 	die "Automatic merge failed; fix conflicts and then commit the result."
 fi
diff --git a/git-rebase.sh b/git-rebase.sh
index 7a02f29..cbafa14 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -101,7 +101,7 @@ call_merge () {
 		return
 		;;
 	1)
-		test -d "$GIT_DIR/rr-cache" && git rerere
+		git rerere
 		die "$RESOLVEMSG"
 		;;
 	2)
@@ -160,10 +160,7 @@ do
 	--skip)
 		if test -d "$dotest"
 		then
-			if test -d "$GIT_DIR/rr-cache"
-			then
-				git rerere clear
-			fi
+			git rerere clear
 			prev_head="`cat $dotest/prev_head`"
 			end="`cat $dotest/end`"
 			msgnum="`cat $dotest/msgnum`"
@@ -181,10 +178,7 @@ do
 		exit
 		;;
 	--abort)
-		if test -d "$GIT_DIR/rr-cache"
-		then
-			git rerere clear
-		fi
+		git rerere clear
 		if test -d "$dotest"
 		then
 			rm -r "$dotest"
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 71d364a..6f55ba0 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -39,15 +39,32 @@ sed -e 's/To die, t/To die! T/' > a1
 echo "* END *" >>a1
 git commit -q -a -m second
 
-# activate rerere
-mkdir .git/rr-cache
+test_expect_success 'nothing recorded without rerere' '
+	(rm -rf .git/rr-cache; git config rerere.enabled false) &&
+	! git merge first &&
+	! test -d .git/rr-cache
+'
 
-test_expect_failure 'conflicting merge' 'git pull . first'
+# activate rerere, old style
+test_expect_success 'conflicting merge' '
+	git reset --hard &&
+	mkdir .git/rr-cache &&
+	git config --unset rerere.enabled &&
+	! git merge first
+'
 
 sha1=$(sed -e 's/	.*//' .git/rr-cache/MERGE_RR)
 rr=.git/rr-cache/$sha1
 test_expect_success 'recorded preimage' "grep ======= $rr/preimage"
 
+test_expect_success 'rerere.enabled works, too' '
+	rm -rf .git/rr-cache &&
+	git config rerere.enabled true &&
+	git reset --hard &&
+	! git merge first &&
+	grep ======= $rr/preimage
+'
+
 test_expect_success 'no postimage or thisimage yet' \
 	"test ! -f $rr/postimage -a ! -f $rr/thisimage"
 
-- 
1.5.3.rc0.2689.g99ca2-dirty
