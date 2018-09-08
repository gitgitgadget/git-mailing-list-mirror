Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 859FE1F404
	for <e@80x24.org>; Sat,  8 Sep 2018 21:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeIICKG (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 22:10:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:43906 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727608AbeIICKG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 22:10:06 -0400
Received: (qmail 30016 invoked by uid 109); 8 Sep 2018 21:22:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 08 Sep 2018 21:22:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31296 invoked by uid 111); 8 Sep 2018 21:23:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 08 Sep 2018 17:23:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Sep 2018 17:22:57 -0400
Date:   Sat, 8 Sep 2018 17:22:57 -0400
From:   Jeff King <peff@peff.net>
To:     Stas Bekman <stas@stason.org>
Cc:     git@vger.kernel.org
Subject: Re: git silently ignores include directive with single quotes
Message-ID: <20180908212256.GB31560@sigill.intra.peff.net>
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 08, 2018 at 11:58:47AM -0700, Stas Bekman wrote:

> This doesn’t:
> 
> [include]
>         path = '../.gitconfig'

So I think it's been covered elsewhere that single quotes aren't a thing
in git's config format. I will say that this was actually a minor
surprise to me, after a decade of working with the format. ;)

I don't know if it's worth changing now or not It would be
backwards-incompatible, but I wonder if we could do it in a sane way.
E.g., with a rule like:

  - if the first non-whitespace character of the value is a
    single-quote, assume the value is quoted and apply normal shell
    rules (i.e., no backslash escapes until the ending single-quote)

  - otherwise, single-quotes are not special at all

That would allow things like:

  [diff "foo"]
  textconv = some_shell_hackery 'with quotes' | foo

to continue working, but make:

  [some]
  path = 'this has "double quotes" in it!'

do what the user probably intended. It would be a regression for anybody
who literally has a value that starts with a single-quote, but that
seems like it would be pretty rare. Or I dunno, maybe people do it on
Windows to try to protect path-names that get interpreted by the shell.

> The original problem cropped up due to using:
> 
>  git config --local include.path '../.gitconfig'
> 
> which on linux stripped the single quotes, but on some windows git bash
> emulation it kept them.

That sounds like a bug in git bash, if it is not treating single quotes
in the usual shell way. But I'd also expect such a bug to cause loads of
problems in all of the shell scripts. Are you sure it wasn't cmd.exe or
some other interpreter?

-Peff
