Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4531F454
	for <e@80x24.org>; Fri,  1 Nov 2019 16:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfKAQ7W (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 12:59:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:36310 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727327AbfKAQ7W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 12:59:22 -0400
Received: (qmail 27782 invoked by uid 109); 1 Nov 2019 16:59:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Nov 2019 16:59:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12391 invoked by uid 111); 1 Nov 2019 17:02:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Nov 2019 13:02:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Nov 2019 12:59:21 -0400
From:   Jeff King <peff@peff.net>
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] sequencer: reencode to utf-8 before arrange
 rebase's todo list
Message-ID: <20191101165921.GD26219@sigill.intra.peff.net>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1572596278.git.congdanhqx@gmail.com>
 <b7927b27235422ac53595cfaa63b4f1cbe009013.1572596278.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7927b27235422ac53595cfaa63b4f1cbe009013.1572596278.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 01, 2019 at 03:25:11PM +0700, Doan Tran Cong Danh wrote:

> This problem wasn't specific to musl libc. On Linux with glibc, this
> problem can be observed by:
> 
> for encoding in utf-8 iso-8859-1; do
> 	# commit using the encoding
> 	echo $encoding >file && git add file
> 	echo "éñcödèd with $encoding" | iconv -f utf-8 -t $encoding |
> 	  git -c i18n.commitEncoding=$encoding commit -F -
> 	# and then fixup without it
> 	echo "$encoding fixed" >file && git add file
> 	git commit --fixup HEAD
> done
> git rebase -i --autosquash --root

Is it worth adding this as a test in t3900?

> ---
> The code that demonstrate the problem on Linux with glibc is written by Jeff.
> But I don't know how to attribute him properly.

I'm OK with or without attribution, but people sometimes add a
"Helped-by" trailer if they want to acknowledge someone.

> diff --git a/sequencer.c b/sequencer.c
> index 9d5964fd81..69430fe23f 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5169,7 +5169,7 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
>  		*commit_todo_item_at(&commit_todo, item->commit) = item;
>  
>  		parse_commit(item->commit);
> -		commit_buffer = get_commit_buffer(item->commit, NULL);
> +		commit_buffer = logmsg_reencode(item->commit, NULL, "UTF-8");

I think there are several other spots in this file that could use the
same treatment. But I can live with it if you want to just fix the one
that's bugging you and move on. It's still a strict improvement.

-Peff
