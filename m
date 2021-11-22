Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E901BC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 18:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239851AbhKVSDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 13:03:30 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56675 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbhKVSD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 13:03:28 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C80AF3D2B;
        Mon, 22 Nov 2021 13:00:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ujxOp/TmGqpY
        hryh4BcF3Tp3yfwQ1P4gQjCwlVtq2Dw=; b=UcOR9e9VSb6/hpZJr2U8ogj/oDfU
        Xc03O5xVhp/Dhs6aswh4kWrU4hqJoazXC49VA0km/QCuStlQanEOb9f92MxF5l3w
        /oYcQgltAfpDie9w4ij5ex/8SD9252WkAOSf8180wE+SEVY0JL01qVEI4ukpxk7r
        za9+Tu/azn7paYU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12821F3D2A;
        Mon, 22 Nov 2021 13:00:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F080F3D26;
        Mon, 22 Nov 2021 13:00:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Enzo Matsumiya <ematsumiya@suse.de>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] pager: fix crash when pager program doesn't exist
References: <20211120194048.12125-1-ematsumiya@suse.de>
        <YZqSBlvzz2KgOMnJ@coredump.intra.peff.net>
        <xmqqfsrplz3z.fsf@gitster.g>
        <20211122153119.h2t2ti3lkiycd7pb@cyberdelia>
        <211122.86a6hwyx1b.gmgdl@evledraar.gmail.com>
        <20211122164635.6zrqjqow4xa7idnn@cyberdelia>
        <211122.861r38yuun.gmgdl@evledraar.gmail.com>
Date:   Mon, 22 Nov 2021 10:00:19 -0800
In-Reply-To: <211122.861r38yuun.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 22 Nov 2021 18:10:47 +0100")
Message-ID: <xmqqfsrogjf0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0EBC4368-4BBE-11EC-A146-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> We then use that to check if we set it up ourselves and skip setting it
> up, but any other program invoked by us will be fooled by
> GIT_PAGER_IN_USE=3Dtrue. Maybe that's intentional,...

I think there is no other reason than to ensure subprocesses we
spawn (be it git or somebody else that will later spawn git) are
affected; otherwise a global variable in environment.c would have
sufficed.

> Presumably we can invoke N git <something>, where those <something> hav=
e
> different pager.<something> config...

A tangent, but pager.<cmd> should be renamed/transitioned to
pager.<cmd>.program, I would think.  Not that we allow characters
that are unsafe in the configuration variable names (like dot ".")
in the names of Git subcommands right now, but any name that is
taken from an unbounded set should not appear anywhere but the
second level of a three-level configuration variable name.
