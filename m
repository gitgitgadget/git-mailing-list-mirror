Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DD2C209FA
	for <e@80x24.org>; Fri, 14 Apr 2017 00:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754005AbdDNA7c (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 20:59:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:33321 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753351AbdDNA7b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 20:59:31 -0400
Received: (qmail 450 invoked by uid 109); 14 Apr 2017 00:59:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Apr 2017 00:59:27 +0000
Received: (qmail 28876 invoked by uid 111); 14 Apr 2017 00:59:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Apr 2017 20:59:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Apr 2017 20:59:25 -0400
Date:   Thu, 13 Apr 2017 20:59:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@jeffhostetler.com, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3] unpack-trees: avoid duplicate ODB lookups during
 checkout
Message-ID: <20170414005924.sfu4csdxaoafipsv@sigill.intra.peff.net>
References: <20170413155852.4281-1-git@jeffhostetler.com>
 <20170413155852.4281-2-git@jeffhostetler.com>
 <xmqqtw5roqcc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtw5roqcc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 04:11:31PM -0700, Junio C Hamano wrote:

> git@jeffhostetler.com writes:
> 
> > +	/*
> > +	 * Fetch the tree from the ODB for each peer directory in the
> > +	 * n commits.
> > +	 *
> > +	 * For 2- and 3-way traversals, we try to avoid hitting the
> > +	 * ODB twice for the same OID.  This should yield a nice speed
> > +	 * up in checkouts and merges when the commits are similar.
> > +	 *
> > +	 * We don't bother doing the full O(n^2) search for larger n,
> > +	 * because wider traversals don't happen that often and we
> > +	 * avoid the search setup.
> > +	 *
> > +	 * When 2 peer OIDs are the same, we just copy the tree
> > +	 * descriptor data.  This implicitly borrows the buffer
> > +	 * data from the earlier cell.
> 
> This "borrowing" made me worried, but it turns out that this is
> perfectly OK.
> 
> fill_tree_descriptor() uses read_sha1_file() to give a tree_desc its
> own copy of the tree object data, so the code that calls into the
> tree traversal API is responsible for freeing the buffer returned
> from fill_tree_descriptor().  The updated code avoids double freeing
> by setting buf[i] to NULL for borrowing [i].

Yeah, I think that logic is fine. We could also keep a separate counter
for the size of buf, like:

  buf[nr_buf++] = fill_tree_descriptor(t+i, sha1);

and then just count from zero to nr_buf in the freeing loop. I don't
think it matters much either way (the free(NULL) calls are presumably
cheap).

-Peff
