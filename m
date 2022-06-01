Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66568C433EF
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 21:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiFAVwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 17:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiFAVwx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 17:52:53 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAADB1C929
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 14:52:51 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 58D0D1A8681;
        Wed,  1 Jun 2022 17:52:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cK8g7l6iklA4
        Zyv49AGT+TO8xBepRV7/83gVBdnv/v4=; b=oPg7nzy++bQ1oZoGg12Wlk1s7Lcu
        cGqQ1StNx3gATr85Atzkc5WhmiK7bTu0lxq/yjmuCihWMHdLqzI8bkWkAzE8ogUP
        p9cej5sAiHW1qAPxV46xSCQCSjM25OGXiC4QVTL5+lSbmXbJZ+lapaditSGzs8Mf
        TgtxXx+w1dFCvkI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 510411A8680;
        Wed,  1 Jun 2022 17:52:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7BD011A867A;
        Wed,  1 Jun 2022 17:52:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3] revert: optionally refer to commit in the
 "reference" format
References: <xmqqsfp2b30k.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205231507350.352@tvgsbejvaqbjf.bet>
        <xmqq35gzn9vk.fsf@gitster.g> <xmqq8rqn7buk.fsf_-_@gitster.g>
        <220601.86zgiwz9uk.gmgdl@evledraar.gmail.com>
Date:   Wed, 01 Jun 2022 14:52:46 -0700
In-Reply-To: <220601.86zgiwz9uk.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 01 Jun 2022 17:14:41 +0200")
Message-ID: <xmqqmtewoxu9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2CB99442-E1F5-11EC-B003-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I think a good solution to that would be to e.g. emit:
>
>     # *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***
>
>     Reverts commit <git reference>
>
>     This revert of a merge reverts changes made to <git reference 2>.
>
> Instead of what you have, which is:
>
>     # *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***
>
>     This reverts commit <git reference>, reversing
>     changes made to <git reference 2>.
>
> It's sharing a bit less code between the two, but I think the message i=
s
> suffering for it now.

We shouldn't be making it inconvenient for our primary intended
audience.

The real first line is designed to be usable without editing for
them.  Those who forgets to write the title and ends up with "This
reverts ..." as the title can still identify such a commit for the
purpose of "rebase -i" and "commit --fixup", and that is good enough
for them.

But your version will force the intended audience to remove the
"Reverts ..." line, that strikes the balance at the wrong place.

>> +test_expect_success 'identification of reverted commit (revert.refere=
nce)' '
>> +	git checkout --detach to-ident &&
>> +	git -c revert.reference=3Dtrue revert --no-edit HEAD &&
>> +	git cat-file commit HEAD >actual.raw &&
>> +	grep "^This reverts " actual.raw >actual &&
>> +	echo "This reverts commit $(git show -s --pretty=3Dreference HEAD^).=
" >expect &&
>> +	test_cmp expect actual
>
> Also (probably mentioned) I'd find this much easier to read/review if i=
t
> was using test_cmp, now you need to carefully parse the code to see wha=
t
> the outputs are like exactly, but if we compared the full output...

We are using test_cmp.  'actual' has what we care about (i.e. what
does the line that begin with "This reverts " say?) and compares it
with what we expect to see in 'expect'.
