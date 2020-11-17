Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3374BC2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 22:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DED3021D40
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 22:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgKQWyD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 17:54:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:33072 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbgKQWyC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 17:54:02 -0500
Received: (qmail 19130 invoked by uid 109); 17 Nov 2020 22:54:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Nov 2020 22:54:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5058 invoked by uid 111); 17 Nov 2020 22:54:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Nov 2020 17:54:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 17 Nov 2020 17:54:01 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] list-objects-filter-options: fix function name in BUG
Message-ID: <20201117225401.GA642410@coredump.intra.peff.net>
References: <20201114084327.14891-1-martin.agren@gmail.com>
 <20201117021318.GA30463@coredump.intra.peff.net>
 <CAN0heSoGnAKjTz2tiHpe2==Y-w7M03eiEpW2hU67FRbv=G+H8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSoGnAKjTz2tiHpe2==Y-w7M03eiEpW2hU67FRbv=G+H8w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 07:02:19PM +0100, Martin Ågren wrote:

> > But as a general rule, I don't think we even need to include function
> > names here. The message would look like:
> >
> >   BUG: list-objects-filter-options.c:20: list_object_filter_choice_name: invalid argument '3'
> >
> > which already tells us where the code is[1]. Perhaps:
> >
> >   BUG("invalid filter choice enum: %d", c);
> >
> > would be shorter but equally informative (I don't overly care here,
> > since the idea is that nobody sees it, but just making a point about the
> > future).
> 
> Having the function name or something else making the string unique
> across the codebase could be useful if the compiler doesn't support
> variadic macros -- we'll fall back to using a function instead of a
> macro, and can't use __FILE__ and __LINE__. (You obviously know all of
> this, having written d8193743e0 ("usage.c: add BUG() function",
> 2017-05-12).)

My feeling is that we shouldn't care too much about platforms without
variadic macros. AFAIK they are an extreme minority at this point, if
they exist at all. We are being nice by making Git compile at all on
such platforms, but I don't want people doing normal development work
(like writing trace or bug calls) to have to be thinking too much about
it.

I actually wonder if it is time to drop HAVE_VARIADIC_MACROS completely.
They are in C99, and we have been introducing many other C99-isms. It
would be a minor cleanup to a few bits of code, which perhaps isn't
worth the risk. But I also have a vague memory of not being able to
implement some interfaces because we couldn't count on them.

Poking around, 3689539127 (add helpers for allocating flex-array
structs, 2016-02-22) points out one such case. I think discussion of
BUG_ON() got blocked by that, too. Looks like we also discussed them in
the big "C99 weather balloon" thread:

  https://lore.kernel.org/git/20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net/

Maybe it's time for something like this as a test:

diff --git a/git-compat-util.h b/git-compat-util.h
index 2fd9d5b403..fe5de2239f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1194,14 +1194,9 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
 /* usage.c: only to be used for testing BUG() implementation (see test-tool) */
 extern int BUG_exit_code;
 
-#ifdef HAVE_VARIADIC_MACROS
 __attribute__((format (printf, 3, 4))) NORETURN
 void BUG_fl(const char *file, int line, const char *fmt, ...);
 #define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
-#else
-__attribute__((format (printf, 1, 2))) NORETURN
-void BUG(const char *fmt, ...);
-#endif
 
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
diff --git a/usage.c b/usage.c
index 06665823a2..b72f48f70e 100644
--- a/usage.c
+++ b/usage.c
@@ -273,23 +273,13 @@ static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_lis
 	abort();
 }
 
-#ifdef HAVE_VARIADIC_MACROS
 NORETURN void BUG_fl(const char *file, int line, const char *fmt, ...)
 {
 	va_list ap;
 	va_start(ap, fmt);
 	BUG_vfl(file, line, fmt, ap);
 	va_end(ap);
 }
-#else
-NORETURN void BUG(const char *fmt, ...)
-{
-	va_list ap;
-	va_start(ap, fmt);
-	BUG_vfl(NULL, 0, fmt, ap);
-	va_end(ap);
-}
-#endif
 
 #ifdef SUPPRESS_ANNOTATED_LEAKS
 void unleak_memory(const void *ptr, size_t len)
