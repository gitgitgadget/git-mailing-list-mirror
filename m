Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB1417B418
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767338988; cv=none; b=dN+agRSX1kDVacLFRrvM0IO+t56no/ecA8pNW5zJcztzXyQ2s1EW6wH3AobwDffmz0kHzdyAnKJl7Tl/Vf8oQrFaRa6i0l4mMzO9/O+oqMKBEGuOYinyZVJrK+tXgAuQLZuU1NmUofZgTGvbEEcgxJKS9u5qapXh+y/qMNRn+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767338988; c=relaxed/simple;
	bh=7Zp64Zfhqs8CKlZFn7vkTaqTKh2W5RjK2ElyCvXDCtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anL8h6VmPCUIEsJ5yfsQcvXUi0PTRLPTz7b/fqED/H5h4qVoEykJd9BCK14ir8oPrAprkgi3q9MYeLdRXERoQVX6pTwmmavxlTgZ2ZMGMKRqtpWIWtOfcIcOYQ0AMlWfB0fvkzIKrpUZGVgxw5SB8d1XI90IUHF1rqNyhcqk/JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=X9r41I8w; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="X9r41I8w"
Received: (qmail 553091 invoked by uid 109); 2 Jan 2026 07:29:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=7Zp64Zfhqs8CKlZFn7vkTaqTKh2W5RjK2ElyCvXDCtI=; b=X9r41I8wj4L72Ph+1zUNpOIJ5p1Pw8FKLDJke0Fj5V8CctrkNBrLh14LGCK8H/LOz8OAbO/xNVrJp0gHaG35fmPCMjSjGCvtClt1QGYiQ5gU+gHtXhpZsbZIjoc3W0S9HYUpHVEVoj6/dR3YABt+KuMg719rO7xODX4YcKUdd/kT1hBMjH5YwQFTvl2ZrDprrISTiTM9PNYUKe7ETnMwoqU/LYQsPaaNh+NKN9W/o8qYzbSVt34GNMPF23jWzHnYuYGmvdH3F64y0mehKShi3txTn4fSiZXnqYyWxKdMPEUFdJTVXJx+Lh6+4pTx+M4f4ku5Ym9LPagKFRo8yAiV3Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Jan 2026 07:29:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 719624 invoked by uid 111); 2 Jan 2026 07:29:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Jan 2026 02:29:47 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 2 Jan 2026 02:29:43 -0500
From: Jeff King <peff@peff.net>
To: Rostislav Krasny <rostiprodev@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/1] compat: modernize and simplify byte swapping
 functions
Message-ID: <20260102072943.GB2581074@coredump.intra.peff.net>
References: <20260102002735.31390-1-rostiprodev@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260102002735.31390-1-rostiprodev@gmail.com>

On Fri, Jan 02, 2026 at 02:27:34AM +0200, Rostislav Krasny wrote:

> The main reason it was implemented so complicated is UB when conversion of a
> pointer to one object type into a pointer of a different object type is used.
> On the other hand, memcpy is protected from such UB and this allows us to make
> that code simpler and even more optimal, in some cases.

We actually used to do casts and unaligned loads on platforms that
allowed it (like x86). But what I measured in c578e29ba0 (bswap.h: drop
unaligned loads, 2020-09-24) indicated that it did not really help, and
the -O2-optimized long-hand code performed the same. So I'm a little
surprised that going back in that direction is beneficial. But my
numbers were all with gcc, and your improvement was seen with clang, so
let's see if we can tease out the reasons.

