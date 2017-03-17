Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAA0720951
	for <e@80x24.org>; Fri, 17 Mar 2017 16:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751237AbdCQQSx (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 12:18:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62552 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751047AbdCQQSv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 12:18:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C6EF7446E;
        Fri, 17 Mar 2017 12:03:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=63WAX9GYW0V0L0PEuTfpofqfW18=; b=WZVDcg
        lQFU3vDwyCu5EHJBhjLkr8VcOyHJ7a9b+PlEK7sR3PccRjCQkqRSfq/Uhf1X9tqo
        X6rW/QrKyrI0ZkvkROhbD4w3fL75mFnEKWexAfmZZQF7FQuiqLuwhgCIq6QejSue
        QHEvptEeAJYri/0oWlxdejtHcnWB/GHUy60oU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k5B13wkKJ3LFRvOn/aUJSrl9kbiLJx/M
        OPtMvq1KR1k1ZpVw8HrVAr9Ps2UDoaOjaAMgZAa10to9bIu3KmsCoT7c6iIUeWE1
        L7/Ju9B6wLnfjm13akqcbPvbPYonRGHcJ+JHKnjVfWknT74UVy3csUp3MS/KTeW4
        dxGzNnfmAMs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 853057446D;
        Fri, 17 Mar 2017 12:03:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E76627446C;
        Fri, 17 Mar 2017 12:03:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] name-rev: favor describing with tags and use committer date to tiebreak
References: <xmqqd1die00j.fsf@gitster.mtv.corp.google.com>
        <20170315225045.15788-1-gitster@pobox.com>
        <20170315225045.15788-3-gitster@pobox.com>
        <ce5252a5-b94a-a389-6b3e-0e4d7b243210@drmicha.warpmail.net>
Date:   Fri, 17 Mar 2017 09:03:16 -0700
In-Reply-To: <ce5252a5-b94a-a389-6b3e-0e4d7b243210@drmicha.warpmail.net>
        (Michael J. Gruber's message of "Fri, 17 Mar 2017 12:25:01 +0100")
Message-ID: <xmqqh92r99h7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C3390F4-0B2B-11E7-916A-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> +#define COMPARE(attribute, smaller_is_better)	 \
>> +	if (name->attribute > attribute) \
>> +		return smaller_is_better; \
>> +	if (name->attribute < attribute) \
>> +		return !smaller_is_better
>
> I find that define pretty confusing. On first reading, the "==" case
> seems to be missing, but that is basically "pass" as one can see in the
> later code.
>
> Also, the comparison ">"  and "<" is used to switch between the cases
> "tag vs. non-tag" and "non-tag vs. tag" which happen to be encoded by
> the from_tag attribute beeing "1 vs. 0" resp "0 vs. 1" in the following:
> ...
> But in the next two instances you use it to do "actual" comparisons
> between distances and dates:

That is pretty much deliberate.  The macro is designed to compare
the attribute and return if one side is strictly better than the
other side, and fall through to tie-breaker that follow (i.e. lack
of "==" is very deliberate).  Also it is not "return if one side is
strictly smaller"---the second parameter decides if smaller means
better or bigger means better (i.e. "from_tag" being 1 for a name
based on tag and 0 for a name based on non-tag can use the macro by
telling that the side that is strictly bigger is better).

> How about something like
> ...

I did a sequence of COMPARE() macros that cascade to implement
tie-breaking logic because I thought it was the easiest to read and
understand, and I did "tag vs non-tag first decides, and then
tiebreak to favor shorter hops and then tiebreak on date, while
paying attention to committer dates even when we are comparing two
commits", because I thought that would be one of the easier logic to
explain to the users.  

But this topic is not my itch, and quite honestly I'd be happier if
you took it over, improving both the implementation and the
semantics it implements, following your best judgment.  You are
equipped with better motivation than I am to make these decisions.

This patch has turned up a bug in git-p4 in that it seems to have
misunderstood that "name-rev HEAD" is a good way to learn which
branch we are currently on (it never is); as far as I am concerned,
it has served its purpose ;-)

Thanks.
