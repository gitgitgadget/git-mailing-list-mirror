Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE0CC43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 17:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377544AbiFVRxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 13:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377482AbiFVRxb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 13:53:31 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17E0FD29
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 10:53:29 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5054D1A497A;
        Wed, 22 Jun 2022 13:53:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eba3A9BPbON+
        PMbklO0mGycU2Ulcd+MCNT93A/ER2pM=; b=c9GchLpfm564NtN7rsJ/Vcle5KF6
        FueIwnN8cMl/obbmLnNguqw3oAjuoaTgwL/E6nyeX1IDGyUqymjj7DbKXSTuafXz
        IIrCAM1G3c/8wJl7rPzf6TbFAS0rQgg7tt4SVYpBIqFjtOvK8QwCB8K2CR+jcwwD
        7M2DVBqTDRi/s2o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4864C1A4979;
        Wed, 22 Jun 2022 13:53:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DAF381A496F;
        Wed, 22 Jun 2022 13:53:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     haoyurenzhuxia@gmail.com, git@vger.kernel.org, me@ttaylorr.com,
        derrickstolee@github.com, dyroneteng@gmail.com
Subject: Re: [RFC PATCH] midx.c: clean up .rev file
References: <20220622115014.53754-1-haoyurenzhuxia@gmail.com>
        <220622.86a6a4lmdv.gmgdl@evledraar.gmail.com>
Date:   Wed, 22 Jun 2022 10:53:24 -0700
In-Reply-To: <220622.86a6a4lmdv.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 22 Jun 2022 17:56:16 +0200")
Message-ID: <xmqqo7yk60vf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3736A86E-F254-11EC-B27C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Jun 22 2022, haoyurenzhuxia@gmail.com wrote:
>
>> From: Xia XiaoWen <haoyurenzhuxia@gmail.com>
>>
>> The command: `git multi-pack-index write --bitmap` will create 3
>> files in `objects/pack/`:
>>     * multi-pack-index
>>     * multi-pack-index-*.bitmap
>>     * multi-pack-index-*.rev
>>
>> But if the command is terminated by the user (such as Ctl-C) or
>> the system, the midx reverse index file (`multi-pack-index-*.rev`)
>> is not removed and still exists in `objects/pack/`:
>>
>>     $ GIT_TEST_MIDX_WRITE_REV=3D1 git multi-pack-index write --bitmap
>>     Selecting bitmap commits: 133020, done.
>>     Building bitmaps:   0% (3/331)
>>     ^C^C
>>
>>     $ tree objects/pack/
>>     objects/pack/
>>     =E2=94=9C=E2=94=80=E2=94=80 multi-pack-index-3b048d1b965842cd866e1=
0b6ec1a3035dbede0a5.rev
>>     =E2=94=9C=E2=94=80=E2=94=80 pack-b7d425f1b01727d5f364f5d9fbab2d190=
0fcd5c0.idx
>>     =E2=94=94=E2=94=80=E2=94=80 pack-b7d425f1b01727d5f364f5d9fbab2d190=
0fcd5c0.pack
>> ...
> Also, the commit message doesn't really say *why*, i.e. in cmd_repack()
> we've suffered from this already, but don't we have "git gc" cleaning
> these up? Maybe not (I didn't check), but maybe that was the previous
> assumption...

Exactly my thought.  Well said.

The _only_ case that might matter is if the next "write --bitmap" gets
confused ir there is a leftover file(s) from a previous run, but then
such a bug should be fixed on the reading side, I would think.

Thanks.
