Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA7D120951
	for <e@80x24.org>; Fri, 17 Mar 2017 22:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbdCQW3H (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 18:29:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:46232 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751061AbdCQW3H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 18:29:07 -0400
Received: (qmail 3668 invoked by uid 109); 17 Mar 2017 22:29:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 22:29:06 +0000
Received: (qmail 7404 invoked by uid 111); 17 Mar 2017 22:29:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 18:29:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Mar 2017 18:29:02 -0400
Date:   Fri, 17 Mar 2017 18:29:02 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Stefan Beller <sbeller@google.com>,
        Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: fatal: Could not get current working directory: Permission
 denied | affected 2.10,2.11,2.12, but not 1.9.5 |
Message-ID: <20170317222902.isndsmzy43btxh4i@sigill.intra.peff.net>
References: <10cc42b8-0f63-2d97-8da1-2943970d63cc@web.de>
 <ogwsaxvtiqlsiwojzxul@owpk>
 <3ba0c8e3-894a-846f-ba99-dad1deba7cdf@web.de>
 <tskgutqgpyszzedvyfra@prol>
 <f2ab799f-5f0a-0ce0-0625-13513bc1973d@web.de>
 <ffntuqzgjgcfhebokbty@eduj>
 <7f25def4-9943-ae59-a649-b4348a79890e@web.de>
 <f6588ace-eecc-118d-ef26-70bc21dcc4d4@web.de>
 <CAGZ79kbpPBN21mbN2F20ikr6dXrKEcY=msqymaG8TOujeQF0jw@mail.gmail.com>
 <250f6b35-03c3-1fa8-8b6b-dfdc42660d8c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <250f6b35-03c3-1fa8-8b6b-dfdc42660d8c@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2017 at 10:07:18PM +0100, René Scharfe wrote:

> >   As  an extension to the POSIX.1-2001 standard, Linux (libc4, libc5,
> > glibc) getcwd()
> >   allocates the buffer dynamically using malloc(3) if buf is NULL.  In
> > this case, the
> >   allocated buffer has the length size unless size is zero, when buf
> > is allocated as big
> >   as necessary.  The caller should free(3) the returned buffer.
> > 
> > This sounds specific to Linux (though I am reading Linux man pages,
> > which claim this; Also it seems I might have misread it as it also states
> > "The pathname is returned as the function result and via the
> > argument buf, if present.").
> 
> I'm only interested in FreeBSD for now, as that's the platform Zenobiusz
> reported the issue on and I haven't been able to reproduce it, so this is
> still a bit exploratory, but hopefully getting closer.  This extension is
> used in the first version of pwd(1) in FreeBSD's repo, comitted 1994-05-26,
> so it was supported there basically forever.
> 
> The oldest version I found that's using the extention is NetBSD's pwd(1),
> which was committed 1993-03-21 and carries a SCCS timestamp of 1991-02-20.
> Visual Studio .NET 2003 supports it as well.

My big question is what happens on other platforms when they see a NULL
(but 0-sized) buffer. Any reasonable implementation would just return
ERANGE and we'd fall back to the existing code. But we often have to deal with unreasonable ones.

So do we need a "my OS understands getcwd(NULL)" build knob?

-Peff
