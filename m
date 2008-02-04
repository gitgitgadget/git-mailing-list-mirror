From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/9] Add flag to make unpack_trees() not print errors.
Date: Mon, 4 Feb 2008 13:35:40 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802041335390.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 19:36:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM6BS-0006Qr-K3
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 19:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbYBDSfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 13:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753945AbYBDSfm
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 13:35:42 -0500
Received: from iabervon.org ([66.92.72.58]:51146 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753859AbYBDSfm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 13:35:42 -0500
Received: (qmail 3537 invoked by uid 1000); 4 Feb 2008 18:35:40 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Feb 2008 18:35:40 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72543>

This will allow builtin-checkout to suppress merge errors if it's
going to try more merging methods.

Additionally, if unpack_trees() returns with an error, but without
printing anything, it will roll back any changes to the index (by
rereading the index, currently). This obviously could be done by the
caller, but chances are that the caller would forget and debugging
this is difficult.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 unpack-trees.c |   43 +++++++++++++++++++++++++++++--------------
 unpack-trees.h |    1 +
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 9e6587f..45f40c2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -356,12 +356,23 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 			posns[i] = create_tree_entry_list(t+i);
 
 		if (unpack_trees_rec(posns, len, o->prefix ? o->prefix : "",
-				     o, &df_conflict_list))
+				     o, &df_conflict_list)) {
+			if (o->gently) {
+				discard_cache();
+				read_cache();
+			}
 			return -1;
+		}
 	}
 
-	if (o->trivial_merges_only && o->nontrivial_merge)
-		return error("Merge requires file-level merging");
+	if (o->trivial_merges_only && o->nontrivial_merge) {
+		if (o->gently) {
+			discard_cache();
+			read_cache();
+		}
+		return o->gently ? -1 :
+			error("Merge requires file-level merging");
+	}
 
 	check_updates(active_cache, active_nr, o);
 	return 0;
@@ -415,7 +426,8 @@ static int verify_uptodate(struct cache_entry *ce,
 	}
 	if (errno == ENOENT)
 		return 0;
-	return error("Entry '%s' not uptodate. Cannot merge.", ce->name);
+	return o->gently ? -1 :
+		error("Entry '%s' not uptodate. Cannot merge.", ce->name);
 }
 
 static void invalidate_ce_path(struct cache_entry *ce)
@@ -501,8 +513,9 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
 		d.exclude_per_dir = o->dir->exclude_per_dir;
 	i = read_directory(&d, ce->name, pathbuf, namelen+1, NULL);
 	if (i)
-		return error("Updating '%s' would lose untracked files in it",
-			     ce->name);
+		return o->gently ? -1 :
+			error("Updating '%s' would lose untracked files in it",
+			      ce->name);
 	free(pathbuf);
 	return cnt;
 }
@@ -574,8 +587,9 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 				return 0;
 		}
 
-		return error("Untracked working tree file '%s' "
-			     "would be %s by merge.", ce->name, action);
+		return o->gently ? -1 :
+			error("Untracked working tree file '%s' "
+			      "would be %s by merge.", ce->name, action);
 	}
 	return 0;
 }
@@ -707,7 +721,7 @@ int threeway_merge(struct cache_entry **stages,
 	/* #14, #14ALT, #2ALT */
 	if (remote && !df_conflict_head && head_match && !remote_match) {
 		if (index && !same(index, remote) && !same(index, head))
-			return reject_merge(index);
+			return o->gently ? -1 : reject_merge(index);
 		return merged_entry(remote, index, o);
 	}
 	/*
@@ -715,7 +729,7 @@ int threeway_merge(struct cache_entry **stages,
 	 * make sure that it matches head.
 	 */
 	if (index && !same(index, head)) {
-		return reject_merge(index);
+		return o->gently ? -1 : reject_merge(index);
 	}
 
 	if (head) {
@@ -866,11 +880,11 @@ int twoway_merge(struct cache_entry **src,
 			/* all other failures */
 			remove_entry(remove);
 			if (oldtree)
-				return reject_merge(oldtree);
+				return o->gently ? -1 : reject_merge(oldtree);
 			if (current)
-				return reject_merge(current);
+				return o->gently ? -1 : reject_merge(current);
 			if (newtree)
-				return reject_merge(newtree);
+				return o->gently ? -1 : reject_merge(newtree);
 			return -1;
 		}
 	}
@@ -897,7 +911,8 @@ int bind_merge(struct cache_entry **src,
 		return error("Cannot do a bind merge of %d trees\n",
 			     o->merge_size);
 	if (a && old)
-		return error("Entry '%s' overlaps.  Cannot bind.", a->name);
+		return o->gently ? -1 :
+			error("Entry '%s' overlaps.  Cannot bind.", a->name);
 	if (!a)
 		return keep_entry(old, o);
 	else
diff --git a/unpack-trees.h b/unpack-trees.h
index 197a004..83d1229 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -16,6 +16,7 @@ struct unpack_trees_options {
 	int trivial_merges_only;
 	int verbose_update;
 	int aggressive;
+	int gently;
 	const char *prefix;
 	int pos;
 	struct dir_struct *dir;
-- 
1.5.4
