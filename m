From: Jeff King <peff@peff.net>
Subject: [PATCH v2 21/25] rev-list: add --index-objects option
Date: Wed, 15 Oct 2014 18:44:30 -0400
Message-ID: <20141015224430.GU25630@peff.net>
References: <20141015223244.GA25368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 00:44:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeXJ6-0001Rk-Tp
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 00:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbaJOWod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 18:44:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:59022 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750721AbaJOWoc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 18:44:32 -0400
Received: (qmail 2705 invoked by uid 102); 15 Oct 2014 22:44:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 17:44:32 -0500
Received: (qmail 28257 invoked by uid 107); 15 Oct 2014 22:44:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 18:44:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Oct 2014 18:44:30 -0400
Content-Disposition: inline
In-Reply-To: <20141015223244.GA25368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is currently no easy way to ask the revision traversal
machinery to include objects reachable from the index (e.g.,
blobs and trees that have not yet been committed). This
patch adds an option to do so.

Signed-off-by: Jeff King <peff@peff.net>
---
I was tempted to call this just "--index", because I could not think of
what else "--index" would mean in the context of rev-list. But I also
worried about weird interactions with other commands that take revision
arguments. And since this is mostly for internal use anyway, I figured
the more verbose name is not too bad. I could be convinced otherwise,
though.

 Documentation/rev-list-options.txt |  7 ++++++
 revision.c                         | 51 ++++++++++++++++++++++++++++++++++++++
 revision.h                         |  1 +
 t/t6000-rev-list-misc.sh           | 23 +++++++++++++++++
 4 files changed, 82 insertions(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 4cf94c6..03ab343 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -172,6 +172,13 @@ explicitly.
 	Pretend as if all objects mentioned by reflogs are listed on the
 	command line as `<commit>`.
 
+--index-objects::
+	Pretend as if all objects used by the index (any blobs, and any
+	trees which are mentioned by the index's cache-tree extension)
+	ad listed on the command line. Note that you probably want to
+	use `--objects`, too, as there are by definition no commits in
+	the index.
+
 --ignore-missing::
 	Upon seeing an invalid object name in the input, pretend as if
 	the bad input was not given.
diff --git a/revision.c b/revision.c
index 9a0f99a..caabaf1 100644
--- a/revision.c
+++ b/revision.c
@@ -17,6 +17,7 @@
 #include "mailmap.h"
 #include "commit-slab.h"
 #include "dir.h"
+#include "cache-tree.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -1299,6 +1300,53 @@ void add_reflogs_to_pending(struct rev_info *revs, unsigned flags)
 	for_each_reflog(handle_one_reflog, &cb);
 }
 
+static void add_cache_tree(struct cache_tree *it, struct rev_info *revs,
+			   struct strbuf *path)
+{
+	size_t baselen = path->len;
+	int i;
+
+	if (it->entry_count >= 0) {
+		struct tree *tree = lookup_tree(it->sha1);
+		add_pending_object_with_path(revs, &tree->object, "",
+					     040000, path->buf);
+	}
+
+	for (i = 0; i < it->subtree_nr; i++) {
+		struct cache_tree_sub *sub = it->down[i];
+		strbuf_addf(path, "%s%s", baselen ? "/" : "", sub->name);
+		add_cache_tree(sub->cache_tree, revs, path);
+		strbuf_setlen(path, baselen);
+	}
+
+}
+
+void add_index_objects_to_pending(struct rev_info *revs, unsigned flags)
+{
+	int i;
+
+	read_cache();
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		struct blob *blob;
+
+		if (S_ISGITLINK(ce->ce_mode))
+			continue;
+
+		blob = lookup_blob(ce->sha1);
+		if (!blob)
+			die("unable to add index blob to traversal");
+		add_pending_object_with_path(revs, &blob->object, "",
+					     ce->ce_mode, ce->name);
+	}
+
+	if (active_cache_tree) {
+		struct strbuf path = STRBUF_INIT;
+		add_cache_tree(active_cache_tree, revs, &path);
+		strbuf_release(&path);
+	}
+}
+
 static int add_parents_only(struct rev_info *revs, const char *arg_, int flags)
 {
 	unsigned char sha1[20];
@@ -1649,6 +1697,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	    !strcmp(arg, "--reflog") || !strcmp(arg, "--not") ||
 	    !strcmp(arg, "--no-walk") || !strcmp(arg, "--do-walk") ||
 	    !strcmp(arg, "--bisect") || starts_with(arg, "--glob=") ||
+	    !strcmp(arg, "--index-objects") ||
 	    starts_with(arg, "--exclude=") ||
 	    starts_with(arg, "--branches=") || starts_with(arg, "--tags=") ||
 	    starts_with(arg, "--remotes=") || starts_with(arg, "--no-walk="))
@@ -2078,6 +2127,8 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--reflog")) {
 		add_reflogs_to_pending(revs, *flags);
+	} else if (!strcmp(arg, "--index-objects")) {
+		add_index_objects_to_pending(revs, *flags);
 	} else if (!strcmp(arg, "--not")) {
 		*flags ^= UNINTERESTING | BOTTOM;
 	} else if (!strcmp(arg, "--no-walk")) {
diff --git a/revision.h b/revision.h
index e644044..e6dcd5d 100644
--- a/revision.h
+++ b/revision.h
@@ -277,6 +277,7 @@ extern void add_pending_sha1(struct rev_info *revs,
 
 extern void add_head_to_pending(struct rev_info *);
 extern void add_reflogs_to_pending(struct rev_info *, unsigned int flags);
+extern void add_index_objects_to_pending(struct rev_info *, unsigned int flags);
 
 enum commit_action {
 	commit_ignore,
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 3794e4c..c2fb09c 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -73,4 +73,27 @@ test_expect_success 'symleft flag bit is propagated down from tag' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rev-list can show index objects' '
+	# Of the blobs and trees in the index, note:
+	#
+	#   - we do not show two/three, because it is the
+	#     same blob as "one", and we show objects only once
+	#
+	#   - we do show the tree "two", because it has a valid cache tree
+	#     from the last commit
+	#
+	#   - we do not show the root tree; since we updated the index, it
+	#     does not have a valid cache tree
+	#
+	cat >expect <<-\EOF
+	8e4020bb5a8d8c873b25de15933e75cc0fc275df one
+	d9d3a7417b9605cfd88ee6306b28dadc29e6ab08 only-in-index
+	9200b628cf9dc883a85a7abc8d6e6730baee589c two
+	EOF
+	echo only-in-index >only-in-index &&
+	git add only-in-index &&
+	git rev-list --objects --index-objects >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.1.2.596.g7379948
