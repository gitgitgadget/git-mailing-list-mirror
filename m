From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] merge-recursive: do not report the resulting tree object name
Date: Fri, 12 Jan 2007 23:03:50 -0800
Message-ID: <7vk5zrmmqx.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com>
	<7v8xgileza.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
	<20070107163112.GA9336@steel.home>
	<7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
	<20070112184839.9431ddff.vsu@altlinux.ru>
	<7vr6u0t87q.fsf@assigned-by-dhcp.cox.net>
	<7v8xg8t3aj.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701130034000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vbql3pxz8.fsf@assigned-by-dhcp.cox.net>
	<20070113051447.GA22063@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 08:04:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5cvs-0002mQ-QV
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 08:04:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbXAMHDx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 02:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbXAMHDx
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 02:03:53 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:46969 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965052AbXAMHDw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 02:03:52 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070113070351.UGKB29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Sat, 13 Jan 2007 02:03:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AX2z1W0021kojtg0000000; Sat, 13 Jan 2007 02:02:59 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070113051447.GA22063@spearce.org> (Shawn O. Pearce's message
	of "Sat, 13 Jan 2007 00:14:47 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36741>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> Among these, I think lines 2..3 are somewhat confusing but I am
>> used to seeing them and do not mind them too much.
>
> In my experience these lines scare new users.  And then they start
> to ignore other "fatal:" messages from Git because they can safely
> ignore this particular one.

I tend to agree; we could do something like the attached.

>> Lines 10..16 are useful, but I think we probably should show
>> them only for outermost merges.
>
> Actually I think that only 13 is useful.  10-12,14-17 are
> pretty useless messages in my mind.

I am not sure.  It is nice to view which paths have
content-level merges as it is more significant than path-level
merges.

I think the output from merge-recursive can be categorized into
5 verbosity levels:

 1. "CONFLICT", "Rename", "Adding here instead due to D/F conflict" (outermost)

 2. "Auto-merged successfully" (outermost)

 3. The first "Merging X with Y".

 4. outermost "Merging:\ntitle1\ntitle2".

 5. outermost "found N common ancestors\nancestor1\nancestor2\n..."
    and anything from inner merge.

I would prefer the default verbosity level to be 2 (that is,
show both 1 and 2); your "quieter" option would show only level
1, and somebody who is debugging reursive would ask for all
levels.

-- >8 --
[PATCH] Make 'trivial merge' attempt less verbose.

This replaces die() calls in unpack-trees with simple and quiet
exit(1) when we are trying trivial merges only and die() is
about the case that cannot trivially be merged (i.e. not a
serious corruption error but expected).  Also it makes the
nontrivial merges exit early.

And then this updates git-merge so that we do not have to say
"trying..." followed by "wonderful" or "nope".

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-merge.sh   |   36 ++++++++++++++++++++++--------------
 unpack-trees.c |   29 ++++++++++++++++++-----------
 2 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 3eef048..6240a73 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -302,21 +302,29 @@ f,*)
 	# one common.  See if it is really trivial.
 	git var GIT_COMMITTER_IDENT >/dev/null || exit
 
-	echo "Trying really trivial in-index merge..."
 	git-update-index --refresh 2>/dev/null
-	if git-read-tree --trivial -m -u -v $common $head "$1" &&
-	   result_tree=$(git-write-tree)
-	then
-	    echo "Wonderful."
-	    result_commit=$(
-	        echo "$merge_msg" |
-	        git-commit-tree $result_tree -p HEAD -p "$1"
-	    ) || exit
-	    finish "$result_commit" "In-index merge"
-	    dropsave
-	    exit 0
-	fi
-	echo "Nope."
+	git-read-tree --trivial -m -u -v $common $head "$1"
+	case "$?" in
+	1)	: expected failure from non-trivial merge
+		;;
+	0)
+		if result_tree=$(git-write-tree)
+		then
+			echo "Trivially merged in index."
+			result_commit=$(
+				echo "$merge_msg" |
+				git-commit-tree $result_tree -p HEAD -p "$1"
+			) || exit
+			finish "$result_commit" "In-index merge"
+			dropsave
+			exit 0
+		fi
+		;;
+	*)
+		: This could be serious failure.
+		echo >&2 "Tried trivial merge but did not work; don't worry..."
+		;;
+	esac
 	;;
 *)
 	# An octopus.  If we can reach all the remote we are up to date.
diff --git a/unpack-trees.c b/unpack-trees.c
index 2e2232c..0fca83b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -409,17 +409,17 @@ int unpack_trees(struct object_list *trees, struct unpack_trees_options *o)
 			return -1;
 	}
 
-	if (o->trivial_merges_only && o->nontrivial_merge)
-		die("Merge requires file-level merging");
-
 	check_updates(active_cache, active_nr, o);
 	return 0;
 }
 
 /* Here come the merge functions */
 
-static void reject_merge(struct cache_entry *ce)
+static void reject_merge(struct cache_entry *ce,
+			 struct unpack_trees_options *o)
 {
+	if (o->trivial_merges_only)
+		exit(1);
 	die("Entry '%s' would be overwritten by merge. Cannot merge.",
 	    ce->name);
 }
@@ -459,6 +459,8 @@ static void verify_uptodate(struct cache_entry *ce,
 	}
 	if (errno == ENOENT)
 		return;
+	if (o->trivial_merges_only)
+		exit(1);
 	die("Entry '%s' not uptodate. Cannot merge.", ce->name);
 }
 
@@ -473,15 +475,18 @@ static void invalidate_ce_path(struct cache_entry *ce)
  * is not tracked, unless it is ignored.
  */
 static void verify_absent(const char *path, const char *action,
-		struct unpack_trees_options *o)
+			  struct unpack_trees_options *o)
 {
 	struct stat st;
 
 	if (o->index_only || o->reset || !o->update)
 		return;
-	if (!lstat(path, &st) && !(o->dir && excluded(o->dir, path)))
+	if (!lstat(path, &st) && !(o->dir && excluded(o->dir, path))) {
+		if (o->trivial_merges_only)
+			exit(1);
 		die("Untracked working tree file '%s' "
 		    "would be %s by merge.", path, action);
+	}
 }
 
 static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
@@ -617,7 +622,7 @@ int threeway_merge(struct cache_entry **stages,
 	/* #14, #14ALT, #2ALT */
 	if (remote && !df_conflict_head && head_match && !remote_match) {
 		if (index && !same(index, remote) && !same(index, head))
-			reject_merge(index);
+			reject_merge(index, o);
 		return merged_entry(remote, index, o);
 	}
 	/*
@@ -625,7 +630,7 @@ int threeway_merge(struct cache_entry **stages,
 	 * make sure that it matches head.
 	 */
 	if (index && !same(index, head)) {
-		reject_merge(index);
+		reject_merge(index, o);
 	}
 
 	if (head) {
@@ -677,6 +682,8 @@ int threeway_merge(struct cache_entry **stages,
 	}
 
 	o->nontrivial_merge = 1;
+	if (o->trivial_merges_only)
+		exit(1);
 
 	/* #2, #3, #4, #6, #7, #9, #11. */
 	count = 0;
@@ -743,11 +750,11 @@ int twoway_merge(struct cache_entry **src,
 		else {
 			/* all other failures */
 			if (oldtree)
-				reject_merge(oldtree);
+				reject_merge(oldtree, o);
 			if (current)
-				reject_merge(current);
+				reject_merge(current, o);
 			if (newtree)
-				reject_merge(newtree);
+				reject_merge(newtree, o);
 			return -1;
 		}
 	}
-- 
1.5.0.rc1.g120b
