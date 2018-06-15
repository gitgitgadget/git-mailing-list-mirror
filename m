Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07FB41F403
	for <e@80x24.org>; Fri, 15 Jun 2018 04:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755499AbeFOEUZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 00:20:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:45364 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750890AbeFOEUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 00:20:25 -0400
Received: (qmail 19372 invoked by uid 109); 15 Jun 2018 04:20:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Jun 2018 04:20:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18459 invoked by uid 111); 15 Jun 2018 04:20:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 15 Jun 2018 00:20:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2018 00:20:23 -0400
Date:   Fri, 15 Jun 2018 00:20:23 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Subject: Re: [PATCH] Makefile: make NO_ICONV really mean "no iconv"
Message-ID: <20180615042023.GA31294@sigill.intra.peff.net>
References: <CACcTrKePbgyCbXneN5NZ+cS-tiDyYe_dkdwttXpP0CUeEicvHw@mail.gmail.com>
 <20180615022503.34111-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180615022503.34111-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 14, 2018 at 10:25:03PM -0400, Eric Sunshine wrote:

> The Makefile tweak NO_ICONV is meant to allow Git to be built without
> iconv in case iconv is not installed or is otherwise dysfunctional.
> However, NO_ICONV's disabling of iconv is incomplete and can incorrectly
> allow "-liconv" to slip into the linker flags when NEEDS_LIBICONV is
> defined, which breaks the build when iconv is not installed.
> 
> On some platforms, iconv lives directly in libc, whereas, on others it
> resides in libiconv. For the latter case, NEEDS_LIBICONV instructs the
> Makefile to add "-liconv" to the linker flags. config.mak.uname
> automatically defines NEEDS_LIBICONV for platforms which require it.
> The adding of "-liconv" is done unconditionally, despite NO_ICONV.
> 
> Work around this problem by making NO_ICONV take precedence over
> NEEDS_LIBICONV.

Nicely explained.

We have OLD_ICONV, too, which should probably do nothing if NO_ICONV is
set. I think that works OK. We end up setting -DOLD_ICONV on the command
line, but that's only consider inside "#ifndef NO_ICONV" within the
code.

> This patch is extra noisy due to the indentation change. Viewing it with
> "git diff -w" helps. An alternative to re-indenting would have been to
> "undefine NEEDS_LIBICONV", however, 'undefine' was added to GNU make in
> 3.82 but MacOS is stuck on 3.81 (from 2006) so 'undefine' was avoided.

Yeah, with "-w" it looks pretty obviously correct.

-Peff
