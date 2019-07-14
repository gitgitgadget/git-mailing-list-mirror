Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C8C81F461
	for <e@80x24.org>; Sun, 14 Jul 2019 18:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfGNS74 (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jul 2019 14:59:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59810 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbfGNS74 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jul 2019 14:59:56 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD4B9160B9B;
        Sun, 14 Jul 2019 14:59:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6RkoBN2xRnTuWc8IL95hl2oOuZA=; b=LVrLxF
        YfEE0Il+TCoPxeWdllgpO59+t+4ZhU9m+dVL3kOqFDxnuggHskzbSAZ95W8IIf4C
        omYTzEdbBBsRLs+G9+nD5hcMiV5kakyzUvnB8YrSytGmGYD96QV1RExX2AA+qcrg
        mzdbojiJc9O0RIFVDa5KWr4zpkIZt5tSxw0qE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LlXzgiB6UqK1XF/uiVkwS5l9bgcsYado
        GBBwISLbaFY9nAnIaTxoS6Ur3j4uVseZ4QiL2YL2F8xOzeLn+cf8mRZVt+H4ZMa0
        4DkDZfghUTxuUx2jwfxbaPylV7+477HA3bTGjVEHhE+FC7pNEv6mQrb5SjiYkAKt
        v+0CzPUcgD4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C5981160B9A;
        Sun, 14 Jul 2019 14:59:55 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 304DF160B98;
        Sun, 14 Jul 2019 14:59:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Varun Naik <vcnaik94@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] read-cache.c: do not die if mmap fails
References: <20190714030153.22022-1-vcnaik94@gmail.com>
Date:   Sun, 14 Jul 2019 11:59:54 -0700
In-Reply-To: <20190714030153.22022-1-vcnaik94@gmail.com> (Varun Naik's message
        of "Sat, 13 Jul 2019 20:01:53 -0700")
Message-ID: <xmqq7e8k5tn9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 915DA80E-A669-11E9-95B0-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Varun Naik <vcnaik94@gmail.com> writes:

> do_read_index() mmaps the index, or tries to die with an error message
> on failure. It should call xmmap_gently(), which returns MAP_FAILED,
> rather than xmmap(), which dies with its own error message.
>
> An easy way to cause this mmap to fail is by setting $GIT_INDEX_FILE to
> a path to a directory and then invoking any command that reads from the
> index.
>
> Signed-off-by: Varun Naik <vcnaik94@gmail.com>
> ---
> I believe this is the only place that calls xmmap() when it should be
> calling xmmap_gently(). There is a related recent commit 3203566a71
> ("Use xmmap_gently instead of xmmap in use_pack", 2019-05-16).

Nice find and thanks for checking other callsites of xmmap().

>
>  read-cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 22e7b9944e..4e30dafa9d 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2140,7 +2140,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>  	if (mmap_size < sizeof(struct cache_header) + the_hash_algo->rawsz)
>  		die(_("%s: index file smaller than expected"), path);
>  
> -	mmap = xmmap(NULL, mmap_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +	mmap = xmmap_gently(NULL, mmap_size, PROT_READ, MAP_PRIVATE, fd, 0);
>  	if (mmap == MAP_FAILED)
>  		die_errno(_("%s: unable to map index file"), path);
>  	close(fd);
