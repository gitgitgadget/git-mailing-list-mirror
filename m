Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 980241F453
	for <e@80x24.org>; Tue, 18 Sep 2018 17:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbeIRXD4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 19:03:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:52268 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729037AbeIRXD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 19:03:56 -0400
Received: (qmail 7536 invoked by uid 109); 18 Sep 2018 17:30:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Sep 2018 17:30:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9258 invoked by uid 111); 18 Sep 2018 17:30:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Sep 2018 13:30:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Sep 2018 13:30:18 -0400
Date:   Tue, 18 Sep 2018 13:30:18 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] gc: exit with status 128 on failure
Message-ID: <20180918173017.GD15470@sigill.intra.peff.net>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180717065151.GA177907@aiede.svl.corp.google.com>
 <20180717065416.GC177907@aiede.svl.corp.google.com>
 <20180717195946.GC26218@sigill.intra.peff.net>
 <20180917183336.GA4630@sigill.intra.peff.net>
 <20180917184012.GD140909@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180917184012.GD140909@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 11:40:12AM -0700, Jonathan Nieder wrote:

> > There's discussion elsewhere[1] of applying just up to patch 2.
> >
> > Do we still want to convert these cases to die() as their end-state?
> 
> IMHO yes, we do.  die() is the function that you can use to exit with
> a fatal error.
> 
> If we want to get rid of die(), that would be a tree-wide effort, not
> something that should hold up this patch.

But that was sort of my question. I think there are people who _do_ want
to get rid of most die() calls (like Dscho), and there is a tree-wide
effort that is happening slowly to lib-ify. Your patch goes in the
opposite direction.

That said, I think there are actually two cases in your patch.

The calls to "return error()" or even just "return -1" in cmd_gc() seem
like obvious candidates for die(). We're at the top of the stack, and
anybody lib-ifying at that level is going to need to extract bits into
reusable functions anyway.

I more wondered about helpers like report_last_gc_error() and
gc_before_repack().

> > It also makes the code more flexible and lib-ifiable (since the caller
> > can decide how to handle the errors). That probably doesn't matter much
> > since this is all static-local to builtin/gc.c,
> 
> Exactly.  I'm a strong believer in http://wiki.c2.com/?YouArentGonnaNeedIt.

I only half-agree that this is YAGNI. If it were "let's punt on making
this code friendlier to lib-ification", I'd agree more completely. But
it's actually taking an active step in the opposite direction.

I dunno. It's probably not worth spending too much more time discussing,
and I'm OK either way.  I mostly just wanted to raise the issue since
dropping patch 3 changes the balance to me.

-Peff
