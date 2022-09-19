Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066F9ECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 16:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiISQmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 12:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiISQms (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 12:42:48 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208A937FAE
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 09:42:48 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 92EEF1BEAE6;
        Mon, 19 Sep 2022 12:42:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uCJ3A9Z0kqu7vbW76g9H+kn1Qx94t+SBzBMEYH
        NjnZ0=; b=REoQJHpWtdqG0KaUs5dAi4225lC1xBSupmNw6NugaVsV+1V9uWNgNu
        LD5IfFMSPhJXLXb+nyxAciTW4RLG3NWCFoVzFolJKagWVVBinEL8CfUfKPjKdFyO
        nMzag88F3GcE+QodD4qrNpfd4Fhef01oVRU475/6ksmmRfolx6YIU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B6FC1BEAE5;
        Mon, 19 Sep 2022 12:42:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 36D3C1BEAE4;
        Mon, 19 Sep 2022 12:42:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v7 2/6] fsmonitor: relocate socket file if .git
 directory is remote
References: <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
        <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
        <075340bd2a713905d8bee4f53765dcbcba9a17c4.1663358014.git.gitgitgadget@gmail.com>
        <xmqqy1ujf5a9.fsf@gitster.g>
        <5c50a3cf-c5ac-6b11-2548-8400e5574b32@jeffhostetler.com>
Date:   Mon, 19 Sep 2022 09:42:42 -0700
In-Reply-To: <5c50a3cf-c5ac-6b11-2548-8400e5574b32@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 19 Sep 2022 08:31:04 -0400")
Message-ID: <xmqq35cnco3h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15BE9936-383A-11ED-8E78-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 9/16/22 4:11 PM, Junio C Hamano wrote:
>> "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>>> +const char *fsmonitor_ipc__get_path(struct repository *r)
>>> +{
>>> +	static const char *ipc_path;
>>> +	SHA_CTX sha1ctx;
>>> +	char *sock_dir;
>>> +	struct strbuf ipc_file = STRBUF_INIT;
>>> +	unsigned char hash[SHA_DIGEST_LENGTH];
>>> +
>>> +	if (ipc_path)
>>> +		return ipc_path;
>>> +
>>> +	if (!r)
>>> +		r = the_repository;
>> I'd prefer not to see this "NULL means the_repository".  It would be
>> a different story if the caller does not necessarily have a ready
>> access to the_repository, but it is a global, so the caller can pass
>> the_repository and be more explicit.  Giving two ways to the caller
>> to express same thing is not a good idea.
>> Thanks.
>> 
>
> To be fair, I added several "if (!r) r = the_repository;" statements
> to the original public FSMonitor routines.  There were obscure cases
> where tests would sometimes randomly fail because "r" wasn't completely
> passed down via some hard to isolate call stack.  Offlist, AEvar told me
> that he managed to isolate it and has a fix.
>
> So eventually, we'll be able to get rid of all of these direct
> references to "the_repository" and properly assume that "r" is
> always passed down.
>
> But for now, I think we should let this stay for safety.

I wouldn't call "sweeping a breakage under the rug" a "safety",
though.  If the caller cannot decide which repository instance is
the right thing to pass, or the caller does not yet have a good one
to pass when making a call down the codepath, how can it be safer to
use the_repository that may or may not be the appropriate one than
noticing the problem by dying and stopping the spread of damage?
