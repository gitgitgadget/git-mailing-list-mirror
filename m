Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C57C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 17:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351098AbiCURvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 13:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240444AbiCURvw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 13:51:52 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9B1369DC
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 10:50:25 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BE72127BF7;
        Mon, 21 Mar 2022 13:50:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b+oB7hNwjZIBdlvhInDAZttPzExs4uXBKfbjFA
        GIkM8=; b=PDGlidSoLErCOwffCIN0dgv5RVE7ngIK/Zc+kvhJwZPtJjSq3moWBc
        oIZoV6dlFDszs9x8uTWBL+vyi++atB10jKa8KccXqfWMjMS9xEPLLfEZWqkheCld
        CaWC3JPfmbfCTBa7B/9SHjk7T1x3sOWPAzNk8isCfj7sATfEVbmcc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 018CA127BF5;
        Mon, 21 Mar 2022 13:50:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 57AD2127BF4;
        Mon, 21 Mar 2022 13:50:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        nksingh85@gmail.com, ps@pks.im,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 3/7] update-index: use the bulk-checkin infrastructure
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
        <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
        <54797dbc52060b7fa913642cd5266f7e159a5bc9.1647760561.git.gitgitgadget@gmail.com>
Date:   Mon, 21 Mar 2022 10:50:23 -0700
In-Reply-To: <54797dbc52060b7fa913642cd5266f7e159a5bc9.1647760561.git.gitgitgadget@gmail.com>
        (Neeraj Singh via GitGitGadget's message of "Sun, 20 Mar 2022 07:15:56
        +0000")
Message-ID: <xmqqzgljyz34.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6298615E-A93F-11EC-9967-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 75d646377cc..38e9d7e88cb 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -5,6 +5,7 @@
>   */
>  #define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
> +#include "bulk-checkin.h"
>  #include "config.h"
>  #include "lockfile.h"
>  #include "quote.h"
> @@ -1110,6 +1111,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  
>  	the_index.updated_skipworktree = 1;
>  
> +	/* we might be adding many objects to the object database */
> +	plug_bulk_checkin();
> +
>  	/*
>  	 * Custom copy of parse_options() because we want to handle
>  	 * filename arguments as they come.
> @@ -1190,6 +1194,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  		strbuf_release(&buf);
>  	}
>  
> +	/* by now we must have added all of the new objects */
> +	unplug_bulk_checkin();

I understand read-from-stdin code path would be worth plugging, but
the list of paths on the command line?  How many of them would one
fit?

Of course, the feeder may be expecting for the objects to appear in
the object store as it feeds the paths and will be utterly broken by
this change, as you mentioned in the proposed log message.  The
existing plug/unplug will change the behaviour by making the objects
sent to the packfile available only after getting unplugged.  This
series makes it even worse by making loose objects also unavailable
until unplug is called.

So, it probably is safer and more sensible approach to introduce a
new command line option to allow the bulk checkin, and those who do
not care about the intermediate state to opt into the new feature.

