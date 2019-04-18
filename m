Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SUSPICIOUS_RECIPS shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7545C20248
	for <e@80x24.org>; Thu, 18 Apr 2019 16:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388888AbfDRQGg (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 12:06:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:33954 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725888AbfDRQGg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 12:06:36 -0400
Received: (qmail 2440 invoked by uid 109); 18 Apr 2019 16:06:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Apr 2019 16:06:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2163 invoked by uid 111); 18 Apr 2019 16:07:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Apr 2019 12:07:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Apr 2019 12:06:33 -0400
Date:   Thu, 18 Apr 2019 12:06:33 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 01/11] Start to implement a built-in version of `git add
 --interactive`
Message-ID: <20190418160633.GB8054@sigill.intra.peff.net>
References: <pull.170.git.gitgitgadget@gmail.com>
 <12978dc248a2cd07c90559691b8a2add84f45394.1554917868.git.gitgitgadget@gmail.com>
 <3149b9ba-2f5a-46ce-ad89-4105ec217795@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3149b9ba-2f5a-46ce-ad89-4105ec217795@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 18, 2019 at 10:31:30AM -0400, Jeff Hostetler wrote:

> Currently, neither function looks at any other k/v pairs, so
> this is a bit of a moot point, but I'm wondering if this should
> look like this:
> 
>     int add_config(...)
>     {
>         // give add-interactive.c a chance to look at k/v pair, but
>         // do not short-cut because we don't know yet whether we
>         // will be interactive or not yet.
>         (void)add_i_config(...);
> 
>         ...ignore_add_errors...
>         ...use_builtin_add_i...
> 
>         return git_default_config(...);
>     }

Yeah, I agree this split seems a bit more natural. It is worth
propagating errors from add_i_config(), though, like:

  if (add_i_config(var, value, data))
	return -1;

so that any key-specific errors (e.g., config_error_nonbool) stop the
parsing in the usual way.

-Peff