> #define ITERATIONS 1000000
> #define BUF_SIZE 8192
> 
> int main() {
>     uint8_t buffer[BUF_SIZE];
>     uint64_t sum = 0;
> 
>     for (int i = 0; i < BUF_SIZE; i++) {
>         buffer[i] = (uint8_t)i;
>     }
> 
>     clock_t start = clock();
> 
>     for (int i = 0; i < ITERATIONS; i++) {
>         // use a volatile pointer to force the compiler to read memory
>         volatile uint8_t *p = buffer; 
>         for (int j = 0; j < BUF_SIZE - 8; j++) {
>             sum += get_be64((const void*)(p + j));
>         }
>     }

OK, so this is a measure of pure be64 speeds. That's over-emphasizing
what we'd see in a real workload, but it should at least help us focus
on whether we can see any improvement.

You mentioned sha256 earlier, but it only has a single get_be32() call.
I couldn't measure any change with "test-tool sha256" before/after your
patch. For block-sha1, we'd see get_be32() calls, too, but these days
we'd almost always use the (much slower) sha1dc anyway.

It looks like you iterate byte by byte, so we do get some unaligned
calls there. Good.

I pulled this into Git itself to make it easier to test particular
builds, and to measure it with hyperfine (which introduces some extra
noise due to program startup and exit, but also gives us nicer
statistics):

diff --git a/common-main.c b/common-main.c
index 6b7ab077b0..9f19dfe68c 100644
--- a/common-main.c
+++ b/common-main.c
@@ -1,10 +1,31 @@
 #include "git-compat-util.h"
 #include "common-init.h"
 
+#define ITERATIONS 1000000
+#define BUF_SIZE 8192
+
 int main(int argc, const char **argv)
 {
 	int result;
 
+	uint8_t buffer[BUF_SIZE];
+	uint64_t sum = 0;
+
+	for (int i = 0; i < BUF_SIZE; i++) {
+		buffer[i] = (uint8_t)i;
+	}
+
+	for (int i = 0; i < ITERATIONS; i++) {
+		// use a volatile pointer to force the compiler to read memory
+		volatile uint8_t *p = buffer;
+		for (int j = 0; j < BUF_SIZE - 8; j++) {
+			sum += get_be64((const void*)(p + j));
+		}
+	}
+	printf("%"PRIuMAX, (uintmax_t)sum);
+	/* skip git stuff */
+	exit(0);
+
 	init_git(argv);
 	result = cmd_main(argc, argv);
 

> And these are the results:
> 
> GCC 15.2.1
> version |  -Os     |  -O0     |  -O1     |  -O2     |  -O3
> ================================================================
>         | 3.721806 |72.342204 |11.956021 | 3.119833 | 0.919873  
> original| 3.726111 |72.326920 |11.963618 | 3.128222 | 0.921128  
>         | 3.719791 |72.328175 |11.949108 | 3.130956 | 0.920296         
> ================================================================
>         | 3.719899 |17.177719 | 3.005065 | 3.120747 | 0.920609  
> new     | 3.714785 |17.168950 | 3.004978 | 3.119227 | 0.918851  
>         | 3.716782 |17.145386 | 3.009364 | 3.119573 | 0.920030  
> ================================================================

I think we can disregard the -O0 results. They're both horribly slow,
and for obvious reasons.

The -O2 results match what I saw back when I measured sha1 performance
(though I also wouldn't be surprised if get_be32() is lost in the noise
there). That was also with gcc. Testing again with the patch above, I
get similar results to you (actually a slight slowdown, but within the
statistical noise).

The -O3 results are interesting. Not because they change, but because
they outperform -O2 so handily in this case. I get similar results here.

The diff of the generated asm between o2 and o3 looks like this:

--- asm.o2	2026-01-02 01:51:35.312098163 -0500
+++ asm.o3	2026-01-02 01:51:45.744134814 -0500
@@ -19,6 +19,7 @@
 	movdqa	.LC0(%rip), %xmm2
 	movd	%edi, %xmm9
 	movl	$8, %edi
+	movq	%rsp, %rcx
 	movq	%rsp, %rax
 	movd	%edi, %xmm8
 	movl	$12, %edi
@@ -59,24 +60,23 @@
 	pand	%xmm5, %xmm0
 	packuswb	%xmm0, %xmm1
 	movaps	%xmm1, -16(%rax)
-	cmpq	%rdi, %rax
+	cmpq	%rax, %rdi
 	jne	.L2
-	movl	$1000000, %edi
+	leaq	8184(%rcx), %rdi
 	xorl	%esi, %esi
-	leaq	8184(%rsp), %rcx
 .L3:
-	movq	%rsp, %rax
-	.p2align 5
+	movq	(%rcx), %rdx
+	movl	$1000000, %eax
+	bswap	%rdx
+	.p2align 4
 	.p2align 4
 	.p2align 3
 .L4:
-	movq	(%rax), %rdx
-	addq	$1, %rax
-	bswap	%rdx
-	addq	%rdx, %rsi
-	cmpq	%rcx, %rax
+	leaq	(%rsi,%rdx,2), %rsi
+	subl	$2, %eax
 	jne	.L4
-	subl	$1, %edi
+	addq	$1, %rcx
+	cmpq	%rcx, %rdi
 	jne	.L3
 	leaq	.LC6(%rip), %rdi
 	xorl	%eax, %eax

It looks like the loops were inverted and the bswap was hoisted out of
the inner loop. ;) So that is really just an artifact of how this test
code was written (since we are summing, we do not care about iteration
order).

Oh well, a 3x speedup for -O3 was probably too good to be true anyway.

It feels like there is an easy optimization on top of that loop
inversion: rather than iterating and adding, we could just multiply by
ITERATIONS. And indeed, if we re-order the loops ourselves:

diff --git a/common-main.c b/common-main.c
index 9f19dfe68c..5960755dcc 100644
--- a/common-main.c
+++ b/common-main.c
@@ -15,11 +15,12 @@ int main(int argc, const char **argv)
 		buffer[i] = (uint8_t)i;
 	}
 
