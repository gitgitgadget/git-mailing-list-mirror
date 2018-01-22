Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CB2F1F424
	for <e@80x24.org>; Mon, 22 Jan 2018 07:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750938AbeAVHhD (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 02:37:03 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:52212 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750828AbeAVHhC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 02:37:02 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 07C391F424;
        Mon, 22 Jan 2018 07:37:02 +0000 (UTC)
Date:   Mon, 22 Jan 2018 07:37:01 +0000
From:   Eric Wong <e@80x24.org>
To:     Gargi Sharma <gs051095@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5] mru: Replace mru.[ch] with list.h implementation
Message-ID: <20180122073701.h7fh7xrkmnzndzj7@untitled>
References: <1516497964-6041-1-git-send-email-gs051095@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1516497964-6041-1-git-send-email-gs051095@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gargi Sharma <gs051095@gmail.com> wrote:
>  7 files changed, 15 insertions(+), 86 deletions(-)

Thanks! I like the code reduction and increased use of list.h

Were you able to finish running the test suite?  I wasn't :<

> -void mru_clear(struct mru *head)
> -{
> -	struct list_head *pos;
> -	struct list_head *tmp;
> -
> -	list_for_each_safe(pos, tmp, &head->list) {
> -		free(list_entry(pos, struct mru, list));
> -	}
> -	INIT_LIST_HEAD(&head->list);
> -}

OK, the free() calls are no longer necessary...

<snip>

> --- a/packfile.c
> +++ b/packfile.c
> @@ -859,9 +859,8 @@ static void prepare_packed_git_mru(void)
>  {
>  	struct packed_git *p;
>  
> -	mru_clear(&packed_git_mru);

But the removed mru_clear needs to be replaced with:

+	INIT_LIST_HEAD(&packed_git_mru);

Otherwise, t3050 never finishes for me.

>  	for (p = packed_git; p; p = p->next)
> -		mru_append(&packed_git_mru, p);
> +		list_add_tail(&p->mru, &packed_git_mru);
>  }

Everything else looks good to me, I'm still waiting for the test
suite to run but I don't expect further problems.
