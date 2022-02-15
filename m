Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A02C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 00:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiBOA2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 19:28:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiBOA2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 19:28:16 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29600118634
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 16:28:07 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B519E16989D;
        Mon, 14 Feb 2022 19:28:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TN5uaeTDceSk
        NI8B+dqEwTZTAbHnBda6o6p2A5rkqao=; b=A1+JRFECeSrrfTwQ52pjaryMqJUW
        b7pppxaitpO0HIMQukeTgCoe4eCXH4V9EqM53Itp7vVFx6Vvc5ZYygielquZd9Bx
        FY5XSzI1dXuMQRoWD61upDkpFlMGBQFOmYdVihFa+hC235Nnf+blDGDjulQvB7ln
        vtn46DNCS96NZ78=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AF35616989C;
        Mon, 14 Feb 2022 19:28:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1EA7616989B;
        Mon, 14 Feb 2022 19:28:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] date API: add and use a date_mode_release()
References: <YZQHEiFnOdyxYX5t@coredump.intra.peff.net>
        <cover-0.5-00000000000-20220202T195651Z-avarab@gmail.com>
        <patch-5.5-b67e23549ed-20220202T195651Z-avarab@gmail.com>
Date:   Mon, 14 Feb 2022 16:28:02 -0800
In-Reply-To: <patch-5.5-b67e23549ed-20220202T195651Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 2 Feb
 2022 22:03:53 +0100")
Message-ID: <xmqqzgmtynvx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 23A90FC0-8DF6-11EC-9FB1-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix a memory leak in the parse_date_format() function by providing a
> new date_mode_release() companion function.
>
> By using this in "t/helper/test-date.c" we can mark the
> "t0006-date.sh" test as passing when git is compiled with
> SANITIZE=3Dleak, and whitelist it to run under
> "GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue" by adding
> "TEST_PASSES_SANITIZE_LEAK=3Dtrue" to the test itself.
>
> The other tests that expose this memory leak (i.e. take the
> "mode->type =3D=3D DATE_STRFTIME" branch in parse_date_format()) are
> "t6300-for-each-ref.sh" and "t7004-tag.sh". The former is due to an
> easily fixed leak in "ref-filter.c", and brings the failures in
> "t6300-for-each-ref.sh" down from 51 to 48.
>
> Fixing the remaining leaks will have to wait until there's a
> release_revisions() in "revision.c", as they have to do with leaks via
> "struct rev_info".

Here are hits from "git grep -e parse_date_format -e date_mode_release":

builtin/blame.c:701:		parse_date_format(value, &blame_date_mode);
builtin/log.c:162:		parse_date_format(default_date_mode, &rev->date_mode)=
;
date.c:966:void parse_date_format(const char *format, struct date_mode *m=
ode)
date.c:996:void date_mode_release(struct date_mode *mode)
date.h:53: * date_mode_release() later.
date.h:55:void parse_date_format(const char *format, struct date_mode *mo=
de);
date.h:59: * parse_date_format() has parsed a "DATE_STRFTIME" format.
date.h:61:void date_mode_release(struct date_mode *mode);
ref-filter.c:1266:		parse_date_format(formatp, &date_mode);
ref-filter.c:1279:	date_mode_release(&date_mode);
revision.c:2478:		parse_date_format(optarg, &revs->date_mode);
t/helper/test-date.c:40:	parse_date_format(format, &mode);
t/helper/test-date.c:58:	date_mode_release(&mode);

Unlike builtin/log.c which uses the date_mode member that is
embedded in a rev_info, the one used by format_time() in
builtin/blame.c should be releasable without waiting for updating
revision.c, right?

