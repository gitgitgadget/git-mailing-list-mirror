From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v3] Be more user-friendly when refusing to do something because of conflict.
Date: Wed,  6 Jan 2010 21:36:25 +0100
Message-ID: <1262810185-7046-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1262809074-27137-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 06 21:36:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSccZ-0001bL-8I
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 21:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739Ab0AFUgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 15:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571Ab0AFUgg
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 15:36:36 -0500
Received: from mx1.imag.fr ([129.88.30.5]:56203 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932502Ab0AFUgf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 15:36:35 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o06KaQQ7016815
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 6 Jan 2010 21:36:26 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NSccF-0001Ke-1m; Wed, 06 Jan 2010 21:36:27 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NSccF-0001qK-0K; Wed, 06 Jan 2010 21:36:27 +0100
X-Mailer: git-send-email 1.6.6.81.g2955.dirty
In-Reply-To: <1262809074-27137-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 06 Jan 2010 21:36:26 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o06KaQQ7016815
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1263414987.134@+oBe8WBCszDMuAq25n9rbQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136297>

Various commands refuse to run in the presence of conflicts (commit,
merge, pull, cherry-pick/revert). They all used to provide rough, and
inconsistant error messages.

A new variable advice.resolveconflict is introduced, and allows more
verbose messages, pointing the user to the appropriate solution.

For commit, the error message used to look like this:

$ git commit
foo.txt: needs merge
foo.txt: unmerged (c34a92682e0394bc0d6f4d4a67a8e2d32395c169)
foo.txt: unmerged (3afcd75de8de0bb5076942fcb17446be50451030)
foo.txt: unmerged (c9785d77b76dfe4fb038bf927ee518f6ae45ede4)
error: Error building trees

The "need merge" line is given by refresh_cache. We add the IN_PORCELAIN
option to make the output more consistant with the other porcelain
commands, and catch the error in return, to stop with a clean error
message. The next lines were displayed by a call to cache_tree_update(),
which is not reached anymore if we noticed the conflict.

Pull is slightly modified to abort immediately if $GIT_DIR/MERGE_HEAD
exists instead of waiting for merge to complain.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Sorry, v2 missed a #include "git-compat-utils.h", it's not even compilable.

 Documentation/config.txt |    4 ++++
 advice.c                 |   12 ++++++++++++
 advice.h                 |    5 +++++
 builtin-commit.c         |   15 +++++++++++++--
 builtin-merge.c          |   15 ++++++++++-----
 builtin-revert.c         |   15 ++++++++++++++-
 git-pull.sh              |   25 +++++++++++++++++++++++--
 7 files changed, 81 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 23a965e..5078d26 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -130,6 +130,10 @@ advice.*::
 		Advice shown when linkgit:git-merge[1] refuses to
 		merge to avoid overwritting local changes.
 		Default: true.
+	resolveConflict::
+		Advices shown by various commands when conflicts
+		prevent the operation from being performed. 
+		Default: true.
 --
 
 core.fileMode::
diff --git a/advice.c b/advice.c
index cb666ac..ec2bd82 100644
--- a/advice.c
+++ b/advice.c
@@ -3,6 +3,7 @@
 int advice_push_nonfastforward = 1;
 int advice_status_hints = 1;
 int advice_commit_before_merge = 1;
+int advice_resolve_conflict = 1;
 
 static struct {
 	const char *name;
@@ -11,6 +12,7 @@ static struct {
 	{ "pushnonfastforward", &advice_push_nonfastforward },
 	{ "statushints", &advice_status_hints },
 	{ "commitbeforemerge", &advice_commit_before_merge },
+	{ "resolveconflict", &advice_resolve_conflict },
 };
 
 int git_default_advice_config(const char *var, const char *value)
@@ -27,3 +29,13 @@ int git_default_advice_config(const char *var, const char *value)
 
 	return 0;
 }
+
+void NORETURN die_resolve_conflict(const char *me)
+{
+	if (advice_resolve_conflict)
+		die("'%s' is not possible because you have unmerged files.\n"
+		    "Please, fix them up in the work tree, and then use 'git add/rm <file>'\n"
+		    "as appropriate to mark resolution, or use 'git commit -a'.", me);
+	else
+		die("'%s' is not possible because you have unmerged files.", me);
+}
diff --git a/advice.h b/advice.h
index 3de5000..acd5fdd 100644
--- a/advice.h
+++ b/advice.h
@@ -1,10 +1,15 @@
 #ifndef ADVICE_H
 #define ADVICE_H
 
+#include "git-compat-util.h"
+
 extern int advice_push_nonfastforward;
 extern int advice_status_hints;
 extern int advice_commit_before_merge;
+extern int advice_resolve_conflict;
 
 int git_default_advice_config(const char *var, const char *value);
 
+extern void NORETURN die_resolve_conflict(const char *me);
+
 #endif /* ADVICE_H */
diff --git a/builtin-commit.c b/builtin-commit.c
index 3dfcd77..a4977ac 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -235,6 +235,17 @@ static void create_base_index(void)
 		exit(128); /* We've already reported the error, finish dying */
 }
 
