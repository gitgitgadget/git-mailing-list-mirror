Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC26E20248
	for <e@80x24.org>; Sat, 23 Feb 2019 13:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfBWNoz (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 08:44:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:55536 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726422AbfBWNoz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 08:44:55 -0500
Received: (qmail 22973 invoked by uid 109); 23 Feb 2019 13:44:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Feb 2019 13:44:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4239 invoked by uid 111); 23 Feb 2019 13:45:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 23 Feb 2019 08:45:08 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Feb 2019 08:44:53 -0500
Date:   Sat, 23 Feb 2019 08:44:53 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Bartosz Baranowski <bbaranow@redhat.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] bisect: make diff-tree output prettier
Message-ID: <20190223134452.GE22403@sigill.intra.peff.net>
References: <20190222061949.GA9875@sigill.intra.peff.net>
 <20190222062327.GC10248@sigill.intra.peff.net>
 <xmqqsgwfr9vr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsgwfr9vr.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 09:49:44AM -0800, Junio C Hamano wrote:

> > Even though bisect might be driven by scripts, there's no reason to
> > consider this part of the output as machine-readable (if anything, the
> > initial "$hash is the first bad commit" might be parsed, but we won't
> > touch that here). Let's make it prettier and more informative for a
> > human reading the output.
> 
> Sounds very sensible.  One potential point that makes me worried is
> this move might tempt people to make the output even larger (e.g. a
> full diff with "--patch" is overkill if done unconditionally).

Yeah, I agree that would be overkill. What I have here isn't actually
much bigger. It mostly trades one line of --raw for one line of --stat.
The big change is that we actually bother to recurse, but I think the
old behavior was just buggy.

At any rate, I think we can discuss such a patch if and when it comes
up.

> > If we do care about the change in exit code from bisect, then it
> > probably does make sense to go with an external process. Then it can
> > happily die on the corruption, while bisect continues with the rest of
> > the high-level operation. I'm not sure it really matters much, though.
> > Once your repository is corrupted, all bets are off. It's nice that we
> > can bisect in such a state at all.
> 
> This is about showing the very final message after finding which one
> is the culprit.  Is there any other "clean-up" action we need to do
> after showing the message?  I do not care too much about the exit
> code from the bisection, but if dying from diff-tree can interfere
> with such a clean-up, that would bother me a lot more, and at that
> point, given especially that this is not a performance sensitive
> thing at all (it is not even invoked log(n) times---just once at the
> end), moving to external process may make it a lot simpler and
> cleaner.

Thanks, I had a vague feeling along these lines, but you nicely put it
into words. As far as I can tell, no, we're not missing any important
cleanup in that process; it looks like the only call to show_diff_tree()
then calls exit(10) immediately after.

However, that does change our exit code, which git-bisect.sh then
propagates instead of writing the entry into the BISECT_LOG.

I'm still not convinced this is really worth caring about, as it implies
a corrupt repo. But if we did want to fix it, then I think the external
diff-tree would still be the right thing (since it's hard for
git-bisect.sh to tell the different between this death and another one).

-Peff
