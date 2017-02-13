Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D29681FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 23:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbdBMXFg (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 18:05:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:54598 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751079AbdBMXFg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 18:05:36 -0500
Received: (qmail 13956 invoked by uid 109); 13 Feb 2017 23:05:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Feb 2017 23:05:35 +0000
Received: (qmail 29487 invoked by uid 111); 13 Feb 2017 23:05:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Feb 2017 18:05:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Feb 2017 18:05:33 -0500
Date:   Mon, 13 Feb 2017 18:05:33 -0500
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w5h5dmluZCBBIC4=?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 4/5] stash: introduce new format create
Message-ID: <20170213230532.sr7lpl26mcfa4gfc@sigill.intra.peff.net>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170205202642.14216-1-t.gummerer@gmail.com>
 <20170205202642.14216-5-t.gummerer@gmail.com>
 <20170206155606.xgkmhg656vuc6uki@sigill.intra.peff.net>
 <20170211145127.GA23081@hank>
 <20170213215734.puoung6hhdifbgai@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170213215734.puoung6hhdifbgai@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2017 at 04:57:34PM -0500, Jeff King wrote:

> Yeah, I think your patch is actually fixing that case. But your search
> is only part of the story. You found somebody using "-m" explicitly, but
> what about somebody blindly calling:
> 
>   git stash create $*
> 
> That's now surprising to somebody who puts "-m" in their message.
> 
> > I *think* this regression is acceptable, but I'm happy to introduce
> > another verb if people think otherwise.
> 
> Despite what I wrote above, I'm still inclined to say that this isn't an
> important regression. I'd be surprised if "stash create" is used
> independently much at all.

Just thinking on this more...do we really care about "fixing" the
interface of "stash create"? This is really just about refactoring what
underlies the new "push", right?

So we could just do:

diff --git a/git-stash.sh b/git-stash.sh
index 6d629fc43..ee37db135 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -711,7 +711,7 @@ clear)
 	;;
 create)
 	shift
-	create_stash "$@" && echo "$w_commit"
+	create_stash -m "$*" && echo "$w_commit"
 	;;
 store)
 	shift

on top of your patch and keep the external interface the same.

It might be nice to clean up the interface for "create" to match other
ones, but from this discussion I think it is mostly a historical wart
for scripting, and we are OK to just leave its slightly-broken interface
in place forever.

I could go either way.

-Peff
