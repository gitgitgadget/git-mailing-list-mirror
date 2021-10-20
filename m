Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34646C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 14:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FCD7610EA
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 14:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhJTOjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:39:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63954 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhJTOjU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 10:39:20 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D661E00D3;
        Wed, 20 Oct 2021 10:37:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RA1I+QAopJQC
        tVuebogLSr9qBeqM0CTUZfTBso1BRAc=; b=wVPgdxNBsyQ8wCWGHfLUT6DmhSQ+
        BLwLXc2BwPkzU+JScHk506dkIK/G16zqsQUdr+l8eP3c/8BtpAuAGPLZslhfNIdn
        +s3p/wvdoqi2fqfOv7ZekyXAtYUCXdzc3IKQ0dWDebcx8yrplg9C2bAO7lG2qVR0
        ZBHrUrX7O4zY4vw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 24B31E00D2;
        Wed, 20 Oct 2021 10:37:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 73704E00D1;
        Wed, 20 Oct 2021 10:37:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH v2 1/4] tag: use a "goto cleanup" pattern, leak less
 memory
References: <211020.864k9boo0f.gmgdl@evledraar.gmail.com>
        <RFC-cover-v2-0.4-00000000000-20211020T131627Z-avarab@gmail.com>
        <RFC-patch-v2-1.4-fc776c3f1cd-20211020T131627Z-avarab@gmail.com>
Date:   Wed, 20 Oct 2021 07:37:03 -0700
In-Reply-To: <RFC-patch-v2-1.4-fc776c3f1cd-20211020T131627Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 20 Oct
 2021 15:24:33
        +0200")
Message-ID: <xmqqwnm7rcds.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 31BC04AE-31B3-11EC-900E-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change cmd_tag() to free its "struct string_list"'s instead of using

string_list -> strbuf

> an UNLEAK() pattern. This changes code added in 886e1084d78 (builtin/:
> add UNLEAKs, 2017-10-01).
>
> As shown in the context of the deceleration of the "struct

deceleration?

> msg_arg" (which I'm changing to use a designated initializer while at
> it, and to show the context in this change), that struct is just a
> thin wrapper around an int and "struct strbuf".
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/tag.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 6535ed27ee9..ad6c9855914 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -432,7 +432,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
>  	int annotate =3D 0, force =3D 0;
>  	int cmdmode =3D 0, create_tag_object =3D 0;
>  	const char *msgfile =3D NULL, *keyid =3D NULL;
> -	struct msg_arg msg =3D { 0, STRBUF_INIT };
> +	struct msg_arg msg =3D { .buf =3D STRBUF_INIT };
>  	struct ref_transaction *transaction;
>  	struct strbuf err =3D STRBUF_INIT;
>  	struct ref_filter filter;
> @@ -482,6 +482,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
>  		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are c=
ase insensitive")),
>  		OPT_END()
>  	};
> +	int ret =3D 0;
> =20
>  	setup_ref_filter_porcelain_msg();
> =20
> @@ -529,7 +530,6 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
>  	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
>  	filter.ignore_case =3D icase;
>  	if (cmdmode =3D=3D 'l') {
> -		int ret;
>  		if (column_active(colopts)) {
>  			struct column_options copts;
>  			memset(&copts, 0, sizeof(copts));
> @@ -540,7 +540,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
>  		ret =3D list_tags(&filter, sorting, &format);
>  		if (column_active(colopts))
>  			stop_column_filter();
> -		return ret;
> +		goto cleanup;
>  	}
>  	if (filter.lines !=3D -1)
>  		die(_("-n option is only allowed in list mode"));
> @@ -552,12 +552,15 @@ int cmd_tag(int argc, const char **argv, const ch=
ar *prefix)
>  		die(_("--points-at option is only allowed in list mode"));
>  	if (filter.reachable_from || filter.unreachable_from)
>  		die(_("--merged and --no-merged options are only allowed in list mod=
e"));
> -	if (cmdmode =3D=3D 'd')
> -		return delete_tags(argv);
> +	if (cmdmode =3D=3D 'd') {
> +		ret =3D delete_tags(argv);
> +		goto cleanup;
> +	}
>  	if (cmdmode =3D=3D 'v') {
>  		if (format.format && verify_ref_format(&format))
>  			usage_with_options(git_tag_usage, options);
> -		return for_each_tag_name(argv, verify_tag, &format);
> +		ret =3D for_each_tag_name(argv, verify_tag, &format);
> +		goto cleanup;
>  	}
> =20
>  	if (msg.given || msgfile) {
> @@ -626,10 +629,11 @@ int cmd_tag(int argc, const char **argv, const ch=
ar *prefix)
>  		printf(_("Updated tag '%s' (was %s)\n"), tag,
>  		       find_unique_abbrev(&prev, DEFAULT_ABBREV));
> =20
> -	UNLEAK(buf);
> -	UNLEAK(ref);
> -	UNLEAK(reflog_msg);
> -	UNLEAK(msg);
> -	UNLEAK(err);
> -	return 0;
> +cleanup:
> +	strbuf_release(&buf);
> +	strbuf_release(&ref);
> +	strbuf_release(&reflog_msg);
> +	strbuf_release(&msg.buf);
> +	strbuf_release(&err);
> +	return ret;
>  }
