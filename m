Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3BFC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 21:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiCDVUD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 16:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiCDVUC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 16:20:02 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A263FDA5
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 13:19:12 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A389E111E28;
        Fri,  4 Mar 2022 16:19:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b2E/pskaWaRZg41VNuSN9a+oED9Im9ddW+4e/A
        CeGHs=; b=RvPTTT4W8gSFUDZz9qRfVB7fx+6Rp22at8hOWYrlUKnJESapwnKiS8
        hWiZx8hhrQREtoo/J3V53JbhBtjgaMfiDK5NSHk/ac51YyXzwNUONIrZURQs90AR
        x/Ew3BCoKnLTRzQLx5ZgSOJ3wfSyu3nug3uwyAdBG1opZ/CFqWKBs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99C64111E27;
        Fri,  4 Mar 2022 16:19:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0FD37111E26;
        Fri,  4 Mar 2022 16:19:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH v3 4/7] fetch: add --refetch option
References: <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
        <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
        <a503b98f33328133f9a89ad7eba986b73535c461.1646406275.git.gitgitgadget@gmail.com>
Date:   Fri, 04 Mar 2022 13:19:07 -0800
In-Reply-To: <a503b98f33328133f9a89ad7eba986b73535c461.1646406275.git.gitgitgadget@gmail.com>
        (Robert Coup via GitGitGadget's message of "Fri, 04 Mar 2022 15:04:31
        +0000")
Message-ID: <xmqqa6e51kms.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BADFF40E-9C00-11EC-A0F3-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert Coup via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static int verbosity, deepen_relative, set_upstream, refetch;
>  static int progress = -1;
>  static int enable_auto_gc = 1;
>  static int tags = TAGS_DEFAULT, unshallow, update_shallow, deepen;
> @@ -190,6 +190,9 @@ static struct option builtin_fetch_options[] = {
>  	OPT_SET_INT_F(0, "unshallow", &unshallow,
>  		      N_("convert to a complete repository"),
>  		      1, PARSE_OPT_NONEG),
> +	OPT_SET_INT_F(0, "refetch", &refetch,
> +		      N_("re-fetch without negotiating common commits"),
> +		      1, PARSE_OPT_NONEG),

I guess the existing --unshallow has the same problem, but it strikes
me odd that these aren't doing a bog-standard OPT_BOOL(), with default
value of "false", like, say "--update-head-ok" does.

That will naturally support things like

	git fetch --refetch --no-refetch

where a later option overrides what an earlier option did.

