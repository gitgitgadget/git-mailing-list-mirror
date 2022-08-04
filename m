Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA227C19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 16:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiHDQKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 12:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiHDQKA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 12:10:00 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95371583E
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 09:09:58 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 56E1A1AD991;
        Thu,  4 Aug 2022 12:09:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ffvRWHs28XmP
        0uhmwZr3SU2IfQc2Z/DLa3IA92nKBzw=; b=rgItY0Ufyj/xkqBE04/vtTVXFKBg
        jncod0zmUVbdRKjMLPOXPbs//XLxwwosV4dy6dy1slQJmbnZUBLbukVTbTF96TP3
        eauBmofv4zSclZoZGTxKJ3YoUFZzp+ewnjHWH6Dgn6Rv1YHeRLe6Rx/pJeMTOteS
        DBQlmu94AkmHSLY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E3671AD990;
        Thu,  4 Aug 2022 12:09:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F01161AD98D;
        Thu,  4 Aug 2022 12:09:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] gc: add tests for --cruft and friends
References: <20220803205721.3686361-1-emilyshaffer@google.com>
        <20220803205721.3686361-2-emilyshaffer@google.com>
        <220804.86a68ke9d5.gmgdl@evledraar.gmail.com>
Date:   Thu, 04 Aug 2022 09:09:53 -0700
In-Reply-To: <220804.86a68ke9d5.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 04 Aug 2022 09:48:24 +0200")
Message-ID: <xmqqtu6s6lda.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E0FB43F0-140F-11ED-BA60-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> +test_expect_success 'gc --cruft generates a cruft pack' '
>> +	git init crufts &&
>> +	test_when_finished "rm -fr crufts" &&
>
> Let's "test_when_finished" first, then "git init", the point is to clea=
n
> up the directory if we fail.

Good advice.

We say "rm -fr" not "rm -r" there because we do not want to see a
failure to remove if "git init" failed before it manages to create
the directory ;-)

>
>> +	(
>> +		cd crufts &&
>> +		test_commit base &&
>> +
>> +		test_commit --no-tag foo &&
>> +		test_commit --no-tag bar &&
>> +		git reset HEAD^^ &&
>> +
>> +		git gc --cruft &&
>> +
>> +		cruft=3D$(basename $(ls .git/objects/pack/pack-*.mtimes) .mtimes) &=
&
>> +		test_path_is_file .git/objects/pack/$cruft.pack
>> +	)
>> +'
>
> ...this...
>
>> +test_expect_success 'gc.cruftPacks=3Dtrue generates a cruft pack' '
>> +	git init crufts &&
>> +	test_when_finished "rm -fr crufts" &&
>> +	(
>> +		cd crufts &&
>> +		test_commit base &&
>> +
>> +		test_commit --no-tag foo &&
>> +		test_commit --no-tag bar &&
>> +		git reset HEAD^^ &&
>> +
>> +		git -c gc.cruftPacks=3Dtrue gc &&
>> +
>> +		cruft=3D$(basename $(ls .git/objects/pack/pack-*.mtimes) .mtimes) &=
&
>> +		test_path_is_file .git/objects/pack/$cruft.pack
>> +	)
>> +'
>> +
>
> ...whole thing seems to be copy/pasted aside from the git options.
>
> If so let's factor this into a trivial helper that invokes git "$@",
> then call it with "gc --cruft" and "-c ..."?

With shell, passing "here is a series of commands to be run in the
middle of a boilerplate sequence" is indeed easy to write, but it
gets harder to follow and quote correctly, which is why I'd rather
not see that pattern overused.

A pair of helper functions, one of which prepares a sample history
to be used, and the other checks if we created one (or more) cruft
packs, may achieve the same conciseness while remaining to be more
readable.  I.e.

    test_when_finished "rm -fr crufts" &&
    git init crufts &&
    (
	cd crufts &&
	prepare_history &&

	git -c gc.cruftPacks=3Dtrue gc &&

	cruft_packs_exist
    )

perhaps?
