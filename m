From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/4] git-read-tree --set-base=<commit>
Date: Sun, 08 Apr 2007 23:13:34 -0700
Message-ID: <7vr6qu3wj5.fsf@assigned-by-dhcp.cox.net>
References: <7vwt0uypz7.fsf@assigned-by-dhcp.cox.net>
	<7vhcrvti9i.fsf@assigned-by-dhcp.cox.net>
	<7vps6e5b93.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 09 08:14:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Han96-0000cT-93
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 08:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbXDIGOQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 02:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753008AbXDIGOP
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 02:14:15 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:41025 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbXDIGOK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 02:14:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070409061334.NLUF25613.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 9 Apr 2007 02:13:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id kuDa1W0071kojtg0000000; Mon, 09 Apr 2007 02:13:35 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44043>

This allows the caller of read-tree to record the base commit
object in the index, so that later operations that build a new
commit based on the contents of the index can verify that the
HEAD is still at the expected place, and notice cases where
somebody else updated the tip of the current branch while we are
looking the other way.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-read-tree.txt |    6 +++++-
 builtin-read-tree.c             |   19 +++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 0ff2890..ef731e2 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -8,7 +8,7 @@ git-read-tree - Reads tree information into the index
 
 SYNOPSIS
 --------
-'git-read-tree' (<tree-ish> | [[-m [--aggressive] | --reset | --prefix=<prefix>] [-u | -i]] [--exclude-per-directory=<gitignore>] <tree-ish1> [<tree-ish2> [<tree-ish3>]])
+'git-read-tree' (<tree-ish> | [[-m [--aggressive] | --reset | --prefix=<prefix>] [-u | -i]] [--exclude-per-directory=<gitignore>] [--set-base=<commit>] <tree-ish1> [<tree-ish2> [<tree-ish3>]])
 
 
 DESCRIPTION
@@ -86,6 +86,10 @@ OPTIONS
 	file (usually '.gitignore') and allows such an untracked
 	but explicitly ignored file to be overwritten.
 
+--set-base=<commit>::
+	This option records the commit object name in the index,
+	later to be retrieved with the `git-update-index --get-base`.
+
 <tree-ish#>::
 	The id of the tree object(s) to be read/merged.
 
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 06c2912..d1c4489 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -93,6 +93,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 {
 	int i, newfd, stage = 0;
 	unsigned char sha1[20];
+	unsigned char newbase[20];
+	int newbase_set = 0;
 	struct unpack_trees_options opts;
 
 	memset(&opts, 0, sizeof(opts));
@@ -158,6 +160,15 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			continue;
 		}
 
+		if (!prefixcmp(arg, "--set-base=")) {
+			if (get_sha1(arg+11, newbase) ||
+			    sha1_object_info(newbase, NULL) != OBJ_COMMIT)
+				die("Specified base is not a valid commit object name '%s'",
+				    arg);
+			newbase_set = 1;
+			continue;
+		}
+
 		if (!strcmp(arg, "--trivial")) {
 			opts.trivial_merges_only = 1;
 			continue;
@@ -261,12 +272,20 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	 * "-m ent" or "--reset ent" form), we can obtain a fully
 	 * valid cache-tree because the index must match exactly
 	 * what came from the tree.
+	 *
+	 * Also when we read from a single commit with --reset, the
+	 * index will be used to build a commit on top of it.
 	 */
 	if (trees && trees->item && !opts.prefix && (!opts.merge || (stage == 2))) {
 		cache_tree_free(&active_cache_tree);
 		prime_cache_tree();
 	}
 
+	if (newbase_set) {
+		active_cache_base_valid = 1;
+		hashcpy(active_cache_base, newbase);
+	}
+
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    close(newfd) || commit_lock_file(&lock_file))
 		die("unable to write new index file");
-- 
1.5.1.730.g0d43be
