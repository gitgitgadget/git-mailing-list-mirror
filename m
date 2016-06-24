Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0562C2018A
	for <e@80x24.org>; Fri, 24 Jun 2016 17:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbcFXRUl (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 13:20:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:59798 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751394AbcFXRUk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 13:20:40 -0400
Received: (qmail 25181 invoked by uid 102); 24 Jun 2016 17:20:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 13:20:39 -0400
Received: (qmail 20922 invoked by uid 107); 24 Jun 2016 17:20:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 13:20:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jun 2016 13:20:37 -0400
Date:	Fri, 24 Jun 2016 13:20:37 -0400
From:	Jeff King <peff@peff.net>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	matthieu moy <matthieu.moy@grenoble-inp.fr>
Subject: Re: [PATCH 0/2] strbuf: improve API
Message-ID: <20160624172037.GA3273@sigill.intra.peff.net>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
 <1069084553.156626.1464607928755.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <20160601074218.GB14096@sigill.intra.peff.net>
 <20160601210713.GA18118@sigill.intra.peff.net>
 <5750147C.5060609@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5750147C.5060609@alum.mit.edu>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 02, 2016 at 01:11:56PM +0200, Michael Haggerty wrote:

> On 06/01/2016 11:07 PM, Jeff King wrote:
> > On Wed, Jun 01, 2016 at 03:42:18AM -0400, Jeff King wrote:
> > 
> >> I have no idea if those ideas would work. But I wouldn't want to start
> >> looking into either of them without some idea of how much time we're
> >> actually spending on strbuf mallocs (or how much time we would spend if
> >> strbufs were used in some proposed sites).
> > 
> > So I tried to come up with some numbers.
> > 
> > Here's an utterly silly use of strbufs, but one that I think should
> > over-emphasize the effect of any improvements we make:
> [...]
> 
> Thanks for generating actual data.

Thanks for following up on this, and sorry for my slow response. It got
put in my "to think about and respond to later" pile (never a good place
to be :) ).

> Your benchmark could do two things to stress malloc()/free()
> even more. I'm not claiming that this makes the benchmark more typical
> of real-world use, but it maybe gets us closer to the theoretical upper
> limit on improvement.

Yeah, you're right. I added more writes to try to actually stimulate the
strbuf to grow, but if the point is to call malloc in a tight loop, it
works against that (I agree that malloc-in-a-tight-loop does not
necessarily represent a real workload, but I think the point of this
exercise is to make sure we can get a useful speedup even under
theoretical conditions).

