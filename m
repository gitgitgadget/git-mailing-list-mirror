Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A6F320A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 10:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeLKKzY (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 05:55:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:37986 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726630AbeLKKzE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 05:55:04 -0500
Received: (qmail 15022 invoked by uid 109); 11 Dec 2018 10:55:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Dec 2018 10:55:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4055 invoked by uid 111); 11 Dec 2018 10:54:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 11 Dec 2018 05:54:11 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2018 05:54:40 -0500
Date:   Tue, 11 Dec 2018 05:54:40 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        stolee@gmail.com
Subject: Re: [PATCH on master v2] revision: use commit graph in
 get_reference()
Message-ID: <20181211105439.GA8452@sigill.intra.peff.net>
References: <20181204224238.50966-1-jonathantanmy@google.com>
 <20181207215034.213211-1-jonathantanmy@google.com>
 <xmqqwooj5xpr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwooj5xpr.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 09, 2018 at 09:51:28AM +0900, Junio C Hamano wrote:

> > -static int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item)
> > +static struct commit *parse_commit_in_graph_one(struct repository *r,
> > +						struct commit_graph *g,
> > +						struct commit *shell,
> > +						const struct object_id *oid)
> 
> Now the complexity of the behaviour of this function deserves to be
> documented in a comment in front.  Let me see if I can get it
> correctly without such a comment by explaining the function aloud.
> 
> The caller may or may not have already obtained an in-core commit
> object for a given object name, so shell could be NULL but otherwise
> it could be used for optimization.  When shell==NULL, the function
> looks up the commit object using the oid parameter instead.  The
> returned in-core commit has the parents etc. filled as if we ran
> parse_commit() on it.  If the commit is not yet in the graph, the
> caller may get a NULL even if the commit exists.

Yeah, this was the part that took me a bit to figure out, as well. The
optimization here is really just avoiding a call to lookup_commit(),
which will do a single hash-table lookup. I wonder if that's actually
worth this more complex interface (as opposed to just always taking an
oid and then always returning a "struct commit", which could be old or
new).

-Peff
