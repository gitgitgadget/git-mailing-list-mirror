Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DEE31F404
	for <e@80x24.org>; Tue, 20 Mar 2018 04:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751308AbeCTEc2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 00:32:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:35444 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750968AbeCTEc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 00:32:27 -0400
Received: (qmail 30241 invoked by uid 109); 20 Mar 2018 04:32:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Mar 2018 04:32:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29050 invoked by uid 111); 20 Mar 2018 04:33:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Mar 2018 00:33:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Mar 2018 00:32:25 -0400
Date:   Tue, 20 Mar 2018 00:32:25 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] -Wuninitialized
Message-ID: <20180320043225.GB13302@sigill.intra.peff.net>
References: <8f6d8e2e-aba4-128c-f17c-6c1b9c12436c@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f6d8e2e-aba4-128c-f17c-6c1b9c12436c@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 05:53:09PM +0000, Ramsay Jones wrote:

> This series removes all 'self-initialised' variables (ie. <type> var = var;).
> This construct has been used to silence gcc '-W[maybe-]uninitialized' warnings
> in the past [1]. Unfortunately, this construct causes warnings to be issued by
> MSVC [2], along with clang static analysis complaining about an 'Assigned value
> is garbage or undefined'. The number of these constructs has dropped over the
> years (eg. see [3] and [4]), so there are currently only 6 remaining in the
> current codebase. As demonstrated below, 5 of these no longer cause gcc to
> issue warnings.

Great. I'm happy to see these going away, and thanks for all the careful
digging.

> If we now add a patch to remove all self-initialization, which would be the
> first patch plus the obvious change to 'saved_namelen' in read-cache.c, then
> note the warnings issued by various compilers at various optimization levels
> on several different platforms [5]:
> 
>                     O0      O1      O2      O3      Os       Og
>  1) gcc 4.8.3   |   -      1,20     1    1,18-19  1-4,21-23  1,5-17
>  2) gcc 4.8.4   |   -      1,20     1       1     1-4,21-23  1,5-8,10-13,15-16 
>  3) clang 3.4   |   -       -       -       -        -       n/a 
>  4) gcc 5.4.0   |   -       1       1       1     1,3-4,21   1,5-8,10-13,16-16
>  5) clang 3.8.0 |   -       -       -       -        -       n/a 
>  6) gcc 5.4.0   |   -       1       1       1       1-4     1,5-17 
>  7) clang 3.8.0 |   -       -       -       -        -       n/a 
>  8) gcc 6.4.0   |   -       1       1    1,18-19    1,4     1,5-17
>  9) clang 5.0.1 |   -       -       -       -        -        -
> 10) gcc 7.2.1   |   -       1       1       1       1,4     1,5-17

So I guess this could create headaches for people using DEVELOPER=1 on
as ancient a compiler as 4.8.4, but most other people should be OK. I
think I can live with that as a cutoff, and the Travis builds should
work there.

(And if we do the detect-compiler stuff from the other nearby thread,
somebody who cares can even loosen the warnings for those old gcc
versions).

I'm neglecting anybody doing -O3 or -Os here, but IMHO those are
sufficiently rare that the builder can tweak their own settings.

I wonder if people use -Og, though? I don't (I usually do -O0 for my
edit-compile-debug cycle).

-Peff
