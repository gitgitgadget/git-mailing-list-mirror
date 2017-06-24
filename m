Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63EDD20401
	for <e@80x24.org>; Sat, 24 Jun 2017 20:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754814AbdFXUck (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 16:32:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:52060 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751586AbdFXUcj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 16:32:39 -0400
Received: (qmail 25759 invoked by uid 109); 24 Jun 2017 20:32:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 24 Jun 2017 20:32:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25218 invoked by uid 111); 24 Jun 2017 20:32:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 24 Jun 2017 16:32:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Jun 2017 16:32:37 -0400
Date:   Sat, 24 Jun 2017 16:32:37 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: Re: [PATCH v5 5/5] convert: add "status=delayed" to filter process
 protocol
Message-ID: <20170624203237.tmismuaits5pi7vq@sigill.intra.peff.net>
References: <20170601082203.50397-1-larsxschneider@gmail.com>
 <20170601082203.50397-6-larsxschneider@gmail.com>
 <20170624141941.usy2pyhid3jrf3ku@sigill.intra.peff.net>
 <A8FAEFDC-1ADA-4355-80DC-069A739F829C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A8FAEFDC-1ADA-4355-80DC-069A739F829C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 24, 2017 at 07:22:40PM +0200, Lars Schneider wrote:

> > It might be worth giving a reason in this last paragraph. I think the
> > reason is "because it's more complicated for the caller, as they have to
> > be OK with out-of-order processing and remembering to go back and handle
> > the delayed cases".
> 
> Correct! However, my real reason was that these code paths process all
> files of the tree. Therefore the "out-of-order" processing can be
> effective. 
> 
> How about this:
> 
> Git has a multiple code paths that checkout a blob. Support delayed
> checkouts only in `clone` (in unpack-trees.c) and `checkout` operations
> for now. The optimization is most effective in these code paths as all 
> files of the tree are processed.

Sounds good.

> > Why do we need to tell the filter we know about delay? Shouldn't it just
> > need to tell us that it knows about delay, and then we choose whether to
> > ask for can-delay for particular entries?
> 
> Because in the protocol I defined that the filter needs to answer with
> a strict subset of this list [1]. I thought that this would make the protocol
> more future proof/backward compatible. Because the filter is not allowed to
> answer with something that Git does not understand.
> 
> [1] https://github.com/git/git/blob/5402b1352f5181247405fbff1887008a0cb3b04a/Documentation/gitattributes.txt#L408-L411

OK. That makes sense, then.

> > The operator precedence is such that it works without them, so this is
> > just a style question (I'd also usually put the flags field before the
> > flag itself, but that's really getting into aesthetics).
> 
> You mean (entry & CAP_DELAY) instead of (CAP_DELAY & entry)?

Yes, exactly.

> How about this?
> 
> 	errs |= dco->paths.nr;
> 	for_each_string_list_item(path, &dco->paths) {
> 		warning("%s was not processed properly.", path->string);
> 	}
> 	string_list_clear(&dco->paths, 0);
> 
> The output would be:
> 
> warning: test-delay10.a was not processed properly.
> warning: test-delay10.b was not processed properly.
> warning: test-delay11.a was not processed properly.
> warning: test-delay20.a was not processed properly.
> fatal: unable to checkout working tree
> warning: Clone succeeded, but checkout failed.
> You can inspect what was checked out with 'git status'
> and retry the checkout with 'git checkout -f HEAD'

I think it may make sense to use something more specific than
"processed". The user might not even be thinking about filters during
their operation. It would be really nice if we could mention the name of
the filter. As you noted, we don't have it here but I wonder how hard it
would be. Anyway, I'm OK with leaving it more vague for now.

> I contemplated about the warning text.
> "$FILE was not filtered properly." is technical more
> correct but maybe it would confuse the user?

I like it better because "filter" is a word the user might associate
with the filter feature. Whereas "processed" is vague and could mean
many things.

> > Hmm. This "reset the state" bit at the end surprised me. I guess it's
> > not wrong, but it goes against the mental model I had formed above. ;)
> > 
> > We really are using dco->state as a per-entry state flag. It just
> > happens to be in a persistent shared struct. I don't think it's wrong,
> > it was mostly just surprising. I don't know if it's worth trying to
> > simplify, but I think you could do it by:
> > 
> >  1. Passing back the "was delayed" state from async_convert... in the
> >     return value or via a separate out-parameter.
> 
> In the beginning I had it implemented that way. But that meant that I
> had to pass two variables through the entire convert stack:
> 
> async_convert_to_working_tree
> -> convert_to_working_tree_internal
> --> apply_filter
> ---> apply_multi_file_filter

Right, I see. I wonder if just a comment in the definition of the
delayed_checkout struct would make it more clear exactly how we expect
the member to be used.

> >  2. Setting dco->state to CE_RETRY at the top of finish_delayed... so
> >     that it's clear that it's about what phase of the conversation
> >     we're in.
> 
> I could do that. However, I thought it is safer to set the state *before*
> every checkout operation in case convert.c messes with this field (it
> should not in this phase).
>
> > But I'm OK with it as-is, too.
> 
> I'll try 2.

I think you'd have to do (1) and (2) together. But if it causes pain, I
think the comment I suggested above may be the simplest way to go.

> Thanks a lot for the review,

You're welcome. The bits of your response I didn't quote all made sense
to me.

-Peff
