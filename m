Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF1BC433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 15:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357741AbiFVPhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 11:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiFVPhR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 11:37:17 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3953239835
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 08:37:16 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BC26144FDB;
        Wed, 22 Jun 2022 11:37:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cU6tzztsfDfL
        M8w2E2pGCI6twYSXU+KPEHx/UtSzZoM=; b=GKhS7Z/DRRv5G990SQflHxA6hsW4
        4CW1+BiFVIQYZ9KU1sDN5xBnF0ccPGRm7UYwhVeYD9flnfYK21vz3GZBCuyHI+83
        ELIfD7osKSLJ7Yp+6QgdFzhCiPuoLVYkB9wd0kbW4xEOgV22P1YK6CN4Q7BIObEV
        tOy93RHFJmVwtOw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13AF0144FDA;
        Wed, 22 Jun 2022 11:37:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 29F23144FD6;
        Wed, 22 Jun 2022 11:37:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] gitweb: fix "make" not including "gitweb"
 without NOOP run slowdowns
References: <220527.861qwf489s.gmgdl@evledraar.gmail.com>
        <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
        <xmqqa6ap8z55.fsf@gitster.g> <20220620083202.GB1689@szeder.dev>
        <YrFphmtLuHVkI7yr@coredump.intra.peff.net>
        <220622.86r13hkp2c.gmgdl@evledraar.gmail.com>
Date:   Wed, 22 Jun 2022 08:37:10 -0700
In-Reply-To: <220622.86r13hkp2c.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 22 Jun 2022 11:27:54 +0200")
Message-ID: <xmqq7d587lqx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2FE3A7AA-F241-11EC-BFD6-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>   - I wondered if "make NO_PERL=3D1" would complain about "gitweb" bei=
ng
>>     in the default targets. It doesn't, but it does actually build
>>     gitweb, which seems a little weird. I don't think we actually rely
>>     on perl during the build (e.g., no "perl -c" checks or anything),
>>     and the t950x tests seem to respect NO_PERL and avoid running the
>>     generated file. So maybe it's OK?
>
> I think it's arguably a bug, but as you note we build/test etc. without
> errors, and I think it's restoring the state before e25c7cc146
> (Makefile: drop dependency between git-instaweb and gitweb, 2015-05-29)=
.
>
> Arguably we should replace with a stub script like git-svn et al, and
> arguably we should leave it, as you're more likely to e.g. run gitweb o=
n
> a webserver, so even if you build a "no perl" package, perhaps it's
> convenient to have "gitweb" part of it, and then on that one box that
> runs it you'll install perl...

It is perfectly acceptable to "make DESTDIR=3D... install" and tar up
the result on a host with NO_PERL and extract it on the target that
is capable to run gitweb, isn't it?  As long as "make NO_PERL=3D1"
gives exactly the gitweb as a build without NO_PERL, that should be
OK, I would think.  I would think what you have is in a good state.

>>   - Speaking of backwards compatibility: after this series, "cd gitweb
>>     && make" yields an error. It's got a nice message telling you what
>>     to do, but it's likely breaking distro scripts. Again, I'm not sur=
e
>>     I care, but if the point of the exercise was to avoid breaking
>>     things, well...
>
> I think that's OK, having maintained those sorts of build scripts in a
> past life.
>
> I.e. when you upgrade the package it's a minor hassle, and the error
> tells you exactly what to do, and the fix is a 2-3 lines in your recipe
> at most.

We could easily add "cd .. && make gitweb" to gitweb/Makefile with
the same "minor hassle" but that needs to be done just once, instead
of having to be done once per packager, so I am not sure the above
argues for a good tradeoff.

Thanks.
