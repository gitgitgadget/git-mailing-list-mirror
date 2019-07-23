Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 611581F461
	for <e@80x24.org>; Tue, 23 Jul 2019 19:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391731AbfGWTkL (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 15:40:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:49586 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730048AbfGWTkL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 15:40:11 -0400
Received: (qmail 9936 invoked by uid 109); 23 Jul 2019 19:40:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Jul 2019 19:40:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12544 invoked by uid 111); 23 Jul 2019 19:41:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jul 2019 15:41:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Jul 2019 15:40:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     thibault.jamet@gmail.com, git@vger.kernel.org,
        thibault.jamet@adevinta.com
Subject: Re: [PATCH] Close transport helper on protocol error
Message-ID: <20190723194009.GB3879@sigill.intra.peff.net>
References: <20190722212250.44011-1-thibault.jamet@gmail.com>
 <xmqq5znsu04p.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5znsu04p.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 23, 2019 at 10:33:10AM -0700, Junio C Hamano wrote:

> > +		if (recvline(data, &buf)){
> > +			release_helper(transport);
> >  			exit(128);
> > +		}
> 
> This, together with other exit(128) we see in this patch now have
> release_helepr() in front of it, which is in line with what the log
> message claims that the patch does.
> 
> I however wonder if we want to do a bit more, perhaps with atexit().
> I am not hinting-suggesting to do so (as you said, if the init
> process ought to take care of the zombies, the patch under review
> might already be unneeded, and atexit() makes things even worse),
> but having trouble to convince that this patch stops at the right
> place.

I was just writing a similar comment when I read this. It probably fixes
the particular case the OP saw, but Git is quite happy to die() in
various code-paths when it encounters an error.

Rather than try to annotate every possible exit, atexit() might be a
better solution. But isn't this a more general problem even than that?
Lots of parts of Git may spawn a sub-process and assume that the
children will be reaped automatically (as long as they do exit, but that
is usually guaranteed by us closing their input pipes when we ourselves
exit).

So I think you'd have to atexit() quite a few places. Or possibly
instrument run_command() to do so, though it might need some extra
annotation to mark whether a particular sub-process should be waited for
(there is some prior art in the child_process.clean_on_exit option).

At which point I do wonder if this is better handled by a wrapper
process which simply reaps everything. And indeed, people have already
come up with similar solutions for containers:

  https://github.com/Yelp/dumb-init

So I dunno. I am not really opposed to this patch, as it is just adding
some extra cleanup. But it seems like it is really hitting the tip of
the iceberg, and I'm not sure it's an iceberg I'd like to get to the
bottom of.

-Peff
