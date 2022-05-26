Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7783AC433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 16:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345059AbiEZQza (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 12:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238069AbiEZQz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 12:55:29 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661A912AEC
        for <git@vger.kernel.org>; Thu, 26 May 2022 09:55:28 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B12F136AE5;
        Thu, 26 May 2022 12:55:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=G9y06dA1l07T
        a7jjUJ3P6r/DvPsrAkGQ0UumSbCo5PU=; b=JRT8PJILZKwP74ylYejRs4httJ+E
        KtsGLeRMEhenJcwgAfrPP62OhUSc2xx6JpOOgJ8mPJs6JD20XBAe8x0bzlyjixVW
        MCrD0mShjk6z3/xqlGkIVPXTA3Dvh6/aRu57nNRoAxtHS5xeVggg5CFnIStmlNjg
        3Hkt06bTolA2W+A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 722E7136AE4;
        Thu, 26 May 2022 12:55:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C4E40136AE3;
        Thu, 26 May 2022 12:55:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 1/5] usage.c: add a non-fatal bug() function to go with
 BUG()
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
        <patch-1.5-faa1c708a79-20220521T170939Z-avarab@gmail.com>
        <xmqqpmk15o46.fsf@gitster.g> <xmqqh75d2aif.fsf@gitster.g>
        <220526.86fskw7mbv.gmgdl@evledraar.gmail.com>
Date:   Thu, 26 May 2022 09:55:25 -0700
In-Reply-To: <220526.86fskw7mbv.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 26 May 2022 09:59:20 +0200")
Message-ID: <xmqqleuo1beq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A45C87C4-DD14-11EC-BECF-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I don't think we should do it like that and keep it a BUG() not to call
> BUG_if_bug() when we hit exit(), because e.g. in the case of
> parse-options.c once we have the a bad "struct options" we don't want t=
o
> continue, as we might segfault, or have other bad behavior etc. So we'd
> like to BUG() out as soon as possible.

Oh, there is no question about that.  When we detect that the
program is in an inconsistent and unexpected state, we would want to
bug out instead of continuing at some point, and that is why we would
want to have BUG_if_bug(), or exit_if_called_bug(), as I called in
the message you are reponding to.

What I am getting at is that the code often or usually calls
BUG_if_bug() is not a reason to require it to be called, especially
if there are conditional calls to bug() near the end of the program.
Imagine a program, after finishing to respond to the end-user
request, before the end of the program, performing some self sanity
checks with a series of "if (condition) bug()", and there is no more
thing that needs to be done other than exiting after such check.  I
would have added such a call to sanity_check_refcnt() at the end of
"git blame", for example, if the facility existed.

Thanks.


