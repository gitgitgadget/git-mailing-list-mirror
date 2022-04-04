Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9922DC38A2B
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 21:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379816AbiDDVVE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379127AbiDDQgV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 12:36:21 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78F0E094
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 09:34:23 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3031C115E79;
        Mon,  4 Apr 2022 12:34:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IzcBo4H0sTcH
        egCJwntcg9m1Ts1FcibVa8Fyuh7PDgs=; b=IM4fmjG7Cp6dkZ4kFWbVdfV1vagc
        2JbQti1YBMuB19Ggxoy101nUjBlT1FmTnJX8gNjqbdwnUr1DKg8pi0yyxtKsftUG
        GB4LyeQeVeKyBiv32x5z3hcjXPCXeBFYp7ouzin5KdyHOZ2XMnBpXMNMS74bDEMb
        UtGtf5A5XgRfa0s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 25A2E115E78;
        Mon,  4 Apr 2022 12:34:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8685A115E75;
        Mon,  4 Apr 2022 12:34:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>, whydoubt@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH] blame: report correct number of lines in progress when
 using ranges
References: <20220403165038.52803-1-eantoranz@gmail.com>
        <220404.8635itl6h0.gmgdl@evledraar.gmail.com>
Date:   Mon, 04 Apr 2022 09:34:21 -0700
In-Reply-To: <220404.8635itl6h0.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 04 Apr 2022 08:12:06 +0200")
Message-ID: <xmqq5ynost82.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 15530344-B435-11EC-B95D-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> diff --git a/builtin/blame.c b/builtin/blame.c
>> index 8d15b68afc..e33372c56b 100644
>> --- a/builtin/blame.c
>> +++ b/builtin/blame.c
>> @@ -898,6 +898,7 @@ int cmd_blame(int argc, const char **argv, const c=
har *prefix)
>>  	unsigned int range_i;
>>  	long anchor;
>>  	const int hexsz =3D the_hash_algo->hexsz;
>> +	long num_lines =3D 0;
>
> Here ranges's nr is unsigned int, and the "num_lines" is an int, and th=
e
> argument to start_delayed_progress() is uint64_t, but both of "start"
> and "end" are "long".

I see num_lines is a long, which I am guessing was made to match
what start and end are, which in turn is to use parse_range_arg().

> But we appand multiple differences to num_lines, are we sure we won't
> overflow here?

Looking at members of blame_entry and blame_scoreboard structures, I
think we make liberal use of "int" in the blame codepath without
worrying about those with 16-bit int, or those with files longer
than 2G lines, and progress meter showing incorrect values to them
is probably the least of our worries ;-)

