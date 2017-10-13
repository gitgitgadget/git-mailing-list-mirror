Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BC4120372
	for <e@80x24.org>; Fri, 13 Oct 2017 01:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753575AbdJMBrY (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 21:47:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:51736 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753327AbdJMBrX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 21:47:23 -0400
Received: (qmail 15718 invoked by uid 109); 13 Oct 2017 01:47:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 01:47:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22458 invoked by uid 111); 13 Oct 2017 01:47:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 21:47:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Oct 2017 21:47:21 -0400
Date:   Thu, 12 Oct 2017 21:47:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] color: downgrade "always" to "auto" only for on-disk
 configuration
Message-ID: <20171013014721.d4vesqv4v5j7tmk2@sigill.intra.peff.net>
References: <xmqqr2uao2vy.fsf@gitster.mtv.corp.google.com>
 <20171012021007.7441-1-gitster@pobox.com>
 <20171012021007.7441-2-gitster@pobox.com>
 <20171012123153.i265nun6pklw7kjg@sigill.intra.peff.net>
 <xmqqinfjykm2.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqinfjykm2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 13, 2017 at 09:09:09AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... Also
> > as an aside, I think this patch means that:
> >
> >   git -c color.ui=always add -p
> >
> > is broken (as would a hypothetical "git --default-color=always add -p").
> > That's sufficiently insane that I'm not sure we should care about it.
> 
> Do you mean that "'-c color.ui=always' from the command line is
> passed down to the invocations of 'git' the 'add' command makes, and
> would break output from 'diff-index' that 'add -i' wants to parse"?

Yes, exactly.

> With the breakage that motivated "downgrade only for on-disk" change
> in mind, I do think that is the right behaviour.  Those third-party
> scripts we broke knew how '-c color.ui=always' works and depended on
> it, and I consider that the command line configuration getting
> passed around as an integral part of 'how it works'.  "Fixing" it
> will break them again.

Yeah, agreed. We cannot know what the script is expecting, so without
that we cannot win, short of turning off color.ui entirely for plumbing.

> Let's take it as a signal that tells us that the script writers know
> what they are doing and leave it as a longish rope they can play with.

OK. For the record, I'm not against scrapping this whole thing and
trying to rollback to your "plumbing never looks at color.ui" proposal.
It's quite late in the -rc cycle to do that, but there's nothing that
says we can't bump the release date if that's what we need to do to get
it right.

If we ship v2.15 with the "color.ui=always really means auto", I don't
think we'd want to undo that. So if we ship with what's in -rc1 (plus
this new hack on top) I think that would be fairly final.

-Peff
