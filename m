Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65701C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 21:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CE36610E5
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 21:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbhHRVZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 17:25:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52866 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbhHRVZA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 17:25:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2590FD81E2;
        Wed, 18 Aug 2021 17:24:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3pXOX9jlyg5mh2k4h4H4NT+uQSgAzy3Bznu7Ml
        zYgeA=; b=kSg3+Cx9rBybOtr10Q6eDwz0am+3nBo4PQHqnrUoC7UBr8Vs2GbVJm
        KITv1il2ERz+/fPCs+5IKCB7CWLant3WiVH0szIpE00eJ4n2qGNIMdKwMR1fQXlN
        Z2lsgelvC35q0LOlBv6fIIQG2yJq5eT2qWT/Uf29t2VQl/p66VHOc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DC10D81E1;
        Wed, 18 Aug 2021 17:24:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 99DC3D81E0;
        Wed, 18 Aug 2021 17:24:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 4/6] hook: allow running non-native hooks
References: <20210812004258.74318-1-emilyshaffer@google.com>
        <20210812004258.74318-5-emilyshaffer@google.com>
        <xmqqy29632hx.fsf@gitster.g> <YR1y7jxhGmnTJKyH@google.com>
        <YR14M7IJ9SoSwFDU@google.com>
Date:   Wed, 18 Aug 2021 14:24:23 -0700
In-Reply-To: <YR14M7IJ9SoSwFDU@google.com> (Emily Shaffer's message of "Wed,
        18 Aug 2021 14:14:27 -0700")
Message-ID: <xmqqh7fm4faw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A8941EA6-006A-11EC-839A-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> Yes, I see what you mean. Ok. I have been wanting to change the naming
>> anyways - most functions in hook.h are verb-y ("find hook", "run hooks",
>> so on) but hook_list stands out as the only noun-y function.
>> 
>> So I considered changing it to "list_hooks" and "list_hooks_gently", to align
>> with find_hook(_gently)....

I do not claim I am goot at naming (or better than you at it
anyway), but list-hooks sounds to me like it is calling printf()
to show the hooks to the user, not computing a list of hooks and
returning it to the caller.

>> I also think that approach would make a callsite easier to understand
>> than checking for null from hook_list().
>> 
>>   const char *hookname = "my-new-hook";
>> 
>>   /* Here it's pretty clear what the reason for the error was... */
>>   if (!known_hook(hookname))
>>     BUG("is hook '%s' in Documentation/githooks.txt?", hookname);

Yes.  The callsite becomes easier to understand, and it separates
the responsibility between the helper to respond to "please give me
list of defined hooks" and its caller that may react to the returned
list with "ok, among these hooks, this does not look kosher for such
and such reason, so I'd die/warn/error" much cleaner.


