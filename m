Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AB111F991
	for <e@80x24.org>; Thu,  3 Aug 2017 17:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbdHCRAG (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 13:00:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:57092 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751966AbdHCRAE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 13:00:04 -0400
Received: (qmail 1692 invoked by uid 109); 3 Aug 2017 17:00:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 03 Aug 2017 17:00:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20717 invoked by uid 111); 3 Aug 2017 17:00:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 03 Aug 2017 13:00:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Aug 2017 13:00:02 -0400
Date:   Thu, 3 Aug 2017 13:00:02 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH DONOTAPPLY 5/4] revision: let --stdin set rev_input_given
Message-ID: <20170803170002.qogk3ezvhgumnyi7@sigill.intra.peff.net>
References: <20170802222425.7xkoxniz2xbjlnku@sigill.intra.peff.net>
 <20170802223416.gwiezhbuxbdmbjzx@sigill.intra.peff.net>
 <xmqq3798r6ai.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq3798r6ai.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 03, 2017 at 08:59:33AM -0700, Junio C Hamano wrote:

> >   (echo --; echo t) | git log --stdin
> >
> > no longer defaults to HEAD. Which maybe people would see as a
> > regression. I could see arguments either way.
> 
> Yeah, thanks for thinking this through.  I do think this would be a
> regression.  On the other hand,
> 
>     (printf "%s\n" --tags=no-such -- t) | git log --stdin
> 
> should not default to HEAD and show nothing, I would think.

That was the same conclusion I got to, but it actually doesn't matter,
because we don't allow it anyway:

  $ echo --tags=no-such | git log --stdin
  fatal: options not supported in --stdin mode

If we were to make that work later, it should automatically do the right
thing with respect to rev_input_given, since the stdin code would just
call into handle_revision_arg().

> So if we wanted to do the "--stdin" thing properly, we probably need
> to keep the "--stdin" option itself neutral wrt "did we get rev
> input?"; instead, each input item that comes in from the standard
> input stream would decide if the user wants us to fall back to the
> default, perhaps?

Yes, exactly. It is a shame that scripts can't rely on an empty input to
"rev-list --stdin" to produce a empty output, though. That seems like it
would be handy. On the other hand, nobody has complained about it in the
past 10 years, so perhaps it just doesn't come up.

> Hmph.  Do you mean the former should traverse from HEAD while the
> latter should give us empty in the following two, because unlike
> "log", "rev-list" does not do the "default to HEAD" thing if it is
> not told to do so?
> 
>     git rev-list --default HEAD --stdin </dev/null
>     git rev-list --stdin </dev/null
> 
> If so, I think the reasoning makes sense.

TBH, I think both would make sense with an empty output. But it looks
like filter-branch is relying on the former to show HEAD. But like I
said, I didn't dig into whether its expectation is sane. If anybody is
interested in digging further you can apply the --stdin patch in this
thread and run t7003.

> > I didn't dig enough to see if it's actually sane or
> > not. The failing tests seem to be weird noop filters that our test
> > script uses. But I'm worried it would break some real case, too.
> 
> Thanks.  Let's not rush things.  
> 
> The ones you sent for application 1-4/4 all are improvements.

Thanks. I agree that is probably an OK stopping point, as the --stdin
behavior is largely orthogonal (it just happens to be in the same
general area).

-Peff
