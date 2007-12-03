From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/2] Add flag to make unpack_trees() not print errors.
Date: Mon, 3 Dec 2007 00:32:45 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712030028120.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Dec 03 06:33:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz3vi-0008Me-Vz
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 06:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbXLCFcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 00:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbXLCFcr
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 00:32:47 -0500
Received: from iabervon.org ([66.92.72.58]:46461 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751806AbXLCFcq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 00:32:46 -0500
Received: (qmail 20090 invoked by uid 1000); 3 Dec 2007 05:32:45 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Dec 2007 05:32:45 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66865>

This will allow builtin-checkout to suppress merge errors if it's
going to try more merging methods.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 unpack-trees.c |   29 +++++++++++++++++------------
 unpack-trees.h |    1 +
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 0958166..a423197 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -362,7 +362,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	}
 
 	if (o->trivial_merges_only && o->nontrivial_merge)
-		return error("Merge requires file-level merging");
+		return o->gently ? -1 : 
+			error("Merge requires file-level merging");
 
 	check_updates(active_cache, active_nr, o);
 	return 0;
@@ -416,7 +417,8 @@ static int verify_uptodate(struct cache_entry *ce,
 	}
 	if (errno == ENOENT)
 		return 0;
-	return error("Entry '%s' not uptodate. Cannot merge.", ce->name);
+	return o->gently ? -1 : 
+		error("Entry '%s' not uptodate. Cannot merge.", ce->name);
 }
 
 static void invalidate_ce_path(struct cache_entry *ce)
@@ -502,8 +504,9 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
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
@@ -575,8 +578,9 @@ static int verify_absent(struct cache_entry *ce, const char *action,
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
@@ -708,7 +712,7 @@ int threeway_merge(struct cache_entry **stages,
 	/* #14, #14ALT, #2ALT */
 	if (remote && !df_conflict_head && head_match && !remote_match) {
 		if (index && !same(index, remote) && !same(index, head))
-			return reject_merge(index);
+			return o->gently ? -1 : reject_merge(index);
 		return merged_entry(remote, index, o);
 	}
 	/*
@@ -716,7 +720,7 @@ int threeway_merge(struct cache_entry **stages,
 	 * make sure that it matches head.
 	 */
 	if (index && !same(index, head)) {
-		return reject_merge(index);
+		return o->gently ? -1 : reject_merge(index);
 	}
 
 	if (head) {
@@ -867,11 +871,11 @@ int twoway_merge(struct cache_entry **src,
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
@@ -898,7 +902,8 @@ int bind_merge(struct cache_entry **src,
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
index 5517faa..619950d 100644
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
1.5.3.6.886.gb204
