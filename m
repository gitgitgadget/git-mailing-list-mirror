Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE81820248
	for <e@80x24.org>; Tue, 26 Mar 2019 05:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfCZFil (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 01:38:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:36070 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725497AbfCZFil (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 01:38:41 -0400
Received: (qmail 8692 invoked by uid 109); 26 Mar 2019 05:38:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Mar 2019 05:38:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15006 invoked by uid 111); 26 Mar 2019 05:39:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Mar 2019 01:39:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2019 01:38:39 -0400
Date:   Tue, 26 Mar 2019 01:38:39 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/5] progress: return early when in the background
Message-ID: <20190326053839.GC1933@sigill.intra.peff.net>
References: <20190325103844.26749-1-szeder.dev@gmail.com>
 <20190325103844.26749-3-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190325103844.26749-3-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 25, 2019 at 11:38:41AM +0100, SZEDER Gábor wrote:

> diff --git a/progress.c b/progress.c
> index 02a20e7d58..b57c0dae16 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -86,28 +86,30 @@ static void display(struct progress *progress, uint64_t n, const char *done)
>  		return;
>  
>  	progress->last_value = n;
> +
> +	if (!is_foreground_fd(fileno(stderr)) && !done) {
> +		progress_update = 0;
> +		return;
> +	}
> +

Moving it here causes a measurable slowdown for:

  git rev-list --progress=foo --objects --all

This function gets called for every single increment of the progress
counter. Whereas in its old location:

>  	tp = (progress->throughput) ? progress->throughput->display.buf : "";
>  	eol = done ? done : "   \r";
>  	if (progress->total) {
>  		unsigned percent = n * 100 / progress->total;
>  		if (percent != progress->last_percent || progress_update) {
>  			progress->last_percent = percent;
> -			if (is_foreground_fd(fileno(stderr)) || done) {
> -				fprintf(stderr, "%s: %3u%% (%"PRIuMAX"/%"PRIuMAX")%s%s",
> -					progress->title, percent,
> -					(uintmax_t)n, (uintmax_t)progress->total,
> -					tp, eol);
> -				fflush(stderr);
> -			}

It was only triggered when we accumulated enough increments to print. So
we save a few instructions in the backgrounded case, but it costs us a
lot of extra syscalls in every other case.

According to "strace -c", the number of ioctls for that rev-list on
git.git went from 6 to 373,461. But more importantly, my best-of-five
timings went from 3.340s from 3.407s. That's only 2%, but it would be
nice not to pay it if we don't need to.

-Peff
