Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E6BC4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 20:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC9261004
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 20:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbhHIUFC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 16:05:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56233 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhHIUFB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 16:05:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B2B61478B1;
        Mon,  9 Aug 2021 16:04:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7g2i33lnpHDlQnr3d12WPmX9eJ7/XEuon5IVNc
        ih8ck=; b=yRhnNPJZN3qNqq3Ksnew+Ii4yzvMAkRcJznpckxOkYjxGzVGL9Z2Bc
        jrZXTcvBy+7gAWEDj4Nmwm0GBzOzeVEn9ZwQKv4YWdExbT54Tf1H7TuBmyghLvVt
        GCacD5I4bA8/8eZcB1Cy+Fi/Wwhy2T4BZhE0ZBRNzwzaKBH2CIhh0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 43B161478B0;
        Mon,  9 Aug 2021 16:04:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 88F6D1478AE;
        Mon,  9 Aug 2021 16:04:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] transport: no warning if no server wait-for-done
References: <20210806214612.1501980-1-jonathantanmy@google.com>
        <xmqqh7fyfrtl.fsf@gitster.g> <YRF91qCi+c7csUxM@google.com>
Date:   Mon, 09 Aug 2021 13:04:35 -0700
In-Reply-To: <YRF91qCi+c7csUxM@google.com> (Jonathan Nieder's message of "Mon,
        9 Aug 2021 12:11:18 -0700")
Message-ID: <xmqq4kbyfkq4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0624123A-F94D-11EB-B8C7-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>>> -	if (finish_command(&child)) {
>>> -		/*
>>> -		 * The information that push negotiation provides is useful but
>>> -		 * not mandatory.
>>> -		 */
>>> -		warning(_("push negotiation failed; proceeding anyway with push"));
>>> -	}
>>
>> Perhaps like "optional ancestry negotiation failed---pushing
>> normally" or some phrasing that assures the users that pushing
>> without negotiation is perfectly normal?
>
> The question is what the user will do with this information.
>
> Will they contact the service provider to ask them to turn on push
> negotiation?
>
> Will they turn off push negotiation because they don't want to waste a
> round trip?
>
> Does what they will do depend on _why_ push negotiation failed?  If it
> failed because the server didn't declare the capability and the user
> has set push.negotate to true to represent "I want to live in the
> future by using push negotiation wherever it's available", then the
> message is noise.  If it failed due to a bug, then the message is more
> relevant to the user --- e.g., should we use a different exit status
> to distinguish between these two cases?

I was hoping that the "child" command being run there gives enough
clue before the warning message so that the user would already know
(that is where my "assures the users" primarily comes from---even we
cannot hide that the negotiation poll has failed, the users would be
helped by being told that it is OK).

If "child" does not give enough clue to this codepath (via the exit
code) or to the end user (via error messages), we probably would
want to fix that for that approach to work.



