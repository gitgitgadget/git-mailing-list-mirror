Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C933C433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 23:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238136AbiEJXo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 19:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiEJXoX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 19:44:23 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA52B59090
        for <git@vger.kernel.org>; Tue, 10 May 2022 16:44:22 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B122C18BA92;
        Tue, 10 May 2022 19:44:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=95i8k8wQPDfBmxVyTNOpBrywbUU2VDykSAXsqt
        7iC6o=; b=sjClEv5fPa3BISMe7+pQcRxi0RRdiysLF8aitGg0kph/zhuj/AOvbK
        f5EHJ9Yt1P+o6I+s1ghZj+d7HByu47mNmBhr9nmjGsBILElgj1q6K5auxVx1BGOj
        vXIf/V5+b4u5ZJtApYhi07yK2DXbBa1Ia8MGmUn0AzA8VUz5Ag0FM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9CF0518BA91;
        Tue, 10 May 2022 19:44:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3763918BA8B;
        Tue, 10 May 2022 19:44:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 1/3] t: regression git needs safe.directory when
 using sudo
References: <20220507163508.78459-1-carenas@gmail.com>
        <20220510174616.18629-1-carenas@gmail.com>
        <20220510174616.18629-2-carenas@gmail.com>
        <xmqqczgl6nua.fsf@gitster.g>
        <CAPUEspgGZeF8LA5PZNF87=+zZLKvWLqWtpD5YUBUON4gq_TaDg@mail.gmail.com>
Date:   Tue, 10 May 2022 16:44:16 -0700
In-Reply-To: <CAPUEspgGZeF8LA5PZNF87=+zZLKvWLqWtpD5YUBUON4gq_TaDg@mail.gmail.com>
        (Carlo Arenas's message of "Tue, 10 May 2022 16:11:55 -0700")
Message-ID: <xmqqwnet3qcv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B9D9FD2-D0BB-11EC-B95C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

>> > +test_lazy_prereq SUDO '
>> > +     sudo -n id -u >u &&
>> > +     id -u root >r &&
>> > +     test_cmp u r &&
>> > +     command -v git >u &&
>> > +     sudo command -v git >r &&
>> > +     test_cmp u r
>> > +'
>>
>> I vaguely recall mentions of older dash that lack "command -v" made
>> earlier, but implementations of dash I have handy seem to know it.
>> I am personally fine with this as this script has a very narrow and
>> limited audience in mind.
>
> I did check that, but think the report was mistaken.
> Debian, Ubuntu, NetBSD and OpenBSD would fail the same way here, but
> it is not because of the use of dash, as much as sudo NOT being
> configured to default to `-s` mode.

OK.

> dscho was right to point out that I should had usen type instead, but
> that wouldn't work because of the mismatch of shells and therefore the
> mismatch of outputs, so I went with command instead as an extra clever
> way to make sure both the shell inside and outside were most likely
> the same, even if some sudo somewhere decides in the name of security
> not to respect its own "-s mode" and force a "safer" shell.

In this particular case, "command -v" is the right thing to use, as
you care where the command is found on the $PATH and "type --path"
is *NOT* portable.

>> > +     sudo chown root root &&
>> > +     (
>> > +             cd root/r &&
>> > +             git init
>> > +     )
>> > +'
>>
>> So, "root/" is owned by root, "root/r" is owned by the tester.
>
> It doesn't need to be root, but needs to be different than "tester",

To make sure you do not misunderstand, I know the ownership of
root/r and root/p matter---tester and root must be different.  And
we use these two as sample repositories owned by two different
users.

What I am pointing out here is the root/ directory itself.  I do not
think its ownership does not matter anywhere in these new tests (not
just this patch, but after applying all three patches).

>> > +test_expect_failure SUDO 'sudo git status as original owner' '
>> > +     (
>> > +             cd root/r &&
>> > +             git status &&
>>
>> The tester runs "git status" in "root/r" owned by the tester and it
>> should succeed.
>>
>> > +             sudo git status
>>
>> We want the tester to be able to do the same while temporarily
>> becoming 'root' with "sudo", but we know it fails right now.
>>
>> > +     )
>> > +'
>>
>> Mental note.  We do not need root to be owned by 'root' with the
>> tests we see here.  Perhaps we would add some that requires it in
>> later patches.  We'll see.
>
> I am not good with subtle messages in a foreign language, but is this
> a way to imply that I shouldn't need to chown and instead use the
> GIT_TEST_PRETEND feature more?

No.  I just said I made a mental note of the fact that the ownership
of root/ directory (not root/r which is the other directory this
test script creates in this step) does not matter at least in patch
1/3, but I cannot say, by that observation alone, that chown we saw
earlier should be removed, because patches 2/3 and 3/3 might start
requiring root/ to be owned by 'root'.  Hence "I made a mental note
here.  We do not have anything that requires the above chown in this
patch, but we might see something that makes it a good idea to keep
the chown in later patches".

I do not think GIT_TEST_PRETEND needs to be involved at all.  It's
just root/ can be left owned by the tester, because we only care
about the owners of root/p and root/r in these three patches.

Thanks.

