Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF166C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 03:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbhLJDnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 22:43:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:48406 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231314AbhLJDnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 22:43:16 -0500
Received: (qmail 16578 invoked by uid 109); 10 Dec 2021 03:39:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Dec 2021 03:39:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26172 invoked by uid 111); 10 Dec 2021 03:39:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Dec 2021 22:39:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Dec 2021 22:39:41 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 02/10] range-diff.c: don't use st_mult() for signed
 "int"
Message-ID: <YbLL/YWbjc/sPRyH@coredump.intra.peff.net>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
 <RFC-patch-02.10-bd7d014c531-20211209T191653Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <RFC-patch-02.10-bd7d014c531-20211209T191653Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 09, 2021 at 08:19:19PM +0100, Ævar Arnfjörð Bjarmason wrote:

> As documented in 320d0b493a2 (add helpers for detecting size_t
> overflow, 2016-02-19) the arguments to st_mult() and st_add() "must be
> unsigned".

This isn't correct. The comment that says "must be unsigned" is for
unsigned_mult_overflows(). Which indeed would not work correctly for a
signed type. But st_add() is a separate function (and not a macro)
because that means its arguments will always be promoted or converted
into a size_t. And so no matter what you pass it, it will always itself
pass a size_t into unsigned_mult_overflows().

> In subsequent commits further overflows resulting in segfaults will be
> fixed in this code, but let's start by removing this supposed guard
> that does nothing except give us a false sense of
> security. E.g. providing an "n" of INT_MAX here will result in "1" on
> my system, causing us to write into memory.

This guard doesn't do nothing. Your patch here:

> @@ -312,7 +312,7 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
>  	int *cost, c, *a2b, *b2a;
>  	int i, j;
>  
> -	ALLOC_ARRAY(cost, st_mult(n, n));
> +	ALLOC_ARRAY(cost, n * n);
>  	ALLOC_ARRAY(a2b, n);
>  	ALLOC_ARRAY(b2a, n);

makes things strictly worse, because that "n * n" may overflow and cause
us to under-allocate the array. You can see it in isolation with some
extra code like this:

diff --git a/git.c b/git.c
index 5ff21be21f..63349e4b79 100644
--- a/git.c
+++ b/git.c
@@ -850,11 +850,23 @@ static int run_argv(int *argcp, const char ***argv)
 	return done_alias;
 }
 
+static void foo(void)
+{
+	int n = 2 << 16;
+
+	printf("n = %d\n", n);
+	printf("raw mult = %"PRIuMAX"\n", (uintmax_t)(n * n));
+	printf("st_mult = %"PRIuMAX"\n", (uintmax_t)st_mult(n, n));
+	exit(0);
+}
+
 int cmd_main(int argc, const char **argv)
 {
 	const char *cmd;
 	int done_help = 0;
 
+	foo();
+
 	cmd = argv[0];
 	if (!cmd)
 		cmd = "git-help";

With st_mult, we get the correct answer of 16GB. Without it, we end up
with 0!

Back to the original code, if you generate a test setup like this:

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index e30bc48a29..f552d3086e 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -772,4 +772,11 @@ test_expect_success '--left-only/--right-only' '
 	test_cmp expect actual
 '
 
+test_expect_success 'giant case' '
+	test_commit base &&
+	test_commit_bulk --ref=refs/heads/v1 --message="v1 commit %s" 32768 &&
+	test_commit_bulk --ref=refs/heads/v2 --message="v2 commit %s" 32768 &&
+	git range-diff base v1 v2
+'
+
 test_done

Then we'd allocate a 0-length array for "cost" and segfault as soon as
we try to put anything in it. You can confirm this by applying your
patch, running under gdb, and stopping at the xmalloc() call inside
get_correspondences(). With st_mult(), then we come up with the correct
value of 16GB (or complain about overflow on a 32-bit system).

So st_add() is working as advertised here; it's goal is just to make
sure we never under-allocate. You are right, though, that the code after
that in get_correspondences() has trouble because of the signedness. If
the code used an "unsigned int", it would still be _wrong_. But when it
overflowed, it would always come up with a value under 4GB. So it might
produce a wrong answer, but it couldn't possibly point outside the
bounds of the array and cause a security problem.

But because it's a signed int, we overflow to a negative value and try
to look at memory far before the start of the array. So I can see how it
is tempting to argue that this st_mult() isn't really helping since we
segfault anyway. But I'd disagree. By correctly computing the value of
16GB instead of "0", we know that the ALLOC_ARRAY() line is doing the
right thing. And it may choose not to continue if it can't allocate
16GB. That may happen because you don't have the RAM, but also because
of GIT_ALLOC_LIMIT.

So if you set GIT_ALLOC_LIMIT=4g, for example, you are immune to the bug
here. We'd refuse the allocation and die there, which protects
downstream code from trying to fill in the array with bogus arithmetic.

Dropping the st_mult() does nothing to fix the actual problem (which is
that this function should use a more appropriate type), but introduces
new failure modes.

-Peff
