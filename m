Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C03CB20FCF
	for <e@80x24.org>; Fri,  1 Jul 2016 06:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbcGAG3c (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 02:29:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:38761 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750924AbcGAG3c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 02:29:32 -0400
Received: (qmail 24894 invoked by uid 102); 1 Jul 2016 06:22:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 02:22:52 -0400
Received: (qmail 13774 invoked by uid 107); 1 Jul 2016 06:23:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 02:23:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 02:22:47 -0400
Date:	Fri, 1 Jul 2016 02:22:47 -0400
From:	Jeff King <peff@peff.net>
To:	Steffen Nurpmeso <steffen@sdaoden.eu>
Cc:	git@vger.kernel.org
Subject: Re: --abbrev-commit gives longer hash than necessary
Message-ID: <20160701062247.GB5358@sigill.intra.peff.net>
References: <20160630193845.TbelqPPHx%steffen@sdaoden.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160630193845.TbelqPPHx%steffen@sdaoden.eu>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 30, 2016 at 09:38:45PM +0200, Steffen Nurpmeso wrote:

> For some time (currently with 2.9.0) know see that a single commit
> gives a longer hash than necessary, even though there is no
> ambiguity:
> 
>   ?0[steffen@wales ]$ git longca|
>   awk 'BEGIN{l7=0;l8=0}\
>     /^[[:alnum:]]{7} /{++l7;next}\
>     /^[[:alnum:]]{8} /{++l8;print}\
>   END{print "L7 " l7 " L8 " l8}'
>   786d0c9c [mimepipe.2] send.c:sendpart(): force iconv(3)+ for TEXT part handlers..
>   L7 3364 L8 1

I don't know what your "git longca" alias is, but presumably it's
running "git log". That will show just _commit_ hashes, but the
abbreviation code will consider all objects.

There are some places you can use an abbreviated sha1 that know they are
looking for a commit, but most places will generally complain if there
is ambiguity between a blob and commit (e.g., "git show $foo").

It's also presumably just traversing HEAD, so it would miss commits on
other branches.

>   ?0[steffen@wales ]$ git long|cut -f1 -d' '|grep ^786
>   786d0c9c
>   786f219

Try "git rev-list --objects --all | grep ^786d0c9".

-Peff
