Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372EEC2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 18:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAAB120663
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 18:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="btAg3/iI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgKISfc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 13:35:32 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56837 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgKISfc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 13:35:32 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B1FFBFD3BA;
        Mon,  9 Nov 2020 13:35:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2GIMwGOXyNKM
        DVCEXABOtZqMR7g=; b=btAg3/iIpg11OSOkFqw2BTSbGBt5GY5ZhuZ7783O4otg
        CzCoWVQ+aTgq9vGQEGRR3/OQ6gPgEbGHf6liAVDymkud0YQ6OtL/zz3+enXoQ6a9
        OkuK8GQup4VjnRE1z3sDQ5K00D59IV6vdl2dKaChtpPEsnjIpq6fw7rDAYxuOyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ORlqOK
        M+6yTVH/oT0I3u4XDMnETFkL20Ki7sUbecFVjFfYQ0lI5m/dX1N/SFn5fV1EWlv0
        hY1HtvVJjNEbkZbpdrueFi8vcHHZAOPsyeRD42VkRrbo89w6CCyG75MFfy495M46
        sTbNLSYlcxBCTeUkC1e3YeBfMYCsuHJW2xE6I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A89E0FD3B9;
        Mon,  9 Nov 2020 13:35:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D040BFD3B8;
        Mon,  9 Nov 2020 13:35:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] archive: support compression levels beyond 9
References: <96e6e2ce-fc7b-1e73-0112-93589b28506d@web.de>
Date:   Mon, 09 Nov 2020 10:35:26 -0800
In-Reply-To: <96e6e2ce-fc7b-1e73-0112-93589b28506d@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 9 Nov 2020 17:05:31 +0100")
Message-ID: <xmqq7dqucr9t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 56B1BCB2-22BA-11EB-A95D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Compression programs like zip, gzip, bzip2 and xz allow to adjust the
> trade-off between CPU cost and size gain with numerical options from -1
> for fast compression and -9 for high compression ratio.  zip also
> accepts -0 for storing files verbatim.  git archive directly support
> these single-digit compression levels for ZIP output and passes them to
> filters like gzip.
>
> Zstandard additionally supports compression level options -10 to -19, o=
r
> up to -22 with --ultra.  This *seems* to work with git archive in most
> cases, e.g. it will produce an archive with -19 without complaining, bu=
t
> since it only supports single-digit compression level options this is
> the same as -1 -9 and thus -9.
>
> Allow git archive to accept multi-digit compression levels to support
> the full range supported by zstd.  Explicitly reject them for the ZIP
> format, as otherwise deflateInit2() would just fail with a somewhat
> cryptic "stream consistency error".

The implementation looks more like "not enable them for the ZIP
format", but the symptom observable to end-users is exactly
"explicitly reject", so that's OK ;-)

As with the usual compression levels, this is only about how
deflator finds a better results, and the stream is understandable by
any existing inflator, right?

> diff --git a/archive.h b/archive.h
> index 82b226011a..e3d04e8ab3 100644
> --- a/archive.h
> +++ b/archive.h
> @@ -36,6 +36,7 @@ const char *archive_format_from_filename(const char *=
filename);
>
>  #define ARCHIVER_WANT_COMPRESSION_LEVELS 1
>  #define ARCHIVER_REMOTE 2
> +#define ARCHIVER_HIGH_COMPRESSION_LEVELS 4
>  struct archiver {
>  	const char *name;
>  	int (*write_archive)(const struct archiver *, struct archiver_args *)=
;
> diff --git a/archive-tar.c b/archive-tar.c
> index f1a1447ebd..a971fdc0f6 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -374,7 +374,8 @@ static int tar_filter_config(const char *var, const=
 char *value, void *data)
>  		ar =3D xcalloc(1, sizeof(*ar));
>  		ar->name =3D xmemdupz(name, namelen);
>  		ar->write_archive =3D write_tar_filter_archive;
> -		ar->flags =3D ARCHIVER_WANT_COMPRESSION_LEVELS;
> +		ar->flags =3D ARCHIVER_WANT_COMPRESSION_LEVELS |
> +			    ARCHIVER_HIGH_COMPRESSION_LEVELS;

Nice. =20

Hindsight tells me that WANT should have been ACCEPT, though---and
an addition of ARCHIVER_ACCEPT_HIGH_COMPRESSION_LEVELS would be in
line with that.  But that probably is too minor---it just stood out
a bit funny to me.

> diff --git a/archive.c b/archive.c
> index 3c1541af9e..7a888c5338 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -529,10 +529,12 @@ static int add_file_cb(const struct option *opt, =
const char *arg, int unset)
>  	return 0;
>  }
>
> -#define OPT__COMPR(s, v, h, p) \
> -	OPT_SET_INT_F(s, NULL, v, h, p, PARSE_OPT_NONEG)
> -#define OPT__COMPR_HIDDEN(s, v, p) \
> -	OPT_SET_INT_F(s, NULL, v, "", p, PARSE_OPT_NONEG | PARSE_OPT_HIDDEN)
> +static int number_callback(const struct option *opt, const char *arg, =
int unset)
> +{
> +	BUG_ON_OPT_NEG(unset);
> +	*(int *)opt->value =3D strtol(arg, NULL, 10);
> +	return 0;
> +}
>
>  static int parse_archive_args(int argc, const char **argv,
>  		const struct archiver **ar, struct archiver_args *args,
> @@ -561,16 +563,8 @@ static int parse_archive_args(int argc, const char=
 **argv,
>  		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
>  			N_("read .gitattributes in working directory")),
>  		OPT__VERBOSE(&verbose, N_("report archived files on stderr")),
> -		OPT__COMPR('0', &compression_level, N_("store only"), 0),
> -		OPT__COMPR('1', &compression_level, N_("compress faster"), 1),
> -		OPT__COMPR_HIDDEN('2', &compression_level, 2),
> -		OPT__COMPR_HIDDEN('3', &compression_level, 3),
> -		OPT__COMPR_HIDDEN('4', &compression_level, 4),
> -		OPT__COMPR_HIDDEN('5', &compression_level, 5),
> -		OPT__COMPR_HIDDEN('6', &compression_level, 6),
> -		OPT__COMPR_HIDDEN('7', &compression_level, 7),
> -		OPT__COMPR_HIDDEN('8', &compression_level, 8),
> -		OPT__COMPR('9', &compression_level, N_("compress better"), 9),
> +		OPT_NUMBER_CALLBACK(&compression_level,
> +			N_("set compression level"), number_callback),

Doubly nice.  Adds a feature while removing lines. =20

Do we miss the description given in "git archive -h" though?

    usage: git archive [<options>] <tree-ish> [<path>...]
       or: git archive --list
       ...
        -v, --verbose         report archived files on stderr
        -0                    store only
        -1                    compress faster
        -9                    compress better

