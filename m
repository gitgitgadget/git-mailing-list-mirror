Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C96C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 23:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbiCYXbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 19:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiCYXbL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 19:31:11 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D8B13D02
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 16:29:36 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4EADD19C4CF;
        Fri, 25 Mar 2022 19:29:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V99YV/bsjnLvUB+xBOymAMVyy3/9pXoAalIJMw
        ckheY=; b=ZLR8TT/oB/8tRArKPH3REPAblFBWwIAMZfbFGVUHhbg1K3qYTStVRB
        KejnzsRwGFC8OiZz7ifyd0a8oHVq97vGclBY+JetnT9T3CZlocWtObYwmXyUSeIl
        0GMv58QKrvrowt2K9Fwc34iuYSlBLLzuzp6aBDdGml87PUDJFu+K0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4824219C4CE;
        Fri, 25 Mar 2022 19:29:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AF16719C4CD;
        Fri, 25 Mar 2022 19:29:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, reichemn@icloud.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] mv: refresh stat info for moved entry
References: <pull.1187.git.1648173419533.gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 16:29:32 -0700
In-Reply-To: <pull.1187.git.1648173419533.gitgitgadget@gmail.com> (Victoria
        Dye via GitGitGadget's message of "Fri, 25 Mar 2022 01:56:59 +0000")
Message-ID: <xmqqk0ch8vc3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D67B1B4-AC93-11EC-A2D0-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/read-cache.c b/read-cache.c
> index 1ad56d02e1d..2c5ccc48d6c 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -148,6 +148,7 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
>  	untracked_cache_remove_from_index(istate, old_entry->name);
>  	remove_index_entry_at(istate, nr);
>  	add_index_entry(istate, new_entry, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
> +	refresh_cache_entry(istate, new_entry, CE_MATCH_REFRESH);
>  }

This is a bit unforunate.

If we are renaming "foo" to "bar", I wonder if we can grab the
cached stat info before calling remove_index_entry_at() for "foo"
and copy it to the new entry we create for "bar".  After all, we
would be making a corresponding change to rename from "foo" to "bar"
at the filesystem level, too, no?

Well, we are already doing that by calling copy_cache_entry().  So
why do we further need to refresh the cache entry in the first
place?  There is something fishy going on, isn't it?

Puzzling...

In any case, refresh_cache_entry() either returns ce or create a
newly allocated entry, so you'd want to first refresh and then the
add the cache entry returned from the function to the index, I
think.

Thanks.