+static void refresh_cache_or_die(int refresh_flags)
+{
+	/*
+	 * refresh_flags contains REFRESH_QUIET, so the only errors
+	 * are for unmerged entries.
+	*/
+	if(refresh_cache(refresh_flags | REFRESH_IN_PORCELAIN)) {
+		die_resolve_conflict("commit");
+	}
+}
+
 static char *prepare_index(int argc, const char **argv, const char *prefix, int is_status)
 {
 	int fd;
@@ -274,7 +285,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 	if (all || (also && pathspec && *pathspec)) {
 		int fd = hold_locked_index(&index_lock, 1);
 		add_files_to_cache(also ? prefix : NULL, pathspec, 0);
-		refresh_cache(refresh_flags);
+		refresh_cache_or_die(refresh_flags);
 		if (write_cache(fd, active_cache, active_nr) ||
 		    close_lock_file(&index_lock))
 			die("unable to write new_index file");
@@ -293,7 +304,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 	 */
 	if (!pathspec || !*pathspec) {
 		fd = hold_locked_index(&index_lock, 1);
-		refresh_cache(refresh_flags);
+		refresh_cache_or_die(refresh_flags);
 		if (write_cache(fd, active_cache, active_nr) ||
 		    commit_locked_index(&index_lock))
 			die("unable to write new_index file");
diff --git a/builtin-merge.c b/builtin-merge.c
index f1c84d7..abe6c03 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -847,11 +847,16 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	const char *best_strategy = NULL, *wt_strategy = NULL;
 	struct commit_list **remotes = &remoteheads;
 
-	if (file_exists(git_path("MERGE_HEAD")))
-		die("You have not concluded your merge. (MERGE_HEAD exists)");
-	if (read_cache_unmerged())
-		die("You are in the middle of a conflicted merge."
-				" (index unmerged)");
+	if (read_cache_unmerged()) {
+		die_resolve_conflict("merge");
+	}
+	if (file_exists(git_path("MERGE_HEAD"))) {
+		if (advice_resolve_conflict)
+			die("You have not concluded your merge (MERGE_HEAD exists).\n"
+			    "Please, commit your changes before you can merge.");
+		else
+			die("You have not concluded your merge (MERGE_HEAD exists).");
+	}
 
 	/*
 	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
diff --git a/builtin-revert.c b/builtin-revert.c
index 151aa6a..d14dde3 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -233,6 +233,19 @@ static struct tree *empty_tree(void)
 	return tree;
 }
 
+static NORETURN void die_dirty_index(const char *me)
+{
+	if (read_cache_unmerged()) {
+		die_resolve_conflict(me);
+	} else {
+		if (advice_commit_before_merge)
+			die("Your local changes would be overwritten by %s.\n"
+			    "Please, commit your changes or stash them to proceed.", me);
+		else
+			die("Your local changes would be overwritten by %s.\n", me);
+	}
+}
+
 static int revert_or_cherry_pick(int argc, const char **argv)
 {
 	unsigned char head[20];
@@ -269,7 +282,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		if (get_sha1("HEAD", head))
 			die ("You do not have a valid HEAD");
 		if (index_differs_from("HEAD", 0))
-			die ("Dirty index: cannot %s", me);
+			die_dirty_index(me);
 	}
 	discard_cache();
 
diff --git a/git-pull.sh b/git-pull.sh
index 9e69ada..54ce0af 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -13,8 +13,29 @@ set_reflog_action "pull $*"
 require_work_tree
 cd_to_toplevel
 
-test -z "$(git ls-files -u)" ||
-	die "You are in the middle of a conflicted merge."
+
+die_conflict () {
+    git diff-index --cached --name-status -r --ignore-submodules HEAD --
+    if [ $(git config --bool --get advice.resolveConflict || echo true) = "true" ]; then
+	die "Pull is not possible because you have unmerged files.
+Please, fix them up in the work tree, and then use 'git add/rm <file>'
+as appropriate to mark resolution, or use 'git commit -a'."
+    else
+	die "Pull is not possible because you have unmerged files."
+    fi
+}
+
+die_merge () {
+    if [ $(git config --bool --get advice.resolveConflict || echo true) = "true" ]; then
+	die "You have not concluded your merge (MERGE_HEAD exists).
+Please, commit your changes before you can merge."
+    else
+	die "You have not concluded your merge (MERGE_HEAD exists)."
+    fi
+}
+
+test -z "$(git ls-files -u)" || die_conflict
+test -f "$GIT_DIR/MERGE_HEAD" && die_merge
 
 strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
 log_arg= verbosity=
-- 
1.6.6.81.g2955.dirty
