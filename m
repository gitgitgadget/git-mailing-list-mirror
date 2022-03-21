Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2FAC433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 17:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351727AbiCUR5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 13:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbiCUR5J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 13:57:09 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4BD3B564
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 10:55:43 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31648111855;
        Mon, 21 Mar 2022 13:55:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WEGNQ0dSeyeWclylABUWp1wdCBQV3oUy0uk82+
        rDUUE=; b=yfh9UwnmfT/4zcwx1hJs0t6Eqv/kliK8zVH0OhIvrh2RXzV34kHFB1
        p+bsFBjieaLkDdbD5x3+Dcx+qaBtQXg2ITHGXP3uH9M7EXaSKSNcI1wwtwIcg5fd
        9h4iTsKEAZsYJuA+Z3IY0tUbVMlaIN47VvGHo6ySYCexi+KB8wmHk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 238CB111854;
        Mon, 21 Mar 2022 13:55:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6C13B111853;
        Mon, 21 Mar 2022 13:55:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        nksingh85@gmail.com, ps@pks.im,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 4/7] unpack-objects: use the bulk-checkin infrastructure
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
        <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
        <6662e2dae0f5d65c158fba785d186885f9671073.1647760561.git.gitgitgadget@gmail.com>
Date:   Mon, 21 Mar 2022 10:55:41 -0700
In-Reply-To: <6662e2dae0f5d65c158fba785d186885f9671073.1647760561.git.gitgitgadget@gmail.com>
        (Neeraj Singh via GitGitGadget's message of "Sun, 20 Mar 2022 07:15:57
        +0000")
Message-ID: <xmqqv8w7yyua.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 202F966A-A940-11EC-B511-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Neeraj Singh <neerajsi@microsoft.com>
>
> The unpack-objects functionality is used by fetch, push, and fast-import
> to turn the transfered data into object database entries when there are
> fewer objects than the 'unpacklimit' setting.
>
> By enabling bulk-checkin when unpacking objects, we can take advantage
> of batched fsyncs.

This feels confused in that we dispatch to unpack-objects (instead
of index-objects) only when the number of loose objects should not
matter from performance point of view, and bulk-checkin should shine
from performance point of view only when there are enough objects to
batch.

Also if we ever add "too many small loose objects is wasteful, let's
send them into a single 'batch pack'" optimization, it would create
a funny situation where the caller sends the contents of a small
incoming packfile to unpack-objects, but the command chooses to
bunch them all together in a packfile anyway ;-)

So, I dunno.


> Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> ---
>  builtin/unpack-objects.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index dbeb0680a58..c55b6616aed 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -1,5 +1,6 @@
>  #include "builtin.h"
>  #include "cache.h"
> +#include "bulk-checkin.h"
>  #include "config.h"
>  #include "object-store.h"
>  #include "object.h"
> @@ -503,10 +504,12 @@ static void unpack_all(void)
>  	if (!quiet)
>  		progress = start_progress(_("Unpacking objects"), nr_objects);
>  	CALLOC_ARRAY(obj_list, nr_objects);
> +	plug_bulk_checkin();
>  	for (i = 0; i < nr_objects; i++) {
>  		unpack_one(i);
>  		display_progress(progress, i + 1);
>  	}
> +	unplug_bulk_checkin();
>  	stop_progress(&progress);
>  
>  	if (delta_list)
