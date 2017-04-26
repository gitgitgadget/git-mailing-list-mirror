Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A12A207D6
	for <e@80x24.org>; Wed, 26 Apr 2017 10:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2998835AbdDZKzI (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 06:55:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:40431 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2998694AbdDZKzH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 06:55:07 -0400
Received: (qmail 9602 invoked by uid 109); 26 Apr 2017 10:55:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Apr 2017 10:55:05 +0000
Received: (qmail 23165 invoked by uid 111); 26 Apr 2017 10:55:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Apr 2017 06:55:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Apr 2017 06:55:03 -0400
Date:   Wed, 26 Apr 2017 06:55:03 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v2 7/9] rebase -i: skip unnecessary picks using the
 rebase--helper
Message-ID: <20170426105503.wewlbefrsdmjqnob@sigill.intra.peff.net>
References: <cover.1472833365.git.johannes.schindelin@gmx.de>
 <cover.1493128210.git.johannes.schindelin@gmx.de>
 <ecab086a62e96388f4dfc7e36a679821fdc7c8c3.1493128210.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ecab086a62e96388f4dfc7e36a679821fdc7c8c3.1493128210.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2017 at 03:52:10PM +0200, Johannes Schindelin wrote:

> diff --git a/sequencer.c b/sequencer.c
> index 3a935fa4cbc..bbbc98c9116 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2616,3 +2616,93 @@ int check_todo_list(void)
>  
>  	return res;
>  }
> +
> +/* skip picking commits whose parents are unchanged */
> +int skip_unnecessary_picks(void)

Coverity warns of some descriptor leaks in this function (and in
rearrange_squash). I think you get those emails, so I won't repeat the
details here. But I while looking at them I did notice something it
didn't mention:

> +	if (i > 0) {
> +		int offset = i < todo_list.nr ?
> +			todo_list.items[i].offset_in_buf : todo_list.buf.len;
> +		const char *done_path = rebase_path_done();
> +
> +		fd = open(done_path, O_CREAT | O_WRONLY | O_APPEND, 0666);
> +		if (write_in_full(fd, todo_list.buf.buf, offset) < 0) {
> +			todo_list_release(&todo_list);
> +			return error_errno(_("could not write to '%s'"),
> +				done_path);
> +		}
> +		close(fd);

This should probably check the result of open(). I know write_in_full()
will fail if fd is -1, but we'd rather show the user the errno from
open(), not EBADF.

Technically the free() calls from todo_list_release() can also munge
errno before you print it. You might want to just call error_errno()
first, then do the cleanup (including the missing close()).

> +
> +		fd = open(rebase_path_todo(), O_WRONLY, 0666);
> +		if (write_in_full(fd, todo_list.buf.buf + offset,
> +				todo_list.buf.len - offset) < 0) {
> +			todo_list_release(&todo_list);
> +			return error_errno(_("could not write to '%s'"),
> +				rebase_path_todo());
> +		}

Ditto here.

-Peff
