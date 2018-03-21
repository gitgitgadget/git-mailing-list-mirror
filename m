Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 668FD1F42D
	for <e@80x24.org>; Wed, 21 Mar 2018 06:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbeCUGwP (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 02:52:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:37106 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751317AbeCUGwP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 02:52:15 -0400
Received: (qmail 32048 invoked by uid 109); 21 Mar 2018 06:52:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Mar 2018 06:52:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7541 invoked by uid 111); 21 Mar 2018 06:53:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Mar 2018 02:53:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Mar 2018 02:52:13 -0400
Date:   Wed, 21 Mar 2018 02:52:13 -0400
From:   Jeff King <peff@peff.net>
To:     Dakota Hawkins <dakota@dakotahawkins.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git <git@vger.kernel.org>
Subject: Re: .gitattributes override behavior (possible bug, or documentation
 bug)
Message-ID: <20180321065212.GC16784@sigill.intra.peff.net>
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
 <20180320023423.GA10143@sigill.intra.peff.net>
 <CAHnyXxRcwq40W4tKm=Kscrsnb77yh7=eGDE=r5AZq073MPX9AQ@mail.gmail.com>
 <20180320040411.GB12938@sigill.intra.peff.net>
 <CAHnyXxQMbnNam=oB_B57xDZBaMPRn_8hfKtostHPV6nBHbTBog@mail.gmail.com>
 <20180320044036.GD13302@sigill.intra.peff.net>
 <CACsJy8BP+ov0jeHp6QZoi=etPDQX5qEFqEfktyA-U-ffUE92vA@mail.gmail.com>
 <CAHnyXxRsqR3A0FpHJwnfOWo29WNx05qWSXfxvmwPv1TUdqm0aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHnyXxRsqR3A0FpHJwnfOWo29WNx05qWSXfxvmwPv1TUdqm0aQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 20, 2018 at 11:22:02PM -0400, Dakota Hawkins wrote:

> Thinking about this a little more, I'm now attracted to the idea that
> its .gitignore that's weird.
> 
> As I understand it, .gitignore stops recursion when there's a
> directory match (`somedir/`) but also explicitly allows nested
> .gitnore file _as well as_ exclusion (`!*.txt`).
> 
> So, in the following (contrived) example, the user doesn't get what they want:
> 
>     repo/
>     |- .git/
>     |- .gitignore               # /ignore-most/
>     |- ignore-most/
>     |  |- .gitignore            # !*.txt
>     |  |- please_ignore.png
>     |  |- dont_ignore_me.txt
> 
> `repo/ignore-most/dont_ignore_me.txt` is still ignored, despite what
> seems like the obvious intention of the user.

Right, I think this gets back to Duy's other email. We're not really
recursively applying the pattern, it's just that we don't bother
descending into ignore areas at all.

> Maybe a unified "best-practices" would first-and-foremost recommend
> against matching directories at all (makes sense, git doesn't manage
> directories). In the above example, changing `/ignore-most/` to
> `/ignore-most/*` has the "desired" effect.
> 
> What do you think?

I think that ignoring all of /ignore-most/ is much more efficient, since
we don't have to enumerate the paths inside it at all (which is why the
current behavior works as it does).

-Peff
