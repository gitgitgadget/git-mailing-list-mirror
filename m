Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 512BC1F463
	for <e@80x24.org>; Tue, 24 Sep 2019 21:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfIXVit (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 17:38:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:58968 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728183AbfIXVit (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 17:38:49 -0400
Received: (qmail 11541 invoked by uid 109); 24 Sep 2019 21:38:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Sep 2019 21:38:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12887 invoked by uid 111); 24 Sep 2019 21:41:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2019 17:41:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Sep 2019 17:38:48 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/3] pack-bitmap.h: fix unused variable warning
Message-ID: <20190924213847.GF20858@sigill.intra.peff.net>
References: <cover.1569263631.git.liu.denton@gmail.com>
 <a3a3357925cb144deb35b298cbe2796934fa0673.1569315905.git.liu.denton@gmail.com>
 <20190924213408.GD20858@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190924213408.GD20858@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 24, 2019 at 05:34:08PM -0400, Jeff King wrote:

> > I'm tacking this patch on since this warning didn't show up until I
> > compiled it on gcc 9.1.0.
> 
> Curiously, I _don't_ see the warning with gcc 9.2.1. By my reading of
> the manpage, this should be triggered by -Wunused-const-variable=2, but
> not by "1" (the difference being whether it triggers for stuff in header
> files). And only the latter is triggered by -Wall or -Wextra.
> 
> But another weirdness is that hdr-check is directly compiling the header
> files. So I guess that fools it. But we don't pass any of the extra
> diagnostic options there.  Have you put "-Wall" into your $(CC)?
> 
> Perhaps a more realistic hdr-check would be:
> 
>   {
>     echo '#include "git-compat-util.h"'
>     echo '#include "$<"'
>   } >$*.hcc
>   $(QUIET_HDR)$(CC) $(ALL_CFLAGS) -o /dev/null -c -xc $*.hcc

Oh, heh. I should have read your whole series (the mention of
pack-bitmaps in the subject got my attention).

So yeah, I think the problem is that you're using $(ALL_CFLAGS) with our
fake "compile the header" check, which does not reflect how our code is
really compiled. I think we should use a more accurate simulation, like
what I wrote above.

-Peff
