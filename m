Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98738C433DF
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 04:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8373F2078C
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 04:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgGHEiV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 00:38:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:51976 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgGHEiV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 00:38:21 -0400
Received: (qmail 26555 invoked by uid 109); 8 Jul 2020 04:38:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Jul 2020 04:38:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1344 invoked by uid 111); 8 Jul 2020 04:38:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Jul 2020 00:38:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Jul 2020 00:38:19 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>
Subject: [PATCH] diff: check for merge bases before assigning sym->base
Message-ID: <20200708043819.GA2303891@coredump.intra.peff.net>
References: <20200707235436.GH9782@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200707235436.GH9782@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 07, 2020 at 11:54:36PM +0000, brian m. carlson wrote:

> I was kicking off a build on a cloud instance for the final series of my
> SHA-256 work and I noticed that t4068 fails with -fsanitize=address
> using Debian's GCC 9.3.0-14 (the version in unstable).  It has failed
> since the test was introduced and currently fails on the latest HEAD.

Thanks for reporting. I occasionally do an ASan (and UBSan) run, but I
haven't in a while. It's definitely good to catch this before the
release.

> Reproduction steps:
> 
>   printf 'DEVELOPER=1\nDC_SHA1=1\nBLK_SHA256=1\nSANITIZE=address\n' >config.mak
>   make -j6 all && (cd t && ./t4068-*.sh --verbose)
> 
> Output with --verbose:
> 
> expecting success of 4068.4 'diff with no merge bases':
>         test_must_fail git diff br2...br3 >tmp 2>err &&
>         test_i18ngrep "fatal: br2...br3: no merge base" err
> 
> test_must_fail: died by signal 6: git diff br2...br3
> not ok 4 - diff with no merge bases
> #
> #               test_must_fail git diff br2...br3 >tmp 2>err &&
> #               test_i18ngrep "fatal: br2...br3: no merge base" err
> #

The goodies are in "err", which shows:

  $ cat trash\ directory.t4068-diff-symmetric/err
  ==2319726==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x61d000000068 at pc 0x556a45b790b4 bp 0x7fff59d414f0 sp 0x7fff59d414e8
  READ of size 8 at 0x61d000000068 thread T0
      #0 0x556a45b790b3 in symdiff_prepare builtin/diff.c:358
      #1 0x556a45b7a1a2 in cmd_diff builtin/diff.c:509
      [...etc...]

The offending line is:

     sym->base = rev->pending.objects[basepos].name;

and indeed, if we instrument it like so:

  diff --git a/builtin/diff.c b/builtin/diff.c
  index 8c36da09b6..698e81e01b 100644
  --- a/builtin/diff.c
  +++ b/builtin/diff.c
  @@ -292,6 +292,9 @@ static void symdiff_prepare(struct rev_info *rev, struct symdiff *sym)
   	int lpos = -1, rpos = -1, basepos = -1;
   	struct bitmap *map = NULL;
   
  +	trace_printf("cmdline.nr = %d, pending.nr = %d",
  +		     rev->cmdline.nr, rev->pending.nr);
  +
   	/*
   	 * Use the whence fields to find merge bases and left and
   	 * right parts of symmetric difference, so that we do not
  @@ -353,6 +356,8 @@ static void symdiff_prepare(struct rev_info *rev, struct symdiff *sym)
   		return;
   	}
   
  +	trace_printf("lpos = %d, rpos = %d, basepos = %d",
  +		     lpos, rpos, basepos);
   	sym->left = rev->pending.objects[lpos].name;
   	sym->right = rev->pending.objects[rpos].name;
   	sym->base = rev->pending.objects[basepos].name;

I get:

  $ GIT_TRACE=1 ./t4068-diff-symmetric.sh -v -i
  [...]
  trace: built-in: git diff br2...br3
  cmdline.nr = 2, pending.nr = 2
  lpos = 0, rpos = 1, basepos = -1
  test_must_fail: died by signal 6: git diff br2...br3
  not ok 4 - diff with no merge bases

I suspect the solution is this:

-- >8 --
Subject: diff: check for merge bases before assigning sym->base

In symdiff_prepare(), we iterate over the set of parsed objects to pick
out any symmetric differences, including the left, right, and base
elements. We assign the results into pointers in a "struct symdiff", and
then complain if we didn't find a base, like so:

    sym->left = rev->pending.objects[lpos].name;
    sym->right = rev->pending.objects[rpos].name;
    sym->base = rev->pending.objects[basepos].name;
    if (basecount == 0)
            die(_("%s...%s: no merge base"), sym->left, sym->right);

But the least lines are backwards. If basecount is 0, then basepos will
be -1, and we will access memory outside of the pending array. This
isn't usually that big a deal, since we don't do anything besides a
single pointer-sized read before exiting anyway, but it does violate the
C standard, and of course memory-checking tools like ASan complain.

Let's put the basecount check first. Note that we haveto split it from
the other assignments, since the die() relies on sym->left and
sym->right having been assigned (this isn't strictly necessary, but is
easier to read than dereferencing the pending array again).

Reported-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Jeff King <peff@peff.net>
---
I don't see anything within this function guaranteeing that rpos is set,
either, though I suspect it is OK due to how the revision parser works.
We have to see a left-side in order to set is_symdiff, and if we don't
do that, we'd bail before hitting this code. But if we saw REV_CMD_LEFT
but not REV_CMD_RIGHT, we'd have lpos set to something valid and rpos
not. It might be worth adding an assert() or BUG() to document and check
our assumption there.

 builtin/diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 8c36da09b6..cb98811c21 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -355,9 +355,9 @@ static void symdiff_prepare(struct rev_info *rev, struct symdiff *sym)
 
 	sym->left = rev->pending.objects[lpos].name;
 	sym->right = rev->pending.objects[rpos].name;
-	sym->base = rev->pending.objects[basepos].name;
 	if (basecount == 0)
 		die(_("%s...%s: no merge base"), sym->left, sym->right);
+	sym->base = rev->pending.objects[basepos].name;
 	bitmap_unset(map, basepos);	/* unmark the base we want */
 	sym->warn = basecount > 1;
 	sym->skip = map;
-- 
2.27.0.730.gcc195a083d
