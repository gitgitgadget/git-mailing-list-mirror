Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEF33C695
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE1D4205
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 14:01:43 -0800 (PST)
Received: (qmail 15280 invoked by uid 109); 10 Nov 2023 22:01:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Nov 2023 22:01:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1009 invoked by uid 111); 10 Nov 2023 22:01:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Nov 2023 17:01:44 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Nov 2023 17:01:42 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/7] chunk-format: introduce `pair_chunk_expect()` helper
Message-ID: <20231110220142.GH2758295@coredump.intra.peff.net>
References: <20231109070310.GA2697602@coredump.intra.peff.net>
 <cover.1699569246.git.me@ttaylorr.com>
 <af5fe3b7237caeba8f970e967933db96c83a230e.1699569246.git.me@ttaylorr.com>
 <xmqqedgyw6jv.fsf@gitster.g>
 <ZU5Z/Z4PcdNP5U1r@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZU5Z/Z4PcdNP5U1r@nand.local>

On Fri, Nov 10, 2023 at 11:27:41AM -0500, Taylor Blau wrote:

> Hmm. I was thinking of Peff's "commit-graph: handle overflow in
> chunk_size checks", but I think that I was overly eager in applying the
> same reasoning to the MIDX code.
> 
> The important piece of the rationale in that patch is as follows:
> 
>     In the current code this is only possible for the CDAT chunk, but
>     the reasons are quite subtle. We compute g->num_commits by dividing
>     the size of the OIDL chunk by the hash length (since it consists of
>     a bunch of hashes). So we know that any size_t multiplication that
>     uses a value smaller than the hash length cannot overflow. And the
>     CDAT records are the only ones that are larger (the others are just
>     4-byte records). So it's worth fixing all of these, to make it clear
>     that they're not subject to overflow (without having to reason about
>     seemingly unrelated code).
> 
> In particular, that g->num_commits is computed by dividing the length of
> the OIDL chunk by the hash length, thus any size_t multiplication of
> g->num_commits with a value smaller than that hash length cannot
> overflow.
> 
> But I don't think we enjoy the same benefits in the MIDX scenario. In
> this case, the num_objects field is just:
> 
>     m->num_objects = ntohl(m->chunk_oid_fanout[255])
> 
> so I don't think we can make the same guarantees about what is and isn't
> save to compute under size_t arithmetic.

Yes, the logic does not apply to the midx code (just like the graph code
after we switch to using the fanout value later in my series). But that
paragraph was just explaining why only the CDAT chunk was _currently_
vulnerable.

The more interesting question is the paragraphs after that, about
whether it is OK to die() or not when we see overflow (and IMHO it is
not for commit-graphs).

The situation _is_ different there for midx's, because we immediately
die() if we see a bogus midx anyway. But I think that is wrong, and
something we may want to change in the long run. Both because it's the
wrong thing for lib-ification, but also because we can easily keep going
if the midx is broken; we can still use the individual pack idx files.

> I'd be curious what Peff has to say, but if he agrees with me, I'd
> recommend taking the first five patches, and dropping the two
> MIDX-related ones.

I think dropping those is a bad direction. The point of adding
pair_chunk_expect() is that we could use it consistently.

-Peff
