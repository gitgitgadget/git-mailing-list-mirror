Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6242CC43334
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 23:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiFMXDN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 19:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiFMXDM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 19:03:12 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DC028E18
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 16:03:11 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 39E9E135592;
        Mon, 13 Jun 2022 19:03:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jPwGSWQ/RS7PUENd+Tz7GA2Aa0MssUvPBlyRm2
        Y9N1M=; b=axVT2PaIJ4CWIooedMbdLM5aHP7Q+rI5qSiqwcR3b0T5BD1BkiPPwF
        ED3fOnVSyAgrk5pBrROMddybgr3KsCcBYu5GfK2wYPRO3salJnYG77G3PhHeXudw
        uTX5yRXnCSo/RynkWYOORu7xI1XQ5NdMQsHvn7zinU1a731g67Fi4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30206135591;
        Mon, 13 Jun 2022 19:03:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D31E135590;
        Mon, 13 Jun 2022 19:03:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/5] branch: fix branch_checked_out() leaks
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
        <6cd7db33-6ab5-9843-4483-4cce9835b177@github.com>
Date:   Mon, 13 Jun 2022 16:03:08 -0700
In-Reply-To: <6cd7db33-6ab5-9843-4483-4cce9835b177@github.com> (Derrick
        Stolee's message of "Mon, 13 Jun 2022 10:59:58 -0400")
Message-ID: <xmqq35g8415f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE3C06FA-EB6C-11EC-B747-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>  	while (worktrees[i]) {
> +		char *old;
>  		struct wt_status_state state = { 0 };
>  		struct worktree *wt = worktrees[i++];
>  
>  		if (wt->is_bare)
>  			continue;
>  
> -		if (wt->head_ref)
> -			strmap_put(&current_checked_out_branches,
> -				   wt->head_ref,
> -				   xstrdup(wt->path));
> +		if (wt->head_ref) {
> +			old = strmap_put(&current_checked_out_branches,
> +					 wt->head_ref,
> +					 xstrdup(wt->path));
> +			free(old);
> +		}

While it is equivalent to

			free(strmap_put(&current_checked_out_branches,
                        		wt->head_ref,
					xstrdup(wt->path)));

writing the "put the new one" and "discard the old one (if exists)"
as separate steps like the above does make it easier to follow, at
least to me.

Thanks.  Will queue.
