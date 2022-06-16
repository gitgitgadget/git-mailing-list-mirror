Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648FBC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 18:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377330AbiFPSMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 14:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiFPSMg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 14:12:36 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B54626F6
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 11:12:34 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AEE791AF338;
        Thu, 16 Jun 2022 14:12:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Qy+IayMP0div
        LAdq5GhI4RbiO4oJjeRkx7ExKOyp5/I=; b=epxQHC0AwGKO3D94kwC7BBLIZeNm
        KhlxEbLySjwYN9uQwdFrEsEV54nss+HnG3HHXnXpQzd1R0GGOqzHlIkgalkRzJfN
        njuPEX08ee5Ak/FMoRJ0ks7Oi92/HrVqdbfHcCWHlruYe5EEIpmd1C3QdZYO3pdW
        0dd8BntMNk7/pFg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A70741AF337;
        Thu, 16 Jun 2022 14:12:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3FB5C1AF336;
        Thu, 16 Jun 2022 14:12:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>, Kyle Zhao <kylezhao@tencent.com>
Subject: Re: [PATCH v2] send-pack.c: add config push.useBitmaps
References: <pull.1263.git.1655291320433.gitgitgadget@gmail.com>
        <pull.1263.v2.git.1655350617442.gitgitgadget@gmail.com>
        <220616.86fsk4ww69.gmgdl@evledraar.gmail.com>
Date:   Thu, 16 Jun 2022 11:12:28 -0700
In-Reply-To: <220616.86fsk4ww69.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 16 Jun 2022 15:38:36 +0200")
Message-ID: <xmqqfsk4tr3n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E2D429C6-ED9F-11EC-BEA8-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> +	mk_test testrepo heads/main &&
>> +	git checkout main &&
>> +	GIT_TRACE2_EVENT=3D"$PWD/default" \
>> +	git push testrepo main:test &&
>> +	test_subcommand git pack-objects --all-progress-implied --revs --std=
out \
>> +	--thin --delta-base-offset -q --no-use-bitmap-index <default &&
>
> Nit: We tend to indent these ase we wrap, so e.g.:
>
> 	test_subcommand git ... \
> 		--thin --delta [...]
>
> The rest all looks good as far as the diff goes, if what we want to do
> is to disable this by default, and this isn't worth a re-roll in itself=
.
>
> But I still think that completely disabling bitmaps might be premature
> here, especially per Taylor's comment on v1 (which I understand to mean
> that they should help some of the time, even with push).

The usual way to move is to move slowly and carefully.

It may well be the case that disabling bitmaps gives users a better
default, but that is not even proven and is hard to prove.  How many
users of Git do we have?  Those silently using it happily will by
definition complain here or elsewhere, and the complaints "X is slow
with Y, so Y should be disabled when doing X" we hear tend to be
louder than "I am happily doing X with Y".

I have different problems with this patch, though.  It can use a bit
more honesty.  If you introduce a new knob and sell it as a knob
that allows disabling, be honest and keep its behaviour as
advertised.

As posted, IIUC, the patch does something quite different.  It
disables by default, and have a knob to allow it enabled again.

So, perhaps make it default on to keep the historical behaviour, and
document it as "setting it false may improve push performance without
affecting use of the reachability bitmaps for other operations.
Default is true."

Thanks.
