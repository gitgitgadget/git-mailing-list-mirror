Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E0FC35679
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 06:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7E220661
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 06:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgBXGiD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 01:38:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:52456 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726452AbgBXGiD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 01:38:03 -0500
Received: (qmail 5653 invoked by uid 109); 24 Feb 2020 06:38:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Feb 2020 06:38:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7585 invoked by uid 111); 24 Feb 2020 06:47:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Feb 2020 01:47:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 24 Feb 2020 01:38:02 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use strpbrk(3) to search for characters from a given set
Message-ID: <20200224063802.GB1015967@coredump.intra.peff.net>
References: <4140dade-d999-a74a-1f8e-06eedb84ed20@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4140dade-d999-a74a-1f8e-06eedb84ed20@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 22, 2020 at 07:51:19PM +0100, René Scharfe wrote:

> We can check if certain characters are present in a string by calling
> strchr(3) on each of them, or we can pass them all to a single
> strpbrk(3) call.  The latter is shorter, less repetitive and slightly
> more efficient, so let's do that instead.

I think the resulting code is more readable, and this is worth doing on
those grounds alone.

I was curious whether it's always more efficient (tldr, it is; read on
only if you're also curious). The default glibc implementation of
strpbrk() is built on strcspn(). That in turn creates a 256-byte table
with a boolean flag set for each char in the accept string, and then
walks the haystack string doing O(1) lookups in the table for a hit. So
we have to memset() the table to zeroes at the start. Depending on the
length of the input string, that could be more expensive than just
walking the haystack string three times (one for each char in the accept
string).

But of course in practice there's all kinds of weird SSE assembly going
on behind the scenes. So in most of my tests, strpbrk() beats strchr()
handily. The one exception is when the first strchr() matches early in
the string and can short-circuit the rest of them.

The test I used was:

  $ cat foo.c
  #include <string.h>
  
  int check(const char *s)
  {
  #if USE_STRCHR
  	return strchr(s, '<') || strchr(s, '>') || strchr(s, '@');
  #else
  	return !!strpbrk(s, "@<>");
  #endif
  }

  $ cat bar.c 
  int check(const char *s);
  
  int main(int argc, const char **argv)
  {
  	int ret;
  	int i;
  
  	for (i = 0; i < 100000000; i++)
  		ret += check(argv[1]);
  	return ret & 0x7f;
  }
  

I put it into two separate files to avoid check() being hoisted out of
the loop. There's something a bit interesting, though. If you combine
those two files, gcc _does_ hoist the strpbrk() version, generating
this as the complete code:

	  subq    $8, %rsp
          .cfi_def_cfa_offset 16
          movq    8(%rsi), %rdi
          leaq    .LC0(%rip), %rsi
          call    strpbrk@PLT
          testq   %rax, %rax
          setne   %al
          addq    $8, %rsp
          .cfi_def_cfa_offset 8
          movzbl  %al, %eax
          movl    %eax, %edx
          imull   $99999999, %eax, %eax
          addl    %edx, %eax
          andl    $127, %eax
          ret

So it calls strpbrk() exactly once, then recognizes that the loop is
just adding up the same variable over and over and turns it into a
multiply. No loop at all; very cool (though I am puzzled why it doesn't
multiply by the full loop count; instead if multiplies by one less and
then adds back in one iteration).

But with strchr() it was less willing to do that (curiously, it will if
the function _isn't_ static, but won't if it is).

Anyway, that's all compiler arcana subject to change between versions,
and it's a dumb toy example anyway. But it does seem like the single
call is more likely to get inlined or hoisted by the compiler, which is
a point in its favor.

-Peff
