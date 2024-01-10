Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA9547A57
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18020 invoked by uid 109); 10 Jan 2024 11:39:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Jan 2024 11:39:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26228 invoked by uid 111); 10 Jan 2024 11:39:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Jan 2024 06:39:17 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Jan 2024 06:39:14 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Scott Leggett <scott@sl.id.au>
Subject: Re: [PATCH] commit-graph: retain commit slab when closing NULL
 commit_graph
Message-ID: <20240110113914.GE16674@coredump.intra.peff.net>
References: <20240105054142.GA2035092@coredump.intra.peff.net>
 <ZZg3YIEDCjbbGyVX@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZZg3YIEDCjbbGyVX@nand.local>

On Fri, Jan 05, 2024 at 12:07:44PM -0500, Taylor Blau wrote:

> > I do think there's some fragility here that we might want to follow up
> > on. We have a global commit_graph_data_slab that contains graph
> > positions, and our global commit structs depend on the that slab
> > remaining valid. But close_commit_graph() is just about closing _one_
> > object store's graph. So it's dangerous to call that function and clear
> > the slab without also throwing away any "struct commit" we might have
> > parsed that depends on it.
> 
> I definitely agree that there seems like a high risk of another
> potentially-dangerous bug happening as a result of this area.
> 
> One thing that sticks out to me is that we have a scope mismatch
> between the commit structs, the raw_object_store, and the commit slabs.
> Slabs are tied to the lifetime of the raw_object_store, but the commit
> objects are tied to the global lifetime of the process. I wonder if it
> would make sense to have a slab per object-store, and require that you
> pass both the commit *and* the object-store you're looking it up in as
> arguments to any slab-related functions.

Right, that scope mismatch is the crux of the issue. I had imagined that
if you're really closing the object database you might want to just
throw away all of the object structs. But we don't have a way to do that
(and in general I'd be slightly scared if we did, since lots of code
likes to think of object pointers as immutable).

I don't know if your solution works, though. If I "partially" load a
commit (i.e., its "parsed" flag is 1, but maybe_tree is still NULL, not
having been loaded from the graph yet), then that commit object depends
on the slab. If we later ask the commit about its tree, then it needs to
refer to the slab to see if it came from the graph. Right now that
happens in the global slab. If we did it in a per-object-store slab,
we'd need each commit to know which object store it came from!

Of course we do have a "struct repository" argument in
repo_get_commit_tree(). So...maybe that's enough? It still doesn't get
us all the way there, though. In this case the culprit was submodules,
and we really would be closing an alternate repo. But we have actual
calls to close_commit_graph() sprinkled around. Any code which closes
any commit-graph and then still accesses a "struct commit" is
potentially buggy.

I think a simpler solution would be that upon clearing the slab, we
either "finish" each commit (filling in the maybe_tree field) or
"unparse" it (unsetting the parsed flag, and then doing a regular and/or
graph lookup if it is accessed again later).

It should be easy-ish to iterate through the slab and look at the
commits that are mentioned in it. Though maybe not? Each commit knows
its slab-id, but I'm not sure if we have a master list of commits to go
the other way.

So yet another alternative is: don't clear the slab. Mark the entries as
"this came from a graph, but we don't know the correct graph position
anymore" (presumably with a new sentinel value for data->graph_pos). And
then functions like repo_get_commit_tree() would know that they need to
try harder (e.g., doing the unparse then and going back to the object
store to parse again).

Hmm. Actually, maybe COMMIT_NOT_FROM_GRAPH already functions that way.
If we see a commit that is parsed but has a NULL maybe_tree, then if we
see COMMIT_NOT_FROM_GRAPH we assume it's just a corrupt commit and
return NULL. But we could just try harder to re-parse it then. Like:

diff --git a/commit.c b/commit.c
index ef679a0b93..909898cf7f 100644
--- a/commit.c
+++ b/commit.c
@@ -423,6 +423,24 @@ struct tree *repo_get_commit_tree(struct repository *r,
 	if (commit_graph_position(commit) != COMMIT_NOT_FROM_GRAPH)
 		return get_commit_tree_in_graph(r, commit);
 
+	/*
+	 * This is either a corrupt commit, or one which we partially loaded
+	 * from a graph file but then subsequently threw away the graph data.
+	 *
+	 * Optimistically assume it's the latter and try to reload from
+	 * scratch. This gives a performance penalty if it really is a corrupt
+	 * commit, but presumably that happens rarely.
+	 *
+	 * This will throw away the parents list, which is potentially sketchy.
+	 * A better version of this would just unset commit->object.parsed
+	 * and then do a minimal version of parse_commit() that _just_ loads
+	 * the tree data (and/or graph position if available).
+	 *
+	 * Naturally we'd need to drop the "const" from our commit above, too.
+	 */
+	unparse_commit(r, &commit->object.oid);
+	repo_parse_commit(r, commit);
+
 	return NULL;
 }
 
I dunno. I do feel like this is a lurking maintenance headache, and
might even be a triggerable bug. But without knowing of a way that it
happens in the current code base, it feels like it would be easy to make
things worse rather than better.

I'm content to leave it for now and let this discussion serve as a
reference if somebody does manage to run into it in practice.

-Peff
