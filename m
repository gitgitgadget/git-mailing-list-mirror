Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF95CC25B06
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 22:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiHDWQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 18:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiHDWQT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 18:16:19 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CA161D49
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 15:16:18 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BAE5140006;
        Thu,  4 Aug 2022 18:16:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OHN8/4lX4ugeo0A9WSXWi4zoJEyJ5VrjTm5oNe
        nra1k=; b=UtRQcIEv0kgKbCi5K59yT3/AoDRECdJVa04q+mjVp+ZDYDiy//uK20
        pvAAoiHIHqHkueCpAP5EHr1ApUpY7IpcrPOhIWIF+Yas5ihN24nN72BHr51iU/JC
        5ko+8Mu/WjIfoiNIYc/lS+p9aiEwjXlB1ZgajYIGs4slKMfSiYvOc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11C73140005;
        Thu,  4 Aug 2022 18:16:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E0B8140004;
        Thu,  4 Aug 2022 18:16:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        shaoxuan.yuan02@gmail.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 3/4] cache.h: replace 'index_entry_exists()' with
 'index_name_pos_sparse()'
References: <pull.1312.git.1659645967.gitgitgadget@gmail.com>
        <f7978d223fe86b6d0d43e905ee3abdc02fef8b7d.1659645967.git.gitgitgadget@gmail.com>
Date:   Thu, 04 Aug 2022 15:16:15 -0700
In-Reply-To: <f7978d223fe86b6d0d43e905ee3abdc02fef8b7d.1659645967.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Thu, 04 Aug 2022 20:46:06
        +0000")
Message-ID: <xmqqpmhf1wpc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0EF5B3AC-1443-11ED-B4AB-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Replace 'index_entry_exists()' (which returns a binary '1' or '0' depending
> on whether a specified entry exists in the index) with
> 'index_name_pos_sparse()' (which behaves the same as 'index_name_pos()',
> except that it does not expand a sparse index to search for an entry inside
> a sparse directory).
>
> 'index_entry_exists()' was original implemented in 20ec2d034c (reset: make

"original" -> "originally"?

> sparse-aware (except --mixed), 2021-11-29) to allow callers to search for an
> index entry without expanding a sparse index. That particular case only
> required knowing whether the requested entry existed. This patch expands the
> amount of information returned by indicating both 1) whether the entry
> exists, and 2) its position (or potential position) in the index.

"position or potential position" is good, but the latter stalled my
reading briefly, wondering if "potential" refers to "the position
that the entry would be at when the sparse entries are all
expanded", which is not what the patch and the description intend to
say.  I am not sure how to rephrase the proposed log message to
alleviate the confusion, though.

> diff --git a/cache.h b/cache.h
> index 4aa1bd079d5..6bfd1d80b24 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -831,14 +831,13 @@ struct cache_entry *index_file_exists(struct index_state *istate, const char *na
>  int index_name_pos(struct index_state *, const char *name, int namelen);
>  
>  /*
> + * Like index_name_pos, returns the position of an entry of the given name in
> + * the index if one exists, otherwise returns a negative value where the negated
> + * value minus 1 is the position where the index entry would be inserted. Unlike
> + * index_name_pos, however, a sparse index is not expanded to find an entry
> + * inside a sparse directory.
> + */

This description is perfectly clear.

> +int index_name_pos_sparse(struct index_state *, const char *name, int namelen);
>  
>  /*
>   * Some functions return the negative complement of an insert position when a
> diff --git a/read-cache.c b/read-cache.c
> index 4de207752dc..a85b922a3bc 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -620,9 +620,9 @@ int index_name_pos(struct index_state *istate, const char *name, int namelen)
>  	return index_name_stage_pos(istate, name, namelen, 0, EXPAND_SPARSE);
>  }
>  
> -int index_entry_exists(struct index_state *istate, const char *name, int namelen)
> +int index_name_pos_sparse(struct index_state *istate, const char *name, int namelen)
>  {
> -	return index_name_stage_pos(istate, name, namelen, 0, NO_EXPAND_SPARSE) >= 0;
> +	return index_name_stage_pos(istate, name, namelen, 0, NO_EXPAND_SPARSE);
>  }

Nice.

Thanks.
