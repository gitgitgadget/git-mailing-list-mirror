Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1262B1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 01:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbfKFBg0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 20:36:26 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58255 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbfKFBg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 20:36:26 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E6B0BA4785;
        Tue,  5 Nov 2019 20:36:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qOF2rxYGiO/EUTcKUSX6JV9intc=; b=b87lve
        A9LzK79A6UlWbnKusW2FhbUturxVykfDyKIBnTBE41KAwKk2u2xlZ5yhluFkQ5Z7
        ACxuODoD0h4IIrmYpM/TbeTwjdEV0oDW6DXQf4y2b1R5YCO33gR/ek1ooH+f3vv8
        1b2cXHIXrUB0yip5PBVl+7/JGNBXb2ytpQAE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yMwpZtmdsnEW6RGQ0td12GseZW1sld/W
        mtTO7psHfsDB0VNy6b2XbNgpfqvT3fM2BmarBbT2r5KTRqMDLvWtP58dEls6VxFm
        bYPWkaDf0W+66It+HT8J3QJk1rcEzliypIzlB3v3eFS4cpK40GL/TT/rdESL74Ul
        ZF/KCyh4qvE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DEBCAA4784;
        Tue,  5 Nov 2019 20:36:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1B41DA4783;
        Tue,  5 Nov 2019 20:36:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Davide Berardi <davide.berardi6@unibo.it>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2] clone: Don't segfault on -b specifing a non-commit
References: <20191101002432.GA49846@carpenter.lan>
        <20191103180716.GA72007@carpenter.lan>
        <20191105043749.GA27601@sigill.intra.peff.net>
Date:   Wed, 06 Nov 2019 10:36:18 +0900
In-Reply-To: <20191105043749.GA27601@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 4 Nov 2019 23:37:49 -0500")
Message-ID: <xmqqbltpyeel.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5F77582-0035-11EA-B200-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I like the logic flow in this function, which is IMHO clearer than the
> existing code. But the "err" thing puzzled me for a moment. I think you
> are trying to tell the difference between the case that both "our" and
> "remote" are NULL, and the case that we saw a non-commit. In either case
> we return NULL, but only one is an error.

Yup.

> But:
>
>   - I don't think that logic needs to extend down into
>     lookup_commit_reference_gently(); a NULL return from it would always
>     be an error, wouldn't it?

Yes.

>   - we could probably simplify this by just inlining it into
>     update_head(). Something like:
>
>       if (our)
>               tip = &our->old_oid;
>       else if (remote)
>               tip = &remote->old_oid;
>
>       if (!tip) {
> 	      /*
> 	       * We have no local branch requested with "-b", and the
> 	       * remote HEAD is unborn. There's nothing to update HEAD
> 	       * to, but this state is not an error.
> 	       */
>               return 0;
>       }

I somehow had an impression that Davide was protecting against the
case where tip->old_oid is null_oid (cloning from an empty repo?);
NULL return from lookup_commit_reference_gently(null_oid) would not
deserve a warning from this codepath, and should work just like the
way it has worked before these changes.

>       tip_commit = lookup_commit_reference_gently(...);
>       if (!tip_commit) {
>               /*
>> -	fetch_if_missing = 1;
>> -	err = checkout(submodule_progress);
>> +	if (!err) {
>> +		fetch_if_missing = 1;
>> +		err = checkout(submodule_progress);
>> +	}
>
> This part makes sense. We might want an explanatory comment along the
> lines of:
>
>   /*
>    * Only try to checkout if we successfully updated HEAD; otherwise
>    * HEAD isn't pointing to the thing the user wanted.
>    /
>    if (!err) {
>        ...

Yup.

>> diff --git a/t/t5609-clone-branch.sh b/t/t5609-clone-branch.sh
>
> I think it would be the case that the remote HEAD is pointing to a
> non-commit (since that's a corrupt repository, it might make sense
> create a separate sub-repository).

All good comments. 

Thanks
