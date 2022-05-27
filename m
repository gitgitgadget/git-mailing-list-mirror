Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CF8C433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 21:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351663AbiE0VgC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 17:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiE0Vf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 17:35:59 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34B670347
        for <git@vger.kernel.org>; Fri, 27 May 2022 14:35:58 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F2241A788D;
        Fri, 27 May 2022 17:35:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hE1bCQDouIWoJbumKPyxbypca1roKbj42FZbYa
        NslFY=; b=i9q4d4QaSiuiEpmS6TgNoUvyPRKYTkSc/5iGLZCIoO4Hy5GlBP3Jnn
        8Z6M3psQMvSKucR/l8iJpip9XNk0HuLUh2mMP+PogkemJ8WDCgqrrTB3hAq57Fv/
        0JAw9V8vGBKwwvRDjOY2ANLWQlbJYvyx5Z58/24XBmsqfYNCis/IE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 771CA1A788C;
        Fri, 27 May 2022 17:35:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F1CAE1A788B;
        Fri, 27 May 2022 17:35:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Re* jc/http-clear-finished-pointer
References: <xmqqzgj41ya2.fsf@gitster.g>
        <220526.86v8ts3z2k.gmgdl@evledraar.gmail.com>
        <xmqq7d68ytj8.fsf_-_@gitster.g>
        <nycvar.QRO.7.76.6.2205272235220.349@tvgsbejvaqbjf.bet>
Date:   Fri, 27 May 2022 14:35:53 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2205272235220.349@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 27 May 2022 22:41:09 +0200 (CEST)")
Message-ID: <xmqqpmjy1ww6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD26C02C-DE04-11EC-A4B7-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

This analysis and explanation was actually still too conservative.

>> +	/*
>> +	 * The value of slot->finished we set before the loop was used
>> +	 * to set our "finished" variable when our request completed.
>> +	 *
>> +	 * 1. The slot may not have been reused for another requst
>> +	 *    yet, in which case it still has &finished.
>> +	 *
>> +	 * 2. The slot may already be in-use to serve another request,
>> +	 *    which can further be divided into two cases:
>> +	 *
>> +	 * (a) If call run_active_slot() hasn't been called for that
>> +	 *     other request, slot->finished may still have the
>> +	 *     address of our &finished.
>> +	 *
>> +	 * (b) If the request did call run_active_slot(), then the
>> +	 *     call would have updated slot->finished at the beginning
>> +	 *     of this function, and with the clearing of the member
>> +	 *     below, we would find that slot->finished is now NULL.

Given that there are only two places that assign to slot->finished
(one is at the beginning of run_active_slot(), the other is when
get_active_slot() either allocates a new one or decides to reuse the
one that finish_active_slot() has marked to be no longer in use),
all in "reused" cases, not just 2-(b), but even in case 2-(a),
slot->finished should be NULL.

>> +	 * In all cases, slot->finished has no useful information to
>> +	 * anybody at this point.  Some compilers warn us for
>> +	 * attempting to smuggle a pointer that is about to become
>> +	 * invalid, i.e. &finished.  We clear it here to assure them.
>> +	 */
>> +	slot->finished = NULL;
>>  }

The conclusion is still valid.  The slot->finished member will not
have any useful information when we get here.  It either keeps the
value &finished we stored if the slot wasn't reused, or it has NULL
if it was reused.

> Having said that, it is quite puzzling that GCC thinks it is safe to
> assign a local variable's pointer to a struct that is then accessed
> outside the current file. This would make it easy to copy and use the
> pointer well after the function scope was left. This is _not_ the case in
> Git's source code, but GCC seems that this isn't possible by
> (mis-)interpreting the final `slot->finished = NULL` to mean that the
> `slot->finished = &finished` was safe (because it clearly isn't).

I do not think it is compiler's job to prevent us from assigning to
slot->finished, in fear of somebody downstream copying the pointer
away to a global variable that can be accessed long after we return.

We can store a pointer to an object we malloc() in a member of a
struct, pass the struct to somebody else, who might copy the member
away in a global variable for their own use later, but when they
give control back to us, we may free() the object via the member in
the struct.  The compiler may see that we free() the pointer we stored
in the struct, but it would not warn us against doing so.

> With all that, here is my ACK.

Thanks.
