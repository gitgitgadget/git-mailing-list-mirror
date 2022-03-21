Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5633C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 16:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351301AbiCUQkn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 12:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351297AbiCUQkk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 12:40:40 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EA317E18
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 09:39:15 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 72436184B0B;
        Mon, 21 Mar 2022 12:39:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Ti4VOyDNHsco
        tw6yFrMCbYd8Ws7WUwlSiOmD1GkwR4g=; b=qcVr782RhjebLv49z24NqvGO44ut
        2VnJaP7Ns8JtyhXxo0SxUlBzk8uczT+HEby2LkvFd99+lrvEPxW0wxYFzX7wdbpg
        xKHrSjatCBItqBiMLJZyPmqLo008XpNGeFMP2EdZ76WaFXpElKkBlDq15x0j0HKQ
        pv80of9/rx8ykJw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6A8B9184B0A;
        Mon, 21 Mar 2022 12:39:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B4FB1184B09;
        Mon, 21 Mar 2022 12:39:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] ppc: remove custom SHA-1 implementation
References: <20200223223758.120941-1-mh@glandium.org>
        <patch-1.1-05dcdca3877-20220319T005952Z-avarab@gmail.com>
Date:   Mon, 21 Mar 2022 09:39:09 -0700
In-Reply-To: <patch-1.1-05dcdca3877-20220319T005952Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 19 Mar
 2022 02:02:16 +0100")
Message-ID: <xmqq5yo72rbm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6F50F58C-A935-11EC-A22C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The main reason for doing so at this point is to simplify follow-up
> Makefile change. Since PPC_SHA1 included the only in-tree *.S assembly
> file we needed to keep around special support for building objects
> from it. By getting rid of it we know we'll always build *.o from *.c
> files, which makes the build process simpler.

Yuck.

> diff --git a/Makefile b/Makefile
> index 70f0a004e75..965e51f773e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -155,9 +155,6 @@ include shared.mak
>  # Define BLK_SHA1 environment variable to make use of the bundled
>  # optimized C SHA1 routine.
>  #
> -# Define PPC_SHA1 environment variable when running make to make use o=
f
> -# a bundled SHA1 routine optimized for PowerPC.
> -#
>  # Define DC_SHA1 to unconditionally enable the collision-detecting sha=
1
>  # algorithm. This is slower, but may detect attempted collision attack=
s.
>  # Takes priority over other *_SHA1 knobs.
> @@ -1770,14 +1767,14 @@ ifdef OPENSSL_SHA1
>  	EXTLIBS +=3D $(LIB_4_CRYPTO)
>  	BASIC_CFLAGS +=3D -DSHA1_OPENSSL
>  else
> +ifdef PPC_SHA1
> +$(error PPC_SHA1 has been removed! You should almost definitely remove=
 that \
> +knob and use the DC_SHA1 default! See INSTALL for more information)
> +endif

"use the DC_SHA1 default"? =20

	PPC_SHA1 support is being removed.  Use DC_SHA1 instead,=20
	which is the default.


I am wondering if we can make only these four lines the first step
of remova, without doing anything else.  It would give us a good
feel on how many users we may be inconveniencing (not necessarily
hurting, as switching to DC_SHA1 would be a good move) by the
removal.

> @@ -2509,6 +2505,11 @@ OBJECTS +=3D $(SCALAR_OBJECTS)
>  .PHONY: objects
>  objects: $(OBJECTS)
> =20
> +# Derived from $(OBJECTS)
> +OBJECTS_C =3D $(OBJECTS:%.o=3D%.c)
> +OBJECTS_S =3D $(OBJECTS:%.o=3D%.s)
> +OBJECTS_SP =3D $(OBJECTS:%.o=3D%.sp)

Usually we build objects from sources, so "derived from" is a
puzzling way to call them.  I understand we are deriving a list from
another list, but it still feels confusing (see below for ASM_OBJ).

This seems to have nothing to do with "we no longer have *.S files"
and looks more like "now we have excuse to touch Makefile, make
random changes that look subjectively good to me, burying them in
the noise so that we can sneak them in without justifying them much
in the proposed log message".

>  dep_files :=3D $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
>  dep_dirs :=3D $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
> =20
> @@ -2540,13 +2541,7 @@ missing_compdb_dir =3D
>  compdb_args =3D
>  endif
> =20
> -ASM_SRC :=3D $(wildcard $(OBJECTS:o=3DS))
> -ASM_OBJ :=3D $(ASM_SRC:S=3Do)
> -C_OBJ :=3D $(filter-out $(ASM_OBJ),$(OBJECTS))

I tend to agree with this patch that these three lines are ugly in
multiple ways.

It's a confusing construct.  The list of OBJECTS is used as the
single source of truth and others are derived by filtering the list
and futzing the suffix of the resulting subset of elements; it makes
me wonder if it should be the other way around (i.e. we have a list
of source files in various languages, all get turned into objects,
rather than we have a list of object files, and we see if
corresponding source file in possible languages, if any, exists on
disk).  It is pleasing that we can see them go.

Unfortunately the new "Derived from $(OBJECTS) lists are in the same
spirit as used by ASM_SRC we are removing here, aren't they?

> -$(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir=
)
> -	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) =
$(EXTRA_CPPFLAGS) $<
> -$(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_d=
ir)
> +$(OBJECTS): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_d=
ir)
>  	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) =
$(EXTRA_CPPFLAGS) $<

Now we deal only with *.c sources and all objects come from them,
and the action is the same as the old C_OBJ rule, naturally.

>  %.s: %.c GIT-CFLAGS FORCE

This is the only remaining rule regarding assembly and it is the
target to generate for debugging, not even used as a source to
create object files.  Do we need OBJECTS_S defined above?  I somehow
doubt it.  FWIW, I do not see the need for OBJECTS_SP or OBJECTS_C,
either.  E.g.

> @@ -2692,7 +2687,7 @@ XGETTEXT_FLAGS_SH =3D $(XGETTEXT_FLAGS) --languag=
e=3DShell \
>  	--keyword=3Dgettextln --keyword=3Deval_gettextln
>  XGETTEXT_FLAGS_PERL =3D $(XGETTEXT_FLAGS) --language=3DPerl \
>  	--keyword=3D__ --keyword=3DN__ --keyword=3D"__n:1,2"
> -LOCALIZED_C =3D $(C_OBJ:o=3Dc) $(LIB_H) $(GENERATED_H)
> +LOCALIZED_C =3D $(OBJECTS_C) $(LIB_H) $(GENERATED_H)

Shouldn't it be sufficient to use %(OBJECTS:o=3Dc) here, i.e. equating
the old C_OBJ with OBJECTS, now we know all objects come from C?
The same question for SP_OBJ below, but I won't repeat.
