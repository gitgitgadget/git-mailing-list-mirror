Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 662791F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 12:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbcHOMJU (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 08:09:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:55341 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752707AbcHOMJT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 08:09:19 -0400
Received: (qmail 12706 invoked by uid 109); 15 Aug 2016 12:09:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 12:09:18 +0000
Received: (qmail 13612 invoked by uid 111); 15 Aug 2016 12:09:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 08:09:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Aug 2016 08:09:16 -0400
Date:	Mon, 15 Aug 2016 08:09:16 -0400
From:	Jeff King <peff@peff.net>
To:	Eli Barzilay <eli@barzilay.org>
Cc:	git@vger.kernel.org
Subject: Re: Minor bug: git config ignores empty sections
Message-ID: <20160815120916.6iobqirqbg76exms@sigill.intra.peff.net>
References: <CALO-gutdz5VMgoRmbqEa9UiaTC+L2Sy2n-3AF+zfPr-X8+1U4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALO-gutdz5VMgoRmbqEa9UiaTC+L2Sy2n-3AF+zfPr-X8+1U4A@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Aug 14, 2016 at 09:29:27PM -0400, Eli Barzilay wrote:

> Looks like there's a problem with setting a config with an empty
> section, making it create a new section.  The result is:
> 
>     $ git --version
>     git version 2.9.2
>     $ git init
>     Initialized empty Git repository in /home/eli/t/.git/
>     $ t() { git config x.y x; git config --unset x.y; }
>     $ t;t;t
>     $ grep -c '\[x\]' .git/config
>     3
>     $ git config x.z x
>     $ t;t;t
>     $ git config x.z x     # adds another [x], but leaves it populated
>     $ t;t;t;t;t;t;t;t
>     $ grep -c '\[x\]' .git/config
>     4

Yep. This is a very old and well-known bug. IIRC, the problem is that
config updates use the regular callback-parser, so they see only the
config keys themselves. Empty section headers never trigger them.
Fixing it would require rewriting the config-update code.

And implicit in your test is the other bug, which is that deleting the
last key in a section leaves the empty header. I think it's related to
the same issue.

Patches welcome, of course.

-Peff
