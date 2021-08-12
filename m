Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC0DC4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 21:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B97360F35
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 21:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbhHLVCy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 17:02:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:45982 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhHLVCx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 17:02:53 -0400
Received: (qmail 24980 invoked by uid 109); 12 Aug 2021 21:02:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Aug 2021 21:02:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25515 invoked by uid 111); 12 Aug 2021 21:02:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Aug 2021 17:02:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Aug 2021 17:02:26 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 18/25] t5326: test multi-pack bitmap behavior
Message-ID: <YRWMYg2rvv7HjGE+@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
 <3258ccfc1cc99038e43a37bd2d53c9d30a4f22ae.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3258ccfc1cc99038e43a37bd2d53c9d30a4f22ae.1627420428.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 05:20:10PM -0400, Taylor Blau wrote:

> diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
> new file mode 100755
> index 0000000000..c1b7d633e2
> --- /dev/null
> +++ b/t/t5326-multi-pack-bitmaps.sh
> @@ -0,0 +1,277 @@
> +#!/bin/sh
> +
> +test_description='exercise basic multi-pack bitmap functionality'
> +. ./test-lib.sh
> +. "${TEST_DIRECTORY}/lib-bitmap.sh"
> +
> +# We'll be writing our own midx and bitmaps, so avoid getting confused by the
> +# automatic ones.
> +GIT_TEST_MULTI_PACK_INDEX=0
> +GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0

This latter variable doesn't do anything at this point in the series.
Probably not a big deal (it is simply a noop until then), but if it's
not hard, it may make sense to bump the "respect ... WRITE_BITMAP" patch
earlier in the series.

> +test_expect_success 'create single-pack midx with bitmaps' '
> +	git repack -ad &&
> +	git multi-pack-index write --bitmap &&
> +	test_path_is_file $midx &&
> +	test_path_is_file $midx-$(midx_checksum $objdir).bitmap
> +'
> +
> +basic_bitmap_tests

We can't use a midx bitmap without a .rev file. The basic_bitmap_tests
function covers that, but I wonder if we should also check:

  test_path_is_file $midx-$(midx_checksum $objdir).rev

in that first test.

> +test_expect_success 'create new additional packs' '
> +	for i in $(test_seq 1 16)
> +	do
> +		test_commit "$i" &&
> +		git repack -d
> +	done &&

This loop needs an "|| return 1" inside to catch &&-chain problems (not
that we expect "repack -d" to fail, but just on principle).

> +	git checkout -b other2 HEAD~8 &&
> +	for i in $(test_seq 1 8)
> +	do
> +		test_commit "side-$i" &&
> +		git repack -d
> +	done &&

Ditto here.

> +test_expect_success 'create multi-pack midx with bitmaps' '
> +	git multi-pack-index write --bitmap &&
> +
> +	ls $objdir/pack/pack-*.pack >packs &&
> +	test_line_count = 25 packs &&
> +
> +	test_path_is_file $midx &&
> +	test_path_is_file $midx-$(midx_checksum $objdir).bitmap
> +'

Possible spot for checking the .rev file again (though really, it is
belt-and-suspenders at this point).

> +basic_bitmap_tests

I love how the earlier refactoring made it easy to test the single- and
multi-pack cases thoroughly.

> +test_expect_success '--no-bitmap is respected when bitmaps exist' '
> +	git multi-pack-index write --bitmap &&
> +
> +	test_commit respect--no-bitmap &&
> +	GIT_TEST_MULTI_PACK_INDEX=0 git repack -d &&

Do we need to set this env variable? We've already set it to 0 at the
top of the script.

> +	test_path_is_file $midx &&
> +	test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
> +
> +	git multi-pack-index write --no-bitmap &&
> +
> +	test_path_is_file $midx &&
> +	test_path_is_missing $midx-$(midx_checksum $objdir).bitmap
> +'

