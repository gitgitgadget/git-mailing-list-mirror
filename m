Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76439C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 03:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343937AbiBPDAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 22:00:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240388AbiBPDAe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 22:00:34 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E95EFBF2D
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 19:00:23 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EEE011DF0A;
        Tue, 15 Feb 2022 22:00:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jDbwxHiHhVl21iHLlNdLR2hYeG1vCB+WF7OMbV
        Ook6Q=; b=KAZOu+QHEKQYtns9N+z2Z5DT0t+Ky8mo8ew4jiuyTA1Ql9s9FRdPpR
        m1uxO3Huc7oa2iJIQu/JXKGwCiwqEFybw0y68/EEhgJrh5/pZo5pb3Gdk7gflFat
        YrMhyfCV9xFwe175cdrKZHchlC4pE9gSgKysW1qeU2Nc3LSt4Cym8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95B7011DF09;
        Tue, 15 Feb 2022 22:00:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C61111DF08;
        Tue, 15 Feb 2022 22:00:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     John Cai <johncai86@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, phillip.wood123@gmail.com,
        avarab@gmail.com, e@80x24.org, bagasdotme@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v7 4/4] cat-file: add --batch-command mode
References: <pull.1212.v6.git.git.1644862988.gitgitgadget@gmail.com>
        <pull.1212.v7.git.git.1644972810.gitgitgadget@gmail.com>
        <aebaf7e3fe1d4448037d2caf03f3de393908ff9a.1644972810.git.gitgitgadget@gmail.com>
        <xmqqfsojy50b.fsf@gitster.g>
        <BE7471F8-0141-49ED-A34B-04D69BE18D96@gmail.com>
Date:   Tue, 15 Feb 2022 19:00:18 -0800
In-Reply-To: <BE7471F8-0141-49ED-A34B-04D69BE18D96@gmail.com> (John Cai's
        message of "Tue, 15 Feb 2022 21:48:31 -0500")
Message-ID: <xmqq4k4zwm65.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 938357AE-8ED4-11EC-9C99-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Cai <johncai86@gmail.com> writes:

> Yeah, this is what I had before but there was discussion about
> separation of concerns in [1]. But perhaps it's preferable
> compared to passing a pointer to nr.

Oh, I see.

I do not see any issue with separation of concerns here, actually.

As long as "dispatch_calls() consumes all the cmd[] before it
returns to the caller" is clearly understood between the function
and its caller(s) [*], clearing of "nr" the caller has is entirely
caller's problem.  It becomes needed only because this caller
decides to reuse cmd[] array.

	Side note: you do have a comment before the function to tell
	what to expect out of the helper for its callers, right?

If it were just "accumulate many cmd[] and call the function once"
caller, it would care to maintain the correct "nr" only up to the
point where the function is called (because <cmd[], nr> pair is the
way the function takes the list of commands and it needs a correct
"nr"), but not after making the call, as the only thing left to do
would be to free the cmd[] array itself, which does not even need
"nr".

