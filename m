From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] git-read-tree --index-output=<file>
Date: Sat, 31 Mar 2007 23:29:37 -0700
Message-ID: <7vslbk38vi.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vwt11itbz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0703280759230.6730@woody.linux-foundation.org>
	<7v4po04nit.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 01 08:30:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXtZg-0008Sv-Ge
	for gcvg-git@gmane.org; Sun, 01 Apr 2007 08:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932798AbXDAG3l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Apr 2007 02:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932753AbXDAG3l
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Apr 2007 02:29:41 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:45000 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932798AbXDAG3j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2007 02:29:39 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070401062938.TOTS24385.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sun, 1 Apr 2007 02:29:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id hiVd1W00C1kojtg0000000; Sun, 01 Apr 2007 02:29:38 -0400
In-Reply-To: <7v4po04nit.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 31 Mar 2007 23:27:54 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43580>

This corrects the interface mistake of the previous one, and
give a command line parameter to the only plumbing command that
currently needs it, "read-tree".

We can add the set_alternate_index_output() to other plumbing
commands that update the index if/when needed.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-read-tree.txt |   14 +++++++++++++-
 Documentation/git.txt           |    9 ---------
 builtin-read-tree.c             |    7 ++++++-
 cache.h                         |    2 +-
 git-commit.sh                   |    4 ++--
 lockfile.c                      |   11 ++++++++---
 6 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 0ff2890..69f2223 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -8,7 +8,7 @@ git-read-tree - Reads tree information into the index
 
 SYNOPSIS
 --------
-'git-read-tree' (<tree-ish> | [[-m [--aggressive] | --reset | --prefix=<prefix>] [-u | -i]] [--exclude-per-directory=<gitignore>] <tree-ish1> [<tree-ish2> [<tree-ish3>]])
+'git-read-tree' (<tree-ish> | [[-m [--aggressive] | --reset | --prefix=<prefix>] [-u | -i]] [--exclude-per-directory=<gitignore>] [--index-output=<file>] <tree-ish1> [<tree-ish2> [<tree-ish3>]])
 
 
 DESCRIPTION
@@ -86,6 +86,18 @@ OPTIONS
 	file (usually '.gitignore') and allows such an untracked
 	but explicitly ignored file to be overwritten.
 
+--index-output=<file>::
+	Instead of writing the results out to `$GIT_INDEX_FILE`,
+	place the resulting index to the named file.  While the
+	command is operating, the original index file is locked
+	with the same mechanism as usual.  The file must be
+	allow to be rename(2)ed into from a temporary file that
+	is created next to the usual index file; typically this
+	means it needs to be in the same filesystem as the index
+	file itself, and you need write permission to the
+	directory the index file and index output file is
+	located in.
+
 <tree-ish#>::
 	The id of the tree object(s) to be read/merged.
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index bc025d6..dceacfa 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -311,15 +311,6 @@ git so take care if using Cogito etc.
 	index file. If not specified, the default of `$GIT_DIR/index`
 	is used.
 
-'_GIT_INDEX_OUTPUT'::
-	When this environment is defined, plumbing level
-	commands that update the index writes the resulting
-	index to this file, instead of the usual
-	`GIT_INDEX_FILE` (or its default `$GIT_DIR/index`).
-	This is solely meant to be used by Porcelain to drive
-	low-level plumbing.  Defining this in user's environment
-	is always an error.  Do not use it.
-
 'GIT_OBJECT_DIRECTORY'::
 	If the object storage directory is specified via this
 	environment variable then the sha1 directories are created
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 87048f8..213bd93 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -84,7 +84,7 @@ static void prime_cache_tree(void)
 
 }
 
-static const char read_tree_usage[] = "git-read-tree (<sha> | [[-m [--aggressive] | --reset | --prefix=<prefix>] [-u | -i]] [--exclude-per-directory=<gitignore>] <sha1> [<sha2> [<sha3>]])";
+static const char read_tree_usage[] = "git-read-tree (<sha> | [[-m [--aggressive] | --reset | --prefix=<prefix>] [-u | -i]] [--exclude-per-directory=<gitignore>] [--index-output=<file>] <sha1> [<sha2> [<sha3>]])";
 
 static struct lock_file lock_file;
 
@@ -128,6 +128,11 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			continue;
 		}
 
+		if (!prefixcmp(arg, "--index-output=")) {
+			set_alternate_index_output(arg + 15);
+			continue;
+		}
+
 		/* "--prefix=<subdirectory>/" means keep the current index
 		 *  entries and put the entries from the tree under the
 		 * given subdirectory.
diff --git a/cache.h b/cache.h
index 59a05c1..592331f 100644
--- a/cache.h
+++ b/cache.h
@@ -147,7 +147,6 @@ enum object_type {
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
-#define INDEX_OUTPUT_ENVIRONMENT "_GIT_INDEX_OUTPUT"
 #define GRAFT_ENVIRONMENT "GIT_GRAFT_FILE"
 #define TEMPLATE_DIR_ENVIRONMENT "GIT_TEMPLATE_DIR"
 #define CONFIG_ENVIRONMENT "GIT_CONFIG"
@@ -216,6 +215,7 @@ extern int commit_lock_file(struct lock_file *);
 
 extern int hold_locked_index(struct lock_file *, int);
 extern int commit_locked_index(struct lock_file *);
+extern void set_alternate_index_output(const char *);
 
 extern void rollback_lock_file(struct lock_file *);
 extern int delete_ref(const char *, unsigned char *sha1);
diff --git a/git-commit.sh b/git-commit.sh
index 20c0dc8..9e0959a 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -370,8 +370,8 @@ t,)
 		# the same way.
 		if test -z "$initial_commit"
 		then
-			_GIT_INDEX_OUTPUT="$TMP_INDEX" \
-			GIT_INDEX_FILE="$THIS_INDEX" git-read-tree -i -m HEAD
+			GIT_INDEX_FILE="$THIS_INDEX" \
+			git-read-tree --index-output="$TMP_INDEX" -i -m HEAD
 		else
 			rm -f "$TMP_INDEX"
 		fi || exit
diff --git a/lockfile.c b/lockfile.c
index 2023ebb..bed6b21 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 
 static struct lock_file *lock_file_list;
+static const char *alternate_index_output;
 
 static void remove_lock_file(void)
 {
@@ -70,11 +71,15 @@ int hold_locked_index(struct lock_file *lk, int die_on_error)
 	return hold_lock_file_for_update(lk, get_index_file(), die_on_error);
 }
 
+void set_alternate_index_output(const char *name)
+{
+	alternate_index_output = name;
+}
+
 int commit_locked_index(struct lock_file *lk)
 {
-	char *output = getenv(INDEX_OUTPUT_ENVIRONMENT);
-	if (output && *output) {
-		int result = rename(lk->filename, output);
+	if (alternate_index_output) {
+		int result = rename(lk->filename, alternate_index_output);
 		lk->filename[0] = 0;
 		return result;
 	}
-- 
1.5.1.rc3.26.g4f01
