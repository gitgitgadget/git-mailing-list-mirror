Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED2CE1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 10:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeKITnu (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 14:43:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:45894 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727596AbeKITnu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 14:43:50 -0500
Received: (qmail 29389 invoked by uid 109); 9 Nov 2018 10:03:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 09 Nov 2018 10:03:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16145 invoked by uid 111); 9 Nov 2018 10:03:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 09 Nov 2018 05:03:18 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Nov 2018 05:03:57 -0500
Date:   Fri, 9 Nov 2018 05:03:57 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] rebase: consolidate clean-up code before leaving
 reset_head()
Message-ID: <20181109100357.GA7410@sigill.intra.peff.net>
References: <pull.72.git.gitgitgadget@gmail.com>
 <64597fe827021383ab68cfb247de61fcf104a961.1541756054.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64597fe827021383ab68cfb247de61fcf104a961.1541756054.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 09, 2018 at 01:34:17AM -0800, Johannes Schindelin via GitGitGadget wrote:

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 0ee06aa363..6f6d7de156 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -569,16 +569,13 @@ static int reset_head(struct object_id *oid, const char *action,
>  	}
>  
>  	if (!fill_tree_descriptor(&desc, oid)) {
> -		error(_("failed to find tree of %s"), oid_to_hex(oid));
> -		rollback_lock_file(&lock);
> -		free((void *)desc.buffer);
> -		return -1;
> +		ret = error(_("failed to find tree of %s"), oid_to_hex(oid));
> +		goto leave_reset_head;
>  	}

If fill_tree_descriptor() fails, what is left in desc.buffer? Looking at
the implementation, I think it's always NULL or a valid buffer. But I
think all code paths actually die() unless we pass a NULL oid (and in
that case desc.buffer would be NULL, too).

So I think the original here that calls free() doesn't ever do anything
but it did not hurt. After your patch, the leave_reset_head code would
continue to call free(), and that's OK.

There are a few earlier conditionals in reset_head() that do only
rollback_lock_file() that could similarly be converted to use the goto.
But they would need desc.buffer to be initialized to NULL. I could go
either way on converting them or not.

> @@ -586,10 +583,9 @@ static int reset_head(struct object_id *oid, const char *action,
>  
>  	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK) < 0)
>  		ret = error(_("could not write index"));
> -	free((void *)desc.buffer);
>  
>  	if (ret)
> -		return ret;
> +		goto leave_reset_head;
>  
>  	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
>  	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : "rebase");
> @@ -622,7 +618,10 @@ static int reset_head(struct object_id *oid, const char *action,
>  					 UPDATE_REFS_MSG_ON_ERR);
>  	}
>  
> +leave_reset_head:
>  	strbuf_release(&msg);
> +	rollback_lock_file(&lock);
> +	free((void *)desc.buffer);
>  	return ret;

We get here on success, too. So we may call rollback_lock_file() on an
already-committed lock. This is explicitly documented as a no-op by the
lock code, so that's OK.

So overall looks good to me.

-Peff
