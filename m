Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410CBEE4996
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 20:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjHUUqT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjHUUqS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 16:46:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C66CEF
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 13:45:53 -0700 (PDT)
Received: (qmail 17524 invoked by uid 109); 21 Aug 2023 20:45:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Aug 2023 20:45:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19234 invoked by uid 111); 21 Aug 2023 20:45:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Aug 2023 16:45:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Aug 2023 16:45:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/5] diff: teach "--stat -w --exit-code" to notice
 differences
Message-ID: <20230821204552.GC1800481@coredump.intra.peff.net>
References: <20230817222949.3835424-1-gitster@pobox.com>
 <20230818235932.3253552-1-gitster@pobox.com>
 <20230818235932.3253552-4-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230818235932.3253552-4-gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 18, 2023 at 04:59:30PM -0700, Junio C Hamano wrote:

> Set the bit by inspecting the list of paths the diffstat output is
> given for (a mode-only change will still appear as a "0-line added
> 0-line deleted" change) to fix it.
> [...]
> diff --git a/diff.c b/diff.c
> index 998d7ae20c..da965ff688 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6901,6 +6901,7 @@ void compute_diffstat(struct diff_options *options,
>  		if (check_pair_status(p))
>  			diff_flush_stat(p, options, diffstat);
>  	}
> +	options->found_changes = !!diffstat->nr;
>  }

Makes sense, and this is delightfully simple. I wondered if we needed to
remove any code setting found_changes via builtin_diffstat(), but it
does not seem to exist in the first place. ;)

> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index 02731dccb9..230a89b951 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -11,7 +11,7 @@ TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-diff.sh
>  
> -for opts in --patch --quiet -s
> +for opts in --patch --quiet -s --stat --shortstat --dirstat=lines
>  do

I guess this would fix --numstat, too, though there may be diminishing
returns in checking every format if we know it is just hitting the same
code paths (though perhaps one could argue that --shortstat is already
uninteresting for the same reason).

-Peff
