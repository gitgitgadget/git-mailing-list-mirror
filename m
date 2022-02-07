Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C20FC433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 01:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiBHBFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238593AbiBGXgv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 18:36:51 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8B6C061355
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 15:36:50 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 902C011BAA6;
        Mon,  7 Feb 2022 18:36:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VD82hiIh2N76CqBCSLA+JxT+1d7/vQFB2pLdx6
        Z/k5E=; b=yXi0aRn/1H4agVlMA9/kso5bSvgX6OkpXUGbFA0NwLvAY+fvFMxjtt
        eR/aLd1QySUA0IsFtKmYfQRJKGKuw7D6Y+bO6oZH8+E1YBMxqQ0V1JZEb189rTW1
        SuVAeS2DfnPQyeD2m1XE5v2+vyaqFBVFKV10684HvjINfc7jhd4XM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8719611BAA5;
        Mon,  7 Feb 2022 18:36:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3EF611BAA4;
        Mon,  7 Feb 2022 18:36:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 03/15] merge-tree: add option parsing and initial
 shell for real merge function
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
        <63f42df21aec5bda50e4414493eb59dcb64e5558.1643787281.git.gitgitgadget@gmail.com>
        <YgGgCasl1eVz679E@google.com>
Date:   Mon, 07 Feb 2022 15:36:47 -0800
In-Reply-To: <YgGgCasl1eVz679E@google.com> (Emily Shaffer's message of "Mon, 7
        Feb 2022 14:41:13 -0800")
Message-ID: <xmqq7da6gsfk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1D0B5FE-886E-11EC-9CDB-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> +	const char * const merge_tree_usage[] = {
>> +		N_("git merge-tree [--write-tree] <branch1> <branch2>"),
>> +		N_("git merge-tree [--trivial-merge] <base-tree> <branch1> <branch2>"),
>> +		NULL
>> +	};
>> +	struct option mt_options[] = {
>> +		OPT_CMDMODE(0, "write-tree", &o.mode,
>> +			    N_("do a real merge instead of a trivial merge"),
>> +			    'w'),
>> +		OPT_CMDMODE(0, "trivial-merge", &o.mode,
>> +			    N_("do a trivial merge only"), 't'),
>> +		OPT_END()
>> +	};
>
> In the review club last week I had mentioned I thought OPT_CMDMODE
> worked well with enums. I found some a reasonably nice example in
> builtin/replace.c:cmd_replace(), although I have some Opinions about the
> enum declaration placement there. Regardless, I think using an enum
> instead of a single character would make this more readable - otherwise
> I need to remember what 'w' means when I'm reasoning about how many args
> to expect below.

I am reasonably sure whoever did the above use of OPT_CMDMODE()
feature mimicked an existing one that use it to make options with a
single-letter shorthand mutually exclusive.  If the options are with
short-hand, you wouldn't be complaining that you do not know what
'w' stands for.  When using it with options without short-hand, like
this case, I'd agree it would make it easier to read to use symbolic
constants of some kind.

