Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 560661FF40
	for <e@80x24.org>; Thu,  1 Dec 2016 04:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757849AbcLAExB (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 23:53:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:49564 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755322AbcLAExA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 23:53:00 -0500
Received: (qmail 17820 invoked by uid 109); 1 Dec 2016 04:52:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 04:52:46 +0000
Received: (qmail 29221 invoked by uid 111); 1 Dec 2016 04:53:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Nov 2016 23:53:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Nov 2016 23:52:43 -0500
Date:   Wed, 30 Nov 2016 23:52:43 -0500
From:   Jeff King <peff@peff.net>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] xdiff: Do not enable XDL_FAST_HASH by default
Message-ID: <20161201045243.mlr7wqvkbm2yd37m@sigill.intra.peff.net>
References: <alpine.DEB.2.10.1611302310240.20145@buzzword-bingo.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.10.1611302310240.20145@buzzword-bingo.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 11:26:43PM -0500, Anders Kaseorg wrote:

> > So I suspect a better strategy in general is to just override the
> > uname_* variables when cross-compiling.
> 
> The specific case of an i386 userspace on an x86_64 kernel is important 
> independently of the general cross compilation problem (in fact, the words 
> “cross compilation” may not even really apply here).  And I don’t think 
> one should have to manually tweak the build for this setup, especially 
> since the compiler already has the needed information.

Ah, I mistook that you were really cross-compiling x86-64 from i386, in
which case you'd generally have to set CC, etc for the cross-compile
chain. I agree this is a much more subtle case, and it's nice for it to
work out of the box.

> diff --git a/Makefile b/Makefile
> index f53fcc90d..c237d4f91 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -341,7 +341,6 @@ all::
>  # Define XDL_FAST_HASH to use an alternative line-hashing method in
>  # the diff algorithm.  It gives a nice speedup if your processor has
>  # fast unaligned word loads.  Does NOT work on big-endian systems!
> -# Enabled by default on x86_64.

This is a nice incremental step in the sense that people can still
enable it if they want to in order to time it, play with it, etc. But
given what we know, I wonder if the help text here should warn people.

Or I guess we could move straight to dropping it entirely.

Here's what that patch might look like (I retimed it just be sure, and
was sad to see that it really _is_ making some cases faster. But I still
think slower-but-predictable is a better default).

I didn't drop uname_M here. If we go this route, I think it would make
sense to do that in a separate patch on top, with your commit message
explaining why it is a bad idea versus using compiler-defined macros.

-- >8 --
Subject: [PATCH] xdiff: drop XDL_FAST_HASH

The xdiff code hashes every line of both sides of a diff,
and then compares those hashes to find duplicates. The
overall performance depends both on how fast we can compute
the hashes, but also on how many hash collisions we see.

The idea of XDL_FAST_HASH is to speed up the hash
computation. But the generated hashes have worse collision
behavior. This means that in some cases it speeds diffs up
(running "git log -p" on git.git improves by ~8% with it),
but in others it can slow things down. One pathological case
saw over a 100x slowdown[1].

There may be a better hash function that covers both
properties, but in the meantime we are better off with the
original hash. It's slightly slower in the common case, but
it has fewer surprising pathological cases.

[1] http://public-inbox.org/git/20141222041944.GA441@peff.net/

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile         |   9 -----
 config.mak.uname |   3 --
 xdiff/xutils.c   | 106 -------------------------------------------------------
 3 files changed, 118 deletions(-)

diff --git a/Makefile b/Makefile
index f53fcc90d..f61076997 100644
--- a/Makefile
+++ b/Makefile
@@ -338,11 +338,6 @@ all::
 #
 # Define NATIVE_CRLF if your platform uses CRLF for line endings.
 #
-# Define XDL_FAST_HASH to use an alternative line-hashing method in
-# the diff algorithm.  It gives a nice speedup if your processor has
-# fast unaligned word loads.  Does NOT work on big-endian systems!
-# Enabled by default on x86_64.
-#
 # Define GIT_USER_AGENT if you want to change how git identifies itself during
 # network interactions.  The default is "git/$(GIT_VERSION)".
 #
@@ -1485,10 +1480,6 @@ ifndef NO_MSGFMT_EXTENDED_OPTIONS
 	MSGFMT += --check --statistics
 endif
 
-ifneq (,$(XDL_FAST_HASH))
-	BASIC_CFLAGS += -DXDL_FAST_HASH
-endif
-
 ifdef GMTIME_UNRELIABLE_ERRORS
 	COMPAT_OBJS += compat/gmtime.o
 	BASIC_CFLAGS += -DGMTIME_UNRELIABLE_ERRORS
