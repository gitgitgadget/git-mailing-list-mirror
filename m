Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80C0B1FE4E
	for <e@80x24.org>; Fri,  1 Jul 2016 04:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbcGAEOB (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 00:14:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:38696 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751036AbcGAEOA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 00:14:00 -0400
Received: (qmail 19199 invoked by uid 102); 1 Jul 2016 04:07:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 00:07:20 -0400
Received: (qmail 12925 invoked by uid 107); 1 Jul 2016 04:07:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 00:07:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 00:07:15 -0400
Date:	Fri, 1 Jul 2016 00:07:15 -0400
From:	Jeff King <peff@peff.net>
To:	"dmh@ucar.edu" <dmh@ucar.edu>
Cc:	git@vger.kernel.org
Subject: Re: git-credentials-store.exe crash
Message-ID: <20160701040715.GB4832@sigill.intra.peff.net>
References: <7210bce6-093b-9fdf-9a9b-94059ad0d4e3@ucar.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7210bce6-093b-9fdf-9a9b-94059ad0d4e3@ucar.edu>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 30, 2016 at 03:24:41PM -0600, dmh@ucar.edu wrote:

> Carson:part2: git push
> This application has requested the Runtime to terminate it in an unusual
> way.
> Please contact the application's support team for more information.
> A s s e r t i o n   f a i l e d !
> 
>  P r o g r a m :   C : \ t o o l s \ G i t \ m i n g w 3 2 \ l i b e x e c \
> g i
>  t - c o r e \ g i t - c r e d e n t i a l - s t o r e . e x e
>  F i l e :   e x e c _ c m d . c ,   L i n e   2 3
> 
>  E x p r e s s i o n :   a r g v 0 _ p a t h
>  Everything up-to-date

Interesting. It's failing on the assert(argv0_path) in system_path().

That's part of the RUNTIME_PREFIX code which is built only on Windows,
so this is a Windows-specific issue.

I can guess the reason that argv0_path is not set is that
credential-store has its own main() function and does not call
git_extract_argv0_path(). It never mattered before, but as of v2.8.0,
one of the library functions it calls wants to use system_path(), which
assumes that the argv0 stuff has been set up.

I'm preparing some patches to fix this case (and some other related
ones).

-Peff
