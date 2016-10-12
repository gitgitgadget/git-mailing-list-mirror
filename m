Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08A0A215F6
	for <e@80x24.org>; Wed, 12 Oct 2016 22:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933061AbcJLWOx (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 18:14:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59612 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753189AbcJLWOv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 18:14:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C63FA4646E;
        Wed, 12 Oct 2016 16:59:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F6I7jINHNZrH8tDyBqBpDW0fWWk=; b=Foq4p6
        psjLiB0g4NTehv/vBFOPT4nJtxEUPxkLwBp2KTsHdubiGHHssTLk1NMIsW6CcLbu
        aKWhYudtS5FNMlL81Zmt6DGOx058YHkaEKvoqLwRPUw5E9N0rcOAEF3JgAzJhQlQ
        Ii0GnFoikT7EIbpKZLaXu72ikJ/s9WgIhbF/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZRrwxIA2nXjZfRQv+RJief5cVxhgP53D
        wqV9EYTfFMt/ePBCK/EyW+lNur5Ger2lG0DpNEY5pN2RQU0WH+syDnw9WWwYbegF
        SkGovGnXmH+zAdVPdrksYGxO1Xg1SoLLWRqerdsZbZwOL1KxZzOCLvbyM0x6FZIx
        GJX81pOO0bQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD0D64646C;
        Wed, 12 Oct 2016 16:59:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 442EA46469;
        Wed, 12 Oct 2016 16:59:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCHv2] attr: convert to new threadsafe API
References: <20161011235951.8358-1-sbeller@google.com>
        <xmqqvawy5c4i.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZrNSmPAQ6SmBzFDJtSmdCbqKcgQu4KDLfoYVkSXvo-og@mail.gmail.com>
        <xmqqfuo15yjm.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaBhXHLDEK0XMLjm3QofmtaGZspA3EEx5x4-qCYY--wZA@mail.gmail.com>
Date:   Wed, 12 Oct 2016 13:59:37 -0700
In-Reply-To: <CAGZ79kaBhXHLDEK0XMLjm3QofmtaGZspA3EEx5x4-qCYY--wZA@mail.gmail.com>
        (Stefan Beller's message of "Wed, 12 Oct 2016 13:02:40 -0700")
Message-ID: <xmqqpon52shy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA428324-90BE-11E6-8F44-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>> Well all of the hunks in the patch are not threaded, so they
>>> don't follow a threading pattern, but the static pattern to not be
>>> more expensive than needed.
>>
>> Is it too invasive a change to make them as if they are thread-ready
>> users of API that happen to know their callers are not threading?
>> It would be ideal if we can prepare them so that the way they
>> interact with the attr subsystem will not have to change after this
>> step.
>
> As far as I see the future, we do not need to change those in the future,
> unless we add the threading to the current callers, which is usually a very
> invasive thing?

It does not matter how invasive the thread set-up and teardown that
happens in the callers.

I am talking about the part of _THIS_ code that you are updating,
that interacts with attr API.  The way they prepare "check" and
"result", the way they ask questions by calling git_check_attr()
function.

Think of a thread-safe library function (like malloc()).  If you
write 

	func (...) {
		buf = malloc(20);
		...
		free(buf);
	}

in a function that happens to be only called in a non-threaded
program today, you do not have to update these calls to malloc(3)
and free(3) when you update the callchain to threadable, right?

That kind of thread-preparedness is what I am trying to see if we
can achieve with this update.
