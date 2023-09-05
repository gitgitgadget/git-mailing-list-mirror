Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E3FCA101A
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 22:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243037AbjIEWgc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 18:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242263AbjIEWg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 18:36:29 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF25FEB
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 15:36:23 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D610B258A2;
        Tue,  5 Sep 2023 18:36:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6ull9o2VAxm9
        c8zY8JcWDXwlE1QYhYoZuplXyPkt/U8=; b=XZNXVQ0mxeux9XeeUeCyENw+Gkcv
        SnRTDaxDd2D7Mw0eJjheuNNaQsRjWuGljKXvRt2NfRt6GFTnIw+HZ0ekSFc/mOY3
        moz2dRuofYSOX2GmbVIrqwiJ6ghZAVfwIwAC8g7WlMehlZqZvh3ciOZEYW1OYLl8
        /cFOZT9gGWSscCQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CE6E4258A0;
        Tue,  5 Sep 2023 18:36:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 79BAF2589F;
        Tue,  5 Sep 2023 18:36:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Radovan =?utf-8?Q?Halu=C5=A1ka?= <radovan.haluska1@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        William Sprent <williams@unity3d.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Potential bug in `git checkout --quiet`
In-Reply-To: <ZPXdeRnLu6oKoVt2@debian.me> (Bagas Sanjaya's message of "Mon, 4
        Sep 2023 20:36:57 +0700")
References: <9419E14B-5933-4773-B1BA-899A7DA75D96@gmail.com>
        <ZPXdeRnLu6oKoVt2@debian.me>
Date:   Tue, 05 Sep 2023 15:36:17 -0700
Message-ID: <xmqqh6o8qmce.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A16DDA3E-4C3C-11EE-8439-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On Mon, Sep 04, 2023 at 02:56:37PM +0200, Radovan Halu=C5=A1ka wrote:
>> What did you do before the bug happened? (Steps to reproduce your issu=
e)
>>=20
>> ```
>> git clone --quiet --branch master --depth 1 --no-checkout --filter blo=
b:none \
>>     git@github.com:acatai/Strategy-Card-Game-AI-Competition.git locm-a=
gents
>> cd locm-agents
>> git sparse-checkout set --no-cone
>> git sparse-checkout add 'contest-2022-08-COG/ByteRL'
>> git checkout --quiet
>> ```
>>=20
>> What did you expect to happen? (Expected behavior)
>>=20
>> I expected to receive no output from any of the commands above.
>>=20
>> What happened instead? (Actual behavior)
>>=20
>> I received an output from the last command even though the `--quiet` s=
witch was specified
>>=20
>> What's different between what you expected and what actually happened?
>>=20
>> This shouldn't have been printed on the screen:
>>=20
>> '''
>> remote: Enumerating objects: 28, done.
>> remote: Counting objects: 100% (28/28), done.
>> remote: Compressing objects: 100% (27/27), done.
>> remote: Total 28 (delta 0), reused 25 (delta 0), pack-reused 0
>> Receiving objects: 100% (28/28), 31.40 MiB | 4.94 MiB/s, done.
>> '''
>>=20
>
> I can reproduce this bug on v2.40.0 using your reproducer above. Yet,
> `git checkout --quiet` on normal repos (not partial ones) works as
> expected. Cc'ing people working on sparse-checkout recently.

I am not much involved in the lazy clone's on-demand downloading,
but I am torn between calling this a bug and a feature.

Just like the original reporter "expected to receive no output", for
a pure Git person like me, I expect to see *no* network activity
while performing a local operation like "checkout".  And from that
point of view, "checkout --quiet" telling me that something
unexpected and unusual (i.e. the operation "checkout" that is
supposed to be local is lazily downloading blobs and trees from the
outside world) is happening with the extra output is something I may
even appreciate.

Having said that, I would not fundamentally oppose if those who want
to improve the lazy clone feature wants to squelch messages from the
transport layer while the top-level front end ("checkout" in this case)
wants to operate quietly.

Thanks for a report.
