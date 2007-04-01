From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] _GIT_INDEX_OUTPUT: allow plumbing to output to an alternative index file.
Date: Sat, 31 Mar 2007 23:29:34 -0700
Message-ID: <7vtzw038vl.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vwt11itbz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0703280759230.6730@woody.linux-foundation.org>
	<7v4po04nit.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 01 08:30:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXtZf-0008Sv-P0
	for gcvg-git@gmane.org; Sun, 01 Apr 2007 08:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778AbXDAG3h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Apr 2007 02:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932798AbXDAG3h
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Apr 2007 02:29:37 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:43097 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932778AbXDAG3f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2007 02:29:35 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070401062935.CWCK1606.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 1 Apr 2007 02:29:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id hiVa1W0061kojtg0000000; Sun, 01 Apr 2007 02:29:35 -0400
In-Reply-To: <7v4po04nit.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 31 Mar 2007 23:27:54 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43581>

When defined, this allows plumbing commands that update the
index (add, apply, checkout-index, merge-recursive, mv,
read-tree, rm, update-index, and write-tree) to write their
resulting index to an alternative index file while holding a
lock to the original index file.  With this, git-commit that
jumps the index does not have to perform an extra copy of the
index file, and more importantly, it can do the update while
holding the lock on the index.

However, I think the interface to let an environment variable
specify the output is a mistake, as shown in the documentation.
If a curious user has the environment variable set to something
other than the file GIT_INDEX_FILE points at, almost everything
will break.  This should instead be a command line parameter to
tell these plumbing commands to write the result in the named
file, to prevent stupid mistakes.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git.txt    |    9 +++++++++
 builtin-add.c            |    4 ++--
 builtin-apply.c          |    6 +++---
 builtin-checkout-index.c |    7 ++-----
 builtin-mv.c             |    4 ++--
 builtin-read-tree.c      |    4 ++--
 builtin-rm.c             |    4 ++--
 builtin-update-index.c   |    4 ++--
 builtin-write-tree.c     |    2 +-
 cache.h                  |    5 +++++
 git-commit.sh            |    4 ++--
 lockfile.c               |   17 +++++++++++++++++
 merge-recursive.c        |    4 ++--
 13 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index dceacfa..bc025d6 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -311,6 +311,15 @@ git so take care if using Cogito etc.
 	index file. If not specified, the default of `$GIT_DIR/index`
 	is used.
 
+'_GIT_INDEX_OUTPUT'::
+	When this environment is defined, plumbing level
+	commands that update the index writes the resulting
+	index to this file, instead of the usual
+	`GIT_INDEX_FILE` (or its default `$GIT_DIR/index`).
+	This is solely meant to be used by Porcelain to drive
+	low-level plumbing.  Defining this in user's environment
+	is always an error.  Do not use it.
+
 'GIT_OBJECT_DIRECTORY'::
 	If the object storage directory is specified via this
 	environment variable then the sha1 directories are created
diff --git a/builtin-add.c b/builtin-add.c
index 9fcf514..54422d8 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -133,7 +133,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	git_config(git_add_config);
 
-	newfd = hold_lock_file_for_update(&lock_file, get_index_file(), 1);
+	newfd = hold_locked_index(&lock_file, 1);
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -209,7 +209,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (active_cache_changed) {
 		if (write_cache(newfd, active_cache, active_nr) ||
-		    close(newfd) || commit_lock_file(&lock_file))
+		    close(newfd) || commit_locked_index(&lock_file))
 			die("Unable to write new index file");
 	}
 
diff --git a/builtin-apply.c b/builtin-apply.c
index 27a182b..12011c1 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2664,8 +2664,8 @@ static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 
 	write_index = check_index && apply;
 	if (write_index && newfd < 0)
-		newfd = hold_lock_file_for_update(&lock_file,
-						  get_index_file(), 1);
+		newfd = hold_locked_index(&lock_file, 1);
+
 	if (check_index) {
 		if (read_cache() < 0)
 			die("unable to read index file");
@@ -2872,7 +2872,7 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 
 	if (write_index) {
 		if (write_cache(newfd, active_cache, active_nr) ||
-		    close(newfd) || commit_lock_file(&lock_file))
+		    close(newfd) || commit_locked_index(&lock_file))
 			die("Unable to write new index file");
 	}
 
diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index afe4b0e..8460f97 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -202,10 +202,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		if (!strcmp(arg, "-u") || !strcmp(arg, "--index")) {
 			state.refresh_cache = 1;
 			if (newfd < 0)
-				newfd = hold_lock_file_for_update
-					(&lock_file, get_index_file(), 1);
-			if (newfd < 0)
-				die("cannot open index.lock file.");
+				newfd = hold_locked_index(&lock_file, 1);
 			continue;
 		}
 		if (!strcmp(arg, "-z")) {
@@ -302,7 +299,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 
 	if (0 <= newfd &&
 	    (write_cache(newfd, active_cache, active_nr) ||
-	     close(newfd) || commit_lock_file(&lock_file)))
+	     close(newfd) || commit_locked_index(&lock_file)))
 		die("Unable to write new index file");
 	return 0;
 }
diff --git a/builtin-mv.c b/builtin-mv.c
index 737af35..820aca1 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -77,7 +77,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config);
 
-	newfd = hold_lock_file_for_update(&lock_file, get_index_file(), 1);
+	newfd = hold_locked_index(&lock_file, 1);
 	if (read_cache() < 0)
 		die("index file corrupt");
 
@@ -285,7 +285,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		if (active_cache_changed) {
 			if (write_cache(newfd, active_cache, active_nr) ||
 			    close(newfd) ||
-			    commit_lock_file(&lock_file))
+			    commit_locked_index(&lock_file))
 				die("Unable to write new index file");
 		}
 	}
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 793eae0..87048f8 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -100,7 +100,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	setup_git_directory();
 	git_config(git_default_config);
 
