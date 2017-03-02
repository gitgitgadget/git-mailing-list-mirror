Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AE7120133
	for <e@80x24.org>; Thu,  2 Mar 2017 09:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754314AbdCBJAV (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 04:00:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:37081 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754216AbdCBJAC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 04:00:02 -0500
Received: (qmail 24561 invoked by uid 109); 2 Mar 2017 08:53:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 08:53:15 +0000
Received: (qmail 15509 invoked by uid 111); 2 Mar 2017 08:53:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 03:53:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Mar 2017 03:53:13 -0500
Date:   Thu, 2 Mar 2017 03:53:13 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     tboegi@web.de, git@vger.kernel.org, mac@mcrowe.com
Subject: Re: [PATCH v1 1/1] git diff --quiet exits with 1 on clean tree with
 CRLF conversions
Message-ID: <20170302085313.r6dox4wa2kqnp7ao@sigill.intra.peff.net>
References: <xmqqshmyhtnu.fsf@gitster.mtv.corp.google.com>
 <20170301170444.14274-1-tboegi@web.de>
 <xmqqr32gg0o6.fsf@gitster.mtv.corp.google.com>
 <xmqqa894fyst.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa894fyst.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 01, 2017 at 01:54:26PM -0800, Junio C Hamano wrote:

> -- >8 --
> Subject: [PATCH] diff: do not short-cut CHECK_SIZE_ONLY check in diff_populate_filespec()

Thanks, this is well-explained, and the new comments in the code really
help.

I wondered if we should be checking would_convert_to_git() in
reuse_worktree_file(), but we already do. It's just that we may still
end up in this code-path when we're _actually_ diffing the working tree
file, not just trying to optimize.

> diff --git a/diff.c b/diff.c
> index 8c78fce49d..dc51dceb44 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2792,8 +2792,25 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
>  			s->should_free = 1;
>  			return 0;
>  		}
> -		if (size_only)
> +
> +		/*
> +		 * Even if the caller would be happy with getting
> +		 * only the size, we cannot return early at this
> +		 * point if the path requires us to run the content
> +		 * conversion.
> +		 */
> +		if (!would_convert_to_git(s->path) && size_only)
>  			return 0;

The would_convert_to_git() function is a little expensive (it may have
to do an attribute lookup). It may be worth swapping the two halves of
the conditional here to get the short-circuit.

It may not matter much in practice, though, because in the !size_only
case we'd make the same query lower a few lines later (and in theory
expensive bits of the attr lookup are cached).

> +
> +		/*
> +		 * Note: this check uses xsize_t(st.st_size) that may
> +		 * not be the true size of the blob after it goes
> +		 * through convert_to_git().  This may not strictly be
> +		 * correct, but the whole point of big_file_threashold

s/threashold/threshold/

> +		 * and is_binary check being that we want to avoid
> +		 * opening the file and inspecting the contents, this
> +		 * is probably fine.
> +		 */
>  		if ((flags & CHECK_BINARY) &&
>  		    s->size > big_file_threshold && s->is_binary == -1) {
>  			s->is_binary = 1;

I'm trying to think how this "not strictly correct" could bite us. For
line-ending conversion, I'd say that the before/after are going to be
approximately the same size. But what about something like LFS? If I
have a 600MB file that convert_to_git() filters into a short LFS
pointer, I think this changes the behavior. Before, we would diff the
pointer file, but now we'll get "binary file changed".

I wonder if we should take the opposite approach, and ignore
big_file_threshold for converted files. One assumes that such gigantic
files are binary, and therefore do not have line endings to convert. And
any filtering has a reasonable chance of condensing them to something
much smaller.

I dunno. I'm sure somebody has some horrific 500MB-filtering example
that can prove me wrong.

-Peff
