Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3AFC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 21:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241987AbiEXVop (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 17:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbiEXVoo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 17:44:44 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B548020D
        for <git@vger.kernel.org>; Tue, 24 May 2022 14:44:43 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 52DBE18D641;
        Tue, 24 May 2022 17:44:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l8Hp2+aNxWm2rNYtne6SADx8gNv6fVkQ7F52J8
        JUil8=; b=i686xGENPWHhyuISwhRPwv24Ei4xDRGOK06DY0Lel492xxw7b5Ujfw
        0X9xp///omKeG9GN/0yzTd9/tWV+BN15wiwOmmhi7qo48KPZbYhHPsgLR784Ae65
        kHSIFbIaYvsxf918qF9yi2FKDokDbDtN93OGEYhqIAzpY420paFD0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4B47118D640;
        Tue, 24 May 2022 17:44:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 020B618D63F;
        Tue, 24 May 2022 17:44:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, vdye@github.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 2/4] builtin/pack-objects.c: avoid redundant NULL check
References: <cover.1652458395.git.me@ttaylorr.com>
        <cover.1653418457.git.me@ttaylorr.com>
        <2719d33f328e03239cdb2f5cca2fef9a4e9cbb93.1653418457.git.me@ttaylorr.com>
Date:   Tue, 24 May 2022 14:44:37 -0700
In-Reply-To: <2719d33f328e03239cdb2f5cca2fef9a4e9cbb93.1653418457.git.me@ttaylorr.com>
        (Taylor Blau's message of "Tue, 24 May 2022 14:54:27 -0400")
Message-ID: <xmqq8rqqfvwa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6408A8C-DBAA-11EC-8F25-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Before calling `for_each_object_in_pack()`, the caller
> `read_packs_list_from_stdin()` loops through each of the `include_packs`
> and checks that its `->util` pointer (which is used to store the `struct
> packed_git *` itself) is non-NULL.
>
> This check is redundant, because `read_packs_list_from_stdin()` already
> checks that the included packs are non-NULL earlier on in the same
> function (and it does not add any new entries in between).
>
> Remove this check, since it is not doing anything in the meantime.

Will it start doing something soon in a later step?

Oh, did you mean that after the earlier for_each_string_list_item()
iteration over include_packs that died on an item with a NULL .util
member, the code did not do anything to cause this second iteration
over the same list to suddenly start seeing an item with NULL .util?

I am puzzled by the mention of "in the meantime".

The patch itself looks correct, of course.

Thanks.

> Co-authored-by: Victoria Dye <vdye@github.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/pack-objects.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 014dcd4bc9..ec3193fd95 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3369,8 +3369,6 @@ static void read_packs_list_from_stdin(void)
>  
>  	for_each_string_list_item(item, &include_packs) {
>  		struct packed_git *p = item->util;
> -		if (!p)
> -			die(_("could not find pack '%s'"), item->string);
>  		for_each_object_in_pack(p,
>  					add_object_entry_from_pack,
>  					&revs,
