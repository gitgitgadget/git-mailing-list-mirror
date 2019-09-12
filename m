Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB09F1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 13:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbfILN7x (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 09:59:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:47836 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731455AbfILN7x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 09:59:53 -0400
Received: (qmail 13517 invoked by uid 109); 12 Sep 2019 13:59:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Sep 2019 13:59:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7958 invoked by uid 111); 12 Sep 2019 14:01:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Sep 2019 10:01:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Sep 2019 09:59:52 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] upload-pack: disable commit graph more gently for
 shallow traversal
Message-ID: <20190912135952.GB23031@sigill.intra.peff.net>
References: <20190912000414.GA31334@sigill.intra.peff.net>
 <20190912020748.GA76228@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190912020748.GA76228@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 11, 2019 at 10:07:48PM -0400, Taylor Blau wrote:

> > The new test in t5500 triggers this segfault, but see the comments there
> > for how horribly intimate it has to be with how both upload-pack and
> > commit graphs work.
> 
> Thanks for the comment, too. I agree that protocol-level hacking is
> somewhat smelly, at least as far as t5500 is concerned, but for this
> particular case it seems the only sensible option.
> 
> I'm still left scratching my (sore) head about how someone triggered
> this in production, but maybe that's a riddle for another day.

I'll admit that part of my motivation was my inability to generate a
working case just using Git commands (so my justification is that if
it's so hard to do, then the test is inherently fragile, but you can
also just accuse me of being lazy).

I think the key is something to do with the shape of history related to
the requests, such that we walk over a commit during the have
negotiation, but then also need to walk over it during the deepen-since.
So maybe I am just missing something obvious, or maybe it just needs to
be a deeper history. I do like that the case I showed is the minimal
history, at least.

> > +# A few subtle things about the request in this test:
> > +#
> > +#  - the server must have commit-graphs present and enabled
> 
> I think "enabled" may be somewhat redundant, at least since some recent
> changes to enable this by default. (As an aside, I tried to dig up the
> patches that Stolee sent to actually enable this and back up my claim,
> but I couldn't find them on 'master'. I'm not sure if that's my poor use
> of 'git log', or misremembering the fact that these were enabled by
> default.)

Yeah, it is redundant these days. I figured this might go to 'maint',
though, and 31b1de6a09 (commit-graph: turn on commit-graph by default,
2019-08-13) is only in master.

> > +#    latter will try to lod it lazily.
> 
> s/lod/load

Thanks, fixed.

> > +#
> > +#  - we must use protocol v2, because it handles the "have" negotiation before
> > +#    processing the shallow direectives
> > +#
> > +test_expect_success 'shallow since with commit graph and already-seen commit' '
> > +	test_create_repo shallow-since-graph &&
> > +	(
> 
> I'm not sure if this same-level indentation is common, or you're missing
> an extra tab here. Either way.

It's not common, but I was matching the surrounding tests for style (and
use of a separate repo, and non-use of test_config).

> > diff --git a/upload-pack.c b/upload-pack.c
> > index 222cd3ad89..a260b6b50d 100644
> > --- a/upload-pack.c
> > +++ b/upload-pack.c
> > @@ -722,7 +722,7 @@ static void deepen_by_rev_list(struct packet_writer *writer, int ac,
> >  {
> >  	struct commit_list *result;
> >
> > -	close_commit_graph(the_repository->objects);
> > +	disable_commit_graph();
> 
> This line made me think to check if we could remove 'close_commit_graph'
> all together, but there is a remaining callsite in packfile.c, and
> closing the commit-graph _is_ the right thing to do there, so I think we
> ought to keep it around.

Yeah, it's sort of inherently dangerous, as it doesn't scrub any
in-memory commit structs that are in this "have a graph_pos but not
maybe_tree" state.

The call in close_object_store() is probably fine, though, as the whole
point there is getting rid of everything related to the object store.
And since 14ba97f81c (alloc: allow arbitrary repositories for alloc
functions, 2018-05-15) or thereabouts, that includes the object structs.

There's another call in write_commit_graph_file(), right before we
rename a new file into place. This generally happens in a separate
"commit-graph write" process, so I think it's OK.  But it could
eventually happen as part of another process, which would maybe be a
problem. I'm actually not convinced the in-memory one needs to be closed
here, but maybe it's a Windows thing (closing the file before renaming
over it)?

-Peff
