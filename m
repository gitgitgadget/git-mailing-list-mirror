Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59196C433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 02:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32F5560F9D
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 02:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhKDCNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 22:13:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:52716 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230511AbhKDCNp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 22:13:45 -0400
Received: (qmail 6554 invoked by uid 109); 4 Nov 2021 02:11:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Nov 2021 02:11:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27416 invoked by uid 111); 4 Nov 2021 02:11:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Nov 2021 22:11:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 3 Nov 2021 22:11:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dongsheng Song <dongsheng.song@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf_addftime(): handle "%s" manually
Message-ID: <YYNBOp4QDwG9ctHE@coredump.intra.peff.net>
References: <CAE8XmWpK0ubcTXOaxBKGKh1qU+73Rr181wMAM7KAAX_A5PEYOw@mail.gmail.com>
 <YX5Zo9uV7qG73p6R@coredump.intra.peff.net>
 <CAE8XmWqexT89v0R+iVcjOHF+WsF1caMu+toY_gyNmJ6BU_L=ZQ@mail.gmail.com>
 <xmqqcznldobz.fsf@gitster.g>
 <YX9nLJZXB3rOrMru@coredump.intra.peff.net>
 <xmqq1r3zd9k5.fsf@gitster.g>
 <YYEihoLbEGi44dDb@coredump.intra.peff.net>
 <xmqqtugt56i7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtugt56i7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 03, 2021 at 01:28:00PM -0700, Junio C Hamano wrote:

> I think this also needs squashing in?
> 
>  Documentation/rev-list-options.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git c/Documentation/rev-list-options.txt w/Documentation/rev-list-options.txt
> index 24569b06d1..43a86fa562 100644
> --- c/Documentation/rev-list-options.txt
> +++ w/Documentation/rev-list-options.txt
> @@ -1047,7 +1047,7 @@ omitted.
>  has no effect.
>  
>  `--date=format:...` feeds the format `...` to your system `strftime`,
> -except for %z and %Z, which are handled internally.
> +except for %s, %z, and %Z, which are handled internally.
>  Use `--date=format:%c` to show the date in your system locale's
>  preferred format.  See the `strftime` manual for a complete list of
>  format placeholders. When using `-local`, the correct syntax is

Ah, thanks. I didn't even think to look in the documentation, because I
didn't imagine that we would expose these implementation details. But
since we do mention %z there, I think adding %s makes sense.

BTW, I also noticed that stftime supports some locale modifiers. So
"%Es" ends up printing the epoch seconds, but eludes our manual
intervention (and so does the old, wrong thing). I'm fine with stopping
here, though. There's no reason to use %Es over %s (from what I gather,
the %E is about handling year eras for locales that support them, but
that's meaningless for an epoch time), and I'm not sure it is even a
portable thing (glibc does not mention it in the manpage along with
other %E values, but it does work; POSIX does not even define %s, so of
course does not mention %Es).

-Peff
