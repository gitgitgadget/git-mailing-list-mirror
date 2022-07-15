Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACCECCA482
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 16:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbiGOQjP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 12:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbiGOQjE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 12:39:04 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F21F1AF3E
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 09:39:03 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 14DCF1A89BE;
        Fri, 15 Jul 2022 12:39:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rXAkCFKamU2h+s3bhf+NSQ08kX9rJN96UxuDXY
        CTJGA=; b=UvedUg9faM4LfkciSBx97S/klkZ1dD9frsZDS7SczYLdc1Yz8uHN59
        mMhmOaWRNzdkrEjk+vquabyfIZR5lxkl6RHTUytMPzdd7HHXkq2eTidTgy5sGid2
        2va/4ttyR3KpMR6El5bqak9fxth2tnpShmdrmJhioy9ykG//Z1W/U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0DC3D1A89BD;
        Fri, 15 Jul 2022 12:39:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A9EE21A89BA;
        Fri, 15 Jul 2022 12:38:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC][PATCH] mingw: avoid mktemp() in mkstemp() implementation
References: <7265e37f-fd29-3579-b840-19a1df52a59f@web.de>
        <b7fffe99-63fb-3899-6a6d-882b72b9512f@kdbg.org>
Date:   Fri, 15 Jul 2022 09:38:57 -0700
In-Reply-To: <b7fffe99-63fb-3899-6a6d-882b72b9512f@kdbg.org> (Johannes Sixt's
        message of "Fri, 15 Jul 2022 08:00:58 +0200")
Message-ID: <xmqq1qum2uvy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A00E0BEC-045C-11ED-9912-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>> diff --git a/compat/mingw.c b/compat/mingw.c
>> index 2607de93af..b5502997e2 100644
>> --- a/compat/mingw.c
>> +++ b/compat/mingw.c
>> @@ -1059,10 +1059,7 @@ char *mingw_mktemp(char *template)
>> 
>>  int mkstemp(char *template)
>>  {
>> -	char *filename = mktemp(template);
>> -	if (!filename)
>> -		return -1;
>> -	return open(filename, O_RDWR | O_CREAT, 0600);
>> +	return git_mkstemp_mode(template, 0600);
>>  }
>> 
>>  int gettimeofday(struct timeval *tv, void *tz)
>
> I hate such an obvious layering violation. But we have already a ton of
> them elsewhere (calling xmalloc from compat/, for example), so this is
> just a rant, not an objection.

There is intended behaviour difference between xmalloc() and
malloc() that justifies your "layering violation" observation.  A
low level library replacement implemented in compat/ should not call
die() when it fails to obtain memory and instead report an error.

But it is unclear git_mkstemp_mode() and some others in wrapper.c
fall into the same category.  With the posted implementation above,
the end result is how the platform that lack working mkstemp() would
implement it.

If we were to do something to make it "cleaner", I suspect that the
above implementatoin of mkstemp() can be moved out of compat/mingw.c
and made reusable by _anybody_ who lack mkstemp(), just like we ship
memmem() emulation for anybody who lack it in contrib/memmem.c

Thanks.


