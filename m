Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B0FC433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 19:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbhKXTtb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 14:49:31 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57675 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbhKXTt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 14:49:28 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D7EA161556;
        Wed, 24 Nov 2021 14:46:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WWcL+rMAbv+x
        MFDzxc9+BCpYY04/TOoh1MSIUSQ2ftg=; b=APC4YH3AJUce84ScjJPgpGowxSZE
        v/kKQ+w/NLzSQiaru4lp9QTsJcXlb8/S1VKyXtsQvq189/gE8P4ss8hzuy2cZCAL
        RmRqWkoEsnr/MmeGsxJN9cuJxuTPZTtQ5CFL8FFJUTh5RXipty3WCHcy8YaICynk
        FPTMG+eRWsE6w9c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4AF89161553;
        Wed, 24 Nov 2021 14:46:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A7405161552;
        Wed, 24 Nov 2021 14:46:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/8] dir: avoid removing the current working directory
References: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
        <20211123003958.3978-1-chooglen@google.com>
        <CABPp-BE0Bcimwr1wwcnnh+6apx7r114Oqnu=QDgKEn6VAHAtFg@mail.gmail.com>
        <kl6lmtluka55.fsf@chooglen-macbookpro.roam.corp.google.com>
        <CABPp-BGr9PDTE0q5zev4Ffx19g+hG083zdNShoSdH47VqzT8mw@mail.gmail.com>
        <211124.86ee76e4fl.gmgdl@evledraar.gmail.com>
        <CABPp-BGZPheDqWD1pXbePOYe2BcT1-TqX-zGVqnNLGtFuXab1g@mail.gmail.com>
        <211124.86wnkxdbza.gmgdl@evledraar.gmail.com>
        <bf9b547d-f421-49f7-9dc5-cc1f81187127@iee.email>
Date:   Wed, 24 Nov 2021 11:46:12 -0800
In-Reply-To: <bf9b547d-f421-49f7-9dc5-cc1f81187127@iee.email> (Philip Oakley's
        message of "Wed, 24 Nov 2021 14:33:13 +0000")
Message-ID: <xmqqk0gx1gmz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2E6159FE-4D5F-11EC-8D6C-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> On 24/11/2021 11:14, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> I'm not concerned that you didn't research this change well enough, I
>> just find it a bit iffy to introduce semantics in git around FS
>> operations that don't conform with that of POSIX & the underlying OS. =
My
>> *nix system happily accepts an "rm -rf" or an "rmdir" of the directory
>> I'm in, I'd expect git to do the same.
> Isn't this the same, conceptually, as trying to remove the root
> directory, but from a Git perspective?
>
> i.e. Something along the lines of
> https://superuser.com/questions/542978/is-it-possible-to-remove-the-roo=
t-directory
> (their answer is 'no' without a special option, default since 2006)
>
> If I read the arguments correctly, Elijah is saying that Git shouldn't
> delete it's own root (cwd) directory, and that it is already implicit
> within the current Git code.

I do not think it is about protecting "root"; the series wants

    cd t/ && git rm -r ../t

to leave an empty directory at 't/', because "git rm" was started in
that directory.
