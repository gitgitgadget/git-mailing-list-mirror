Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E15FC433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 00:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 484B7611C6
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 00:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238593AbhIWAFe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 20:05:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53728 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhIWAFd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 20:05:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 583A1159AA6;
        Wed, 22 Sep 2021 20:04:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wFg23bXXJWaN
        VTMnUQdmr3PFWCseaAtIz4fBLBL5h6M=; b=ef12TJfSF/9p9YwCjpEy57YZCIHb
        pnKMWxc7Sy2NcT64eWskmdDEnKDgunPk00CY3VoXIxMmgBPSHlCdgsZbIdZvSABb
        vRpEZxJJbsaB6QS5lQNrzoKAD6VWubkLyaGXXBNRIwxuzDK+P2eAObJhATSGetKQ
        eh2WMtNI/ztFKQM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 50AA1159AA5;
        Wed, 22 Sep 2021 20:04:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BA7AE159AA2;
        Wed, 22 Sep 2021 20:03:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: make COMPUTE_HEADER_DEPENDENCIES=auto work
 with DEVOPTS=pedantic
References: <patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com>
        <xmqqmto48ufz.fsf@gitster.g>
        <YUtiNuUiBU4Xg4gw@coredump.intra.peff.net>
        <xmqqzgs479d5.fsf@gitster.g>
        <YUuPYDkxjDIvIfwI@coredump.intra.peff.net>
Date:   Wed, 22 Sep 2021 17:03:58 -0700
In-Reply-To: <YUuPYDkxjDIvIfwI@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 22 Sep 2021 16:17:36 -0400")
Message-ID: <xmqqo88k40pd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C0DBCEB6-1C01-11EC-A649-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I almost suggested using "git.c" as the dummy file, since we know it
> must compile anyway. But that probably has other problems (it's more
> expensive, and if it _does_ have an error, the results may be
> confusing).
>
> It's a shame we can't just try to do the _real_ compiles using the
> auto-dependency stuff, and then fall back if they fail. But I think
> there's a chicken-and-egg problem there with "make" doing real work, an=
d
> figuring out the dependencies to do real work.

Yeah, if compiling any of the real sources is inexpensive enough, I
would think that would be the happy way to go.  Do we have a trivial
source that almost never changes?  Perhaps version.c (especially if
we kick out two helper functions that do not really belong there)?

> ...
> I'm happy to submit that on top, or even turn the earlier hunk into a
> patch.  But let's see what =C3=86var has to say to what's been discusse=
d so
> far. I don't want to derail his effort.

Yup.
