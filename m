Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A589C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 16:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E78C561090
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 16:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236567AbhIVQJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 12:09:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53338 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbhIVQJd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 12:09:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6864E7DF0;
        Wed, 22 Sep 2021 12:08:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RqjLmZcHpOXU
        c0v6Pu+qJ3NnozK959VMKHgzy3TPnJI=; b=plkL+/2LKoSefry6nCsGWniVillG
        lP9KqilUtpE5ZqBj8r1LwUS9dyMphi3upBmKX3tYimzAcDgBNElTSGe+G1lb2eYy
        AsjWCCQV/wuqJFlgEsmJob2rGQi619FJ5QqL/DKu/+d5SIdbqd/TlCXOMfEJCFcH
        LyCQ8X+w2p5v2M4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE5DBE7DEF;
        Wed, 22 Sep 2021 12:08:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0BD0BE7DED;
        Wed, 22 Sep 2021 12:08:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: make COMPUTE_HEADER_DEPENDENCIES=auto work
 with DEVOPTS=pedantic
References: <patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com>
Date:   Wed, 22 Sep 2021 09:08:00 -0700
In-Reply-To: <patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 22 Sep
 2021 12:38:07 +0200")
Message-ID: <xmqqmto48ufz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4322BD0A-1BBF-11EC-9050-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The "COMPUTE_HEADER_DEPENDENCIES" feature added in [1] was extended to
> use auto-detection in [2]. Then when -Wpedantic support was added to
> DEVOPTS in [3] we started passing -Wpedantic in combination with
> -Werror to the compiler here.
>
> This broke the auto-detection, but since we'd quieted it in [4] we
> didn't find out.

Are the references correct?  I am not seeing "quiet"ing in [4].  The
redirection 2>&1 to cram error messages also to $(dep_check), hence
making it impossible to match '0', was done in [2].

We did make the pedantic mode the default and pass both -pedantic
and -Wpedantic after [4].  Before we had only -pedantic.

> It was emitting all of this on STDERR under GCC:
>
>     /dev/null:1: error: ISO C forbids an empty translation unit
>     [-Werror=3Dpedantic]
>     cc1: note: unrecognized command-line option
>     =E2=80=98-Wno-pedantic-ms-format=E2=80=99 may have been intended to=
 silence
>     earlier diagnostics
>     cc1: all warnings being treated as errors
>
> Let's fix that bug by maintaining a NON_DEVELOPER_CFLAGS, it's like
> ALL_CFLAGS but without anything we add in config.mak.dev, and
> furthermore stop redirecting STDERR to /dev/null, this means that
> someone whose compiler doesn't support this will see this output, but
> also this new message:
>
>     Non-zero 1 exit with COMPUTE_HEADER_DEPENDENCIES=3Dauto, set it to =
"yes" or "no" to quiet auto-detect


Hmmmmmph. =20

I recentaly saw many .depend directories (not necessarily empty)
left after "make distclean". After building on one branch, I often
check out a different branch then run distclean on the new branch,
so leftover build artifacts are not necessarily a bug in our
Makefile, but the bug you found may explain it?

While I agree with your analysis of the problem, I cannot shake this
nagging feeling that the proposed solution is barking up a wrong
tree.  After all, -pedantic and any other option that lets the
compiler notice that it is being asked to compile an empty source
can come directly from the end user (e.g. CC=3D"gcc -pedantic" or as
part of CFLAGS)---realization of which makes me wonder if it is
essential to compile /dev/null for this check, or any reasonably
syntactically correct program would do.

I wonder if the attached (with clean-up to remove the tracing cruft)
would show us a better direction.  It feeds a single line

	int dummy_for_dep_check;

C "program" from the standard input of the compiler to tackle the
"you are not supposed to be compiling an empty compilation unit"
problem in a more direct way.

 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git c/Makefile w/Makefile
index 9df565f27b..0593ab7287 100644
--- c/Makefile
+++ w/Makefile
@@ -1277,9 +1277,9 @@ COMPUTE_HEADER_DEPENDENCIES =3D auto
 endif
=20
 ifeq ($(COMPUTE_HEADER_DEPENDENCIES),auto)
-dep_check =3D $(shell $(CC) $(ALL_CFLAGS) \
+dep_check =3D $(shell echo >&2 doing dep check; echo int dummy_for_dep_c=
heck\; | $(CC) $(ALL_CFLAGS) \
 	-c -MF /dev/null -MQ /dev/null -MMD -MP \
-	-x c /dev/null -o /dev/null 2>&1; \
+	-x c - -o /dev/null || echo >&2 oops; \
 	echo $$?)
 ifeq ($(dep_check),0)
 override COMPUTE_HEADER_DEPENDENCIES =3D yes
