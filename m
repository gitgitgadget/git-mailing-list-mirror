Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 947371F403
	for <e@80x24.org>; Mon,  4 Jun 2018 03:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbeFDDoF (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 23:44:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:32902 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751211AbeFDDoF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 23:44:05 -0400
Received: (qmail 517 invoked by uid 109); 4 Jun 2018 03:44:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Jun 2018 03:44:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11406 invoked by uid 111); 4 Jun 2018 03:44:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 03 Jun 2018 23:44:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Jun 2018 23:44:03 -0400
Date:   Sun, 3 Jun 2018 23:44:03 -0400
From:   Jeff King <peff@peff.net>
To:     Max Kirillov <max@max630.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v7 1/2] http-backend: respect CONTENT_LENGTH as specified
 by rfc3875
Message-ID: <20180604034402.GC14451@sigill.intra.peff.net>
References: <20180602212749.21324-1-max@max630.net>
 <20180602212749.21324-2-max@max630.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180602212749.21324-2-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 03, 2018 at 12:27:48AM +0300, Max Kirillov wrote:

> http-backend reads whole input until EOF. However, the RFC 3875 specifies
> that a script must read only as many bytes as specified by CONTENT_LENGTH
> environment variable. Web server may exercise the specification by not closing
> the script's standard input after writing content. In that case http-backend
> would hang waiting for the input. The issue is known to happen with
> IIS/Windows, for example.
> 
> Make http-backend read only CONTENT_LENGTH bytes, if it's defined, rather than
> the whole input until EOF. If the variable is not defined, keep older behavior
> of reading until EOF because it is used to support chunked transfer-encoding.
> 
> Signed-off-by: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
> [mk: fixed trivial build failures and polished style issues]
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
>  config.c       |  2 +-
>  config.h       |  1 +
>  http-backend.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 44 insertions(+), 2 deletions(-)

This first patch looks good to me, though it may be worth mentioning in
the commit message that we're only handling the buffered-input side here
(that is obvious to anybody reading this whole series now, but it may
help out people digging in the history later).

-Peff
