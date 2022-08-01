Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B01C19F2C
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 22:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbiHAWSu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 18:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiHAWSs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 18:18:48 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013E9220D3
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 15:18:47 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C70B6152FBA;
        Mon,  1 Aug 2022 18:18:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6xBuI/tSHMvoVHYOns9nycmkwxxj53KwLq0bIp
        q9CX4=; b=eoQytDbF6/wGJ8anRAFH1jdt5+gOBov6SdOCJZWfChGCWY7K5OAF3p
        3yCjA1Kfx+zCbuv/Ds3LsCEav4xN/FJ15vRoGPKR6fsw46Z2FpjEqWqN3QTkPJ1l
        7d05wjYuCb6ALAc+vRLAw9VXGRENJG+toIm8Cebnh6VvJ1PqF7ZDg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BEC79152FB9;
        Mon,  1 Aug 2022 18:18:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2FDFC152FB8;
        Mon,  1 Aug 2022 18:18:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 3/7] builtin/bugreport.c: avoid size_t overflow
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
        <e8abfdfa892f5670ed411ed6daef26a4ffa1bfe6.1659388498.git.gitgitgadget@gmail.com>
Date:   Mon, 01 Aug 2022 15:18:43 -0700
In-Reply-To: <e8abfdfa892f5670ed411ed6daef26a4ffa1bfe6.1659388498.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Mon, 01 Aug 2022 21:14:54
        +0000")
Message-ID: <xmqqpmhjmwu4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7C8EF9A-11E7-11ED-81F2-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Avoid size_t overflow when reporting the available disk space in
> 'get_disk_info' by casting the block size and available block count to
> 'uint64_t' before multiplying them. Without this change, 'st_mult' would
> (correctly) report size_t overflow on 32-bit systems at or exceeding 2^32
> bytes of available space.

Sane.  But shouldn't the cast be to off_t, which is what
strbuf_humanise_bytes() takes anyway?

>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  builtin/bugreport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index 35b1fc48bf1..720889a37ad 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -258,7 +258,7 @@ static int get_disk_info(struct strbuf *out)
>  	}
>  
>  	strbuf_addf(out, "Available space on '%s': ", buf.buf);
> -	strbuf_humanise_bytes(out, st_mult(stat.f_bsize, stat.f_bavail));
> +	strbuf_humanise_bytes(out, (uint64_t)stat.f_bsize * (uint64_t)stat.f_bavail);
>  	strbuf_addf(out, " (mount flags 0x%lx)\n", stat.f_flag);
>  	strbuf_release(&buf);
>  #endif
