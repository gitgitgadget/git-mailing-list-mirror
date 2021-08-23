Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30386C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 16:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BAFE61246
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 16:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhHWQG6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 12:06:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:56634 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhHWQG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 12:06:58 -0400
Received: (qmail 11867 invoked by uid 109); 23 Aug 2021 16:06:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Aug 2021 16:06:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29983 invoked by uid 111); 23 Aug 2021 16:06:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Aug 2021 12:06:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Aug 2021 12:06:14 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] multi-pack-index: fix *.rev cleanups with --object-dir
Message-ID: <YSPHdofrDOQk3xmy@coredump.intra.peff.net>
References: <20210823094049.44136-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210823094049.44136-1-johannes@sipsolutions.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 23, 2021 at 11:40:49AM +0200, Johannes Berg wrote:

> If using --object-dir to point into a repo while the current
> working dir is outside, such as
> 
>   git init /repo
>   git -C /repo ... # add some objects
>   cd /non-repo
>   git multi-pack-index --object-dir /repo/.git/objects/ write
> 
> the binary will segfault trying to access the object-dir via
> the repo it found, but that's not fully initialized. Fix it
> to use the object_dir properly to clean up the *.rev files,
> this avoids the crash and cleans up the *.rev files for the
> now rewritten multi-pack-index properly.

I'm not entirely convinced that writing a midx when not "inside" a repo
is something that we want to support. But if we do, then...

> Due to running inside git's tree, even with TEST_NO_CREATE_REPO=t
> I cannot reproduce the segfault in a test without the "cd /", so
> I've kept that. Yes, the test caught in that case that the *.rev
> file wasn't cleaned up (due to being initialized to the wrong git
> repo [git's] and cleaning up there!), but I wanted to test the
> segfault too.

...there's a helper in the test suite for doing this kind of "not in a
repo" test:

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 3b6331f641..3981bf96d0 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -211,11 +211,8 @@ test_expect_success 'multi-pack-index *.rev cleanup with --object-dir' '
 	) &&
 	rev="objdir-test-repo/$objdir/pack/multi-pack-index-abcdef123456.rev" &&
 	touch $rev &&
-	(
-		base="$(pwd)" &&
-		cd / && # run outside any git repo, including git itself
-		git multi-pack-index --object-dir="$base/objdir-test-repo/$objdir" write
-	) &&
+	nongit git multi-pack-index \
+		--object-dir="$PWD/objdir-test-repo/$objdir" write &&
 	test_path_is_file objdir-test-repo/$objdir/pack/multi-pack-index &&
 	test_path_is_missing $rev
 '

-Peff
