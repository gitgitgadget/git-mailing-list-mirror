Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E458F1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 20:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbcHCUWa (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 16:22:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:54143 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932394AbcHCUW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 16:22:29 -0400
Received: (qmail 15550 invoked by uid 102); 3 Aug 2016 20:15:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 16:15:48 -0400
Received: (qmail 5330 invoked by uid 107); 3 Aug 2016 20:16:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 16:16:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 16:15:44 -0400
Date:	Wed, 3 Aug 2016 16:15:44 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 6/7] submodule--helper: add remote-branch helper
Message-ID: <20160803201544.7sljaikzwws7rekv@sigill.intra.peff.net>
References: <20160729004409.2072-1-sbeller@google.com>
 <20160729004409.2072-7-sbeller@google.com>
 <20160803162512.veyff5g52kaqwlgx@sigill.intra.peff.net>
 <CAGZ79kYW0dwUh=QpKL9W+cv8k_Z9Vc2wxoLMqud5brDtS9DYpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYW0dwUh=QpKL9W+cv8k_Z9Vc2wxoLMqud5brDtS9DYpA@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 01:11:51PM -0700, Stefan Beller wrote:

> > Coverity complains about "sub" being NULL here, and indeed, it seems
> > like an easy segfault:
> >
> >   $ ./git submodule--helper remote-branch foo
> >   Segmentation fault
> >
> > I guess this should return NULL in that case. But then this...
> 
> I thought about checking for (!sub && !sub->branch) to return "master";
> However I disregarded that implementation as the submodule-config is
> reliable for any correct input. Though we need to handle wrong input as
> well. So how about:
> 
>   if (!sub)
>     die(_("A submodule doesn't exist at path %s"), path);
>   if (!sub->branch)
>     return "master";

OK by me, as long as the caller of submodule--helper handles the death
reasonably. Since it's an internal helper program, we really only have
to worry about what git-submodule.sh does with it, which is good.

> > would need to handle the NULL return, as well. So maybe "master" or the
> > empty string would be better. I haven't followed the topic closely
> > enough to have an opinion.
> 
> Oh I see, this can turn into a discussion what the API for
> remote_submodule_branch is. I think handling the NULL here and dying makes
> more sense as then we can keep remote_submodule_branch pure to its
> intended use case. (If in the far future we have all the submodule stuff in C,
> we may want to call remote_submodule_branch when we already know
> that the path is valid, so no need to check it in there. Also not dying in there
> is more libified.)

Yep, that makes sense to me, too.

-Peff
