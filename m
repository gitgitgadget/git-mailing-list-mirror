Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFF8C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 17:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbiF1Rgb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 13:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbiF1RgX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 13:36:23 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A655D2CE33
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 10:36:21 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DCFAA196D0E;
        Tue, 28 Jun 2022 13:36:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WRbdc7fAyxHl
        PWQQZyFNGzkKPJKGldRuEDM0ZiMTLbM=; b=X6XTnA+51H+MW8vj7XVRjpJav/oU
        JOUYPBI2TE+2Z0VuGGjjEjUM8VH5zmvZmJ8Jh4cyFshwkGQ3HzwQBprfCHtwtm0Y
        vdnGtsdC8vVbK0pPxSWSFuXpSyww4+GDPFZrAiKpXJW4i73MD2Y8shAxPuAmXfJv
        Ec+iZES/oYBPBkk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D47DC196D0D;
        Tue, 28 Jun 2022 13:36:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6E75C196D0A;
        Tue, 28 Jun 2022 13:36:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Han Xin <hanxin.hx@bytedance.com>, chiyutianyi@gmail.com,
        derrickstolee@github.com, git@vger.kernel.org,
        haiyangtand@gmail.com, jonathantanmy@google.com, me@ttaylorr.com,
        ps@pks.im
Subject: Re: [PATCH v3 2/2] commit-graph.c: no lazy fetch in
 lookup_commit_in_graph()
References: <cover.1656044659.git.hanxin.hx@bytedance.com>
        <cover.1656381667.git.hanxin.hx@bytedance.com>
        <3cdb1abd43779844b8e8dc094e2fd2da1adc461a.1656381667.git.hanxin.hx@bytedance.com>
        <220628.865yklgr6g.gmgdl@evledraar.gmail.com>
Date:   Tue, 28 Jun 2022 10:36:16 -0700
In-Reply-To: <220628.865yklgr6g.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 28 Jun 2022 09:49:58 +0200")
Message-ID: <xmqq35folmgf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D0B12F4C-F708-11EC-BE33-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> +test_description=3D'test for no lazy fetch with the commit-graph'
>> +
>> +. ./test-lib.sh
>> +
>> +if ! test_have_prereq ULIMIT_PROCESSES
>
> I think the prereq in 1/2 would be better off squashed into this commit=
.

Good thinking.  It also may make sense to implement it in this file,
without touching test-lib.sh at all.

>> +test_expect_success 'setup: prepare a repository with commit-graph co=
ntains the commit' '
>> +	git init with-commit-graph &&
>> +	echo "$(pwd)/with-commit/.git/objects" \
>> +		>with-commit-graph/.git/objects/info/alternates &&
>
> nit: you can use $PWD instead of $(pwd).

We can, and it would not make any difference on non-Windows. =20

But which one should we use to cater to Windows?  $(pwd) is a full
path in Windows notation "C:\Program Files\Git\..." while $PWD is
MSYS style "/C/Program Files/Git/..." or something like that, IIRC?
