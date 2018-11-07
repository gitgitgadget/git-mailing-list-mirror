Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCBD51F453
	for <e@80x24.org>; Wed,  7 Nov 2018 20:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeKHGZh (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 01:25:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:43970 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726583AbeKHGZh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 01:25:37 -0500
Received: (qmail 9170 invoked by uid 109); 7 Nov 2018 20:53:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 07 Nov 2018 20:53:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18018 invoked by uid 111); 7 Nov 2018 20:52:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 07 Nov 2018 15:52:49 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Nov 2018 15:53:29 -0500
Date:   Wed, 7 Nov 2018 15:53:29 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, AEvar <avarab@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] built-in rebase --autostash: leave the current
 branch alone if possible
Message-ID: <20181107205329.GB30078@sigill.intra.peff.net>
References: <pull.70.git.gitgitgadget@gmail.com>
 <a2f0b53db269e9a6d7c29b665c9be53bd2f30e42.1541599246.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a2f0b53db269e9a6d7c29b665c9be53bd2f30e42.1541599246.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 07, 2018 at 06:00:50AM -0800, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When we converted a `git reset --hard` call in the original Unix shell
> script to built-in code, we asked to reset the worktree and the index
> and explicitly *not* to detach the HEAD. By mistake, though, we still
> did. Let's fix this.
> [...]
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 0ee06aa363..4a608d0a78 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -613,7 +613,8 @@ static int reset_head(struct object_id *oid, const char *action,
>  		reflog_head = msg.buf;
>  	}
>  	if (!switch_to_branch)
> -		ret = update_ref(reflog_head, "HEAD", oid, orig, REF_NO_DEREF,
> +		ret = update_ref(reflog_head, "HEAD", oid, orig,
> +				 detach_head ? REF_NO_DEREF : 0,
>  				 UPDATE_REFS_MSG_ON_ERR);

This makes sense. There are actually a bunch of calls that pass
detach_head==0, besides the one related to autostash. I suspect for most
of them it does not matter, because either:

  1. We are already on a detached HEAD, since we detach as the first
     step of the rebase. So for the call in ACTION_SKIP, for example, we
     probably cannot trigger the problem.

  2. They pass a switch_to_branch arg, so we do not hit this code path
     anyway (the call to fast-forward is like this, for example).

So there may be other ways to trigger the problem, but I didn't dig.
Either way, your fix is clearly the right thing to do.

-Peff
