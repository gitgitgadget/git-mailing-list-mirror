From: Jeff King <peff@peff.net>
Subject: [PATCH] process tree diffs during "rev-list --objects"
Date: Wed, 1 May 2013 20:53:17 -0400
Message-ID: <20130502005317.GA29159@sigill.intra.peff.net>
References: <6c2b67a2f0b67ee796c7676e3febe4c61ab85d4a.1366912627.git.trast@inf.ethz.ch>
 <20130501204947.GA12789@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 02 02:53:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXhm1-000414-3d
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 02:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757467Ab3EBAxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 20:53:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:52387 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753830Ab3EBAxU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 20:53:20 -0400
Received: (qmail 17911 invoked by uid 102); 2 May 2013 00:53:36 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 May 2013 19:53:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 May 2013 20:53:17 -0400
Content-Disposition: inline
In-Reply-To: <20130501204947.GA12789@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223170>

On Wed, May 01, 2013 at 04:49:47PM -0400, Jeff King wrote:

> Another avenue I'd like to explore is actually doing a tree-diff from
> the last processed commit, since we should need to examine only the
> changed entries. I suspect it won't be a big benefit, though, because
> even though the tree diff can happen in O(# of entries), we are trying
> to beat doing an O(1) hash for each entry. So it's the same algorithmic
> complexity, and it is hard to beat a few hashcmp() calls. We'll see.

As I suspected, this is not a win:

Test                               origin            this tree
--------------------------------------------------------------------------
0001.1: rev-list --all             0.40(0.37+0.02)   0.40(0.38+0.01) +0.0%
0001.2: rev-list --all --objects   2.22(2.16+0.05)   2.41(2.16+0.24) +8.6%

I've included the patch below for reference. It really does work as
planned; the number of calls to lookup_object for doing "rev-list --all
--objects" on git.git is reduced from ~15M to ~2.6M. But the benefit is
eaten up by the extra tree-processing time. For fun, here's an excerpt
from the "perf diff" between the two versions:

            +10.51%  git                 [.] update_tree_entry
             +8.97%  git                 [.] lookup_object
             +7.81%  git                 [.] process_tree
             +5.20%  libc-2.13.so        [.] __memcmp_sse4_1
             +3.77%  libc-2.13.so        [.] __strlen_sse42
             +2.69%  git                 [.] base_name_compare
             [....]
             -7.90%  git                 [.] tree_entry
            -39.19%  git                 [.] lookup_object

Shawn had suggested trying to store the tree deltas in such a way that
these tree comparisons could be done more cheaply. That might tip things
in favor of the tree-diff approach.

-Peff

---
diff --git a/list-objects.c b/list-objects.c
index 3dd4a96..b87a049 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -59,8 +59,57 @@ static void process_tree(struct rev_info *revs,
 	/* Nothing to do */
 }
 
+static struct tree *skip_processed_entries(struct tree_desc *cur,
+					   struct tree_desc *old)
+{
+	while (cur->size && old->size) {
+		int cmp = base_name_compare(cur->entry.path,
+					    tree_entry_len(&cur->entry),
+					    0, /* ignore mode */
+					    old->entry.path,
+					    tree_entry_len(&old->entry),
+					    0);
+		if (cmp > 0) {
+			/*
+			 * Old tree has something we do not; ignore it, as it
+			 * was already processed.
+			 */
+			update_tree_entry(old);
+		}
+		else if (cmp == 0) {
+			/*
+			 * We have the same path; if the sha1s match, then we
+			 * have already processed it and can ignore. Otherwise,
+			 * return for processing, but also provide the old
+			 * tree so that we can recurse.
+			 */
+			if (!hashcmp(cur->entry.sha1, old->entry.sha1)) {
+				update_tree_entry(cur);
+				update_tree_entry(old);
+			}
+			else {
+				struct object *o = lookup_object(old->entry.sha1);
+				update_tree_entry(old);
+				if (o && o->type == OBJ_TREE)
+					return (struct tree *)o;
+				else
+					return NULL;
+			}
+		}
+		else {
+			/*
+			 * We have an entry the old one does not; we must look
+			 * at it (and there is no matching old tree to report).
+			 */
+			return NULL;
+		}
+	}
+	return NULL;
+}
+
 static void process_tree(struct rev_info *revs,
 			 struct tree *tree,
+			 struct tree *old_tree,
 			 show_object_fn show,
 			 struct name_path *path,
 			 struct strbuf *base,
@@ -68,7 +117,7 @@ static void process_tree(struct rev_info *revs,
 			 void *cb_data)
 {
 	struct object *obj = &tree->object;
-	struct tree_desc desc;
+	struct tree_desc desc, old_desc;
 	struct name_entry entry;
 	struct name_path me;
 	enum interesting match = revs->diffopt.pathspec.nr == 0 ?
@@ -97,7 +146,18 @@ static void process_tree(struct rev_info *revs,
 
 	init_tree_desc(&desc, tree->buffer, tree->size);
 
-	while (tree_entry(&desc, &entry)) {
+	if (old_tree)
+		init_tree_desc(&old_desc, old_tree->buffer, old_tree->size);
+	else
+		init_tree_desc(&old_desc, NULL, 0);
+
+	while (desc.size) {
+		struct tree *old_tree;
+
+		old_tree = skip_processed_entries(&desc, &old_desc);
+		if (!tree_entry(&desc, &entry))
+			break;
+
 		if (match != all_entries_interesting) {
 			match = tree_entry_interesting(&entry, base, 0,
 						       &revs->diffopt.pathspec);
@@ -109,7 +169,7 @@ static void process_tree(struct rev_info *revs,
 
 		if (S_ISDIR(entry.mode))
 			process_tree(revs,
-				     lookup_tree(entry.sha1),
+				     lookup_tree(entry.sha1), old_tree,
 				     show, &me, base, entry.path,
 				     cb_data);
 		else if (S_ISGITLINK(entry.mode))
@@ -123,8 +183,6 @@ static void process_tree(struct rev_info *revs,
 				     cb_data);
 	}
 	strbuf_setlen(base, baselen);
-	free(tree->buffer);
-	tree->buffer = NULL;
 }
 
 static void mark_edge_parents_uninteresting(struct commit *commit,
@@ -173,6 +231,7 @@ void traverse_commit_list(struct rev_info *revs,
 	int i;
 	struct commit *commit;
 	struct strbuf base;
+	struct tree *last_root_tree = NULL;
 
 	strbuf_init(&base, PATH_MAX);
 	while ((commit = get_revision(revs)) != NULL) {
@@ -196,8 +255,9 @@ void traverse_commit_list(struct rev_info *revs,
 			continue;
 		}
 		if (obj->type == OBJ_TREE) {
-			process_tree(revs, (struct tree *)obj, show_object,
-				     NULL, &base, name, data);
+			process_tree(revs, (struct tree *)obj, last_root_tree,
+				     show_object, NULL, &base, name, data);
+			last_root_tree = (struct tree *)obj;
 			continue;
 		}
 		if (obj->type == OBJ_BLOB) {
