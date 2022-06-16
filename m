Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C0BC433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 20:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiFPUOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 16:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiFPUOA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 16:14:00 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5295A5B3
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 13:14:00 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8DA4819069A;
        Thu, 16 Jun 2022 16:13:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DIOoiiSFSQ2j
        PnE0Z7W5cPnpkIjCB0+CYfqSNQ6Zdx0=; b=PrZJPncn5oecixqTqlz/eRzzcHD+
        45On9hcaSCvpS3dgCk/EW/2XAiGkCGIn/w+nkx5fcGnR7VOd2cOPHCTwRrEkKWIY
        t1jWI/5tR54dHEId6YVgqi7ZaQ5UGAJbVV5dO4DUbkKn00rPs1dMvBdvpTLiP4BN
        IcibP15pf3B05po=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 86670190698;
        Thu, 16 Jun 2022 16:13:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2EC2B190697;
        Thu, 16 Jun 2022 16:13:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 01/11] mingw: avoid accessing uninitialized memory in
 `is_executable()`
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
        <679ea7421f73ce41515aca549982233f88bcefef.1655336146.git.gitgitgadget@gmail.com>
        <98ff788a-d621-cf3f-aed5-66ae763b381f@web.de>
Date:   Thu, 16 Jun 2022 13:13:55 -0700
In-Reply-To: <98ff788a-d621-cf3f-aed5-66ae763b381f@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 16 Jun 2022 21:53:28 +0200")
Message-ID: <xmqqmtecs6ws.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D994A94C-EDB0-11EC-A25A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 16.06.22 um 01:35 schrieb Johannes Schindelin via GitGitGadget:
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> On Windows, we open files we suspect might be scripts, read the first
>> two bytes, and see whether they indicate a hash-bang line. We do not
>> initialize the byte _after_ those two bytes, therefore `strcmp()` is
>> inappropriate here.
>
> Hmm, but buf _is_ initialized fully?  Line 149:
>
>         char buf[3] =3D { 0 };

Ahh, yeah, that changes the landscape quite a bit.

We explicitly ask to read 2 bytes and look at the buf[] when read
says it read 2 bytes, so this is another false positive X-<.

>> diff --git a/run-command.c b/run-command.c
>> index 14f17830f51..2ba38850b4d 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -154,7 +154,7 @@ int is_executable(const char *name)
>>  		n =3D read(fd, buf, 2);
>>  		if (n =3D=3D 2)
>>  			/* look for a she-bang */
>> -			if (!strcmp(buf, "#!"))
>> +			if (!memcmp(buf, "#!", 2))
>>  				st.st_mode |=3D S_IXUSR;
>>  		close(fd);
>>  	}

We can update the variable to

	char buf[2];

to match the updated code, I guess.  The fewer bytes we use on
stack, the better ;-).