OK, so we expect "--no-bitmap" to drop the bitmap (just like it does for
a regular pack bitmap). Makes sense. We probably should check:

  test_path_is_missing $midx-$(midx_checksum $objdir).rev

here, too (unlike the other spots, it isn't redundant; we could leave a
stale file around and likely nobody would notice).

> +test_expect_success 'setup midx with base from later pack' '
> +	# Write a and b so that "a" is a delta on top of base "b", since Git
> +	# prefers to delete contents out of a base rather than add to a shorter
> +	# object.
> +	test_seq 1 128 >a &&
> +	test_seq 1 130 >b &&
> +
> +	git add a b &&
> +	git commit -m "initial commit" &&
> +
> +	a=$(git rev-parse HEAD:a) &&
> +	b=$(git rev-parse HEAD:b) &&
> +
> +	# In the first pack, "a" is stored as a delta to "b".
> +	p1=$(git pack-objects .git/objects/pack/pack <<-EOF
> +	$a
> +	$b
> +	EOF
> +	) &&

This is brittle with respect to Git's delta heuristics, of course, but I
don't think there's a better way to do it with pack-objects. And this is
not the first test to make similar assumptions. I think you can
construct a known set of deltas using lib-pack.sh. It may get a bit
complicated. As an alternative, maybe it makes sense to confirm that the
deltas are set up as expected? You can do it with cat-file
--batch-check.

> +test_expect_success 'removing a MIDX clears stale bitmaps' '
> +	rm -fr repo &&
> +	git init repo &&
> +	test_when_finished "rm -fr repo" &&
> +	(
> +		cd repo &&
> +		test_commit base &&
> +		git repack &&
> +		git multi-pack-index write --bitmap &&
> +
> +		# Write a MIDX and bitmap; remove the MIDX but leave the bitmap.
> +		stale_bitmap=$midx-$(midx_checksum $objdir).bitmap &&
> +		rm $midx &&
> +
> +		# Then write a new MIDX.
> +		test_commit new &&
> +		git repack &&
> +		git multi-pack-index write --bitmap &&
> +
> +		test_path_is_file $midx &&
> +		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
> +		test_path_is_missing $stale_bitmap
> +	)

Another spot where we might want to check that the stale .rev file has
gone away (and optionally that the new one was written; I haven't noted
all of those, though).

> +test_expect_success 'pack.preferBitmapTips' '
> +	git init repo &&
> +	test_when_finished "rm -fr repo" &&
> +	(
> +		cd repo &&
> +
> +		test_commit_bulk --message="%s" 103 &&
> +
> +		git log --format="%H" >commits.raw &&
> +		sort <commits.raw >commits &&
> +
> +		git log --format="create refs/tags/%s %H" HEAD >refs &&
> +		git update-ref --stdin <refs &&
> +
> +		git multi-pack-index write --bitmap &&
> +		test_path_is_file $midx &&
> +		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
> +
> +		test-tool bitmap list-commits | sort >bitmaps &&
> +		comm -13 bitmaps commits >before &&
> +		test_line_count = 1 before &&
> +
> +		perl -ne "printf(\"create refs/tags/include/%d \", $.); print" \
> +			<before | git update-ref --stdin &&
> +
> +		rm -fr $midx-$(midx_checksum $objdir).bitmap &&
> +		rm -fr $midx-$(midx_checksum $objdir).rev &&
> +		rm -fr $midx &&
> +
> +		git -c pack.preferBitmapTips=refs/tags/include \
> +			multi-pack-index write --bitmap &&
> +		test-tool bitmap list-commits | sort >bitmaps &&
> +		comm -13 bitmaps commits >after &&
> +
> +		! test_cmp before after
> +	)
> +'

OK, so we are not depending on any _specific_ commits to get bitmapped,
but just confirming that we have some impact. That may be the best we
can do given that we are subject to the bitmap code's heuristics (and
anyway, this is exactly what the pack version does).

Any other parts of the patch that I didn't quote looked very good to me.
I'm happy to have such a thorough set of tests.

-Peff
