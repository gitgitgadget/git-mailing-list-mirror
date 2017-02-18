Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBF76201A9
	for <e@80x24.org>; Sat, 18 Feb 2017 03:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752795AbdBRDPv (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 22:15:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:57923 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752791AbdBRDPv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 22:15:51 -0500
Received: (qmail 13610 invoked by uid 109); 18 Feb 2017 03:15:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 18 Feb 2017 03:15:33 +0000
Received: (qmail 11694 invoked by uid 111); 18 Feb 2017 03:15:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 22:15:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 22:15:31 -0500
Date:   Fri, 17 Feb 2017 22:15:31 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/19] builtin/diff-tree: convert to struct object_id
Message-ID: <20170218031530.2bhlnjcukl4ybt6h@sigill.intra.peff.net>
References: <20170218000652.375129-1-sandals@crustytoothpaste.net>
 <20170218000652.375129-3-sandals@crustytoothpaste.net>
 <3630da01-5af3-bc02-3a8c-1e3495512279@ramsayjones.plus.com>
 <20170218012607.kdisudmmponvts35@genre.crustytoothpaste.net>
 <20170218014217.sil4jyukkbqguxfz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170218014217.sil4jyukkbqguxfz@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 08:42:17PM -0500, Jeff King wrote:

> > I'm wondering if parse_oid_hex could be useful here as well.
> 
> I know I haven't looked at this chunk nearly as carefully as you have,
> but it seems somewhat crazy to me that these functions get the original
> "line" in the first place. Shouldn't they get line+40 from the caller
> (who in turn should be using parse_oid_hex to compute that)?
> 
> And then each function should subsequently parse left-to-right with
> a mix of isspace() and parse_oid_hex(), and probably doesn't even need
> to care about the original "len" at all (yes, you can quit early if you
> know your len isn't long enough, but that's the unusual error case
> anyway; it's not a big deal to find that out while parsing).
> 
> In general, I think this sort of left-to-right incremental pointer
> movement is safe and simple. There may be a few cases where it doesn't
> apply (i.e., where you need to look at the end of the string to know how
> to parse the beginning), but that should be relatively rare.

So for this case, something like the patch below.

Incidentally, there's an off-by-one in the original loop of
stdin_diff_commit that reads past the end of the trailing NUL for the
final sha1 on the line. The problem is the:

  pos += GIT_SHA1_HEXSZ + 1;

which assumes we're slurping up the trailing space. This works in
practice because the caller will only permit a string which had a
newline (which it converted into a NUL).

I suspect that function could be more aggressive about complaining about
nonsense on the line, rather than silently ignoring it.

 builtin/diff-tree.c | 43 ++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 1f1573bb2..222c671f2 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -16,37 +16,33 @@ static int diff_tree_commit_sha1(const struct object_id *oid)
 }
 
 /* Diff one or more commits. */
-static int stdin_diff_commit(struct commit *commit, char *line, int len)
+static int stdin_diff_commit(struct commit *commit, const char *p)
 {
 	struct object_id oid;
-	if (isspace(line[GIT_SHA1_HEXSZ]) && !get_oid_hex(line+GIT_SHA1_HEXSZ+1, &oid)) {
-		/* Graft the fake parents locally to the commit */
-		int pos = GIT_SHA1_HEXSZ + 1;
-		struct commit_list **pptr;
-
-		/* Free the real parent list */
-		free_commit_list(commit->parents);
-		commit->parents = NULL;
-		pptr = &(commit->parents);
-		while (line[pos] && !get_oid_hex(line + pos, &oid)) {
-			struct commit *parent = lookup_commit(oid.hash);
-			if (parent) {
-				pptr = &commit_list_insert(parent, pptr)->next;
-			}
-			pos += GIT_SHA1_HEXSZ + 1;
+	struct commit_list **pptr = NULL;
+
+	/* Graft the fake parents locally to the commit */
+	while (isspace(*p++) && !parse_oid_hex(p, &oid, &p)) {
+		struct commit *parent = lookup_commit(oid.hash);
+		if (!pptr) {
+			/* Free the real parent list */
+			free_commit_list(commit->parents);
+			commit->parents = NULL;
+			pptr = &(commit->parents);
+		}
+		if (parent) {
+			pptr = &commit_list_insert(parent, pptr)->next;
 		}
 	}
 	return log_tree_commit(&log_tree_opt, commit);
 }
 
 /* Diff two trees. */
-static int stdin_diff_trees(struct tree *tree1, char *line, int len)
+static int stdin_diff_trees(struct tree *tree1, const char *p)
 {
 	struct object_id oid;
 	struct tree *tree2;
-	const int chunksz = GIT_SHA1_HEXSZ + 1;
-	if (len != 2 * chunksz || !isspace(line[chunksz-1]) ||
-		get_sha1_hex(line + chunksz, oid.hash))
+	if (!isspace(*p++) || parse_oid_hex(p, &oid, &p) || *p)
 		return error("Need exactly two trees, separated by a space");
 	tree2 = lookup_tree(oid.hash);
 	if (!tree2 || parse_tree(tree2))
@@ -64,19 +60,20 @@ static int diff_tree_stdin(char *line)
 	int len = strlen(line);
 	struct object_id oid;
 	struct object *obj;
+	const char *rest;
 
 	if (!len || line[len-1] != '\n')
 		return -1;
 	line[len-1] = 0;
-	if (get_oid_hex(line, &oid))
+	if (parse_oid_hex(line, &oid, &rest))
 		return -1;
 	obj = parse_object(oid.hash);
 	if (!obj)
 		return -1;
 	if (obj->type == OBJ_COMMIT)
-		return stdin_diff_commit((struct commit *)obj, line, len);
+		return stdin_diff_commit((struct commit *)obj, rest);
 	if (obj->type == OBJ_TREE)
-		return stdin_diff_trees((struct tree *)obj, line, len);
+		return stdin_diff_trees((struct tree *)obj, rest);
 	error("Object %s is a %s, not a commit or tree",
 	      oid_to_hex(&oid), typename(obj->type));
 	return -1;
