Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC9991F404
	for <e@80x24.org>; Tue, 23 Jan 2018 00:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeAWAHb (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 19:07:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:53898 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751128AbeAWAHa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 19:07:30 -0500
Received: (qmail 11645 invoked by uid 109); 23 Jan 2018 00:07:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Jan 2018 00:07:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12613 invoked by uid 111); 23 Jan 2018 00:08:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Jan 2018 19:08:07 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jan 2018 19:07:28 -0500
Date:   Mon, 22 Jan 2018 19:07:28 -0500
From:   Jeff King <peff@peff.net>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Fixes compile warning with -Wimplicit-fallthrough CFLAGS
Message-ID: <20180123000727.GB26357@sigill.intra.peff.net>
References: <1516665078-107974-1-git-send-email-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1516665078-107974-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 11:51:18PM +0000, Elia Pinto wrote:

> This patch add explicit fallthrough compiler attribute
> when needed on switch case statement eliminating
> the compile warning [-Werror=implicit-fallthrough=].
> It does this by means of a macro that takes into account
> the versions of the compilers that include that attribute.
> 
> The fallthrough (or clang::fallthrough) attribute is used to annotate
> intentional fall-through between switch labels.
> Traditionally these are marked with a specific comment, but
> this attribute is meant to replace comments with a more strict
> annotation, which can be checked by the compiler (gcc-7 or clang).
> The flags in question were introduced in gcc 7 and are also enabled
> with -Wextra.

Hrm. Your subject says "fixes compile warnings", but don't we already
compile cleanly with -Wimplicit-fallthrough after my 1cf01a34ea
(consistently use "fallthrough" comments in switches, 2017-09-21)?

Certainly the tip of "master" seems to pass for me on both gcc 7 and
clang 4. You can pump the warning up to level 5 on gcc to insist on the
attribute, but I think the comments are more readable (and it is not
like we have a problem with false positive comments).

> It would also have been possible to introduce a specific comment
> accepted by gcc 7 instead of the fallthrough attribute for this warning,
> but clang does not have a similar implementation. The macro replaces
> the previous, not uniform, comments and can acts as a comment itself.

Interestingly clang seems to accept -Wimplicit-fallthrough, but I could
not get it to actually trigger a warning, even after removing some of
the existing comments.

What version of clang are you using? I'm certainly puzzled by the
behavior I'm seeing.

> diff --git a/apply.c b/apply.c
> index 321a9fa68..a22fb2881 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -1450,7 +1450,7 @@ static void recount_diff(const char *line, int size, struct fragment *fragment)
>  		switch (*line) {
>  		case ' ': case '\n':
>  			newlines++;
> -			/* fall through */
> +			GIT_FALLTHROUGH;

Ugh, the semi-colon there makes it look like it's actual code. If we go
this route, I wonder if it's worth hiding it inside the macro.

-Peff
