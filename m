Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D3EC433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 17:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbiBRRci (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 12:32:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbiBRRcg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 12:32:36 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2140E25AE6E
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 09:32:20 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A848117BDE;
        Fri, 18 Feb 2022 12:32:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2PF47nEKgbwbcsKrJ8UJIa4gmT9Ulm/hdtb7Ci
        gsEGg=; b=iF3bzSp+WD2QEKib3lBFdvKemAbFpIS3yyr6ypG68bOHPpVHO7eqf5
        NpoMRKc7cXL6ilTndHKg2KW8tk2A0DOU2r65NXkzF3/kb92Bv+lWuluSMCIWcLqh
        ZscvfHZZjSAAYGgPgnyoaHXR7K+NUZGlkw/xWLBGqB1cxyIQjBzh8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 304F7117BDD;
        Fri, 18 Feb 2022 12:32:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 861C0117BDB;
        Fri, 18 Feb 2022 12:32:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     John Cai <johncai86@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v9 4/4] cat-file: add --batch-command mode
References: <pull.1212.v8.git.git.1645023740.gitgitgadget@gmail.com>
        <pull.1212.v9.git.git.1645045157.gitgitgadget@gmail.com>
        <dbe194f8a8592dd67d6ba3a11cb7b1c81b789cec.1645045157.git.gitgitgadget@gmail.com>
        <095278d4-217b-7d97-5364-9cd491b34ed0@gmail.com>
        <ECBE48BF-156B-4D8A-9CDE-30AE84BF3630@gmail.com>
Date:   Fri, 18 Feb 2022 09:32:17 -0800
In-Reply-To: <ECBE48BF-156B-4D8A-9CDE-30AE84BF3630@gmail.com> (John Cai's
        message of "Fri, 18 Feb 2022 11:53:56 -0500")
Message-ID: <xmqqpmnk2i8u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B897F4CE-90E0-11EC-817A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Cai <johncai86@gmail.com> writes:

>>> +		if (!strcmp(cmd->name, "flush")) {
>>> +			dispatch_calls(opt, output, data, queued_cmd, nr);
>>> +			free_cmds(queued_cmd, nr);
>>> +			nr = 0;
>>
>> It'd be nice if free_cmds() zeroed nr for us rather than having to remember to do it separately as the two are intimately linked.
>
> This does feel cleaner. Before there was a version where I did this inside of
> dispatch_calls and there was feedback that this wasn't clean. But now that
> free_cmds prepares the queued_cmd array for reuse, then it may make sense to do
> it inside. Though honestly from the back and forth around this, I'm not too sure
> what the best thing to do stylistically would be.

I am not sure about style, but at the semantic level, free_cmds()
that "frees" the queued_cmd by releasing the resources it holds and
resets its counter to zero would be a more complete "does one thing
and one thing well" helper function.

>>>  +test_expect_success '--batch-command --buffer with flush for blob info' '
>>> +	echo "$hello_sha1 blob $hello_size" >expect &&
>>> +	test_write_lines "info $hello_sha1" "flush" | \
>>
>> You don't need a '\' after a '|', however it might be better to use the style from the tests above where the '|' is on the beginning of the next line.

Please don't do

	producer \
	| consumer

instead, write

	producer |
	consumer

With two fewer bytes, and is far more common, judging from the
output of

    $ git grep -e '^[   ]*| [A-Za-z]' t

i.e. indent with whitespace or tab, pipe, space and alpha (i.e. the
beginning of the command, possibly a single-shot environment
assignment).
