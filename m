Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26C7220248
	for <e@80x24.org>; Sun,  3 Mar 2019 17:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfCCRmR (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 12:42:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:36694 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726416AbfCCRmR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 12:42:17 -0500
Received: (qmail 13764 invoked by uid 109); 3 Mar 2019 17:42:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 03 Mar 2019 17:42:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16617 invoked by uid 111); 3 Mar 2019 17:42:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 03 Mar 2019 12:42:33 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Mar 2019 12:42:15 -0500
Date:   Sun, 3 Mar 2019 12:42:15 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH] builtin/config.c: don't print a newline with --color
Message-ID: <20190303174214.GF23811@sigill.intra.peff.net>
References: <b5ca6391fd0273fb7d6b92bc5ada96df93bc5cf2.1551487219.git.me@ttaylorr.com>
 <xmqqtvgk69ik.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtvgk69ik.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 03, 2019 at 10:18:11AM +0900, Junio C Hamano wrote:

> An interesting aspect of the above is that this is *NOT* limited to
> colors.  Regardless of the type you are reading, be it an int or a
> bool, VAR=$(git config ...) will strip the trailing LF, and existing
> scripts people have do rely on that, i.e. when people write
> 
> 	VAR=$(git config ...)
> 	echo "var setting is $VAR"
> 
> they rely on VAR=$(...) assignment to strip trailing LF and echo to
> add a final LF to the string.
> 
> So if we are going to change anything, the change MUST NOT single
> out "color".  IOW, the title of the patch already tells us that it
> is giving a wrong solution.

I'm not sure I agree. Colors have always been special, and
"--type=color" was advertised as a replacement for "--get-color". And
"--get-color" never output the newline.

Philosophically speaking, I'd make the argument that the "color" type is
a bit special because unlike other output, it is unreadable binary gunk.
But I dunno. It does suck for the output to be dependent on "--type",
because it means that anything consuming it has to understand the
various types. It also creates potential complications if we ever
implement a "--stdin" mode to grab the (type-interpreted) values of
several keys, where presumably we'd have to have newlines as part of the
protocol.

> Needless to say, "using chop in Perl is wrong to begin with" misses
> the point from two directions---(1) 'chop in Perl' is a mere
> example---scripts not written in Perl using chop may still rely on
> the existing behaviour that the output always has the final LF, and
> (2) even if we agree that using chop in Perl is a bad idea, such a
> script has happily been working, and suddenly breaking it is a
> regression no matter what.

With respect to backwards compatibility, my thinking on the matter was
basically:

  1. Since --type=color was supposed to be a drop-in replacement for
     --get-color, it's a bug that they don't behave the same.

  2. It's a fairly recent feature, so nobody really noticed the bug
     until recently (and it was in fact me who noticed and got annoyed
     by it). If it were an ancient behavior, we might think about
     retaining even bug compatibility, but that's not the case here.

But I do admit your argument about consistency is giving me second
thoughts.

-Peff
