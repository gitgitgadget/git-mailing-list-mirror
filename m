Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DF8C433EF
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 22:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E93C60F23
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 22:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhJWWV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 18:21:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57915 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhJWWVx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 18:21:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EC55FEBDC;
        Sat, 23 Oct 2021 18:19:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hG4m/SmqD1zY
        DXzCAHm6+tqgWpjgJ3BjWtQsWQar0cQ=; b=mohaqC7QXNk0X4SWCc336UZCtu4N
        ME9sikRo1T1Fk591TkEpoVbG8uHt/PoNEKwI4m/2o8sCqtrNHHJknCEGSNBR9Tgd
        EK+E9H2k30V31SZy9lk/Zi2A1kB/Eg3K7/zkOIIXwClIfZb/N9qhpGxCIBpRWPoB
        uUu8rIOuhNbPSp4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 74B3DFEBDB;
        Sat, 23 Oct 2021 18:19:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C665CFEBDA;
        Sat, 23 Oct 2021 18:19:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 09/10] generate-cmdlist.sh: replace "grep' invocation
 with a shell version
References: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
        <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
        <patch-v2-09.10-7903dd1f8c2-20211022T193027Z-avarab@gmail.com>
Date:   Sat, 23 Oct 2021 15:19:30 -0700
In-Reply-To: <patch-v2-09.10-7903dd1f8c2-20211022T193027Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 22 Oct
 2021 21:36:13
        +0200")
Message-ID: <xmqqcznv9yfh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4BAD2C32-344F-11EC-B4C0-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Replace the "grep" we run to exclude certain programs from the
> generated output with a pure-shell loop that strips out the comments,
> and sees if the "cmd" we're reading is on a list of excluded
> programs. This uses a trick similar to test_have_prereq() in
> test-lib-functions.sh.
>
> On my *nix system this makes things quite a bit slower compared to
> HEAD~, but since the generate-cmdlist.sh is already quite fast, and
> this likely helps systems where command invocations are more
> expensive (i.e. Windows) let's use this anyway.
>
>   'sh generate-cmdlist.sh.old command-list.txt' ran
>     1.56 =C2=B1 0.11 times faster than 'sh generate-cmdlist.sh command-=
list.txt'
>    18.00 =C2=B1 0.19 times faster than 'sh generate-cmdlist.sh.master c=
ommand-list.txt'
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  generate-cmdlist.sh | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> index 9b7d6aea629..2b184bbc65f 100755
> --- a/generate-cmdlist.sh
> +++ b/generate-cmdlist.sh
> @@ -6,12 +6,27 @@ die () {
>  }
> =20
>  command_list () {
> -	eval "grep -ve '^#' $exclude_programs" <"$1"
> +	while read cmd rest
> +	do
> +		case "$cmd" in
> +		"#"*)
> +			continue;
> +			;;
> +		*)
> +			case "$exclude_programs" in
> +				*":$cmd:"*)
> +				;;

Funny indentation.

> +			*)
> +				echo "$cmd $rest"
> +				;;
> +			esac
> +		esac
> +	done
>  }

>  category_list () {
> -	command_list "$1" |
> +	command_list <"$1" |

This change is unnecessary if you did

	while read cmd rest
	do
		...
	done <"$1"

to keep the external interface to the command_list helper unchanged.

> -	cut -c 40- |
> +	cut -d' ' -f2- |

Is this just a subjective preference or a logical consequence of how
the output from command_list looks like got somehow changed?

> @@ -48,7 +63,7 @@ define_category_names () {
>  print_command_list () {
>  	echo "static struct cmdname_help command_list[] =3D {"
> =20
> -	command_list "$1" |
> +	command_list <"$1" |

Ditto.

> -exclude_programs=3D
> +exclude_programs=3D:
>  while test "--exclude-program" =3D "$1"
>  do
>  	shift
> -	exclude_programs=3D"$exclude_programs -e \"^$1 \""
> +	exclude_programs=3D"$exclude_programs$1:"
>  	shift
>  done