-	newfd = hold_lock_file_for_update(&lock_file, get_index_file(), 1);
+	newfd = hold_locked_index(&lock_file, 1);
 
 	git_config(git_default_config);
 
@@ -267,7 +267,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	}
 
 	if (write_cache(newfd, active_cache, active_nr) ||
-	    close(newfd) || commit_lock_file(&lock_file))
+	    close(newfd) || commit_locked_index(&lock_file))
 		die("unable to write new index file");
 	return 0;
 }
diff --git a/builtin-rm.c b/builtin-rm.c
index bf42003..8a0738f 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -110,7 +110,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config);
 
-	newfd = hold_lock_file_for_update(&lock_file, get_index_file(), 1);
+	newfd = hold_locked_index(&lock_file, 1);
 
 	if (read_cache() < 0)
 		die("index file corrupt");
@@ -220,7 +220,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	if (active_cache_changed) {
 		if (write_cache(newfd, active_cache, active_nr) ||
-		    close(newfd) || commit_lock_file(&lock_file))
+		    close(newfd) || commit_locked_index(&lock_file))
 			die("Unable to write new index file");
 	}
 
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 71cef63..84993d7 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -495,7 +495,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	/* We can't free this memory, it becomes part of a linked list parsed atexit() */
 	lock_file = xcalloc(1, sizeof(struct lock_file));
 
-	newfd = hold_lock_file_for_update(lock_file, get_index_file(), 0);
+	newfd = hold_locked_index(lock_file, 0);
 	if (newfd < 0)
 		lock_error = errno;
 
@@ -661,7 +661,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			    get_index_file(), strerror(lock_error));
 		}
 		if (write_cache(newfd, active_cache, active_nr) ||
-		    close(newfd) || commit_lock_file(lock_file))
+		    close(newfd) || commit_locked_index(lock_file))
 			die("Unable to write new index file");
 	}
 
diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index 90fc1cf..c88bbd1 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -18,7 +18,7 @@ int write_tree(unsigned char *sha1, int missing_ok, const char *prefix)
 	/* We can't free this memory, it becomes part of a linked list parsed atexit() */
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 
-	newfd = hold_lock_file_for_update(lock_file, get_index_file(), 0);
+	newfd = hold_locked_index(lock_file, 1);
 
 	entries = read_cache();
 	if (entries < 0)
diff --git a/cache.h b/cache.h
index 384b260..59a05c1 100644
--- a/cache.h
+++ b/cache.h
@@ -147,6 +147,7 @@ enum object_type {
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
+#define INDEX_OUTPUT_ENVIRONMENT "_GIT_INDEX_OUTPUT"
 #define GRAFT_ENVIRONMENT "GIT_GRAFT_FILE"
 #define TEMPLATE_DIR_ENVIRONMENT "GIT_TEMPLATE_DIR"
 #define CONFIG_ENVIRONMENT "GIT_CONFIG"
@@ -212,6 +213,10 @@ struct lock_file {
 };
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int commit_lock_file(struct lock_file *);
+
+extern int hold_locked_index(struct lock_file *, int);
+extern int commit_locked_index(struct lock_file *);
+
 extern void rollback_lock_file(struct lock_file *);
 extern int delete_ref(const char *, unsigned char *sha1);
 
diff --git a/git-commit.sh b/git-commit.sh
index 292cf96..20c0dc8 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -370,8 +370,8 @@ t,)
 		# the same way.
 		if test -z "$initial_commit"
 		then
-			cp "$THIS_INDEX" "$TMP_INDEX"
-			GIT_INDEX_FILE="$TMP_INDEX" git-read-tree -i -m HEAD
+			_GIT_INDEX_OUTPUT="$TMP_INDEX" \
+			GIT_INDEX_FILE="$THIS_INDEX" git-read-tree -i -m HEAD
 		else
 			rm -f "$TMP_INDEX"
 		fi || exit
diff --git a/lockfile.c b/lockfile.c
index 4824f4d..2023ebb 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -65,6 +65,23 @@ int commit_lock_file(struct lock_file *lk)
 	return i;
 }
 
+int hold_locked_index(struct lock_file *lk, int die_on_error)
+{
+	return hold_lock_file_for_update(lk, get_index_file(), die_on_error);
+}
+
+int commit_locked_index(struct lock_file *lk)
+{
+	char *output = getenv(INDEX_OUTPUT_ENVIRONMENT);
+	if (output && *output) {
+		int result = rename(lk->filename, output);
+		lk->filename[0] = 0;
+		return result;
+	}
+	else
+		return commit_lock_file(lk);
+}
+
 void rollback_lock_file(struct lock_file *lk)
 {
 	if (lk->filename[0])
diff --git a/merge-recursive.c b/merge-recursive.c
index e1aebd7..f46aaae 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1378,7 +1378,7 @@ int main(int argc, char *argv[])
 	if (show(3))
 		printf("Merging %s with %s\n", branch1, branch2);
 
-	index_fd = hold_lock_file_for_update(lock, get_index_file(), 1);
+	index_fd = hold_locked_index(lock, 1);
 
 	for (i = 0; i < bases_count; i++) {
 		struct commit *ancestor = get_ref(bases[i]);
@@ -1388,7 +1388,7 @@ int main(int argc, char *argv[])
 
 	if (active_cache_changed &&
 	    (write_cache(index_fd, active_cache, active_nr) ||
-	     close(index_fd) || commit_lock_file(lock)))
+	     close(index_fd) || commit_locked_index(lock)))
 			die ("unable to write %s", get_index_file());
 
 	return clean ? 0: 1;
-- 
1.5.1.rc3.26.g4f01
