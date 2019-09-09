Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 268DE1F461
	for <e@80x24.org>; Mon,  9 Sep 2019 18:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfIISPl (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 14:15:41 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58430 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbfIISPl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 14:15:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3E70F698F6;
        Mon,  9 Sep 2019 14:15:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E8CS1gWUSfBK1u2DfutDEHaralM=; b=b3ppX5
        qwGvCOkUnXpwaDgDjo6NUqnPCIqH7IWxxL8jm78sTXC+sv+iXEhDyKlKxZEWy7wT
        oiOY7r3Foo17eT4CcEqG8yHX57HJN78gMrjiWCRkY7JH2rTgyKX9+/D8aBZp5QUU
        GbjLx7E5+6MKt2ZBVyMvQPt4cj+xtdL6SYu9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bT+TkRMLCemjEvEKnV3F/G/Yr/GeLjQy
        xFDGtO8TBzJF10sd5HkefKSBTn98QP20p3G0WTfVM7obzh0yL+SIq6ueInEZ39d1
        +3pTVOpqnZj4n6jVpa7AYiBSozgUMkwbCEiZFqCuds/hA89OYvpc/JNtZkf5259r
        s5kB2QSCweM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 36B05698F5;
        Mon,  9 Sep 2019 14:15:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6395E698F1;
        Mon,  9 Sep 2019 14:15:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC 04/11] coccicheck: detect hashmap_entry.hash assignment
References: <20190826024332.3403-1-e@80x24.org>
        <20190826024332.3403-5-e@80x24.org>
        <20190908074953.kux7zz4y7iolqko4@whir>
Date:   Mon, 09 Sep 2019 11:15:34 -0700
In-Reply-To: <20190908074953.kux7zz4y7iolqko4@whir> (Eric Wong's message of
        "Sun, 8 Sep 2019 07:49:53 +0000")
Message-ID: <xmqqsgp5jpyx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2268892-D32D-11E9-B09B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Eric Wong <e@80x24.org> wrote:
>> By renaming the "hash" field to "_hash", it's easy to spot
>> improper initialization of hashmap_entry structs which
>> can leave "hashmap_entry.next" uninitialized.
>
> Junio, I'm planning to reroll this series.
> (Sorry for not following up sooner)
>
> Would you prefer I drop 04/11 "hashmap_entry: detect improper initialization"
> in favor of the following?  Thanks.

Automation is good ;-)
FWIW, I do not mind the original 04/11 myself too much, though.

Thanks.

> ---------8<--------
> Subject: [PATCH 4/11] coccicheck: detect hashmap_entry.hash assignment
>
> Assigning hashmap_entry.hash manually leaves hashmap_entry.next
> uninitialized, which can be dangerous once the hashmap_entry is
> inserted into a hashmap.   Detect those assignments and use
> hashmap_entry_init, instead.
>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  contrib/coccinelle/hashmap.cocci | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 contrib/coccinelle/hashmap.cocci
>
> diff --git a/contrib/coccinelle/hashmap.cocci b/contrib/coccinelle/hashmap.cocci
> new file mode 100644
> index 0000000000..d69e120ccf
> --- /dev/null
> +++ b/contrib/coccinelle/hashmap.cocci
> @@ -0,0 +1,16 @@
> +@ hashmap_entry_init_usage @
> +expression E;
> +struct hashmap_entry HME;
> +@@
> +- HME.hash = E;
> ++ hashmap_entry_init(&HME, E);
> +
> +@@
> +identifier f !~ "^hashmap_entry_init$";
> +expression E;
> +struct hashmap_entry *HMEP;
> +@@
> +  f(...) {<...
> +- HMEP->hash = E;
> ++ hashmap_entry_init(HMEP, E);
> +  ...>}
