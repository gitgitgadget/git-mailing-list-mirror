From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Avoid loading commits twice in log with diffs
Date: Thu, 28 Mar 2013 09:51:14 -0400
Message-ID: <20130328135114.GA12898@sigill.intra.peff.net>
References: <7va9qlc690.fsf@alter.siamese.dyndns.org>
 <f519e4af34cecd6aa4c905aa48288a9c2c841ae1.1364458249.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@inf.ethz.ch>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 28 14:51:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULDFA-0004an-KA
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 14:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755922Ab3C1NvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 09:51:25 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42716 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755879Ab3C1NvY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 09:51:24 -0400
Received: (qmail 24765 invoked by uid 107); 28 Mar 2013 13:53:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Mar 2013 09:53:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Mar 2013 09:51:14 -0400
Content-Disposition: inline
In-Reply-To: <f519e4af34cecd6aa4c905aa48288a9c2c841ae1.1364458249.git.trast@inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219396>

On Thu, Mar 28, 2013 at 09:19:34AM +0100, Thomas Rast wrote:

> However, fixing the commits is easy at least at the band-aid level.
> They are triggered by log_tree_diff() invoking diff_tree_sha1() on
> commits, which duly loads the specified object to dereference it to a
> tree.  Since log_tree_diff() knows that it works with commits and they
> must have trees, we can simply pass through the trees.

Reading this made me wonder if we could be doing the optimization at a
lower level, by re-using objects that we have in our lookup_object cache
(which would include the commit->tree peeling that you're optimizing
here).

My first instinct was to look at read_object_with_reference, but it's a
bit general; for trees, we can indeed find the buffer/size pair. But for
commits, we must infer the size from the buffer (by using strlen). And
for blobs, we do not win at all, as we do not cache the blob contents.

Another option is for diff_tree_sha1 to use parse_tree_indirect. That
will pull the commit object from the cache and avoid re-parsing it, as
well as re-use any trees (although that should not happen much in a
regular "log" traversal).

That patch looks something like:

diff --git a/tree-diff.c b/tree-diff.c
index ba01563..db454bc 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -269,27 +269,28 @@ int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const cha
 
 int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
 {
-	void *tree1, *tree2;
+	struct tree *tree1, *tree2;
 	struct tree_desc t1, t2;
-	unsigned long size1, size2;
 	int retval;
 
-	tree1 = read_object_with_reference(old, tree_type, &size1, NULL);
+	tree1 = parse_tree_indirect(old);
 	if (!tree1)
 		die("unable to read source tree (%s)", sha1_to_hex(old));
-	tree2 = read_object_with_reference(new, tree_type, &size2, NULL);
+	tree2 = parse_tree_indirect(new);
 	if (!tree2)
 		die("unable to read destination tree (%s)", sha1_to_hex(new));
-	init_tree_desc(&t1, tree1, size1);
-	init_tree_desc(&t2, tree2, size2);
+	init_tree_desc(&t1, tree1->buffer, tree1->size);
+	init_tree_desc(&t2, tree2->buffer, tree2->size);
 	retval = diff_tree(&t1, &t2, base, opt);
 	if (!*base && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename()) {
-		init_tree_desc(&t1, tree1, size1);
-		init_tree_desc(&t2, tree2, size2);
+		init_tree_desc(&t1, tree1->buffer, tree1->size);
+		init_tree_desc(&t2, tree2->buffer, tree2->size);
 		try_to_follow_renames(&t1, &t2, base, opt);
 	}
-	free(tree1);
-	free(tree2);
+	/*
+	 * Note that we are now filling up our cache with extra tree data; we
+	 * could potentially unparse the tree objects.
+	 */
 	return retval;
 }
 

but it turns out to actually be slower! The problem is that parse_object
will actually re-check the sha1 on every object it reads, which
read_object_with_reference will not do.

Using this hack:

diff --git a/object.c b/object.c
index 20703f5..361eb74 100644
--- a/object.c
+++ b/object.c
@@ -195,6 +195,7 @@ struct object *parse_object_or_die(const unsigned char *sha1,
 	die(_("unable to parse object: %s"), name ? name : sha1_to_hex(sha1));
 }
 
+int parse_object_quick = 0;
 struct object *parse_object(const unsigned char *sha1)
 {
 	unsigned long size;
@@ -221,7 +222,8 @@ struct object *parse_object(const unsigned char *sha1)
 
 	buffer = read_sha1_file(sha1, &type, &size);
 	if (buffer) {
-		if (check_sha1_signature(repl, buffer, size, typename(type)) < 0) {
+		if (!parse_object_quick &&
+		    check_sha1_signature(repl, buffer, size, typename(type)) < 0) {
 			free(buffer);
 			error("sha1 mismatch %s", sha1_to_hex(repl));
 			return NULL;
diff --git a/tree-diff.c b/tree-diff.c
index db454bc..4b55a1a 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -267,18 +267,23 @@ int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const cha
 	q->nr = 1;
 }
 
+/* hacky */
+extern int parse_object_quick;
+
 int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
 {
 	struct tree *tree1, *tree2;
 	struct tree_desc t1, t2;
 	int retval;
 
+	parse_object_quick = 1;
 	tree1 = parse_tree_indirect(old);
 	if (!tree1)
 		die("unable to read source tree (%s)", sha1_to_hex(old));
 	tree2 = parse_tree_indirect(new);
 	if (!tree2)
 		die("unable to read destination tree (%s)", sha1_to_hex(new));
+	parse_object_quick = 0;
 	init_tree_desc(&t1, tree1->buffer, tree1->size);
 	init_tree_desc(&t2, tree2->buffer, tree2->size);
 	retval = diff_tree(&t1, &t2, base, opt);

my best-of-five "git log --raw" on git.git went from ~4.3s to ~4.1s,
which is on par with what you saw.

-Peff
