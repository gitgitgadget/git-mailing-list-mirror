Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E913C433FE
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 22:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244309AbiBWWvz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 17:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiBWWvy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 17:51:54 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519BB4F9E2
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 14:51:26 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8D770179A16;
        Wed, 23 Feb 2022 17:51:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4ZiwA5defv3F
        9pAQ7VIj2ZgU6jVvInST1mFEIlv2qws=; b=VZhCkwQsrVxD2Cgxl0XLDe8b5kCS
        lmGX26kNoYM2fel8dyi84mrROMvs136iXHZzNKM+TUshuF5ivj+wJCrKG3ELKPQq
        VmwiUGjz1+URuNojYDT8N/vd/u05DEsoHRZ7mpZ6Yf2brKGc2IuTJqQxrRxCiTMV
        b/CyEN2ony0NUxw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 850C8179A15;
        Wed, 23 Feb 2022 17:51:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DF2CC179A14;
        Wed, 23 Feb 2022 17:51:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/3] stash: add test to ensure reflog --rewrite
 --updatref behavior
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
        <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
        <6e136b62ca4588cc58f2cb59b635eeaf14e6e20d.1645554652.git.gitgitgadget@gmail.com>
        <220223.864k4q6jpr.gmgdl@evledraar.gmail.com>
Date:   Wed, 23 Feb 2022 14:51:21 -0800
In-Reply-To: <220223.864k4q6jpr.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 23 Feb 2022 09:54:47 +0100")
Message-ID: <xmqqbkyxqjrq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1F966FF2-94FB-11EC-8971-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> +test_expect_success 'drop stash reflog updates refs/stash' '
>> +	git reset --hard &&
>> +	git rev-parse refs/stash >expect &&
>> +	echo 9 >file &&
>> +	git stash &&
>> +	git stash drop stash@{0} &&
>> +	git rev-parse refs/stash >actual &&
>> +	test_cmp expect actual
>> +'
>
> This one will be portable to the reftable backend.
>
>> +test_expect_success 'drop stash reflog updates refs/stash with rewrit=
e' '
>
> But as I noted in <220222.86fsob88h7.gmgdl@evledraar.gmail.com> (but it
> was easy to miss) this test will need to depend on REFFILES. So just
> changing this line to:
>
>     test_expect_success REFFILES 'drop stash[...]'
>
>> +	git reset --hard &&
>> +	echo 9 >file &&
>> +	git stash &&
>> +	oid=3D"$(git rev-parse stash@{0})" &&
>> +	git stash drop stash@{1} &&
>> +	cut -d" " -f1-2 .git/logs/refs/stash >actual &&
>> +	cat >expect <<-EOF &&
>> +	$(test_oid zero) $oid
>> +	EOF
>> +	test_cmp expect actual
>> +'

Why should this be tested with "cut" in the first place, though?

If we start from

    stash@{0} =3D A
    stash@{1} =3D B
    stash@{2} =3D C

and after saying "drop stash@{1}", what we need to check is that

    stash@{0} =3D A
    stash@{1} =3D C

now holds, which can be done with "git rev-parse", and the fact that
the ref-files backend happens to record both before-and-after object
IDs is an irrelevant implementation detail, no?

I am still puzzled.


