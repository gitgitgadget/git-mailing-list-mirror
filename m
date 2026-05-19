Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2CE384CCC
	for <git@vger.kernel.org>; Tue, 19 May 2026 06:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171337; cv=none; b=s3+TT4HatXjEXJ0RFm636HcWWDyzkgzsaQZXxu5uEX7Q+I2z0bKK9x9xSjsFIsuGk3aLtVv+YbQ+sPG8YDmqmC+dLUtQRfzK8CRzLaYIipwLJsEBR5jFv6kxu5q3Y/DU5Z5nAd7wMspxV8tXrFlowi0d595qWLf0ZCgyJwll+gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171337; c=relaxed/simple;
	bh=664hfdowsmgidF2QUj1y8J7nLsQjymImEogOlDIWLqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrHPDI4ElsNINgK/0t29uDRIuqHxxyR6wgp4227SS1Zd4S71dJUeDFt4iAGMiwlxtO5K1T+rrk3Q3G6TMrqNTXnpMBdvgX0mX3APBUc28Z7UD7uUhAkfN/oAgN6ecOnulsZ75dmrDCa8AH62srhHWc6HTmla7JAB6rTTc9x0VO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gS5yRznA; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gS5yRznA"
Received: (qmail 17898 invoked by uid 106); 19 May 2026 06:15:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=664hfdowsmgidF2QUj1y8J7nLsQjymImEogOlDIWLqs=; b=gS5yRznALwR2xCKnPs9oKrYxjv0doGTYiG3f+KdZdN/yyqX47DbTxCUcrcodrrThb6aVo8fWwDMCxIzjLkA/3QhonX1ezygmF2kwdM8OgfPOVrNnguO6IEY5nYTmZvRPTPO1C1mR5Hrk8phugwyXqxN75dbylPNh8HPPg2zdFdqUKvjfz9h98NDGz1oTdSh/MqXjqztHAdc/xUew+Z2wcZyJClVBztsjP/crQbPu7LZ0cmruTcsRGHIx+r1PkYDdQ2bvF9mYTz8hCjgZN3vKX4V3QlOAZsVTkPFsipJuWpVZwwz5ObiaJwZ3A67oqMHdsHAr2r2weGJPUd72IIjcEQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 May 2026 06:15:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 43769 invoked by uid 111); 19 May 2026 06:15:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 May 2026 02:15:38 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 May 2026 02:15:34 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Rasmus Villemoes <ravi@prevas.dk>,
	Daniel Mach <daniel.mach@suse.com>
Subject: Re: [PATCH] commit: fall back to full read when maybe_tree is NULL
Message-ID: <20260519061534.GA1709881@coredump.intra.peff.net>
References: <20260519050513.GA1635924@coredump.intra.peff.net>
 <xmqqcxys7xi4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcxys7xi4.fsf@gitster.g>

On Tue, May 19, 2026 at 02:56:51PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It also means we have to reimplement a bit of the commit parsing. We
> > can't just use parse_commit_buffer() here, because it expects an
> > unparsed struct and wants to load everything, including parent links.
> > But we don't know if the parent list has been munged during traversal,
> > so it's not safe for us to touch it. Fortunately, it's quite easy to
> > load just the tree, as it is always the first line of the commit object.
> 
> I was hoping that existing code to parse out the tree in
> parse_commit_buffer() will become a call into this new helper
> function, so that we avoid duplicating the logic.

Yeah, I would like to have shared more code, but I think the amount that
can actually be shared gets overwhelmed by boilerplate. In particular,
parse_commit_buffer() wants to keep advancing the pointer afterwards,
since it actually reads the other lines.

> > Moreover, this strategy does nothing if we lose access to the graph file
> > unexpectedly (e.g., due to a system error).
> 
> Or simultaneous repack may lose the file from the filesystem,
> perhaps?

