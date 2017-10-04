Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D2AF20281
	for <e@80x24.org>; Wed,  4 Oct 2017 10:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbdJDKTg (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 06:19:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:60312 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751327AbdJDKTe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 06:19:34 -0400
Received: (qmail 21130 invoked by uid 109); 4 Oct 2017 10:19:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Oct 2017 10:19:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16829 invoked by uid 111); 4 Oct 2017 10:19:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Oct 2017 06:19:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Oct 2017 06:19:32 -0400
Date:   Wed, 4 Oct 2017 06:19:32 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: playing with MSan, was Re: [PATCH 0/3] fixes for running the test
 suite with --valgrind
Message-ID: <20171004101932.pai6wzcv2eohsicr@sigill.intra.peff.net>
References: <20171003195713.13395-1-t.gummerer@gmail.com>
 <20171003234153.pmslizidgbifl6en@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171003234153.pmslizidgbifl6en@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2017 at 07:41:54PM -0400, Jeff King wrote:

> I think using SANITIZE=memory would catch these, but it needs some
> suppressions tuning. The weird "zlib reads uninitialized memory" error
> is a problem (valgrind sees this, too, but we have suppressions).

I dug into this a little more. You can blacklist certain functions from
getting MSan treatment, but that's not quite what we want. We want to
mark bytes from certain _sources_ as being initialized, even if MSan
doesn't agree.

And indeed, you can do that. As far as I can tell, MSan works by keeping
a shadow map of memory and setting flags when it believes it has been
initialized, and then checking that map when we make decisions based on
the memory. But it can only do that if it instruments all writes. So the
MSan documentation recommends that you build _everything_, including
libraries, with it. Which obviously we don't do if we're using a system
zlib. Or a system libc for that matter (though they intercept many
common libc functions to handle this).

So one strategy is to "cheat" a bit at the library interfaces, and claim
whatever they send us is properly initialized. The patch below tries
that with zlib, and it does seem to work. It would fail to notice a real
problem with any input we send _to_ the library (since the library isn't
instrumented, and we claim that whatever comes out of it is legitimate).
I could probably live with that.

But there are quite a few test failures that would still need
investigating and annotating:

  - Certainly it's confused by looking at regmatch_t results from
    regexec(). We can fix that by building with NO_REGEX. But pcre has
    a similar problem.

  - Ditto curl and openssl, whose exit points would need annotations.

  - For some reason test-sigchain segfaults when it raise()s in the
    signal handler and recurses. Not sure if this is an MSan bug or
    what.

So I dunno. This approach is a _lot_ more convenient than trying to
rebuild all the dependencies from scratch, and it runs way faster than
valgrind. It did find the cases that led to the patches in this
series, and at least one more: if the lstat() at the end of
entry.c:write_entry() fails, we write nonsense into the cache_entry.

I think we could probably get it to zero false positives without _too_
much effort. I'll stop here for tonight, but I may pick it up again
later (of course anybody else is welcome to fool around with it, too).

Below is the patch that let me run:

  make SANITIZE=memory CC=clang-6.0 NO_REGEX=1

and get a tractable number of errors.

-- >8 --
diff --git a/Makefile b/Makefile
index b143e4eea3..1da5c01211 100644
--- a/Makefile
+++ b/Makefile
@@ -1047,6 +1047,9 @@ endif
 ifneq ($(filter leak,$(SANITIZERS)),)
 BASIC_CFLAGS += -DSUPPRESS_ANNOTATED_LEAKS
 endif
+ifneq ($(filter memory,$(SANITIZERS)),)
+BASIC_CFLAGS += -DENABLE_MSAN_UNPOISON
+endif
 endif
 
 ifndef sysconfdir
diff --git a/git-compat-util.h b/git-compat-util.h
index cedad4d581..836a4c0b54 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1191,4 +1191,11 @@ extern void unleak_memory(const void *ptr, size_t len);
 #define UNLEAK(var) do {} while (0)
 #endif
 
+#ifdef ENABLE_MSAN_UNPOISON
+#include <sanitizer/msan_interface.h>
+#define msan_unpoison(ptr, len) __msan_unpoison(ptr, len)
+#else
+#define msan_unpoison(ptr, len) do {} while (0)
+#endif
+
 #endif
diff --git a/zlib.c b/zlib.c
index 4223f1a8c5..5fa8f12507 100644
--- a/zlib.c
+++ b/zlib.c
@@ -56,6 +56,8 @@ static void zlib_post_call(git_zstream *s)
 	if (s->z.total_in != s->total_in + bytes_consumed)
 		die("BUG: total_in mismatch");
 
+	msan_unpoison(s->next_out, bytes_produced);
+
 	s->total_out = s->z.total_out;
 	s->total_in = s->z.total_in;
 	s->next_in = s->z.next_in;
