Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6649CDB465
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 23:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbjJKXWV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 19:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbjJKXWU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 19:22:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A3AA4
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 16:22:19 -0700 (PDT)
Received: (qmail 20634 invoked by uid 109); 11 Oct 2023 23:22:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Oct 2023 23:22:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11300 invoked by uid 111); 11 Oct 2023 23:22:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Oct 2023 19:22:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Oct 2023 19:22:17 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 12/20] commit-graph: check size of commit data chunk
Message-ID: <20231011232217.GL518221@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009210536.GL3282181@coredump.intra.peff.net>
 <ZSbthK5919QdrEPx@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZSbthK5919QdrEPx@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2023 at 02:46:28PM -0400, Taylor Blau wrote:

> > +static int graph_read_commit_data(const unsigned char *chunk_start,
> > +				  size_t chunk_size, void *data)
> > +{
> > +	struct commit_graph *g = data;
> > +	if (chunk_size != g->num_commits * GRAPH_DATA_WIDTH)
> 
> Should this be guarded with an st_mult? I think that GRAPH_DATA_WIDTH is
> defined as (the_hash_algo->rawsz + 16), so I *think* that the expression
> in the parenthesis would get done as a size_t, and then g->num_commits
> would be widened to a size_t for the purposes of evaluating this
> expression.
> 
> So I think that this is all OK in the sense that we'd never underflow
> the 64-bit space, and having more than 2^64-1/36 (some eighteen
> quintillion) commits is... unlikely ;-).

Hmm, yeah, I think you are right, but I agree it's awfully subtle. There
is no reason somebody couldn't later change "rawsz" to a smaller type
(after all, we know it's going to be tiny), and it would be quite
surprising if that introduces an overflow in far-away code. We should
protect ourselves here.

-Peff
