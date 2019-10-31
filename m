Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 029491F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 06:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfJaGYz (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 02:24:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:34690 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726411AbfJaGYz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 02:24:55 -0400
Received: (qmail 12094 invoked by uid 109); 31 Oct 2019 06:24:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 Oct 2019 06:24:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27568 invoked by uid 111); 31 Oct 2019 06:28:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Oct 2019 02:28:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Oct 2019 02:24:54 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] vreportf(): avoid relying on stdio buffering
Message-ID: <20191031062454.GB20830@sigill.intra.peff.net>
References: <pull.428.v2.git.1572356272.gitgitgadget@gmail.com>
 <pull.428.v3.git.1572379280.gitgitgadget@gmail.com>
 <fce0894ee46f737322551b51edf5cd2a53413a50.1572379280.git.gitgitgadget@gmail.com>
 <20191029203259.GB12337@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1910300947410.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910300947410.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 30, 2019 at 09:54:52AM +0100, Johannes Schindelin wrote:

> > One non-bikeshed question: would fprintf() on some platforms have sent
> > "\r\n", which is no longer happening with our write()? Do we need to
> > care about that?
> 
> I am not aware of any platform where `fprintf()` would automatically
> transform `\n` to `\r\n`. Not unless the `FILE *` in question has been
> opened with the `t` flag. And I am rather certain that `stderr` is not
> opened with that flag. And if it was, I would force it off in Git for
> Windows.

OK, thanks. You guessed the platform I was thinking of. :)

Another more far-fetched one: IIRC our stdio wrappers on Windows do some
magic to convert ANSI color codes into actual terminal codes. Could that
be a problem here? I think we'd kill off any color codes in the actual
message due to the control-code replacement. In theory the prefix could
have them. I don't think any code does now, but the PUSH_COLOR_ERROR
stuff in builtin/push.c is getting close. I wouldn't be surprised for
that to eventually get folded into error().

-Peff
