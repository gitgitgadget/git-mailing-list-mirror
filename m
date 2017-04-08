Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30FD4209F1
	for <e@80x24.org>; Sat,  8 Apr 2017 22:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbdDHWNG (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 18:13:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:58684 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751466AbdDHWNF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 18:13:05 -0400
Received: (qmail 25815 invoked by uid 109); 8 Apr 2017 22:13:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Apr 2017 22:13:05 +0000
Received: (qmail 14914 invoked by uid 111); 8 Apr 2017 22:13:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Apr 2017 18:13:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Apr 2017 18:13:02 -0400
Date:   Sat, 8 Apr 2017 18:13:02 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: Tools that do an automatic fetch defeat "git push
 --force-with-lease"
Message-ID: <20170408221302.e7sv6cy4xayr2w7o@sigill.intra.peff.net>
References: <1491617750.2149.10.camel@mattmccutchen.net>
 <CACBZZX7MeX-6RHgh2Fa9+YL03mjxs8xmyE86HnVxBxjMYizcig@mail.gmail.com>
 <20170408092910.g5wl2ew4cfu7wzft@sigill.intra.peff.net>
 <CA+P7+xqfHDVKpVKVYbB-4kjb9ja+u4GVMwkTFrj0f0n_OXZfvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xqfHDVKpVKVYbB-4kjb9ja+u4GVMwkTFrj0f0n_OXZfvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 08, 2017 at 02:54:29PM -0700, Jacob Keller wrote:

> > So the best way to use it is something like:
> >
> >   git fetch              ;# update 'master' from remote
> >   git tag base master    ;# mark our base point
> >   git rebase -i master   ;# rewrite some commits
> >   git push --force-with-lease=master:base master:master
> [...]
> 
> What if we added a separate command something like:
> 
> git create-lease
> 
> which you're expected to run at the start of a rewind-y operation and
> it creates a tag (or some other ref like a tag but in a different
> namespace) which is used by force-with-lease?

So then you replace that "git tag" command above with "git
create-lease". I think it's an incremental improvement because it would
probably record which branch you're leasing. But I think the more
important issue is that the user needs to remember to take the lease in
the first place. A create-lease command doesn't help that.

> It might be possible to generate these lease tags prior to operations
> which modify history and then maybe having a way to list them so you
> can select which one you meant when you try to use force-with-lease..

So yeah, I think that is the more interesting direction. I hadn't
considered resolving the multiple-operation ambiguity at push time. But
I guess it would be something like "you did a rebase on sha1 X at time
T, and then one on Y at time T+N", and you pick which one you're
expecting. Or maybe it could even cull old leases that are still
ancestors of your push (so old, already-pushed rebases aren't
mentioned). I suspect that ends up being equivalent to "clear the leases
when you push". And I think that may be converging on the "integrate"
refs that Stefan is talking about elsewhere (or some isomorphism of it).

-Peff
