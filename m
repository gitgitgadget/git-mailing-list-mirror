Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA49C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 23:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26478610CB
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 23:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbhHSXkm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 19:40:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58737 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhHSXkl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 19:40:41 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D159B139996;
        Thu, 19 Aug 2021 19:40:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zy50Jy3/5VcJ
        W0k4UC0MA/5lpZpBbElVmaSQevyP79k=; b=rJMR5DJ7pj36MesMsop9+XhJ0YR/
        3NfBZ1bqVvs5fA6AbSeeE8p6B6LhrIO0SquPFs7xe9HoSUBnC616f/HkbDzMW47Y
        uqXTCTXFQh/k2Axu6GbdhrPoITt54NBrM6ZjBwWg7lpyJmuap1qMhU5L+reyQAgU
        woII4W5qUZu9/yc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CA2E0139995;
        Thu, 19 Aug 2021 19:40:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B4F7E13998F;
        Thu, 19 Aug 2021 19:40:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Makefile: remove archives before manipulating them with
 'ar'
References: <patch-1.1-2557117855-20210629T084356Z-avarab@gmail.com>
        <20210818213611.3658076-1-szeder.dev@gmail.com>
Date:   Thu, 19 Aug 2021 16:39:58 -0700
In-Reply-To: <20210818213611.3658076-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Wed, 18 Aug 2021 23:36:11 +0200")
Message-ID: <xmqqk0khxaup.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C5181442-0146-11EC-BFEC-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> The rules creating the $(LIB_FILE) and $(XDIFF_LIB) archives used to
> be:
>
>   $(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
>
> until commit 7b76d6bf22 (Makefile: add and use the ".DELETE_ON_ERROR"
> flag, 2021-06-29) removed the '$(RM) $@' part, claiming that "we can
> rely on the "c" (create) being present in ARFLAGS", and (I presume)
> assuming that it means that the named archive is created from scratch.
>
> Unfortunately, that's not what the 'c' flag does, it merely "Suppress
> the diagnostic message that is written to standard error by default
> when the archive is created" [1].  Consequently, all object files that
> are already present in an existing archive and are not replaced will
> remain there.  This leads to linker errors in back-to-back builds of
> different revisions without a 'make clean' between them if source
> files going into these archives are renamed in between:
>
>   # The last commit renaming files that go into 'libgit.a':
>   # bc62692757 (hash-lookup: rename from sha1-lookup, 2020-12-31)
>   #  sha1-lookup.c =3D> hash-lookup.c | 14 +++++++-------
>   #  sha1-lookup.h =3D> hash-lookup.h | 12 ++++++------
>   $ git checkout bc62692757^
>   HEAD is now at 7a7d992d0d sha1-lookup: rename `sha1_pos()` as `hash_p=
os()`
>   $ make
>   [...]
>   $ git checkout 7b76d6bf22
>   HEAD is now at 7b76d6bf22 Makefile: add and use the ".DELETE_ON_ERROR=
" flag
>   $ make
>   [...]
>       AR libgit.a
>       LINK git
>   /usr/bin/ld: libgit.a(hash-lookup.o): in function `bsearch_hash':
>   /home/szeder/src/git/hash-lookup.c:105: multiple definition of `bsear=
ch_hash'; libgit.a(sha1-lookup.o):/home/szeder/src/git/sha1-lookup.c:105:=
 first defined here
>   collect2: error: ld returned 1 exit status
>   make: *** [Makefile:2213: git] Error 1
>
> Restore the original make rules to first remove $(LIB_FILE) and
> $(XDIFF_LIB) and then create them from scratch to avoid these build
> errors.

Thanks.  I think I've seen a similar breakage around hook.o but
didn't dig into it.

Will queue.

>
> [1] Quoting POSIX at:
>     https://pubs.opengroup.org/onlinepubs/9699919799/utilities/ar.html
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 157293b555..20a0fe6e88 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2594,10 +2594,10 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o ht=
tp-walker.o GIT-LDFLAGS $(GITLIBS
>  		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
> =20
>  $(LIB_FILE): $(LIB_OBJS)
> -	$(QUIET_AR)$(AR) $(ARFLAGS) $@ $^
> +	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
> =20
>  $(XDIFF_LIB): $(XDIFF_OBJS)
> -	$(QUIET_AR)$(AR) $(ARFLAGS) $@ $^
> +	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
> =20
>  export DEFAULT_EDITOR DEFAULT_PAGER
