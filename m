Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A75C433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 04:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242923AbiFPExI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 00:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiFPExH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 00:53:07 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B476422283
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 21:53:06 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5332C18A64E;
        Thu, 16 Jun 2022 00:53:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nHx6IK8ZAjd+a0iXRF8KUwp3+uRbPB4PuxJxLD
        UuJwY=; b=W+cyIv48qpMOz7tB0WrwKBn4TOMUWeIbrKf+dyvQemXDDCzEynk79r
        GxQxMnVkc2dnXraGxgph2YuEFdTwvmCdZ/pguhR+aHcWZqdmyWL4w9h/5D6+N+w8
        rChtrwTHKiaOfSUeFnHyMIoy0vGqxr15STMhfgUQ2CcvjIqIiaTrg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C2EB18A64C;
        Thu, 16 Jun 2022 00:53:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E88FC18A64B;
        Thu, 16 Jun 2022 00:53:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 06/11] pack-redundant: avoid using uninitialized memory
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
        <bc29a9710e3a22e6d660098c4f201f3bfecc54ea.1655336146.git.gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 21:53:01 -0700
In-Reply-To: <bc29a9710e3a22e6d660098c4f201f3bfecc54ea.1655336146.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 15 Jun 2022
        23:35:40 +0000")
Message-ID: <xmqqilp1w6oi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 341517F2-ED30-11EC-8FF7-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In the `add_pack()` function, we forgot to initialize the field `next`,
> which could potentially lead to readin uninitialized memory later.
>
> Reported by Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/pack-redundant.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
> index ed9b9013a5f..1f7da1f68b6 100644
> --- a/builtin/pack-redundant.c
> +++ b/builtin/pack-redundant.c
> @@ -526,6 +526,7 @@ static struct pack_list * add_pack(struct packed_git *p)
>  	}
>  	l.all_objects_size = l.remaining_objects->size;
>  	l.unique_objects = NULL;
> +	l.next = NULL;
>  	if (p->pack_local)
>  		return pack_list_insert(&local_packs, &l);
>  	else
		return pack_list_insert(&altodb_packs, &l);


The pack_list_insert reads like so:

static inline struct pack_list * pack_list_insert(struct pack_list **pl,
					   struct pack_list *entry)
{
	struct pack_list *p = xmalloc(sizeof(struct pack_list));
	memcpy(p, entry, sizeof(struct pack_list));
	p->next = *pl;
	*pl = p;
	return p;
}


IOW, we prepare members of "l", pass it as "entry" to pack_list_insert(),
but the helper function allocates a new piece of memory, copies "l"
to it, and then sets the .next member of it to a reasonable value.

And after that, the "l" that was merely used as a template goes out
of scope.

So I think this is a false positive.  memcpy(p) does copy the
uninitialized garbage that is held in entry->next to p->next, but it
is overwritten with a reasonable address immediately after that.


