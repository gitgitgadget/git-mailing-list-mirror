Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A5661F404
	for <e@80x24.org>; Tue, 27 Feb 2018 21:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbeB0Vod (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 16:44:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:39438 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751568AbeB0Vod (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 16:44:33 -0500
Received: (qmail 8245 invoked by uid 109); 27 Feb 2018 21:44:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 27 Feb 2018 21:44:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27615 invoked by uid 111); 27 Feb 2018 21:45:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 27 Feb 2018 16:45:21 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Feb 2018 16:44:30 -0500
Date:   Tue, 27 Feb 2018 16:44:30 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/5] sequencer: always roll back lock in
 `do_recursive_merge()`
Message-ID: <20180227214430.GC6899@sigill.intra.peff.net>
References: <cover.1519763396.git.martin.agren@gmail.com>
 <5d657ac87d1e71fd95175faed2b591fa609b8f1c.1519763396.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d657ac87d1e71fd95175faed2b591fa609b8f1c.1519763396.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 10:30:10PM +0100, Martin Ågren wrote:

> diff --git a/sequencer.c b/sequencer.c
> index 90807c4559..e6bac4692a 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -465,8 +465,10 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>  		fputs(o.obuf.buf, stdout);
>  	strbuf_release(&o.obuf);
>  	diff_warn_rename_limit("merge.renamelimit", o.needed_rename_limit, 0);
> -	if (clean < 0)
> +	if (clean < 0) {
> +		rollback_lock_file(&index_lock);
>  		return clean;
> +	}
>  
>  	if (active_cache_changed &&
>  	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))

This addition is obviously correct.

I want to note one thing that confused me while reviewing. While looking
to see if there were other returns, I noticed that the lines right near
the end of your context are funny:

        if (active_cache_changed &&
              write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
                  /*
                   * TRANSLATORS: %s will be "revert", "cherry-pick" or
                   * "rebase -i".
                   */
                  return error(_("%s: Unable to write new index file"),
                          _(action_name(opts)));
          rollback_lock_file(&index_lock);

At first I thought that rollback was a noop, since write_locked_index()
would always either commit or rollback. But it's needed for the case
when we active_cache_changed isn't true.

So I think it's correct as-is, but I wonder if writing it as:

  if (!active_cache_changed)
	rollback_lock_file(&index_lock);
  else if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
	return error(...);

might be easier to follow. I'm OK with leaving it, too, but thought I'd
mention it in case it confused other reviewers.

-Peff
