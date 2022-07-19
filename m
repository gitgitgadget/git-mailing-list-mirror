Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41605CCA47F
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 15:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239708AbiGSP7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 11:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237857AbiGSP7e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 11:59:34 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D991A5B79B
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 08:59:33 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 45F3F19AD23;
        Tue, 19 Jul 2022 11:59:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YwfzGAW8yNzjZjhbRdyLvqkeLU4LC/n1AYluVb
        6+PAU=; b=pye5p4lbAwmn5X0gJSnhORiaxKZeCXW/X10kvJ9arntq0gFQH2PAna
        HCAR7qkQD44fMDoyrEpbqU925Z7VY353GerRrRi9biyewpT52mK6epUBOITGKQdk
        vGQECys1tDO+v6jxijriSaSGsQd/6zxYv2Aj/TC4UBFsSeKtS99l0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3D7B519AD22;
        Tue, 19 Jul 2022 11:59:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C961A19AD20;
        Tue, 19 Jul 2022 11:59:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        chakrabortyabhradeep79@gmail.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 3/3] midx: reduce memory pressure while writing bitmaps
References: <pull.1292.git.1658176565751.gitgitgadget@gmail.com>
        <pull.1292.v2.git.1658244366.gitgitgadget@gmail.com>
        <98e72f71b6bec6f5c2df4139ca3df37d97ddcf54.1658244366.git.gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 08:59:28 -0700
In-Reply-To: <98e72f71b6bec6f5c2df4139ca3df37d97ddcf54.1658244366.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 19 Jul 2022
        15:26:06 +0000")
Message-ID: <xmqq8ropccv3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C5C009C2-077B-11ED-96E2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/midx.c b/midx.c
> index e2dd808b35d..772ab7d2944 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -1451,6 +1451,15 @@ static int write_midx_internal(const char *object_dir,
>  
>  		commits = find_commits_for_midx_bitmap(&commits_nr, refs_snapshot, &ctx);
>  
> +		/*
> +		 * The previous steps translated the information from
> +		 * 'entries' into information suitable for constructing
> +		 * bitmaps. We no longer need that array, so clear it to
> +		 * reduce memory pressure.
> +		 */
> +		FREE_AND_NULL(ctx.entries);
> +		ctx.entries_nr = 0;
> +
>  		if (write_midx_bitmap(midx_name.buf, midx_hash, &pdata,
>  				      commits, commits_nr, ctx.pack_order,
>  				      refs_snapshot, flags) < 0) {

As the reduced helper, thanks to step [1/3], only takes the
pack_order[] array, without being even aware of other members in the
ctx struct, it is immediately obvious that this early freeing is
safe for this call.  It is a bit messy.

I've been staring at the code and was wondering if we can just get
rid of pack_order member from the context, and make pack_order a
separate local variable that belong to this function.  The separate
variable needs to be packaged together with ctx back to please the
chunk-format API, so it may require more boilerplate code and may
not be an overall win.

> @@ -1459,6 +1468,10 @@ static int write_midx_internal(const char *object_dir,
>  			goto cleanup;
>  		}
>  	}
> +	/*
> +	 * NOTE: Do not use ctx.entries beyond this point, since it might
> +	 * have been freed in the previous if block.
> +	 */

OK.

>  	if (ctx.m)
>  		close_object_store(the_repository->objects);