> I ran this for a short string ("short") and a long string ("this is a
> string that we will repeatedly insert"), and also concatenating the
> string 5, 20, or 500 times. The number of loops around the whole program
> is normalized to make the total number of concatenations approximately
> constant. Here are the full results:

I suspect "5 short" and "5 long" are the only really interesting cases.
For the cases we're talking about, the author clearly expects most input
to fit into a single small-ish allocation (or else they would not bother
with the fixed strbuf in the first place). So "500 long" is really just
exercising memcpy.

> Test                   0      1      2      3      4
> ----------------------------------------------------
> 5 short strings     1.64   3.37   8.72   6.08   3.65
> 20 short strings    1.72   2.12   5.43   4.01   3.39
> 500 short strings   1.62   1.61   3.36   3.26   3.10
> 5 long strings      2.08   6.64  13.09   8.50   3.79
> 20 long strings     2.16   3.33   7.03   4.72   3.55
> 500 long strings    2.04   2.10   3.61   3.33   3.26
> 
> 
> Column 0 is approximately the "bare metal" approach, with a
> pre-allocated buffer and no strbuf overhead.
> 
> Column 1 is like column 0, except allocating a correctly-sized buffer
> each time through the loop. This increases the runtime by as much as 219%.

Makes sense. malloc() isn't free (no pun intended).

And I think this shows why the 20/500 cases aren't all that interesting,
as we really just end up measuring memcpy.

> Column 2 is a naive use of strbuf, where each time through the loop the
> strbuf is reinitialized to STRBUF_INIT, and managing the space is
> entirely left to strbuf.

I'd think this would be about the same as column 1 for our interesting
cases, modulo some strbuf overhead. But it's way higher. That implies
that either:

  1. Strbuf overhead is high (and I think in a really tight loop like
     this that things like our overflow checks might start to matter; we
     could be doing those with intrinsics, for example).

  2. We're doing multiple mallocs per strbuf, which implies our initial
     sizes could be a bit more aggressive (it's not like the 30-byte
     "short" case is that huge).

> Column 3 is like column 2, except that it initializes the strbuf to the
> correct size right away using strbuf_init(). This reduces the runtime
> relative to column 2 by as much as 35%.

That should show us the effects of multiple-allocations (my (2) above).
And indeed, it counts for some of it but not all.

> Column 4 uses a simulated "fixed strbuf", where the fixed-size buffer is
> big enough for the full string (thus there are no calls to
> malloc()/realloc()/free()).
> 
> The comparison between columns 0 and 4 shows that using a strbuf costs
> as much as 123% more than using a simple char array, even if the strbuf
> doesn't have to do any memory allocations.

Yeah, I can believe there is overhead in all of the "are we big enough"
checks (though I'd hope that for the no-allocation cases we simply rely
on snprintf to tell us "yes, you fit").

> The comparison between columns 3 and 4 shows savings a reduction in
> runtime of up to 55% from using a "fixed strbuf" rather than a pre-sized
> conventional strbuf. I think this is the comparison that is most
> relevant to the current discussion.

I'm including a patch at the end of this mail that implements a "variant
5", which essentially keeps a single-buffer cache of the last-released
strbuf, and reuses it. Other than that, it is identical to 2 (no tricks,
not even a size hint, in the caller).

That skips the malloc/free cycle entirely for loops like this (or any
where your malloc/free are matched, and you're not using multiple
strbufs or interleaving detached ones).

Here are the numbers from my machine with that variant added in:

Test                    0      1      2      3      4      5
------------------------------------------------------------
5 short strings      1.99   3.95   8.80   5.96   3.56   3.53
20 short strings     2.00   2.49   5.44   3.83   3.29   3.22
500 short strings    1.86   1.90   3.21   3.00   2.99   3.00
5 long strings       2.22   5.30  12.07   7.47   3.71   3.50
20 long strings      2.31   2.97   6.99   4.37   3.39   3.32
500 long strings     2.14   2.16   3.50   3.14   3.14   3.46

Unsurprisingly, it performs about as well as the fixed buffer on this
test, because this is the optimal case for it. The question remains open
whether it would do so in real code practice (I also ignored threading
in my patch, which might add some overhead).

But it also shows that glibc malloc is kind of expensive. I expected it
to be able to optimize this case pretty well. I tried running your tests
against tcmalloc. It's definitely better than glibc, but still not as
fast as either variants 4 or 5.

> Of course strbuf manipulation (especially of small numbers of strings)
> is unlikely to be a big fraction of the workload of any Git command, so
> this is far from proof that this optimization is worthwhile in terms of
> code complexity. But I am still moderately in favor of the idea, for two
> reasons:
> 
> 1. The amount of added code complexity is small and quite
>    encapsulated.

Actually, this is the part I am most concerned about. The code itself is
encapsulated, but it adds a new decision to every caller: should I be
using a stack buffer? How big?

I already hate the "hint" field for the same reason. It's just one more
complication to think about during writing and review.

That's why I prefer something like my variant-5, even if it ends up
being more code (e.g., to do thread-local storage). It means things Just
Work, and the caller does not have to care about micro-optimizing.

> 2. The ability to use strbufs without having to allocate memory might
>    make enough *psychological* difference that it encourages some
>    devs to use strbufs where they would otherwise have done manual
>    memory management. I think this would be a *big* win in terms of
>    potential bugs and security vulnerabilities avoided.

Yeah, I agree there is definitely a psychological difference. I was
hoping to provide evidence that it's merely superstition to combat that.
Unfortunately, this conversation has left me less certain than ever. :)

-Peff

---
diff --git a/strbuf.c b/strbuf.c
index 1ba600b..ec40c1a 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -18,6 +18,10 @@ int starts_with(const char *str, const char *prefix)
  */
 char strbuf_slopbuf[1];
 
