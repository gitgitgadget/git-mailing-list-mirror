Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E62C433F5
	for <git@archiver.kernel.org>; Mon,  2 May 2022 23:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiEBX2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 19:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiEBX0i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 19:26:38 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5781D302
        for <git@vger.kernel.org>; Mon,  2 May 2022 16:23:05 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 18741108CC8;
        Mon,  2 May 2022 19:23:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6P58TDTCWwJXU0qnhDPyXgQaYqJo/mRlWHXTMf
        karX0=; b=c1nNJXiBwNNXZ6kC+ECvsuAse+PxFDRnd6PrTOIbSsow+emwrOh7Ok
        pfjaen+mTkMsHGrHg+NGRSAJRZX+uzjJio2bz1AR3o2g8wocC5Cri8HD2XnZe+OB
        EG7USRfW/OEDu0yaW4nYtdBFZZsb5zR57PxDVn9FT3wj/aphUdPbU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FA45108CC7;
        Mon,  2 May 2022 19:23:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5D248108CC6;
        Mon,  2 May 2022 19:23:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH v4 3/8] object-store: add function to free object_info
 contents
References: <20220328191112.3092139-1-calvinwan@google.com>
        <20220502170904.2770649-1-calvinwan@google.com>
        <20220502170904.2770649-4-calvinwan@google.com>
Date:   Mon, 02 May 2022 16:23:03 -0700
In-Reply-To: <20220502170904.2770649-4-calvinwan@google.com> (Calvin Wan's
        message of "Mon, 2 May 2022 17:08:59 +0000")
Message-ID: <xmqqzgjztt7s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D10C7936-CA6E-11EC-92E1-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Introduce free_object_info_contents.
>
> ---
>  object-file.c  | 16 ++++++++++++++++
>  object-store.h |  3 +++
>  2 files changed, 19 insertions(+)
>
> diff --git a/object-file.c b/object-file.c
> index 5ffbf3d4fd..34a6e34adf 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2659,3 +2659,19 @@ int read_loose_object(const char *path,
>  		munmap(map, mapsize);
>  	return ret;
>  }
> +
> +void free_object_info_contents(struct object_info *object_info)
> +{
> +	if (!object_info)
> +		return;

This is OK, but ...


> +	if (object_info->typep)
> +		free(object_info->typep);
> +	if (object_info->sizep)
> +		free(object_info->sizep);
> +	if (object_info->disk_sizep)
> +		free(object_info->disk_sizep);
> +	if (object_info->delta_base_oid)
> +		free(object_info->delta_base_oid);
> +	if (object_info->type_name)
> +		free(object_info->type_name);

	if (PTR)
		free(PTR);

can and should be written as

	free(PTR);

If we are reusing object_info after calling this function, we
_might_ want to use FREE_AND_NULL() instead of free().

> +}
> \ No newline at end of file

Let's avoid such incomplete lines.

> diff --git a/object-store.h b/object-store.h
> index bd2322ed8c..840e04b56f 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -533,4 +533,7 @@ int for_each_object_in_pack(struct packed_git *p,
>  int for_each_packed_object(each_packed_object_fn, void *,
>  			   enum for_each_object_flags flags);
>  
> +/* Free pointers inside of object_info, but not object_info itself */
> +void free_object_info_contents(struct object_info *object_info);
> +
>  #endif /* OBJECT_STORE_H */
