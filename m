Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2BBC2BA1A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 04:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B73B20767
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 04:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgDXEc1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 00:32:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:38356 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725776AbgDXEc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 00:32:26 -0400
Received: (qmail 19621 invoked by uid 109); 24 Apr 2020 04:32:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 Apr 2020 04:32:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16628 invoked by uid 111); 24 Apr 2020 04:43:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Apr 2020 00:43:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Apr 2020 00:32:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] blame: drop unused parameter from maybe_changed_path
Message-ID: <20200424043225.GB1648190@coredump.intra.peff.net>
References: <20200423210303.GA1635761@coredump.intra.peff.net>
 <xmqqk125g9ze.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk125g9ze.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 23, 2020 at 02:36:53PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We don't use the "parent" parameter at all (probably because the bloom
> > filter for a commit is always defined against a single parent anyway).
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > This is on top of ds/blame-on-bloom, which just made it to next.
> >
> > I _think_ this is the right solution, but perhaps the function should be
> > verifying that we're looking at the right parent?
> 
> Hmph, "solution" to what problem?  Ah, the fact that parent is an
> unused parameter?

Yes, exactly.

> find_origin() runs a tree-diff over "parent" and "origin->commit",
> with literal pathspec limited to the single path.
> 
> And the Bloom filter addition changed the code so that we first
> consult the filter when "origin->commit"'s first parent *is*
> "parent".  Presumably, by asking maybe_changed_path about "origin",
> as "origin" knows what the commit is (i.e. "origin->commit") and
> what path we are talking about (i.e. "origin->path"), it can answer
> "does origin->commit change origin->path relative to its first
> parent?" and it can do so only for the first parent?
> 
> The way I read bloom.c::get_bloom_filter(), it only computes a
> diff-tree between the given commit and its first parent (or an empty
> tree), so I think the above is correct.

Yeah, the bloom filters are always against the first parent. I think I
just got lost in this rather long oidcmp(), which is really just "is
'parent' the first parent?"

	if (origin->commit->parents &&
	    !oidcmp(&parent->object.oid,
		    &origin->commit->parents->item->object.oid))
		compute_diff = maybe_changed_path(r, origin, bd);

If the bloom filter also computes against an empty tree for root
commits (I didn't check, but that would make sense), I think that AND
could be an OR:

   if (!origin->commit->parents ||
       !oidcmp(...))

though it probably doesn't matter that much in practice. Root commits
are rather rare.

BTW, we could also be using oideq() here. I thought coccicheck would
note this, but it doesn't seem to. I suspect we could also get away with
a direct pointer comparison of "parent == origin->commit->parents->item"
due to the way we allocate "struct commit", but I'd rather err on the
safer and less subtle side. :)

-Peff
