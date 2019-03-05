Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2FE820248
	for <e@80x24.org>; Tue,  5 Mar 2019 04:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfCEE0E (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 23:26:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:38806 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726522AbfCEE0D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 23:26:03 -0500
Received: (qmail 747 invoked by uid 109); 5 Mar 2019 04:26:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Mar 2019 04:26:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28595 invoked by uid 111); 5 Mar 2019 04:26:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Mar 2019 23:26:20 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Mar 2019 23:26:01 -0500
Date:   Mon, 4 Mar 2019 23:26:01 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc/fsck: discuss mix of --connectivity-only and
 --dangling
Message-ID: <20190305042601.GF19800@sigill.intra.peff.net>
References: <20190227145549.GA3255@sigill.intra.peff.net>
 <20190227145928.GA3727@sigill.intra.peff.net>
 <xmqqlg1z9uko.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlg1z9uko.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 01, 2019 at 11:50:31AM +0900, Junio C Hamano wrote:

> > I'm actually a little torn on this. We could consider this a bug, and
> > the "option" to disable it when you want things to go fast is to say
> > "--no-dangling". That leaves no way to say "show me the list of
> > unreachable objects, but don't bother spending extra time on dangling
> > analysis". But I don't think I've ever really wanted that list of
> > unreachable objects anyway (and besides, you could do it pretty easily
> > with cat-file, rev-list, and comm).
> >
> > So I sketched up what it might look like to just fix the bug (but kick
> > in only when needed), which is below.
> 
> As the primariy purose of the --conn-only option being such, perhaps
> we should have made --no-dangling the default when --conn-only is in
> effect.

Yes, perhaps. Though after thinking on this for a few days, I actually
think there is no real reason not to just have --dangling do the right
thing here (and we're still much faster than a full fsck, and not much
slower than the current code unless you happen to have a large number
of unreachable commits and trees).

And then if the user says "--no-dangling", we can be even faster (i.e.,
the same as the current code).

We could also make "--no-dangling" the default for
"--connectivity-only", though I do not have a strong feeling either way.

> But if --conn-only is made to do the right thing while showing
> dangling and unreachable properly sifted into their own bins, like
> this patch does, what's the difference between that and the normal
> --no-conn-only, other than performance and corrupt blobs left
> unreported?  Perhaps if we are going that route, it might even make
> sense to rename --conn-only to --skip-parsing-blobs or something.

In addition to not opening blobs, we won't actually do fsck checks on
any of the objects. So in git.git, for instance, we do not warn about
the missing tagger in the v0.99 tag when --connectivity-only is in use.

-Peff