+int use_buf_cache;
+static char *buf_cache;
+static size_t alloc_cache;
+
 void strbuf_init(struct strbuf *sb, size_t hint)
 {
 	sb->alloc = sb->len = 0;
@@ -29,7 +33,12 @@ void strbuf_init(struct strbuf *sb, size_t hint)
 void strbuf_release(struct strbuf *sb)
 {
 	if (sb->alloc) {
-		free(sb->buf);
+		if (use_buf_cache && !buf_cache && sb->len < 4096) {
+			buf_cache = sb->buf;
+			alloc_cache = sb->alloc;
+		} else {
+			free(sb->buf);
+		}
 		strbuf_init(sb, 0);
 	}
 }
@@ -61,8 +70,16 @@ void strbuf_grow(struct strbuf *sb, size_t extra)
 	if (unsigned_add_overflows(extra, 1) ||
 	    unsigned_add_overflows(sb->len, extra + 1))
 		die("you want to use way too much memory");
-	if (new_buf)
-		sb->buf = NULL;
+	if (new_buf) {
+		if (buf_cache) {
+			sb->buf = buf_cache;
+			sb->alloc = alloc_cache;
+			buf_cache = NULL;
+			alloc_cache = 0;
+		} else {
+			sb->buf = NULL;
+		}
+	}
 	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
 	if (new_buf)
 		sb->buf[0] = '\0';
diff --git a/t/helper/test-strbuf-perf.c b/t/helper/test-strbuf-perf.c
index 13c437c..516905a 100644
--- a/t/helper/test-strbuf-perf.c
+++ b/t/helper/test-strbuf-perf.c
@@ -13,6 +13,8 @@
 #include "git-compat-util.h"
 #include "strbuf.h"
 
+extern int use_buf_cache;
+
 int main(int argc, char *argv[])
 {
 	const char *str;
@@ -55,6 +57,9 @@ int main(int argc, char *argv[])
 	}
 	fprintf(stderr, "count = '%d'\n", count);
 
+	if (variant == 5)
+		use_buf_cache = 1;
+
 	big_constant_lifetime_buf = xmalloc(total_len + 1);
 	for (i = 0; i < count; i++) {
 		int j;
@@ -72,7 +77,7 @@ int main(int argc, char *argv[])
 				strcpy(buf + j * len, str);
 
 			free(buf);
-		} else if (variant == 2) {
+		} else if (variant == 2 || variant == 5) {
 			/* Conventional use of strbuf */
 			struct strbuf buf = STRBUF_INIT;
 
diff --git a/t/perf/p0003-strbuf.sh b/t/perf/p0003-strbuf.sh
index 2be1908..5530197 100755
--- a/t/perf/p0003-strbuf.sh
+++ b/t/perf/p0003-strbuf.sh
@@ -5,7 +5,7 @@ test_description='Benchmark different uses of strbuf'
 
 test_perf_default_repo
 
-for variant in $(seq 0 4)
+for variant in $(seq 0 5)
 do
 	export variant
 	test_perf "variant $variant, 5 short strings" '
@@ -13,7 +13,7 @@ do
 	'
 done
 
-for variant in $(seq 0 4)
+for variant in $(seq 0 5)
 do
 	export variant
 	test_perf "variant $variant, 20 short strings" '
@@ -21,7 +21,7 @@ do
 	'
 done
 
-for variant in $(seq 0 4)
+for variant in $(seq 0 5)
 do
 	export variant
 	test_perf "variant $variant, 500 short strings" '
@@ -29,7 +29,7 @@ do
 	'
 done
 
-for variant in $(seq 0 4)
+for variant in $(seq 0 5)
 do
 	export variant
 	test_perf "variant $variant, 5 long strings" '
@@ -37,7 +37,7 @@ do
 	'
 done
 
-for variant in $(seq 0 4)
+for variant in $(seq 0 5)
 do
 	export variant
 	test_perf "variant $variant, 20 long strings" '
@@ -45,7 +45,7 @@ do
 	'
 done
 
-for variant in $(seq 0 4)
+for variant in $(seq 0 5)
 do
 	export variant
 	test_perf "variant $variant, 500 long strings" '
