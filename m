Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC2BC433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 19:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354555AbiE0TFd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 15:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240401AbiE0TFc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 15:05:32 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DA35C76E
        for <git@vger.kernel.org>; Fri, 27 May 2022 12:05:31 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 607C912ED14;
        Fri, 27 May 2022 15:05:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SC4fgaa9MzNa
        bnC+XMi1zTaJ/qiYfWH4emm0ckqOp4w=; b=RpzrhaDhfl/HCdrKMJNCVdw+vTWM
        s0INxSXRr2yleSkaPL/Hs7OkCfIxvDkyEYxnYC0PEGZ/8yxfNxX8/mwKkLas1Wiy
        Z7HwBsJuxMwvwIz4OiZzFNd75o4RFpeoVzqEjpFr2buuwuES2v59WCJT1cOF9xK8
        ccZwHg/61cDVVGc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4378612ED13;
        Fri, 27 May 2022 15:05:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 947C212ED12;
        Fri, 27 May 2022 15:05:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 1/5] usage.c: add a non-fatal bug() function to go with
 BUG()
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
        <patch-1.5-faa1c708a79-20220521T170939Z-avarab@gmail.com>
        <YpEEYpANXEnywDvN@google.com>
Date:   Fri, 27 May 2022 12:05:28 -0700
In-Reply-To: <YpEEYpANXEnywDvN@google.com> (Josh Steadmon's message of "Fri,
        27 May 2022 10:03:30 -0700")
Message-ID: <xmqqczfy3ifb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F99B1E18-DDEF-11EC-8FF2-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> On 2022.05.21 19:14, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Add a bug() function to use in cases where we'd like to indicate a
>> runtime BUG(), but would like to deref the BUG() call because we're
>
> Typo: I assume you meant s/deref/defer/
>
>
> [snip]
>
>> diff --git a/trace2.c b/trace2.c
>> index e01cf77f1a8..d49d5d5a082 100644
>> --- a/trace2.c
>> +++ b/trace2.c
>> @@ -211,6 +211,12 @@ int trace2_cmd_exit_fl(const char *file, int line=
, int code)
>> =20
>>  	code &=3D 0xff;
>> =20
>> +	if (bug_called_must_BUG) {
>> +		/* BUG_vfl() calls exit(), which calls us again */
>> +		bug_called_must_BUG =3D 0;
>> +		BUG("had bug() output above, in addition missed BUG_if_bug() call")=
;
>> +	}
>> +
>>  	if (!trace2_enabled)
>>  		return code;
>
> While it does seem that trace2_cmd_exit_fl() is the only reasonable
> place to put this cleanup code, perhaps it makes sense to rename this
> function and move it out of trace2.c, to more clearly show that it has
> multiple responsibilities now?

Sounds good.  This is to exit() as common_main() is to main(), it
seems to me?

