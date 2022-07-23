Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13224C43334
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 18:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbiGWSkN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jul 2022 14:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbiGWSkL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jul 2022 14:40:11 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B2F389C
        for <git@vger.kernel.org>; Sat, 23 Jul 2022 11:40:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 510B4145A8E;
        Sat, 23 Jul 2022 14:40:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kCpSoujEVj9f2vE0KQp/mfUL7eVlk7sMmACLKH
        d0pIo=; b=BDL8Rbki8Z+iGAzErpELMUyTVCcp56pOSI0obKZrlEJgrvoyv+i6qt
        SgVs1Uqhv5FxLC2yfQVjMxrMN8F39CxtHWLf9nznGxXSQYhQ4OidGbxJEIQIeUjK
        Y11iSy/pZrRW9nBsZ1Vgg4l5QVQfMzgLgSiLQIf8m9xw+sIJlMEVE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36D1E145A8C;
        Sat, 23 Jul 2022 14:40:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8EC9A145A8B;
        Sat, 23 Jul 2022 14:40:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v8] ls-files: introduce "--format" option
References: <pull.1262.v7.git.1657692472994.gitgitgadget@gmail.com>
        <pull.1262.v8.git.1658334983053.gitgitgadget@gmail.com>
        <xmqqbktj3ct7.fsf@gitster.g>
        <CAOLTT8RjLoooT7t+ucFqa9P=8TiVL3M+ZgcEY7qVhRbjB=9OhA@mail.gmail.com>
Date:   Sat, 23 Jul 2022 11:40:06 -0700
In-Reply-To: <CAOLTT8RjLoooT7t+ucFqa9P=8TiVL3M+ZgcEY7qVhRbjB=9OhA@mail.gmail.com>
        (ZheNing Hu's message of "Fri, 22 Jul 2022 14:44:42 +0800")
Message-ID: <xmqqsfmr8ygp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFF8E6EA-0AB6-11ED-99F1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

>> But is this testing the right thing?
>
> Yes, I am sure about that cut can do the same thing as awk, and it can
> specify its delimiter.

That is not an answer to "is this testing the right thing?"
question, though ;-)

>> > +test_expect_success 'git ls-files --format objectmode v.s. -s' '
>> > +     git ls-files -s >files &&
>> > +     cut -d" " -f1 files >expect &&
>> > +     git ls-files --format="%(objectmode)" >actual &&
>> > +     test_cmp expect actual
>> > +'
>>
>> It only looks at the first column of the "-s" output, and we are
>> implicitly assuming that the order of output does not change between
>> the "-s" output and "--format=<format>" output.  I wonder if it is
>> more useful and less error prone to come up with a format string
>> that 100% reproduces the "ls-files -s" output and compare the two,
>> e.g.
>>
>>         format="%(objectmode) %(objectname) %(stage)    %(path)" &&
>>         git ls-files -s >expect &&
>>         git ls-files --format="$format" >actual &&
>>         test_cmp expect actual
>>
>
> See test case: 'git ls-files --format imitate --stage' which just do such thing,


That was not the point.  By extracting only "%(objectmode)" without
having any other clues (like "%(path)") on the same line, the test
is assuming that ls-files will always sort its output in the same
order regardless of the output format, whether it is "--stage" or
"--format=<spec>", and that was what the "is this testing the right
thing?" question was about.

The other test that makes sure --format=<spec> can recreate --stage
output is fine.  If some future developer breaks the output order by
mistake for --format=<spec>, we will catch such a mistake with it.


> maybe I should change its name to 'git ls-files --format v.s. -s'?

I do not think you should.  "A v.s. B" does not imply "A and B
should create identical result".  The original title describes what
it does much more clearly.
