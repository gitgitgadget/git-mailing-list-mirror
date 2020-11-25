Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA361C56201
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 20:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 703BA207BB
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 20:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n7RLCg+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbgKYUh5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 15:37:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63294 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729947AbgKYUh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 15:37:57 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF2088D2D4;
        Wed, 25 Nov 2020 15:37:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=N2Q957IB0w8N
        C2rLERijCbddmII=; b=n7RLCg+qQEzc2ROhZwQiw9b25hnwtkUvKbmY6gkFIHnh
        RZbDlm8CXw+HgB+YvV1fskmleZdgYPcFz8y0Vwo78TKPdyC2e6vxMRFQZZjyJnkD
        jpNotiCNrKQQk5zesEodXQj0NgyaTwY90giAdgDLZIfYGmB4c87gZGkpbSalmfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pIJEfG
        dikN2LK018qNQn8cU5q7CTZgsHqHUxRn5tx4kLlbfCs3u0C0tMvIkKYyELoDZLs8
        xroJ31nVDG3dF1J8UCA/YqgSXBNtIlC9ENnwsTfy/HaQhMEcudFW4jAMrkWd8Gbr
        eX9bAb1lT/O8v4ganU1c4iPX1Ev956I4CcW0g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E70608D2D3;
        Wed, 25 Nov 2020 15:37:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 70CA78D2D2;
        Wed, 25 Nov 2020 15:37:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 01/26] completion: bash: fix prefix detection in
 branch.*
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
        <20201110212136.870769-2-felipe.contreras@gmail.com>
        <20201125084814.GE8396@szeder.dev>
Date:   Wed, 25 Nov 2020 12:37:53 -0800
In-Reply-To: <20201125084814.GE8396@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Wed, 25 Nov 2020 09:48:14 +0100")
Message-ID: <xmqqr1ohdvfi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 183A469C-2F5E-11EB-934F-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Tue, Nov 10, 2020 at 03:21:11PM -0600, Felipe Contreras wrote:
>> Otherwise we are completely ignoring the --cur argument.
>>=20
>> The issue can be tested with:
>>=20
>>   git clone --config=3Dbranch.<tab>
>>=20
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  contrib/completion/git-completion.bash | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completi=
on/git-completion.bash
>> index 7c81e4ba49..b866b68b3c 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2615,8 +2615,8 @@ __git_complete_config_variable_name ()
>>  		return
>>  		;;
>>  	branch.*)
>> -		local pfx=3D"${cur%.*}."
>> -		cur_=3D"${cur#*.}"
>> +		local pfx=3D"${cur_%.*}."
>> +		cur_=3D"${cur_#*.}"
>
> Indeed, somehow this case was only half-converted in 5af9d5f6c8
> (completion: complete config variables and values for 'git clone
> --config=3D', 2019-08-13), thanks.

Very much appreciated a review on this step, and it would be even
more appreciated if the whole series gets some review, as we do not
want to merge a series that has not been looked at.

Thanks.