diff --git a/config.mak.uname b/config.mak.uname
index b232908f8..447f36ac2 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -17,9 +17,6 @@ endif
 # because maintaining the nesting to match is a pain.  If
 # we had "elif" things would have been much nicer...
 
-ifeq ($(uname_M),x86_64)
-	XDL_FAST_HASH = YesPlease
-endif
 ifeq ($(uname_S),OSF1)
 	# Need this for u_short definitions et al
 	BASIC_CFLAGS += -D_OSF_SOURCE
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 027192a1c..04d7b32e4 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -264,110 +264,6 @@ static unsigned long xdl_hash_record_with_whitespace(char const **data,
 	return ha;
 }
 
-#ifdef XDL_FAST_HASH
-
-#define REPEAT_BYTE(x)  ((~0ul / 0xff) * (x))
-
-#define ONEBYTES	REPEAT_BYTE(0x01)
-#define NEWLINEBYTES	REPEAT_BYTE(0x0a)
-#define HIGHBITS	REPEAT_BYTE(0x80)
-
-/* Return the high bit set in the first byte that is a zero */
-static inline unsigned long has_zero(unsigned long a)
-{
-	return ((a - ONEBYTES) & ~a) & HIGHBITS;
-}
-
-static inline long count_masked_bytes(unsigned long mask)
-{
-	if (sizeof(long) == 8) {
-		/*
-		 * Jan Achrenius on G+: microoptimized version of
-		 * the simpler "(mask & ONEBYTES) * ONEBYTES >> 56"
-		 * that works for the bytemasks without having to
-		 * mask them first.
-		 */
-		/*
-		 * return mask * 0x0001020304050608 >> 56;
-		 *
-		 * Doing it like this avoids warnings on 32-bit machines.
-		 */
-		long a = (REPEAT_BYTE(0x01) / 0xff + 1);
-		return mask * a >> (sizeof(long) * 7);
-	} else {
-		/* Carl Chatfield / Jan Achrenius G+ version for 32-bit */
-		/* (000000 0000ff 00ffff ffffff) -> ( 1 1 2 3 ) */
-		long a = (0x0ff0001 + mask) >> 23;
-		/* Fix the 1 for 00 case */
-		return a & mask;
-	}
-}
-
-unsigned long xdl_hash_record(char const **data, char const *top, long flags)
-{
-	unsigned long hash = 5381;
-	unsigned long a = 0, mask = 0;
-	char const *ptr = *data;
-	char const *end = top - sizeof(unsigned long) + 1;
-
-	if (flags & XDF_WHITESPACE_FLAGS)
-		return xdl_hash_record_with_whitespace(data, top, flags);
-
-	ptr -= sizeof(unsigned long);
-	do {
-		hash += hash << 5;
-		hash ^= a;
-		ptr += sizeof(unsigned long);
-		if (ptr >= end)
-			break;
-		a = *(unsigned long *)ptr;
-		/* Do we have any '\n' bytes in this word? */
-		mask = has_zero(a ^ NEWLINEBYTES);
-	} while (!mask);
-
-	if (ptr >= end) {
-		/*
-		 * There is only a partial word left at the end of the
-		 * buffer. Because we may work with a memory mapping,
-		 * we have to grab the rest byte by byte instead of
-		 * blindly reading it.
-		 *
-		 * To avoid problems with masking in a signed value,
-		 * we use an unsigned char here.
-		 */
-		const char *p;
-		for (p = top - 1; p >= ptr; p--)
-			a = (a << 8) + *((const unsigned char *)p);
-		mask = has_zero(a ^ NEWLINEBYTES);
-		if (!mask)
-			/*
-			 * No '\n' found in the partial word.  Make a
-			 * mask that matches what we read.
-			 */
-			mask = 1UL << (8 * (top - ptr) + 7);
-	}
-
-	/* The mask *below* the first high bit set */
-	mask = (mask - 1) & ~mask;
-	mask >>= 7;
-	hash += hash << 5;
-	hash ^= a & mask;
-
-	/* Advance past the last (possibly partial) word */
-	ptr += count_masked_bytes(mask);
-
-	if (ptr < top) {
-		assert(*ptr == '\n');
-		ptr++;
-	}
-
-	*data = ptr;
-
-	return hash;
-}
-
-#else /* XDL_FAST_HASH */
-
 unsigned long xdl_hash_record(char const **data, char const *top, long flags) {
 	unsigned long ha = 5381;
 	char const *ptr = *data;
@@ -384,8 +280,6 @@ unsigned long xdl_hash_record(char const **data, char const *top, long flags) {
 	return ha;
 }
 
-#endif /* XDL_FAST_HASH */
-
 unsigned int xdl_hashbits(unsigned int size) {
 	unsigned int val = 1, bits = 0;
 
-- 
2.11.0.319.gd1e73eb

