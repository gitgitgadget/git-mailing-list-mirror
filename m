Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA0BB1F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 05:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfJaFhf (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 01:37:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:34628 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726321AbfJaFhe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 01:37:34 -0400
Received: (qmail 11013 invoked by uid 109); 31 Oct 2019 05:37:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 Oct 2019 05:37:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27071 invoked by uid 111); 31 Oct 2019 05:40:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Oct 2019 01:40:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Oct 2019 01:37:33 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Davide Berardi <berardi.dav@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Segmentation fault on non-commit objects.
Message-ID: <20191031053733.GA10050@sigill.intra.peff.net>
References: <20191029092735.GA84120@carpenter.lan>
 <20191029140621.GC2843@sigill.intra.peff.net>
 <xmqqbltz3qbc.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbltz3qbc.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 30, 2019 at 11:44:23AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This is definitely a strict improvement over the current behavior
> > (though I agree with Dscho's comments on the error message). A few
> > further thoughts:
> >
> >   - we'll have successfully completed the rest of the clone at this
> >     point. Should we leave the objects and refs in place to allow the
> >     user to fix it up, as we do when "git checkout" fails?
> >
> >     We'd have to leave _something_ in HEAD for it to be a valid repo. I
> >     guess just "refs/heads/master" would be fine, or perhaps we could
> >     fall back to whatever the other side had in their HEAD (i.e.,
> >     pretending that "-b" wasn't specified).
> 
> Do we know for sure that the object at HEAD on the other side is a
> commit, or do we need to prepare for a case where it is not?  I
> suspect it is the latter.  HEAD needs to exist and point at a ref
> that is in refs/heads/ hierarchy, and the ref can even be unborn, so
> falling back on 'master' sounds like a good position.

Yeah, I don't think that we do. This is the same as the case I mentioned
later, and it should be handled in all three arms of the conditional.

Davide, do you have an interest in trying to make these code paths a bit
more robust?

-Peff
