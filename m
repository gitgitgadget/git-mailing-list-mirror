Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CB471F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 18:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753342AbcJKSXG (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 14:23:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62934 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752992AbcJKSXF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 14:23:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB68141B51;
        Tue, 11 Oct 2016 14:23:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zlysGtnyGUEP0wikFMUlkSiAfY8=; b=lLm7vA
        +/7n+DjrTAa1kVCHpL9405cFoyzU32uC1a/7EDpDEfM9fAhzsHsNBeexQ5S7jenh
        TvEf9IuR8dCCI4p85zesX8s/XmIzEjonbmSvlA/+RDUhsci3wfKph/tYk7LHq6lD
        fvJZzSXJUWW/j+Bw5DhZl0fEUMbWtGqvunBOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RC+pTjIEEFTqxYEsPYkF4ce0ftV9KQka
        0TT/FgLr19JmNKyTdgKs67GKklWWo9JGH7p3xUroQBKX0cXj+KaeLiTYJeHDaVYp
        1ojfKxsUQ1lsz8hsKBJHKFl6TzcCm6rK8KVCnXFPTv0n+okuiHDBvvvtaCzy9pdt
        7Puvfj7/zVI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3DFB41B50;
        Tue, 11 Oct 2016 14:23:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 261E741B4F;
        Tue, 11 Oct 2016 14:23:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 28/28] attr: convert to new threadsafe API
References: <20161011002115.23312-1-sbeller@google.com>
        <20161011002115.23312-29-sbeller@google.com>
        <xmqqmviaaina.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaQKDdJfMOjDKEK_dZJhgj+R7rByQS++B3OOBy6uO1x2w@mail.gmail.com>
Date:   Tue, 11 Oct 2016 11:23:01 -0700
In-Reply-To: <CAGZ79kaQKDdJfMOjDKEK_dZJhgj+R7rByQS++B3OOBy6uO1x2w@mail.gmail.com>
        (Stefan Beller's message of "Tue, 11 Oct 2016 10:56:17 -0700")
Message-ID: <xmqqa8eaagoq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF522D78-8FDF-11E6-ACBF-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> I find this description a bit confusing.  At least the way I
>> envisioned was that when this piece of code is run by multiple
>> people at the same time,
>>
>>         static struct git_attr_check *check = NULL;
>>         git_attr_check_initl(&check, ...);
>>
>> we won't waste the "check" by allocated by the first one by
>> overwriting it with another one allocated by the second one.  So
>> "the same arguments" does not come into the picture.  A single
>> variable is either
>>
>>  * already allocated and initialised by the an earlier call to
>>    initl() by somebody else, or
>>
>>  * originally NULL when you call initl(), and the implementation
>>    makes sure that other people wait while you allocate, initialise
>>    and assign it to the variable, or
>>
>>  * originally NULL when you call initl(), but the implementation
>>    notices that somebody else is doing the second bullet point
>>    above, and you wait until that somebody else finishes and then
>>    you return without doing anything (because by that time, "check"
>>    is filled by that other party doing the second bullet point
>>    above).
>>
>> There is no need to check for "the same arguments".
>>
>
> I see. So we assume that there are no different arguments at the same time,
> i.e. all threads run the same code when it comes to attrs.

Sorry, but I fail to see how you can jump to that conclusion.
Puzzled.

You can have many different callsites (think: hits "git grep" finds)
that call git_attr_check_initl() and they all may be asking for
different set of attributes.  As long as they are using different
"check" instance to receive these sets of attributes, they are OK.

It is insane to use the same "check" variable to receive sets of
attributes for different attributes, be it from the same call or
different one, it is insane to do this:

	func(char *anotherattr)
	{
		static struct git_attr_check *check = NULL;
		git_attr_check_initl(&check, "one", anotherattr, ...);

		... use "check" to ask question ...
	}

The whole point of having a static, initialize-once instance of
"check" is so that initl() can do potentially heavy preparation just
once and keep reusing it.  Allowing a later caller of func() to pass
a value of anotherattr that is different from the one used in the
first call that did cause initl() to allocate-initialise-assign to
"check" is simply insane, even there is no threading issue.

And in a threaded environment it is even worse; the first thread may
call initl() to get one set of attributes in "check" and it may be
about to ask the question, while the second call may call initl()
and by your definition it will notice they have different sets of
attributes and returns different "check"?  Either the earlier one is
leaked, or it gets destroyed even though the first thread hasn't
finished with "check" it got.

It is perfectly OK to drop "static" from the above example code.
Then it no longer is insane--it is perfectly normal code whose
inefficiency cannot be avoided because it wants to do dynamic
queries.
