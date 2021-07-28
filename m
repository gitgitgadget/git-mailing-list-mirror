Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE69C432BE
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 16:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A8F60EB9
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 16:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhG1QlP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 12:41:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56377 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhG1QlO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 12:41:14 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D21DC149188;
        Wed, 28 Jul 2021 12:41:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WPjbglINZ0yCROPtiKgNECpHAYTmykTHkAepvp
        Xx8Jg=; b=FFLXym+CSh2Omz/DSWqwNZCuF+xAlx06xE1uVvj1sOHAKzQW4bI568
        uzOEDvGXVFLxHFY6S9aVzs7FW4XVUTyqF+39sxUFlvF+A0itI+aHdegk1IWmsOSx
        BTjnC/clN3hkacv7bF73Z2Yr2M3Arle6dBiWR/fSXmp8pdNDoX2ec=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BC038149187;
        Wed, 28 Jul 2021 12:41:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 002A3149186;
        Wed, 28 Jul 2021 12:41:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Oded S via GitGitGadget <gitgitgadget@gmail.com>,
        Oded S <oded@istraresearch.com>
Subject: Re: [PATCH] Fix git-bisect when show-branch is configured to run
 with pager
References: <pull.1003.git.1627311659384.gitgitgadget@gmail.com>
        <xmqq4kcgkjhk.fsf@gitster.g> <xmqq7dhbehwl.fsf@gitster.g>
        <CAP8UFD26AXTYPvSzBD1x6hSvK5SNbM0F5BPX5bLEbxUZa2dAUg@mail.gmail.com>
Date:   Wed, 28 Jul 2021 09:41:08 -0700
In-Reply-To: <CAP8UFD26AXTYPvSzBD1x6hSvK5SNbM0F5BPX5bLEbxUZa2dAUg@mail.gmail.com>
        (Christian Couder's message of "Wed, 28 Jul 2021 08:37:01 +0200")
Message-ID: <xmqq8s1qbdcr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9CE9A80E-EFC2-11EB-AE08-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> I wonder if it is just a simple matter of a few lines of code, like
>> this?
>
> Yeah, I also think it's a good idea.
>
>> ---- >8 ------- >8 ------- >8 ------- >8 ------- >8 ----
>> Subject: [PATCH] bisect: do not run show-branch just to show the current  commit
>>
>> In scripted versions of "git bisect", we used "git show-branch" to
>> describe single commit in the bisect log and also to the interactive
>
> s/single/ a single/

Thanks.

>>         enum bisect_error res = BISECT_OK;
>> +       struct commit *commit;
>> +       struct pretty_print_context pp = {0};
>> +       struct strbuf commit_msg = STRBUF_INIT;
>> ...
>> +       commit = lookup_commit_reference(the_repository, bisect_rev);
>> +       format_commit_message(commit, "[%H] %s%n", &commit_msg, &pp);
>> +       fputs(commit_msg.buf, stdout);
>> +       strbuf_release(&commit_msg);
>> +
>>         return -abs(res);
>
> Nice! Now, the above line can be simplified to:
>
>          return BISECT_OK;
>
> And the declaration of the `res` variable can be moved into the else
> clause where it is used.

Thanks, again.
