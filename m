Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CA962095E
	for <e@80x24.org>; Fri, 24 Mar 2017 01:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbdCXBE0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 21:04:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:50769 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751355AbdCXBEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 21:04:25 -0400
Received: (qmail 1847 invoked by uid 109); 24 Mar 2017 00:37:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 00:37:44 +0000
Received: (qmail 13116 invoked by uid 111); 24 Mar 2017 00:37:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 20:37:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Mar 2017 20:37:41 -0400
Date:   Thu, 23 Mar 2017 20:37:41 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] completion: put matching ctags symbol names directly
 into COMPREPLY
Message-ID: <20170324003741.vrdhdh6ze7up5kng@sigill.intra.peff.net>
References: <20170323153839.24283-1-szeder.dev@gmail.com>
 <20170323153839.24283-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170323153839.24283-2-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 04:38:37PM +0100, SZEDER Gábor wrote:

> The one-liner awk script in __git_match_ctag() listing ctags symbol
> names for 'git grep <TAB>' is already smart enough to list only symbol
> names matching the current word to be completed.
> 
> Extend this helper function to accept prefix and suffix parameters to
> be prepended and appended, respectively, to each listed symbol name in
> the awk script, so its output won't require any additional processing
> or filtering in the completion script before being handed over to
> Bash.  Use the faster __gitcomp_direct() helper instead of
> __gitcomp_nl() to fill the fully processed matching symbol names into
> Bash's COMPREPLY array.

Seems like an easy win (well, neglecting the other 14 patches that let
to having gitcomp_direct).

I never really noticed it as particularly slow in git.git, but faster is
always better if it comes cheaply.

> Notes:
>     It's still just a simple linear search through the tags file, so there
>     are no miracles: it's still hopelessly, unusably slow e.g. in the
>     Linux repository.

I just tried "git grep foo<Tab>" in the kernel and it was pretty fast.
But then I tried "git grep <Tab>". Ouch. So it seems like it's not the
awk matching that's slow, but everything that comes after (and is
dependent on how much output it produces).

-Peff