-	for (int i = 0; i < ITERATIONS; i++) {
+	for (int j = 0; j < BUF_SIZE - 8; j++) {
 		// use a volatile pointer to force the compiler to read memory
 		volatile uint8_t *p = buffer;
-		for (int j = 0; j < BUF_SIZE - 8; j++) {
-			sum += get_be64((const void*)(p + j));
+		uint64_t swapped = get_be64((const void *)(p + j));
+		for (int i = 0; i < ITERATIONS; i++) {
+			sum += swapped;
 		}
 	}
 	printf("%"PRIuMAX, (uintmax_t)sum);

then even at -O2 the whole thing runs in ~2ms, and the generated asm
looks like this:

        bswap   %rax
        imulq   $1000000, %rax, %rax
        addq    %rax, %rsi

It's a little funny that -O3 can do the loop inversion but misses the
multiplication. :)

> Clang 21.1.7
> version |  -Os     |  -O0     |  -O1     |  -O2     |  -O3
> ================================================================
>         | 3.690718 |62.916338 | 3.017460 | 3.768443 | 3.778840  
> original| 3.686283 |62.965916 | 3.014674 | 3.777897 | 3.774776  
>         | 3.687775 |62.850648 | 3.003496 | 3.766108 | 3.765313         
> ================================================================
>         | 3.681818 |16.753385 | 3.008131 | 2.075271 | 2.076090  
> new     | 3.687184 |16.737982 | 3.004365 | 2.071597 | 2.074507  
>         | 3.683960 |16.765067 | 2.999775 | 2.075354 | 2.075759  
> ================================================================

OK, so here we are getting into the interesting bits, I think. -O0 is
again not really that interesting. And -O3 here behaves like -O2, so
presumably it doesn't figure out the loop inversion.

But -O2 shows two interesting things. One, the existing code is much
slower with clang than gcc. And two, it gets much faster with your
patch. I was able to replicate both results.

For the first, diffing against gcc's -O2 asm might be interesting. Using
"diff" is not productive because there are too many other differences. A
cursory inspection by hand shows the inner loops pretty similar:

  gcc:
        movq    (%rax), %rdx
        addq    $1, %rax
        bswap   %rdx
        addq    %rdx, %rsi
        cmpq    %rcx, %rax
        jne     .L4

  clang:
        movq    -7(%rsp,%rcx), %rdx
        bswapq  %rdx
        addq    %rdx, %rsi
        incq    %rcx
        cmpq    $8191, %rcx                     # imm = 0x1FFF
        jne     .LBB0_4

I think the bswapq vs bswap difference is a red herring, since rdx is a
64-bit register and both should do a 64-bit swap. The loop counters are
handled a bit differently, but fundamentally we are just bswapping,
adding, and looping. I wonder why they perform so differently. But I
suspect it has more to do with the fake test looping and not get_be64()
itself.

So let's see what changes after your patch:

--- asm.old	2026-01-02 02:07:25.455631337 -0500
+++ asm.new	2026-01-02 02:17:40.702545167 -0500
@@ -87,15 +87,30 @@
 	.p2align	4
 .LBB0_3:                                # =>This Loop Header: Depth=1
                                         #     Child Loop BB0_4 Depth 2
-	movl	$7, %ecx
+	movl	$5, %ecx
 	.p2align	4
 .LBB0_4:                                #   Parent Loop BB0_3 Depth=1
                                         # =>  This Inner Loop Header: Depth=2
-	movq	-7(%rsp,%rcx), %rdx
+	movq	-5(%rsp,%rcx), %rdx
+	movq	-4(%rsp,%rcx), %rdi
 	bswapq	%rdx
+	bswapq	%rdi
+	addq	%rsi, %rdx
+	movq	-3(%rsp,%rcx), %r8
+	bswapq	%r8
+	addq	%rdi, %r8
+	movq	-2(%rsp,%rcx), %rsi
+	bswapq	%rsi
+	addq	%rdx, %r8
+	movq	-1(%rsp,%rcx), %rdx
+	bswapq	%rdx
+	addq	%rsi, %rdx
+	movq	(%rsp,%rcx), %rsi
+	bswapq	%rsi
 	addq	%rdx, %rsi
-	incq	%rcx
-	cmpq	$8191, %rcx                     # imm = 0x1FFF
+	addq	%r8, %rsi
+	addq	$6, %rcx
+	cmpq	$8189, %rcx                     # imm = 0x1FFD
 	jne	.LBB0_4
 # %bb.5:                                #   in Loop: Header=BB0_3 Depth=1
 	incl	%eax

Huh. So we do a bunch more bswap instructions, but move in larger chunks
through the loop. I didn't work out the details, but it looks like it's
taking advantage of the fact that we're bswapping overlapping bits of
memory (which is something a real program would hardly ever do).

If we tweak our program to just swap the whole buffer, 8 bytes at a
time:

diff --git a/common-main.c b/common-main.c
index 9f19dfe68c..55a7066c85 100644
--- a/common-main.c
+++ b/common-main.c
@@ -18,7 +18,7 @@ int main(int argc, const char **argv)
 	for (int i = 0; i < ITERATIONS; i++) {
 		// use a volatile pointer to force the compiler to read memory
 		volatile uint8_t *p = buffer;
-		for (int j = 0; j < BUF_SIZE - 8; j++) {
+		for (int j = 0; j < BUF_SIZE; j += 8) {
 			sum += get_be64((const void*)(p + j));
 		}
 	}

then the difference before/after your patch goes away:

  Benchmark 1: ./git.old.clang.o2
    Time (mean ± σ):     482.9 ms ±   7.2 ms    [User: 482.5 ms, System: 0.4 ms]
    Range (min … max):   471.7 ms … 495.3 ms    10 runs
  
  Benchmark 2: ./git.new.clang.o2
    Time (mean ± σ):     472.4 ms ±   4.5 ms    [User: 471.6 ms, System: 0.8 ms]
    Range (min … max):   465.3 ms … 477.8 ms    10 runs
  
  Summary
    ./git.new.clang.o2 ran
      1.02 ± 0.02 times faster than ./git.old.clang.o2

Note that everything is 8x faster than before because we are doing 8x
fewer bswaps. But the time doesn't change before/after the patch.

So what does it all mean?

I _think_ most of the speed differences we've seen are artifacts of the
test program, and not a big difference in how get_be64() is being
implemented. We end up with bswap instructions either way. I could be
wrong, though; there were a lot of versions to juggle, and I'm pretty
bad at reading assembly language.

All that said, I'm not particularly opposed to your patch. The memcpy
version may be easier to read. I'm just a little skeptical that it
provides performance improvements.

-Peff
