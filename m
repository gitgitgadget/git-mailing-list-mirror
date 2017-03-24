Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B4971FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 19:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967050AbdCXTmn (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 15:42:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:51329 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966813AbdCXTmm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 15:42:42 -0400
Received: (qmail 28101 invoked by uid 109); 24 Mar 2017 19:42:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 19:42:40 +0000
Received: (qmail 23357 invoked by uid 111); 24 Mar 2017 19:42:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 15:42:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Mar 2017 15:42:37 -0400
Date:   Fri, 24 Mar 2017 15:42:37 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCHv2 08/14] completion: let 'for-each-ref' and 'ls-remote'
 filter matching refs
Message-ID: <20170324194237.td2nsiyuatexuxo2@sigill.intra.peff.net>
References: <20170323152924.23944-1-szeder.dev@gmail.com>
 <20170323152924.23944-9-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170323152924.23944-9-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 04:29:18PM +0100, SZEDER Gábor wrote:

> When completing refs, several __git_refs() code paths list all the
> refs from the refs/{heads,tags,remotes}/ hierarchy and then
> __gitcomp_nl() iterates over those refs in a shell loop to filter out
> refs not matching the current ref to be completed.  This comes with a
> considerable performance penalty when a repository contains a lot of
> refs but the current ref can be uniquely completed or when only a
> handful of refs match the current ref.

Part of this is due to outputting too many refs from for-each-ref, but
part of it is that for-each-ref is not good at limiting the refs it
looks at internally. I have a patch for that, but it's not all that
helpful without Michael Haggerty's mmap-packed-refs work, so I'll get it
included there.

So that makes this change doubly important. You get the immediate
speedups, and then you'll get another one when that work is merged
later.

>  		case "$cur_" in
>  		refs|refs/*)
>  			format="refname"
> -			refs="${cur_%/*}"
> +			refs=("$match*" "$match*/**")
>  			track=""

Working on the aforementioned patch, I noticed that for-each-ref's
matching is a little tricky due to its path semantics. So I wanted to
double-check your patterns. :) I think these should do the right thing.

-Peff
