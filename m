Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B5441F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 17:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbcJERAc (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 13:00:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55750 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751233AbcJERAb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 13:00:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 392E9441AF;
        Wed,  5 Oct 2016 13:00:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+Am4Z0ZRazVev6kMCU8HEwVFSqs=; b=UmHGnN
        1EUVVFWeXjalQtb16dees+rpCJhvgAWghnanUOwJMrA1OZjVPNmI4fkjC7xxx5ni
        mFgkGXx7vQjhNVkRRyOcUddolqqarcr8tsQjUq5QPSz2XRqx/n2+cjVBv72QdjmU
        CDK9OHCbuQmBWpR8h30mtbOAQF3tiBmJCRCa4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vobYTArjTS8bcNfa5yShz/oB3Edo1FqJ
        1/8Kp328MrU9nQf/iOQ68Q1xKsTREhB7U/TQsZIUuGKRKgSCUgNCTbG7Sw8ogfcx
        FbrSGHX1/Mfa/BadJbo812PusIWv6jT10DS1loF4rrExC8ctxOtSsBx9FbO6m9I8
        9hKyxMr8jsQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 32044441AE;
        Wed,  5 Oct 2016 13:00:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 96612441AD;
        Wed,  5 Oct 2016 13:00:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [RFC/PATCH] attr: Document a new possible thread safe API
References: <20161004221433.23747-1-sbeller@google.com>
        <xmqqtwcrr9l6.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaFx++yipGmq=D2EPN4Gw9JhRXf_i4pFivTnkJmJXjFfg@mail.gmail.com>
Date:   Wed, 05 Oct 2016 10:00:27 -0700
In-Reply-To: <CAGZ79kaFx++yipGmq=D2EPN4Gw9JhRXf_i4pFivTnkJmJXjFfg@mail.gmail.com>
        (Stefan Beller's message of "Tue, 4 Oct 2016 16:25:27 -0700")
Message-ID: <xmqq8tu2ras4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 384DD14A-8B1D-11E6-B874-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I thought about that, but as I concluded that the get_all_attrs doesn't need
> conversion to a threading environment, we can keep it as is.

I agree that it is OK for get_all_attrs() to use its own way to ask
a question and receive an answer to it, that is different from how
git_check_attr() asks its question.  The threading-support for it is
an unrelated issue, though (not that I think it needs to be run from
a multi-threaded caller).

>> ...  I'd expect the most
>> typical caller to be
>>
>>         static struct git_attr_check *check;
>>         struct git_attr_result result[2]; /* we want two */
>>
>>         git_attr_check_initl(&check, "crlf", "ident", NULL);
>>         git_check_attr(path, check, result);
>>         /* result[0] has "crlf", result[1] has "ident" */
>>
>> or something like that.
>
> I see, that seems to be a clean API. So git_attr_check_initl
> will lock the mutex and once it got the mutex it can either
> * return early as someone else did the work
> * needs to do the actual work
> and then unlock. In any case the work was done.
>
> git_check_attr, which runs in all threads points to the same check,
> but gets the different results.

Yeah, something along that line.  It seems that we are now on the
same page?

Thanks.


