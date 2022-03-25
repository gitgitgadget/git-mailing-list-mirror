Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD1AC433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiCYT14 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiCYT1o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:27:44 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A123418C0F0
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:01:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 54B2319A2D1;
        Fri, 25 Mar 2022 14:22:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tMiH8Zdsk8h2p1yEV7g/st+v2fFz+dJANOEDn/
        ImHxY=; b=Q/0u2BfKKigF+Fs9i3Buu8LU63loTrVdC3ghb9djiFvk9mCdQgr0VS
        fT3I9YIEavrPlN6nDws/xlXUbXPAZ3WCnVgGQTDY557+xXTdMLrxf/gue3PX+RSQ
        Yfus8uvG9fOUmGUi/aocL9+WbgVjW1lfebttxWbHtbTfa3i+ApdYE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4AE7919A2D0;
        Fri, 25 Mar 2022 14:22:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AAF7C19A2CF;
        Fri, 25 Mar 2022 14:22:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, chakrabortyabhradeep79@gmail.com
Subject: Re: [PATCH v2 1/2] t7700: check post-condition in kept-pack test
References: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
        <pull.1185.v2.git.1648146897.gitgitgadget@gmail.com>
        <f2f8d12929bcbd630b2de3ce770a6763989ffcff.1648146897.git.gitgitgadget@gmail.com>
        <xmqqmthearlz.fsf@gitster.g>
        <3fab1246-1451-597c-4359-c01f9675e3f1@github.com>
        <Yj39lEzd/9AwQJaP@nand.local>
Date:   Fri, 25 Mar 2022 11:22:53 -0700
In-Reply-To: <Yj39lEzd/9AwQJaP@nand.local> (Taylor Blau's message of "Fri, 25
        Mar 2022 13:36:20 -0400")
Message-ID: <xmqq7d8hc2o2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96BC74DA-AC68-11EC-8087-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, Mar 25, 2022 at 01:23:27PM -0400, Derrick Stolee wrote:
>> > Since we've made sure "before" is a one-liner earlier, we could just
>> > say
>>
>> > 		test_cmp before kept &&
>> >
>> > instead, no?
>>
>> 'before' contains a .idx name and 'kept' contains a .keep name,
>> so this direct comparison does not work. We could do that
>> additional check like this:
>>
>> 	kept_name=$(cat kept) &&
>> 	echo ${kept_name%.keep}.idx >kept-idx &&
>> 	test_cmp before kept-idx &&
>
> I think keeping this kind of post-condition check pretty minimal is
> favorable, since this is functionality of `git repack` (i.e., that `-a`
> leaves you with one kept) that is already tested thoroughly elsewhere.

It is nice in principle, but for this particular script, whose
helper function's implementation relies on these "assumptions" to
work correctly (e.g. imagine what happens when 'before' file had 0
or 2 lines in it and you called the get_sorted_objects_from_packs
helper), we should be more defensive, and that is where all my
suggestions in the thread come from.
