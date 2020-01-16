Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A4EC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 18:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AEF5214AF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 18:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407028AbgAPSYa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:24:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:38094 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2395557AbgAPSXd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 13:23:33 -0500
Received: (qmail 31669 invoked by uid 109); 16 Jan 2020 18:23:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 Jan 2020 18:23:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8493 invoked by uid 111); 16 Jan 2020 18:29:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jan 2020 13:29:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Jan 2020 13:23:31 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eyal Soha <shawarmakarma@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] color.c: Refactor color_output to use enums
Message-ID: <20200116182331.GA2946050@coredump.intra.peff.net>
References: <20200110111516.GA474613@coredump.intra.peff.net>
 <20200110150547.221314-1-shawarmakarma@gmail.com>
 <xmqq5zhbi8l3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5zhbi8l3.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 16, 2020 at 10:01:44AM -0800, Junio C Hamano wrote:

> Not that I agree with the (untold) reasoning why we chose to use
> 30-37 instead of 0-7, though.  If this were up to me, I would have
> rather defined COLOR_BACKGROUND_ANSI = 40, kept .value to 0-7 and
> passed COLOR_{FORE,BACK}GROUPD_ANSI to callers of color_output().
> 
> Since I haven't seen 2/3 and 3/3, perhaps there is a good reason why
> this step was done this way instead, though, I guess.

Yeah, it becomes more clear in patch 2, where the value can be either
"31" or "91", for the bright or non-bright variant, and adding "30" is
wrong. (But certainly I agree this needs to be explained here).

Another way to write it would be to store 0-7 in the value as before,
and then add a separate "bright" flag to "struct color". And then the
output becomes:

  COLOR_FOREGROUND_OFFSET + c->value + (c->bright ? COLOR_BRIGHT_OFFSET : 0)

or similar. One minor confusion there is that COLOR_256 and COLOR_RGB
would ignore the "bright" field.

-Peff
