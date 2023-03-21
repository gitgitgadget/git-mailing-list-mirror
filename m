Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180E0C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 17:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjCURlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 13:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCURlB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 13:41:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5EAF748
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 10:40:36 -0700 (PDT)
Received: (qmail 27866 invoked by uid 109); 21 Mar 2023 17:40:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Mar 2023 17:40:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2363 invoked by uid 111); 21 Mar 2023 17:40:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Mar 2023 13:40:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Mar 2023 13:40:33 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 3/6] pack-bitmap.c: drop unnecessary 'inline's
Message-ID: <20230321174033.GE3119834@coredump.intra.peff.net>
References: <cover.1679342296.git.me@ttaylorr.com>
 <2e3e3a7145a5851fcf5c485b38d14344c9b824d7.1679342296.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e3e3a7145a5851fcf5c485b38d14344c9b824d7.1679342296.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2023 at 04:02:46PM -0400, Taylor Blau wrote:

> Both `read_be32()` and `read_u8()` are defined as inline dating back
> to b5007211b6 (pack-bitmap: do not use gcc packed attribute,
> 2014-11-27), though that commit does not hint at why the functions were
> defined with that attribute.

I think any non-header inline like this can implicitly be assumed to be
"I thought it would make things faster". ;)

> However (at least with GCC 12.2.0, at the time of writing), the
> resulting pack-bitmap.o contains the same instructions with or without
> the inline attribute applied to these functions:
> 
>     $ make O=3 pack-bitmap.o && mv pack-bitmap.o{,.before}
>     [ apply this patch ]
>     $ make O=3 pack-bitmap.o && mv pack-bitmap.o{,.after}
>     $ objdump -d pack-bitmap.o.before >before
>     $ objdump -d pack-bitmap.o.after >after
>     $ diff -u pack-bitmap.o.{before,after}
>     --- before	2023-03-15 18:54:17.021580095 -0400
>     +++ after	2023-03-15 18:54:21.853552218 -0400
>     @@ -1,5 +1,5 @@
> 
>     -pack-bitmap.o.before:     file format elf64-x86-64
>     +pack-bitmap.o.after:     file format elf64-x86-64
> 
>      Disassembly of section .text:
> 
> So defining these functions as inline is at best a noop, and at worst
> confuses the reader into thinking that there is some trickier reason
> that they are defined as inline when there isn't.

Nice digging. The "inline" is really just a hint to the compiler here,
and obviously it does not need that hint. I do wonder if that is still
true after you make them more complicated in a later patch in the
series.

On the other hand, I doubt that these need to be very optimized at all.
If there were a tight loop of single-byte reads, the function overhead
might be noticeable. But generally we're reading only a few items from
the beginning of each entry, and then reading the bulk of the data via
ewah_read_mmap().

So I think the overall argument is "let the compiler decide what is good
to inline and what is not".

-Peff
