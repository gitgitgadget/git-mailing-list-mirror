Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 086A51FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 20:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933636AbcHJUej (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 16:34:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50810 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933050AbcHJUeh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 16:34:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E56833D11;
	Wed, 10 Aug 2016 16:34:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wv1ba5u5zRZsF8pGu5P9X/IJaw4=; b=ei0Eai
	Olv7UwAoLffFArn/6mAUHOQJ7tzLpELyAFz4UybXMpOz0zBHJFR44aqZU7vVjIce
	lXL9MQRSchKhO8lxqNk6iXcOX+zZ66nIdzxcPjH9+/4oi8YFpxaW46igHKiYYcge
	Klx1VJIpxcUeQn5KkBuVZJUey0DvjpSFsKqiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gl1XQKPX5ruPIait2iEZ3WGdI67/mPvz
	r0JT+iPXPcSHTK/wEiOfQo662F0rRAg1RiXWsmkmKQ1WHT1tAKVdD3z8eVBoGCy1
	bD2I445aCSPJr950ekgnAdDsihxtgD602tE2nnVI1GOd+MugVTgLAxgYPI/yy/8z
	1HBe4Y8eoPw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0522D33D10;
	Wed, 10 Aug 2016 16:34:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7A05733D0E;
	Wed, 10 Aug 2016 16:34:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] t7406: fix breakage on OSX
In-Reply-To: <CAGZ79kb5Sy6rC1j8uLq+oCTfVVpan0tgat59yOJV20nFeRzSKQ@mail.gmail.com>
	(Stefan Beller's message of "Wed, 10 Aug 2016 12:03:52 -0700")
References: <A6131C47-3230-4EC4-B3F6-B2507C937A22@gmail.com>
	<20160810175607.30826-1-sbeller@google.com>
	<xmqq1t1w5vk6.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kb5Sy6rC1j8uLq+oCTfVVpan0tgat59yOJV20nFeRzSKQ@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Date:	Wed, 10 Aug 2016 13:34:33 -0700
Message-ID: <xmqqlh044b3a.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9E96CF4-5F39-11E6-992F-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Wed, Aug 10, 2016 at 11:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> On OSX `wc` prefixes the output of numbers with whitespace, such that
>>> the `commit_count` would be "SP <NUMBER>". When using that in
>>>
>>>     git submodule update --init --depth=$commit_count
>>>
>>> the depth would be empty and the number is interpreted as the pathspec.
>>> Fix this by not using `wc` and rather instruct rev-list to count.
>>>
>>> Another way to fix this is to remove the `=` sign after the `--depth`
>>> argument as then we are allowed to have more than just one whitespace
>>> between `--depth` and the actual number. Prefer the solution of rev-list
>>> counting as that is expected to be slightly faster and more self-sustained
>>> within Git.
>>
>> You meant self-contained, I would guess.
>
> Yes. Mind to fix that locally, or waiting for a resend?

Fixed it up while queuing.

>> There are a couple of "log --oneline | wc -l" remaining that are
>> currently safe but they may be a time-bomb waiting to go off.
> ...
> All of the occurrences are not white space sensitive AFAICT,
> they are just bad examples, which may inspire others to follow
> that pattern.

Yup, I agree(d).



