Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 266A52018A
	for <e@80x24.org>; Tue, 28 Jun 2016 20:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbcF1Ulw (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 16:41:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:37231 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751673AbcF1Ulv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 16:41:51 -0400
Received: (qmail 2582 invoked by uid 102); 28 Jun 2016 20:35:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Jun 2016 16:35:09 -0400
Received: (qmail 11820 invoked by uid 107); 28 Jun 2016 20:28:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Jun 2016 16:28:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Jun 2016 16:28:09 -0400
Date:	Tue, 28 Jun 2016 16:28:09 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	sschuberth@gmail.com
Subject: Re: [PATCH v2 0/2] Config conditional include
Message-ID: <20160628202809.GA21002@sigill.intra.peff.net>
References: <20160626070617.30211-1-pclouds@gmail.com>
 <20160628172641.26381-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160628172641.26381-1-pclouds@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 28, 2016 at 07:26:39PM +0200, Nguyễn Thái Ngọc Duy wrote:

> There's a surprise about core.ignorecase. We are matching paths, so we
> should match case-insensitively if core.ignorecase tells us so. And it
> gets a bit tricky if core.ignorecase is defined in the same config
> file. I don't think we have ever told the user that keys are processed
> from top down. We do now.

Hrm. I'm not excited about introducing ordering issues into the config
parsing. But I think it's actually even more complicated than that.

core.ignorecase is generally about the working tree, not the git
repository directory, which may reside on another filesystem entirely
(though I would not be surprised if we've blurred that line already).

I wonder if it would be that bad to just punt on the issue, and say that
these include-match globs are always case-insensitive, or something.
True, that does not allow one to distinguish between config for "foo"
and "Foo" directories, but I find it unlikely anybody would ever want
to. And if we define it that way from day one, then nobody expects it to
work.

> It makes me wonder if we should allow users the option to match case
> insensitively regardless of filesystem too. Something close to
> pathspec magic. But that probably has little use in real world for a
> lot more work.

Yeah, if we had a builtin syntax for "add these options to the
wildmatch", it wouldn't be so bad, but I think we'd be inventing that
syntax.

> The '/' vs '\\' battle on Windows, I'll leave it to Windows guys again.

Oof. Me too. :)

> To leave room for future expansion, perhaps we should declare that ':'
> can't appear in the pattern, so we can add more prefix later, and even
> stack them, e.g. "regexp:gitdir:<pattern>". The prefix can't be one char
> long. That should be enough for windows to specify full path
> including the drive letter.

It seems unnecessarily restrictive to place rules about what can go in
the pattern provided by the user, when we can easily restrict the
characters on the keyword side. For example "gitdir/regexp:<pattern>" is
a natural extension of "gitdir:<pattern>", and is backwards compatible
as long as we use something besides ":" for the option separator.

-Peff
