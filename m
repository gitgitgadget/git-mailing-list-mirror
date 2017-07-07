Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F38A2202AE
	for <e@80x24.org>; Fri,  7 Jul 2017 03:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753322AbdGGDC1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 23:02:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:33138 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753296AbdGGDC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 23:02:27 -0400
Received: (qmail 26655 invoked by uid 109); 7 Jul 2017 03:02:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 03:02:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19122 invoked by uid 111); 7 Jul 2017 03:02:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 06 Jul 2017 23:02:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Jul 2017 23:02:24 -0400
Date:   Thu, 6 Jul 2017 23:02:24 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 6/6] reflog-walk: stop using fake parents
Message-ID: <20170707030224.4iubuzsz2qwdhgiw@sigill.intra.peff.net>
References: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
 <20170705080904.idlpm6ecslzfbm75@sigill.intra.peff.net>
 <20170707003239.GA13431@untitled>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170707003239.GA13431@untitled>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 07, 2017 at 12:32:39AM +0000, Eric Wong wrote:

> I'm not sure why, but this is causing t1414.8 failures on 32-bit
> x86 with the latest pu with Debian jessie (oldstable).
> 
> Reverting this (beafb2c62947a6d4a97b9c3baf99fe62ec8e830f) in pu
> seems to fix the test for me.
> 
> +Cc: Ramsay since he also had a 32-bit environment.

Thanks, I was able to reproduce with CFLAGS=-m32.

> --- expect	2017-07-07 00:30:57.796325232 +0000
> +++ actual	2017-07-07 00:30:57.796325232 +0000
> @@ -3,6 +3,8 @@
>  HEAD@{2} checkout: moving from master to side
>  HEAD@{3} commit: two
>  HEAD@{4} commit (initial): one
> -side@{0} commit (merge): Merge branch 'master' into side
> -side@{1} commit: three
> -side@{2} branch: Created from HEAD^
> +HEAD@{0} commit (merge): Merge branch 'master' into side
> +HEAD@{1} commit: three
> +HEAD@{2} checkout: moving from master to side
> +HEAD@{3} commit: two
> +HEAD@{4} commit (initial): one

That's quite an unexpected error (to show the HEAD reflog twice). Given
that it triggers with 32-bit builds, it's like there's some funny memory
error. And indeed, running it under valgrind shows a problem in
add_reflog_for_walk. I'll try to dig into it. Thanks for reporting.

-Peff
