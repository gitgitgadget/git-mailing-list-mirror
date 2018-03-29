Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1BCF1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 21:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeC2Vi0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 17:38:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:48026 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751189AbeC2ViZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 17:38:25 -0400
Received: (qmail 28869 invoked by uid 109); 29 Mar 2018 21:38:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 29 Mar 2018 21:38:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22642 invoked by uid 111); 29 Mar 2018 21:39:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 29 Mar 2018 17:39:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2018 17:38:23 -0400
Date:   Thu, 29 Mar 2018 17:38:23 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 8/9] git_config_set: use do_config_from_file() directly
Message-ID: <20180329213823.GH2939@sigill.intra.peff.net>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
 <e3032300946eb5962878341f7796f5872c4d138d.1522336130.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3032300946eb5962878341f7796f5872c4d138d.1522336130.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 05:19:04PM +0200, Johannes Schindelin wrote:

> Technically, it is the git_config_set_multivar_in_file_gently()
> function that we modify here (but the oneline would get too long if we
> were that precise).
> 
> This change prepares the git_config_set machinery to allow reusing empty
> sections, by using the file-local function do_config_from_file()
> directly (whose signature can then be changed without any effect outside
> of config.c).
> 
> An incidental benefit is that we avoid a level of indirection, and we
> also avoid calling flockfile()/funlockfile() when we already know that
> we are not operating on stdin/stdout here.

I'm not sure I understand that last paragraph. What does flockfile() have
to do with stdin/stdout?

The point of those calls is that we're locking the FILE handle, so that
it's safe for the lower-level config code to run getc_unlocked(), which
is faster.

So without those, we're calling getc_unlocked() without holding the
lock. I think it probably works in practice because we know that we're
single-threaded, but it seems a bit sketchy.

-Peff
