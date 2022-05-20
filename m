Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC24C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 04:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbiETE1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 00:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiETE1f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 00:27:35 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38B2954B9
        for <git@vger.kernel.org>; Thu, 19 May 2022 21:27:33 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 374EC1970D8;
        Fri, 20 May 2022 00:27:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vl31yUX8D2No
        g3zBHs6Bpw9smiD1V9HjQih+fdPXqgM=; b=k29pyTNj0avlagahm68x9/IpUbAJ
        4klLW5jiHPINoTEgGwQ6iR2INdwebP2UMTqUG/JoVtf9aoWYXMIeUgcbPRnUZ19x
        ltgK1744SsUnpkAU8clTPwaMBidFancV/RPvW+KlO67CotEYY+BxRKMGUPA4GqbS
        p7vn5Fvo0Wlyd7s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 310C11970D6;
        Fri, 20 May 2022 00:27:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.111.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D53371970D5;
        Fri, 20 May 2022 00:27:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [RFC PATCH 2/2] object-file API: have unpack_loose_header()
 return "int" again
References: <377be0e9-8a0f-4a86-0a66-3b08c0284dae@github.com>
        <RFC-cover-0.2-00000000000-20220519T195055Z-avarab@gmail.com>
        <RFC-patch-2.2-af0dfd017af-20220519T195055Z-avarab@gmail.com>
Date:   Thu, 19 May 2022 21:27:28 -0700
In-Reply-To: <RFC-patch-2.2-af0dfd017af-20220519T195055Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 19 May
 2022 22:09:17
        +0200")
Message-ID: <xmqq35h4ltfz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 29247A9A-D7F5-11EC-AC22-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +int unpack_loose_header(git_zstream *stream, unsigned char *map,
> +			unsigned long mapsize, void *buffer,
> +			unsigned long bufsiz, struct strbuf *header);

Simpler is better as long as we don't make it too simple ;-)

>  	if (!header)
> -		return ULHR_TOO_LONG;
> +		return error(_("header too long, exceeds %d bytes"),
> +			     MAX_HEADER_LEN);

OK.

> -	return ULHR_BAD;
> +	return error(_("could not find end of corrupt long header"));
>  }

OK.

> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index dadf3b14583..d742697d3bf 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -536,12 +536,14 @@ do
>  			if test "$arg2" =3D "-p"
>  			then
>  				cat >expect <<-EOF
> -				error: header for $bogus_long_sha1 too long, exceeds 32 bytes
> +				error: header too long, exceeds 32 bytes
> +				error: unable to unpack $bogus_long_sha1 header
>  				fatal: Not a valid object name $bogus_long_sha1
>  				EOF
>  			else
>  				cat >expect <<-EOF
> -				error: header for $bogus_long_sha1 too long, exceeds 32 bytes
> +				error: header too long, exceeds 32 bytes
> +				error: unable to unpack $bogus_long_sha1 header
>  				fatal: git cat-file: could not get object info
>  				EOF
>  			fi &&

Looking good.

