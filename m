Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C53FC433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 17:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239862AbhLQRYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 12:24:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:54098 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233875AbhLQRYR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 12:24:17 -0500
Received: (qmail 25042 invoked by uid 109); 17 Dec 2021 17:24:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Dec 2021 17:24:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 311 invoked by uid 111); 17 Dec 2021 17:24:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Dec 2021 12:24:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Dec 2021 12:24:06 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/2] repack: respect kept objects with '--write-midx -b'
Message-ID: <YbzHtsl045XZbJGN@coredump.intra.peff.net>
References: <pull.1098.git.1639758526.gitgitgadget@gmail.com>
 <1ed91f6d255b76bdbdcccea7e1effcebbb263ced.1639758526.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ed91f6d255b76bdbdcccea7e1effcebbb263ced.1639758526.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 17, 2021 at 04:28:45PM +0000, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> Historically, we needed a single packfile in order to have reachability
> bitmaps. This introduced logic that when 'git repack' had a '-b' option
> that we should stop sending the '--honor-pack-keep' option to the 'git
> pack-objects' child process, ensuring that we create a packfile
> containing all reachable objects.
> 
> In the world of multi-pack-index bitmaps, we no longer need to repack
> all objects into a single pack to have valid bitmaps. Thus, we should
> continue sending the '--honor-pack-keep' flag to 'git pack-objects'.
> 
> The fix is very simple: only disable the flag when writing bitmaps but
> also _not_ writing the multi-pack-index.
> 
> This opens the door to new repacking strategies that might want to keep
> some historical set of objects in a stable pack-file while only
> repacking more recent objects.

That all makes sense. Another way of thinking about it: we disable
--honor-pack-keep so we that keep packs do not interfere with writing a
pack bitmap. But with --write-midx, we skip the pack bitmap entirely.

In the end it's the same, but I wanted to emphasize that the important
hing is not so much that we are writing a midx bitmap as that we are
_not_ writing a pack bitmap. And that is what makes this OK to do (that
the repack code already disables the pack bitmap when writing a midx
one).

> diff --git a/builtin/repack.c b/builtin/repack.c
> index 9b0be6a6ab3..1f128b7c90b 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -693,7 +693,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  		write_bitmaps = 0;
>  	}
>  	if (pack_kept_objects < 0)
> -		pack_kept_objects = write_bitmaps > 0;
> +		pack_kept_objects = write_bitmaps > 0 && !write_midx;

So the code change here looks good.

> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 0260ad6f0e0..8c4ba6500be 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -372,4 +372,19 @@ test_expect_success '--write-midx with preferred bitmap tips' '
>  	)
>  '
>  
> +test_expect_success '--write-midx -b packs non-kept objects' '
> +	git init midx-kept &&
> +	test_when_finished "rm -fr midx-kept" &&
> +	(
> +		cd midx-kept &&
> +		test_commit_bulk 100 &&
> +		GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
> +			git repack --write-midx -a -b &&
> +		cat trace.txt | \
> +			grep \"event\":\"start\" | \
> +			grep pack-objects | \
> +			grep \"--honor-pack-keep\"
> +	)
> +'

This looks correct, though:

  - do we really need this separate repo directory? The test before it
    uses one, but only because it needs a very specific set of commits.
    There is a long-running "midx" directory we could use, though I
    think just the regular test repo would be fine, too.

  - likewise, do we need 100 commits? They are not too expensive these
    days with test_commit_bulk, but I think we don't even care about the
    repo contents at all.

  - there is no actual .keep file in your test. That's OK, as we are
    just checking the args passed to pack-objects.

  - useless use of cat. :) Also, you could probably do it all with one
    grep. This is bikeshedding, of course, but it's nice to keep process
    counts low in the test suite. Also, your middle grep is looser than
    the others (it doesn't check for surrounding quotes).

So something like this would work:

  test_expect_success '--write-midx -b packs non-kept objects' '
          GIT_TRACE2_EVENT="$(pwd)/midx-keep-bitmap.trace" \
                  git -C midx repack --write-midx -a -b &&
          grep "\"event\":\"start\".*\"pack-objects\".*\"--honor-pack-keep\"" \
                  midx-keep-bitmap.trace
  '

One could perhaps argue that the combined grep is less readable. If
that's a concern, I'd suggest wrapping it in a function like:

  # usage: check_trace2_arg <trace_file> <cmd> <arg>
  check_trace2_arg () {
	grep "\"event\":\"start\".*\"$2\".*\"$3\"" "$1"
  }

All just suggestions, of course. I'd be happy enough to see the patch go
in as-is.

-Peff