I don't think so, because our mmap would hold onto the contents until
the process ends. You'd really need some case where we actually drop the
mmap. I could see us doing that if we found that it was corrupted or
something, but I don't think that happens currently. We close it only
for odb_close(), or when writing a new graph file (and so it would only
affect the "commit-graph write" process itself).

> Looks quite straight-forward.  Don't you need to pay attention to
> r->hash_algo and call parse_oid_hex_algop() instead?
> 
> Or are we pretty much sure that "r" is always "the_repository" here,
> in which case parse_oid_hex() that uses "the_hash_algo" would be
> sufficient?

No, I didn't even think about it, since the use of the_hash_algo is
hidden behind the function. We definitely should use the hash algo from
"r", since we have access to it. I'm not even sure if you can have repos
of two different hashes loaded in the same process at this point, but
certainly it is the correct long-term direction.

Here's a re-roll with the one-line fixup:

    diff --git a/commit.c b/commit.c
    index cfc87ad185..499a9602ad 100644
    --- a/commit.c
    +++ b/commit.c
    @@ -448,7 +448,7 @@ static void load_tree_from_commit_contents(struct repository *r, struct commit *
     
     	if (type == OBJ_COMMIT &&
     	    skip_prefix(buf, "tree ", &p) &&
    -	    !parse_oid_hex(p, &tree_oid, &p) &&
    +	    !parse_oid_hex_algop(p, &tree_oid, &p, r->hash_algo) &&
     	    *p == '\n')
     		set_commit_tree(commit, lookup_tree(r, &tree_oid));
     

-- >8 --
Subject: commit: fall back to full read when maybe_tree is NULL

When we load a commit object from the commit graph (rather than reading
the object contents), we don't fill in its "maybe_tree" entry, but
rather wait to lazy-load it. This goes back to 7b8a21dba1 (commit-graph:
lazy-load trees for commits, 2018-04-06), and saves the work of
instantiating tree objects that nobody cares about.

But it creates a data dependency: now the commit struct depends on the
graph file to do that lazy load. This is a problem if we close the graph
file; now we have a commit struct that claims to be parsed but is
missing some of its data.

It's rare for this to be a problem in practice, because we don't tend to
close the graph files at all, and if we do we don't tend to look at
their commits afterward. But there is one case that is easy to trigger:
git-clone's --dissociate option will close the object database before
running the dissociate repack, and then afterwards still try to check
out the working tree. This will yield an error like:

  fatal: unable to parse commit b29edc0babef41810f7b1c9ee1d74058f22e4080
  warning: Clone succeeded, but checkout failed.

What happens is that we expect repo_get_commit_tree() to lazy-load the
tree, but commit_graph_position() returns COMMIT_NOT_FROM_GRAPH because
the position slab has gone away (and even if it hadn't, we don't have
the graph file itself available anymore).

Let's try harder to find the tree in repo_get_commit_tree() by actually
opening the commit object and parsing the tree line. This is extra work,
but no more than we'd have to go to if we hadn't done the initial graph
load in the first place.

It does mean that a corrupt commit (e.g., one that points to a non-tree
object for which we couldn't instantiate a struct) will repeatedly load
the object from disk, once for each call to repo_get_commit_tree(). But
such corruptions should be rare, and we don't tend to perform such calls
repeatedly (usually we'd abort the operation upon seeing corruption).

It also means we have to reimplement a bit of the commit parsing. We
can't just use parse_commit_buffer() here, because it expects an
unparsed struct and wants to load everything, including parent links.
But we don't know if the parent list has been munged during traversal,
so it's not safe for us to touch it. Fortunately, it's quite easy to
load just the tree, as it is always the first line of the commit object.

There is an alternative approach which I considered but rejected:
"complete" each graph-loaded commit struct when we close the graph file
by looking up and instantiating their trees at close time. This is the
most elegant solution in some sense, as it resolves the data dependency
at the moment it goes away. And it avoids ever opening the commit
objects at all, which can be more efficient.

But not always. The resolving effort scales with the number of
graph-loaded commits, even though we may only later access one or a few.
So the tradeoff depends on how many were loaded in total versus how many
will be later accessed.

And in most cases, we will not access any at all! Programs which close
the object database before exiting will then do a bunch of work for no
reason. This could be mitigated by requiring a separate function to
resolve the graph structs before closing the file. But now each close
call has to consider whether to call that resolving function. So we'd
fix this case in git-clone, but we don't know what other cases (if any)
are lurking.

Moreover, this strategy does nothing if we lose access to the graph file
unexpectedly (e.g., due to a system error). I'm not entirely sure this
is possible now (we mmap it, so I'd guess any error would turn into
SIGBUS anyway). But it feels like making the lazy-load more robust
(which this patch does) is the best way to handle a wide variety of
possible failure modes.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c                   | 33 ++++++++++++++++++++++++++++++++-
 t/t5604-clone-reference.sh | 23 +++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 4385ae4329..499a9602ad 100644
--- a/commit.c
+++ b/commit.c
@@ -434,6 +434,27 @@ static inline void set_commit_tree(struct commit *c, struct tree *t)
 	c->maybe_tree = t;
 }
 
+static void load_tree_from_commit_contents(struct repository *r, struct commit *commit)
+{
+	enum object_type type;
+	unsigned long size;
+	char *buf;
+	const char *p;
+	struct object_id tree_oid;
+
+	buf = odb_read_object(r->objects, &commit->object.oid, &type, &size);
+	if (!buf)
+		return;
+
+	if (type == OBJ_COMMIT &&
+	    skip_prefix(buf, "tree ", &p) &&
+	    !parse_oid_hex_algop(p, &tree_oid, &p, r->hash_algo) &&
+	    *p == '\n')
+		set_commit_tree(commit, lookup_tree(r, &tree_oid));
+
+	free(buf);
+}
+
 struct tree *repo_get_commit_tree(struct repository *r,
 				  const struct commit *commit)
 {
@@ -443,7 +464,17 @@ struct tree *repo_get_commit_tree(struct repository *r,
 	if (commit_graph_position(commit) != COMMIT_NOT_FROM_GRAPH)
 		return get_commit_tree_in_graph(r, commit);
 
-	return NULL;
+	/*
+	 * This is either a corrupt commit, or one which we partially loaded
+	 * from a graph file but then subsequently threw away the graph data.
+	 *
+	 * Optimistically assume it's the latter and try to reload from
+	 * scratch. This gives a performance penalty if it really is a corrupt
+	 * commit, but presumably that happens rarely (and only once per
+	 * process).
+	 */
+	load_tree_from_commit_contents(r, (struct commit *)commit);
+	return commit->maybe_tree;
 }
 
 struct object_id *get_commit_tree_oid(const struct commit *commit)
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 470bfb610c..c232ab8c15 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -360,4 +360,27 @@ test_expect_success SYMLINKS 'clone repo with symlinked objects directory' '
 	grep "is a symlink, refusing to clone with --local" err
 '
 
+test_expect_success 'dissociate from repo with commit graph' '
+	git init orig &&
+	# We are trying to make sure the dissociated repo can
+	# find the tree of the tip commit, so the test could still
+	# serve its purpose with an empty tree. But having actual
+	# content future-proofs us against any kind of internal
+	# empty-tree optimizations.
+	echo content >orig/file &&
+	git -C orig add . &&
+	git -C orig commit -m foo &&
+
+	# We will use graph.git as our "local" source to dissociate
+	# from.
+	git clone --bare orig graph.git &&
+	git -C graph.git commit-graph write --reachable &&
+
+	# And then finally clone orig, using graph.git to get our objects. This
+	# must be non-bare so that we perform the checkout step, which will
+	# need to access the tree of HEAD, which we will have originally loaded
+	# via the commit graph.
+	git clone --no-local --reference graph.git --dissociate orig clone
+'
+
 test_done
-- 
2.54.0.547.gb3b6f86dd6

