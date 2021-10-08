Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34494C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 09:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1339661027
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 09:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbhJHJGQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 05:06:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54246 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbhJHJGO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 05:06:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 65EE9F6CEC;
        Fri,  8 Oct 2021 05:04:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=HVoLtpQ0bJe6Tk7Z9zaqmKnuQ1pFuZkIj4zzsuQjy/k=; b=SOGf
        RRIKjskYkw0b64VxX+nc/WmUDFkhkh25aVUelkBS+uBXS+A+st+wICIr1GfcuzZh
        wkGGUVhfKQ3SOkkWp3MaO4GEIAwoDi1jr/OGyYTxT5cFFFA5i/r1OWkiQtiMHbbb
        Hsbe49rCXauhT8FNG1h+1/o1yLLgULhTGK9cmfM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5CE2AF6CEB;
        Fri,  8 Oct 2021 05:04:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C6986F6CEA;
        Fri,  8 Oct 2021 05:04:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH v3 2/8] reset: preserve skip-worktree bit in mixed reset
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
        <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
        <1f6da84830b00b7d33ac8ae4c6a46a90606c901f.1633641339.git.gitgitgadget@gmail.com>
Date:   Fri, 08 Oct 2021 02:04:17 -0700
Message-ID: <xmqqr1cvlwfi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B851183E-2816-11EC-B1F6-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -141,6 +143,18 @@ static void update_index_from_diff(struct diff_queue_struct *q,
>  
>  		ce = make_cache_entry(&the_index, one->mode, &one->oid, one->path,
>  				      0, 0);
> +
> +		/*
> +		 * If the file 1) corresponds to an existing index entry with
> +		 * skip-worktree set, or 2) does not exist in the index but is
> +		 * outside the sparse checkout definition, add a skip-worktree bit
> +		 * to the new index entry.
> +		 */
> +		pos = cache_name_pos(one->path, strlen(one->path));
> +		if ((pos >= 0 && ce_skip_worktree(active_cache[pos])) ||
> +		    (pos < 0 && !path_in_sparse_checkout(one->path, &the_index)))
> +			ce->ce_flags |= CE_SKIP_WORKTREE;

OK.  Nicely explained.
