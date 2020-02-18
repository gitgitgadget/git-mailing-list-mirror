Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE393C34031
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 06:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E98207FD
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 06:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgBRGVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 01:21:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:46580 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726074AbgBRGVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 01:21:25 -0500
Received: (qmail 14639 invoked by uid 109); 18 Feb 2020 06:21:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Feb 2020 06:21:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14822 invoked by uid 111); 18 Feb 2020 06:30:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Feb 2020 01:30:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Feb 2020 01:21:24 -0500
From:   Jeff King <peff@peff.net>
To:     Robear Selwans <rwagih.rw@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC][RFC][PATCH 1/2] STRBUF_INIT_CONST: a new way to
 initialize strbuf
Message-ID: <20200218062124.GF1641086@coredump.intra.peff.net>
References: <20200218041805.10939-1-robear.selwans@outlook.com>
 <20200218041805.10939-2-robear.selwans@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200218041805.10939-2-robear.selwans@outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 18, 2020 at 04:18:04AM +0000, Robear Selwans wrote:

> A new function `STRBUF_INIT_CONST(const_str)` was added to allow for a
> quick initialization of strbuf.
> 
> Details:
> Using `STRBUF_INIT_CONST(str)` creates a new struct of type `strbuf` and
> initializes its `buf`, `len` and `alloc` as `str`, `strlen(str)` and
> `0`, respectively.
> 
> Use Case:
> This is meant to be used to initialize strbufs with constant values and
> thus, only allocating memory when needed.
> 
> Usage Example:
> ```
> strbuf env_var = STRBUF_INIT_CONST("dev");
> ```

This seems a bit dangerous to me, as we're initializing a non-const
pointer with a string literal. In fact, I'm a little surprised that the
compiler doesn't complain, but I think it's mostly due to historical
C-isms (the type of string literals is array-of-char). Using gcc's
-Wwrite-strings does complain, but there are several other cases already
in Git (looking at a few, I think there are some opportunities for
cleanup).

Your second patch catches cases where the strbuf functions want to write
to the buffer. But we've always been pretty open about the fact that
strbuf.buf is a writeable C-style string. So something like this:

  struct strbuf x = STRBUF_INIT_CONST("foo");
  size_t i;

  for (i = 0; i < x.len; i++)
	x.buf[i] = toupper(x.buf[i]);

would generate no compile-time warnings, but would invoke undefined
behavior (on my system it segfaults when run, but it could have even
more confusing outcomes). Even though this is called out specifically in
the strbuf docs:

   However, it is totally safe to modify anything in the string pointed
   by the `buf` member, between the indices `0` and `len-1` (inclusive).

Of course it would be easy to fix that by adding a strbuf_make_var()
call. But my concern is cases where the const-ness and the use of the
strbuf are far apart. The point of a strbuf is that you can just use it
without worrying, but now it's carrying this extra hidden state.

If we want to pursue this direction, I think we'd do better to give each
strbuf a matching array. Something like:

  #define STRBUF_INIT_FROM(buf) { .alloc = 0, .buf = buf, .len = ARRAY_SIZE(buf)-1 }
  ...
  char foo_buf[] = "this is the constant value";
  struct strbuf foo = STRBUF_INIT_FROM(foo_buf);

That gives you a true writeable buffer with the const data in it. _And_
it opens up the option of strbufs using stack buffers with an empty
initial value for efficiency (i.e., avoiding the heap at all for short
common cases, but being able to grow when needed). One trouble is that
you can't do it all in a single variable. You'd need something like:

  #define DECLARE_STACK_STRBUF(name, contents) \
	char name##_buf[] = (contents);
	struct strbuf name = STRBUF_INIT_FROM(name##_buf)
  ...
  DECLARE_STACK_STRBUF(foo, "this is the constant value");

But that gets weirdly un-C-like (your macro expands to multiple
statements, which is usually a macro pitfall; but we can't use the usual
"do { } while(0)" trick here, because the variables would go out of
scope at the end of the fake block.

So I think there are interesting directions here, but there's a lot of
stuff to figure out.

I notice you put GSoC in your subject line. If you're looking at this as
a microproject, IMHO this is _way_ more complicated and subtle than a
microproject should be. The goal there is to give something so easy that
you get to focus on getting your patches in and interacting with the
community. The scope I'd expect is more along the lines of compiling
with -Wwrite-strings and cleaning up some of the locations that
complain.

-Peff
