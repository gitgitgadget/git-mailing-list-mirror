Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A9651F404
	for <e@80x24.org>; Wed, 12 Sep 2018 21:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeIMCkf (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 22:40:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:47396 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727007AbeIMCkf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 22:40:35 -0400
Received: (qmail 12766 invoked by uid 109); 12 Sep 2018 21:34:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Sep 2018 21:34:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29300 invoked by uid 111); 12 Sep 2018 21:34:23 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 12 Sep 2018 17:34:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Sep 2018 17:34:08 -0400
Date:   Wed, 12 Sep 2018 17:34:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] commit-reach: properly peel tags
Message-ID: <20180912213407.GA27598@sigill.intra.peff.net>
References: <pull.39.git.gitgitgadget@gmail.com>
 <948e222228d2f2868b85a425142382e63a17773a.1536762173.git.gitgitgadget@gmail.com>
 <xmqqpnxijtpd.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpnxijtpd.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 12, 2018 at 02:23:42PM -0700, Junio C Hamano wrote:

> > diff --git a/commit-reach.c b/commit-reach.c
> > index 86715c103c..6de72c6e03 100644
> > --- a/commit-reach.c
> > +++ b/commit-reach.c
> > @@ -544,20 +544,31 @@ int can_all_from_reach_with_flag(struct object_array *from,
> >  {
> >  	struct commit **list = NULL;
> >  	int i;
> > +	int nr_commits;
> >  	int result = 1;
> >  
> >  	ALLOC_ARRAY(list, from->nr);
> > +	nr_commits = 0;
> >  	for (i = 0; i < from->nr; i++) {
> > -		list[i] = (struct commit *)from->objects[i].item;
> > +		struct object *from_one = from->objects[i].item;
> >  
> > -		if (parse_commit(list[i]) ||
> > -		    list[i]->generation < min_generation)
> > -			return 0;
> > +		from_one = deref_tag(the_repository, from_one,
> > +				     "a from object", 0);
> > +		if (!from_one || from_one->type != OBJ_COMMIT) {
> > +			from->objects[i].item->flags |= assign_flag;
> 
> I wondered why this is not futzing with "from_one->flags"; by going
> back to the original from->objects[] array, the code is setting the
> flags on the original tag object and not the non-commit object that
> was pointed at by the tag.

Note that from_one may even be NULL.

> > +			continue;
> > +		}
> > +
> > +		list[nr_commits] = (struct commit *)from_one;
> > +		if (parse_commit(list[nr_commits]) ||
> > +		    list[nr_commits]->generation < min_generation)
> > +			return 0; /* is this a leak? */
> > +		nr_commits++;
> >  	}
> 
> In the original code, the flags bits were left unchanged if the loop
> terminated by hitting a commit whose generation is too young (or
> parse_commit() returns non-zero).  With this updated code, flags bit
> can be modified before the code notices the situation and leave the
> function, bypassing the "cleanup" we see below that clears the
> "assign_flag" bits.
> 
> Would it be a problem that we return early without cleaning up?
> 
> Even if we do not call this early return, the assign_flag bits added
> to the original tag in from->objects[i].item won't be cleaned in
> this new code, as "cleanup:" section now loops over the list[] that
> omits the object whose flags was smudged above before the "continue".
> 
> Would it be a problem that we leave the assign_flags without
> cleaning up?

Yeah, I hadn't thought about the bit cleanup when making my original
suggestion. In the original code (before 4fbcca4eff), I think we did set
flags as we iterated through the loop, and we could still do an early
return when we hit "!reachable(...)". But I don't see any cleanup of
assign_flag there at all.

So I guess I'm pretty confused about what the semantics are supposed to
be.

-Peff
