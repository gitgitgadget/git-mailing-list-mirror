Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF42CC07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 19:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiIZTRM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 15:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiIZTRI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 15:17:08 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9ACF9A690
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 12:17:06 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 002BA1CD17C;
        Mon, 26 Sep 2022 15:17:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=T0RMPXRa0L/A
        g4Lk9se2pp7P4dVTbOsMgEqrPw+m2u0=; b=fbKdFCTxi17vYsQ7CnAgfAltrHUP
        8WYnjBy39WOGZUcf9Md1/A/R35B+P8q/HPIsSc9zPvA3Z5Re5QjzwDHJe8TW8cLz
        tynvXZyua+VGk4rR9EaVbCS+tSezGIpg41PV6wo9YTwIVKRc7G4mKaTqwWnN1C/W
        xCM4q8alANEA3NQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EDA6A1CD17B;
        Mon, 26 Sep 2022 15:17:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2DEE81CD17A;
        Mon, 26 Sep 2022 15:17:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com
Subject: Re: [PATCH v2 1/2] maintenance: add 'unregister --force'
References: <pull.1358.git.1663635732095.gitgitgadget@gmail.com>
        <pull.1358.v2.git.1663853837.gitgitgadget@gmail.com>
        <69c74f52eefd906c38494759a02e137e4d7c01d8.1663853837.git.gitgitgadget@gmail.com>
        <20220923130832.GA1761@szeder.dev>
        <fc6739c3-2f7c-5dab-e4a2-8243deafde50@github.com>
        <220926.86mtamyvo7.gmgdl@evledraar.gmail.com>
        <22a767da-5ae0-5a8f-d5f4-f2c5cc217be4@github.com>
Date:   Mon, 26 Sep 2022 12:17:00 -0700
In-Reply-To: <22a767da-5ae0-5a8f-d5f4-f2c5cc217be4@github.com> (Derrick
        Stolee's message of "Mon, 26 Sep 2022 13:25:51 -0400")
Message-ID: <xmqqbkr2ndxv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CCCF6EC6-3DCF-11ED-B52B-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 9/26/2022 11:39 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Mon, Sep 26 2022, Derrick Stolee wrote:
>>=20
>>> On 9/23/2022 9:08 AM, SZEDER G=C3=A1bor wrote:
>>>> On Thu, Sep 22, 2022 at 01:37:16PM +0000, Derrick Stolee via GitGitG=
adget wrote:
>>>>>  static int maintenance_unregister(int argc, const char **argv, con=
st char *prefix)
>>>>>  {
>>>>> +	int force =3D 0;
>>>>>  	struct option options[] =3D {
>>>>> +		OPT_BOOL(0, "force", &force,
>>>>> +			 N_("return success even if repository was not registered")),
>>>>
>>>> This could be shortened a bit by using OPT__FORCE() instead of
>>>> OPT_BOOL().  OTOH, please make it a bit longer, and declare the opti=
on
>>>> with the PARSE_OPT_NOCOMPLETE flag to hide it from completion:
>>>
>>> Looks like I can do both like this:
>>>
>>> 		OPT__FORCE(&force,
>>> 			   N_("return success even if repository was not registered"),
>>> 			   PARSE_OPT_NOCOMPLETE),
>>=20
>> I don't think PARSE_OPT_NOCOMPLETE is appropriate here. Yes we use it
>> for most of --force, but in some non-destructive cases (e.g. "add") we
>> don't.
>>=20
>> This seems to be such a case, we'll destroy no data or do anything
>> irrecoverable. It's really just a
>> --do-not-be-so-anal-about-your-exit-code option.
>
> I agree, so I wasn't completely sold on PARSE_OPT_NOCOMPLETE. I'll use
> your vote to not add that option.

I am perfectly OK with that.  Given that "git reset --hard" is not
given nocomplete option, I do not see much point in "destructive
ones are not completed" guideline in practice anyway.  After all,
"add --force" would be destructively removing the object name
recorded for the path previously.

Thanks for carefully thinking the UI remifications through.
