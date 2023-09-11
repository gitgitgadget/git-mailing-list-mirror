Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B01CA0EC3
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 23:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349283AbjIKVdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243413AbjIKRKP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 13:10:15 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C251A5
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 10:10:10 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BC9F92A1F5;
        Mon, 11 Sep 2023 13:10:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=wifXDSxNu2Dzw+f0vxCPH7IwNBxPT81w6lf1t2
        KemrY=; b=vyJF9bMyNz/GBKpIrDzO9UXLNZWzg11iN747BNa3zHcMc1pPqvc6Zv
        km6ZFmU18Jgsk0+cPOEAzQwhdl4U1Tc9iB7z0Vn8CFPidLMxV74n3BnmsZNjCZKH
        GfOzvUJ1rth+4TBV/q5KHssDFqZpKr1GVkYLDWVpSksekMjXw0mEQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B4C692A1F4;
        Mon, 11 Sep 2023 13:10:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0FB952A1EE;
        Mon, 11 Sep 2023 13:10:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Linus Arver <linusa@google.com>
Subject: Re: [PATCH v2 1/6] trailer: separate public from internal portion
 of trailer_iterator
In-Reply-To: <4f116d2550f6cf218477560a9e25dbe4c384a2a6.1694240177.git.gitgitgadget@gmail.com>
        (Linus Arver via GitGitGadget's message of "Sat, 09 Sep 2023 06:16:12
        +0000")
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
        <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
        <4f116d2550f6cf218477560a9e25dbe4c384a2a6.1694240177.git.gitgitgadget@gmail.com>
Date:   Mon, 11 Sep 2023 10:10:03 -0700
Message-ID: <xmqqbke8ws9g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D3B20E0-50C6-11EE-B047-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> The fields here are not meant to be used by downstream callers, so put
> them behind an anonymous struct named as "internal" to warn against
> their use. This follows the pattern in 576de3d956 (unpack_trees: start
> splitting internal fields from public API, 2023-02-27).

OK.  The patch shows that there exist no code external to this file
that touch these members that are marked "private", so it has some
auditing value from that point of view, which is nice.

But that is only about today's code and does not protect us from
future breakage.  In other words, "git grep internal\\." would not
be an effective way to find misuses of these members from the
sidelines.  But that is OK, as "git grep -E '([.]|->)info'" would
not be an effective way in today's code, either, and the patch is
not making things worse.

Queued.  Thanks.

> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  trailer.c | 10 +++++-----
>  trailer.h |  6 ++++--
>  2 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/trailer.c b/trailer.c
> index f408f9b058d..de4bdece847 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -1220,14 +1220,14 @@ void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
>  	strbuf_init(&iter->key, 0);
>  	strbuf_init(&iter->val, 0);
>  	opts.no_divider = 1;
> -	trailer_info_get(&iter->info, msg, &opts);
> -	iter->cur = 0;
> +	trailer_info_get(&iter->internal.info, msg, &opts);
> +	iter->internal.cur = 0;
>  }
>  
>  int trailer_iterator_advance(struct trailer_iterator *iter)
>  {
> -	while (iter->cur < iter->info.trailer_nr) {
> -		char *trailer = iter->info.trailers[iter->cur++];
> +	while (iter->internal.cur < iter->internal.info.trailer_nr) {
> +		char *trailer = iter->internal.info.trailers[iter->internal.cur++];
>  		int separator_pos = find_separator(trailer, separators);
>  
>  		if (separator_pos < 1)
> @@ -1245,7 +1245,7 @@ int trailer_iterator_advance(struct trailer_iterator *iter)
>  
>  void trailer_iterator_release(struct trailer_iterator *iter)
>  {
> -	trailer_info_release(&iter->info);
> +	trailer_info_release(&iter->internal.info);
>  	strbuf_release(&iter->val);
>  	strbuf_release(&iter->key);
>  }
> diff --git a/trailer.h b/trailer.h
> index 795d2fccfd9..ab2cd017567 100644
> --- a/trailer.h
> +++ b/trailer.h
> @@ -119,8 +119,10 @@ struct trailer_iterator {
>  	struct strbuf val;
>  
>  	/* private */
> -	struct trailer_info info;
> -	size_t cur;
> +	struct {
> +		struct trailer_info info;
> +		size_t cur;
> +	} internal;
>  };
>  
>  /*
