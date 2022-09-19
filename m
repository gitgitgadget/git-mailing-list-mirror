Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF6AECAAA1
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 17:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiISRt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 13:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiISRt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 13:49:26 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86737402F8
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 10:49:25 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF09314EB1D;
        Mon, 19 Sep 2022 13:49:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fCa1PD+WWRlnsxCrAxGUzR7kDGd1l3uz5uBiF+
        CTxus=; b=QAM8Y4aQmF+Z71Zk4dOt7n8ZD4GNk4vCx3ehhclB8VexyKgN2CWGkt
        NlQIoZNIMrSYlZspNUmNhYPVciAglMf4VFF9VTMKAst571R+ayhkZXERLGwPbV2d
        9cfDKWoKcAIs8yHJwiG6PH6urOh1dWpQ9zeuKTI04elmGTxGwI0Wg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6E6014EB1C;
        Mon, 19 Sep 2022 13:49:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3237314EB1B;
        Mon, 19 Sep 2022 13:49:24 -0400 (EDT)
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
        <xmqq35cnco3h.fsf@gitster.g>
        <40b47246-adb6-cf56-02ef-25ab1429a42e@jeffhostetler.com>
Date:   Mon, 19 Sep 2022 10:49:23 -0700
In-Reply-To: <40b47246-adb6-cf56-02ef-25ab1429a42e@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 19 Sep 2022 13:08:53 -0400")
Message-ID: <xmqq35cnb6fw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65EB265A-3843-11ED-8046-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> Aren't we in the middle of a transition from always
> using the global "the_repository" to a passed "r" variable?
> We're getting closer to being able to hide the the global
> symbol, but we're not there yet, right?

We may still have code that works ONLY on the_repository, but
letting a function take "r" and lettin it ignore is worse than
leaving it explicitly limited to the_repository only, no?

> I'm thinking that at as long as the global exists, we are not
> safe to have multiple "struct repository" instances, right?

By itself, Not at all.  It is the code like I am criticizing that
makes it unsafe.

I do not mind adding

	if (!r)
		BUG(...);

at the place you have the "sweep it under the rug" band-aid, though.
