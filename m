Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32349C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 18:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239607AbhLQSKI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 13:10:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:54138 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234093AbhLQSKI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 13:10:08 -0500
Received: (qmail 25147 invoked by uid 109); 17 Dec 2021 18:10:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Dec 2021 18:10:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 672 invoked by uid 111); 17 Dec 2021 18:10:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Dec 2021 13:10:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Dec 2021 13:10:07 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/2] repack: make '--quiet' disable progress
Message-ID: <YbzSfwQixuonrK/o@coredump.intra.peff.net>
References: <pull.1098.git.1639758526.gitgitgadget@gmail.com>
 <3eff83d9ae14023f3527dfeb419cf8259f6d053d.1639758526.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3eff83d9ae14023f3527dfeb419cf8259f6d053d.1639758526.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 17, 2021 at 04:28:46PM +0000, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> While testing some ideas in 'git repack', I ran it with '--quiet' and
> discovered that some progress output was still shown. Specifically, the
> output for writing the multi-pack-index showed the progress.
> 
> The 'show_progress' variable in cmd_repack() is initialized with
> isatty(2) and is not modified at all by the '--quiet' flag. The
> '--quiet' flag modifies the po_args.quiet option which is translated
> into a '--quiet' flag for the 'git pack-objects' child process. However,
> 'show_progress' is used to directly send progress information to the
> multi-pack-index writing logic which does not use a child process.
> 
> The fix here is to modify 'show_progress' to be false if po_opts.quiet
> is true, and isatty(2) otherwise. This new expectation simplifies a
> later condition that checks both.

Makes sense. I wondered if you might have to decide what to do with
"--progress --quiet", but we do not have an explicit progress option for
git-repack in the first place.

> This is difficult to test because the isatty(2) already prevents the
> progess indicators from appearing when we redirect stderr to a file.

You'd need test_terminal. Something like this:

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 8c4ba6500b..b673c49650 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -5,6 +5,7 @@ test_description='git repack works correctly'
 . ./test-lib.sh
 . "${TEST_DIRECTORY}/lib-bitmap.sh"
 . "${TEST_DIRECTORY}/lib-midx.sh"
+. "${TEST_DIRECTORY}/lib-terminal.sh"
 
 commit_and_pack () {
 	test_commit "$@" 1>&2 &&
@@ -387,4 +388,10 @@ test_expect_success '--write-midx -b packs non-kept objects' '
 	)
 '
 
+test_expect_success TTY '--quiet disables progress' '
+	test_terminal env GIT_PROGRESS_DELAY=0 \
+		git -C midx repack -ad --quiet --write-midx 2>stderr &&
+	test_must_be_empty stderr
+'
+
 test_done

-Peff
