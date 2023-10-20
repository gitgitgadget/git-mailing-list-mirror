Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFF8179A0
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0901114
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 03:31:17 -0700 (PDT)
Received: (qmail 15542 invoked by uid 109); 20 Oct 2023 10:31:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Oct 2023 10:31:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12920 invoked by uid 111); 20 Oct 2023 10:31:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Oct 2023 06:31:21 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Oct 2023 06:31:16 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 5/8] commit-graph: read `BIDX` chunk with
 `pair_chunk_expect()`
Message-ID: <20231020103116.GC2673857@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <cover.1697225110.git.me@ttaylorr.com>
 <45cac29403e63483951f7766c6da3c022c68d9f0.1697225110.git.me@ttaylorr.com>
 <xmqqcyxhxk0h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcyxhxk0h.fsf@gitster.g>

On Sat, Oct 14, 2023 at 09:10:22AM -0700, Junio C Hamano wrote:

> > @@ -461,8 +449,10 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
> >  	}
> >  
> >  	if (s->commit_graph_read_changed_paths) {
> > +		if (pair_chunk_expect(cf, GRAPH_CHUNKID_BLOOMINDEXES,
> > +				      &graph->chunk_bloom_indexes,
> > +				      st_mult(graph->num_commits, 4)) == -1)
> > +			warning(_("commit-graph changed-path index chunk is too small (%d)"), graph->num_commits * 4);
> >  		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
> >  			   graph_read_bloom_data, graph);
> >  	}
> 
> Overall the series looked sane, but the need for each caller to
> supply error messages, when the helper perfectly well knows how many
> bytes the caller expected and how many bytes there are avaiable, was
> a bit disturbing, as the level of detail given per each caller will
> inevitably become uneven.  Even now, some give an error() while
> others give a warning(), even though I suspect all of them should be
> data errors.
> 
> I wonder if it makes sense to stuff the message template in the
> pair_chunk_data structure and do
> 
> static int pair_chunk_expect_fn(const unsigned char *chunk_start,
> 				size_t chunk_size,
> 				void *data)
> {
> 	struct pair_chunk_data *pcd = data;
> 	if (pcd->expected_size != chunk_size)
> 		return error(_(pcd->message), pcd->expected_size, chunk_size);
> 	*pcd->p = chunk_start;
> 	return 0;
> }

One issue with the series as-is is that the "chunk is too small"
messages can be misleading when the chunk is in fact missing. We do say
"missing or corrupt" in the die message (at least for midx; I did not
update the similar ones for commit-graph), but the explicit "too small"
for a missing chunk seems to me to cross the line.

The caller can distinguish the cases by the actual value returned from
pair_chunk_expect(), but doing so makes the code a lot longer and harder
to read.

Your suggestion above takes care of it naturally (in the same way that
the existing code does, which basically is emitting the same message in
each read_chunk callback).

-Peff
