Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08BBECAAD5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 17:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbiIBRNS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 13:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiIBRNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 13:13:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C793114C59
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 10:13:14 -0700 (PDT)
Received: (qmail 1193 invoked by uid 109); 2 Sep 2022 17:13:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Sep 2022 17:13:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30699 invoked by uid 111); 2 Sep 2022 17:13:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Sep 2022 13:13:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 2 Sep 2022 13:13:12 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     git@vger.kernel.org, ingy@ingy.net
Subject: Re: [PATCH] rev-parse: Detect missing opt-spec
Message-ID: <YxI5qBylRhj1jsEv@coredump.intra.peff.net>
References: <CAHJtQJ4uJc2_upHvc-SWVpA3OX2Lpu-XspswGTTDLgXWjG-Gew@mail.gmail.com>
 <20220902050621.94381-1-oystwa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220902050621.94381-1-oystwa@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 02, 2022 at 07:06:21AM +0200, Øystein Walle wrote:

> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index b259d8990a..04958cf9a9 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -479,6 +479,9 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
>  		if (!s)
>  			s = help;
>  
> +		if (s == sb.buf)
> +			die(_("Missing opt-spec before option flags"));
> +
>  		if (s - sb.buf == 1) /* short option only */
>  			o->short_name = *sb.buf;
>  		else if (sb.buf[1] != ',') /* long option only */

I think this is the right thing to do, at least for now. Certainly it
catches the bug. It doesn't allow short or long option names to contain
any flag characters, but that's probably OK in practice.

I think one could make an argument that cmd_parseopt() should do a
better job of parsing left-to-right. The reason it missed this case is
that it calls strpbrk(), expecting to jump past the short/long option
names, but it jumps less far than expected.

If the parsing were more left-to-right, like:

  - start with pointer at beginning of sb.buf

  - look for acceptable character for short option, or "," for none;
    advance pointer if found, otherwise bail

  - look for syntactically valid long option name; advance pointer,
    otherwise bail

  - look for valid flags

then I think it becomes much easier to reason about what is valid for
each item. And we _could_ do things like allowing a short-option that is
also a flag-character, if we wanted to.

But IMHO such a refactoring can come later, or not at all. While it
might make the code a bit more clear, I don't think it meaningfully
improves the behavior. And either way, we should start with a minimal
and easy-to-verify fix like you have here.

-Peff
