Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6903820188
	for <e@80x24.org>; Sun, 14 May 2017 03:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751375AbdEND46 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:56:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:51309 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751105AbdEND45 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:56:57 -0400
Received: (qmail 6613 invoked by uid 109); 14 May 2017 03:56:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 May 2017 03:56:55 +0000
Received: (qmail 6356 invoked by uid 111); 14 May 2017 03:57:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 23:57:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 May 2017 23:56:53 -0400
Date:   Sat, 13 May 2017 23:56:53 -0400
From:   Jeff King <peff@peff.net>
To:     Brian Malehorn <bmalehorn@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] interpret-trailers: obey scissors lines
Message-ID: <20170514035652.rn5npxxflku6s5k4@sigill.intra.peff.net>
References: <20170512090032.coddhlsrs6s3zm2f@sigill.intra.peff.net>
 <20170514033923.12870-1-bmalehorn@gmail.com>
 <20170514033923.12870-2-bmalehorn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170514033923.12870-2-bmalehorn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 13, 2017 at 08:39:23PM -0700, Brian Malehorn wrote:

> If a commit message is being editted as "verbose", it will contain a
> scissors string ("-- >8 --") and a diff:
> 
>     my subject
> 
>     # ------------------------ >8 ------------------------
>     # Do not touch the line above.
>     # Everything below will be removed.
>     diff --git a/foo.txt b/foo.txt
>     index 5716ca5..7601807 100644
>     --- a/foo.txt
>     +++ b/foo.txt
>     @@ -1 +1 @@
>     -bar
>     +baz
> 
> interpret-trailers doesn't interpret the scissors and therefore places
> trailer information after the diff. A simple reproduction is:
> 
>     git config commit.verbose true
>     GIT_EDITOR='git interpret-trailers --in-place --trailer Acked-by:me' \
>         git commit --amend
> 
> This commit resolves the issue by teaching "git interpret-trailers" to
> obey scissors the same way "git commit" does.

Overall, this patch looks good to me. A few comments below.

The commit message explains the situation much better than the original.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 2de5f6cc6..2ce9c339d 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1735,7 +1735,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  
>  	if (verbose || /* Truncate the message just before the diff, if any. */
>  	    cleanup_mode == CLEANUP_SCISSORS)
> -		wt_status_truncate_message_at_cut_line(&sb);
> +		strbuf_setlen(&sb,
> +			      wt_status_last_nonscissors_index(sb.buf, sb.len));

This hunk surprised me at first (that we would need to touch commit.c at
all), but the refactoring makes sense.

> @@ -1662,8 +1663,9 @@ int ignore_non_trailer(const char *buf, size_t len)
>  	int boc = 0;
>  	int bol = 0;
>  	int in_old_conflicts_block = 0;
> +	size_t cutoff = wt_status_last_nonscissors_index(buf, len);
>  
> -	while (bol < len) {
> +	while (bol < cutoff) {
>  		const char *next_line = memchr(buf + bol, '\n', len - bol);
>  
>  		if (!next_line)
> @@ -1689,5 +1691,5 @@ int ignore_non_trailer(const char *buf, size_t len)
>  		}
>  		bol = next_line - buf;
>  	}
> -	return boc ? len - boc : 0;
> +	return boc ? len - boc : len - cutoff;
>  }

The change to interpret-trailers here ended up delightfully simple (and
looks right to me).

> diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
> index 4dd1d7c52..d88d4a4ff 100755
> --- a/t/t7513-interpret-trailers.sh
> +++ b/t/t7513-interpret-trailers.sh
> @@ -1258,4 +1258,21 @@ test_expect_success 'with no command and no key' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'with scissors' '
> +	cat >expected <<-EOF &&
> +		my subject
> +
> +		review: Brian
> +		sign: A U Thor <author@example.com>
> +		# ------------------------ >8 ------------------------
> +		ignore this
> +	EOF

Two minor style nits. One, we'd usually use "\EOF" here unless you
really do want to interpolate inside the here document. And two, we
usually indent the contents to the same level as the outer cat/EOF pair
(I actually don't mind at all how yours looks, but I just happened to
notice that it is slightly unlike our usual style).

> diff --git a/wt-status.c b/wt-status.c
> index 4bb46781c..8b807d11f 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -883,17 +883,18 @@ static void wt_longstatus_print_other(struct wt_status *s,
>  	status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
>  }
>  
> -void wt_status_truncate_message_at_cut_line(struct strbuf *buf)
> +size_t wt_status_last_nonscissors_index(const char *s, size_t len)

I can see how the refactor changes this function (and it makes sense),
but the "last nonscissors index" seems like a funny term. It is really
the length, isn't, and therefore one past the last nonscissors index (or
another way of putting it: it's the first index of the scissors).

I wonder if it makes sense to call it "length".

Another way to think of it is still as a truncation. Our strip_suffix()
helper behaves quite similarly to this (not actually writing into the
buffer, but returning the new length). Perhaps something like
"wt_status_strip_scissors" would work.

-Peff
