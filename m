Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26245EAD3
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 07:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 29526 invoked by uid 109); 11 Jan 2024 07:53:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jan 2024 07:53:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3680 invoked by uid 111); 11 Jan 2024 07:53:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jan 2024 02:53:16 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jan 2024 02:53:13 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Scott Leggett <scott@sl.id.au>
Subject: Re: [PATCH] commit-graph: retain commit slab when closing NULL
 commit_graph
Message-ID: <20240111075313.GF48154@coredump.intra.peff.net>
References: <20240105054142.GA2035092@coredump.intra.peff.net>
 <ZZg3YIEDCjbbGyVX@nand.local>
 <20240110113914.GE16674@coredump.intra.peff.net>
 <xmqq34v5dtz9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34v5dtz9.fsf@gitster.g>

On Wed, Jan 10, 2024 at 08:38:18AM -0800, Junio C Hamano wrote:

> > It should be easy-ish to iterate through the slab and look at the
> > commits that are mentioned in it. Though maybe not? Each commit knows
> > its slab-id, but I'm not sure if we have a master list of commits to go
> > the other way.
> 
> We have table of all in-core objects, don't we?

Oh, duh. Yes, we could iterate over obj_hash. I do think the "on demand"
version I showed later in the message is better, though, as the work
both scales with the number of affected commits (rather than the total
number of objects) and can be done lazily (so callers that are not buggy
pay no price at all).

> > +	 * This will throw away the parents list, which is potentially sketchy.
> > +	 * A better version of this would just unset commit->object.parsed
> > +	 * and then do a minimal version of parse_commit() that _just_ loads
> > +	 * the tree data (and/or graph position if available).
> 
> Yeah, it is a concern that we may be working with an in-core commit
> object whose parent list has already been rewritten during revision
> traversal.  Well thought out.

Hmm. Looking at my "a better version" sentence, I guess we know that
either:

  1. The object really is corrupt (i.e., we could not load the tree).

  2. It came from a graph in the first place.

So what if we just tried harder to look it up in the graph file (rather
than the slab) when we see COMMIT_NOT_FROM_GRAPH? And indeed, we even
have a function to do this already!

So something like this almost works:

diff --git a/commit.c b/commit.c
index b3223478bc..096a3d18d0 100644
--- a/commit.c
+++ b/commit.c
@@ -418,10 +418,12 @@ static inline void set_commit_tree(struct commit *c, struct tree *t)
 struct tree *repo_get_commit_tree(struct repository *r,
 				  const struct commit *commit)
 {
+	uint32_t pos;
+
 	if (commit->maybe_tree || !commit->object.parsed)
 		return commit->maybe_tree;
 
-	if (commit_graph_position(commit) != COMMIT_NOT_FROM_GRAPH)
+	if (repo_find_commit_pos_in_graph(r, commit, &pos))
 		return get_commit_tree_in_graph(r, commit);
 
 	return NULL;

but:

  1. It doesn't update the slab, so get_commit_tree_in_graph() then
     complains immediately, because it uses only
     commit_graph_position(). I guess we'd need to do:

       commit_graph_data_at(commit)->graph_pos = pos;

     somewhere. That does make the recently-found segfault go away.
     But...

  2. I'm not sure if other spots would want similar treatment. We store
     generation numbers in the slab, too. I think we'll figure things
     out when they're not available, so there's no segfault problem. But
     it's maybe a potential performance issue. Likewise, it is probably
     a bug that the graph-writing code is looking at this commit at all
     (since we know it is already in a graph file). So we might be
     papering over that bug (that is, even though the segfault is gone,
     we are perhaps still writing a duplicate graph entry).

> > I dunno. I do feel like this is a lurking maintenance headache, and
> > might even be a triggerable bug. But without knowing of a way that it
> > happens in the current code base, it feels like it would be easy to make
> > things worse rather than better.
> 
> Unfortunately I share the feeling X-<.

I somehow sniped myself into thinking about it more, but that has only
reinforced my feeling that I'm afraid to touch it. ;)

-Peff
