Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702EFC433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 05:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiDVFwS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 01:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiDVFwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 01:52:16 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BB74F46E
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 22:49:21 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 275BB19ADDA;
        Fri, 22 Apr 2022 01:49:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dlA5s5p0XpNm
        8te9Ru9g4r8MvweRug30fli5Tckeves=; b=U0MB5NrIuIRI6cA1CNL4FPPxD7IP
        gTqgRllGUexijs/9/l7PFg0C1F3K2Gs0EjQitd0g6SMIi0UjoL88DrIcZjS0M2bJ
        cAJawoIUAKH0yc2iWRY2LdWYm40fOIaKBVRpBM0q6HpsVr4qr/2F9yB3kwfkSuTZ
        Y5QDNRZWUmIcA7k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1282619ADD9;
        Fri, 22 Apr 2022 01:49:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 889CA19ADD8;
        Fri, 22 Apr 2022 01:49:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2 1/2] ci: make failure to find perforce more user
 friendly
References: <20220421225515.6316-1-carenas@gmail.com>
        <20220422013911.7646-1-carenas@gmail.com>
        <20220422013911.7646-2-carenas@gmail.com>
Date:   Thu, 21 Apr 2022 22:49:16 -0700
In-Reply-To: <20220422013911.7646-2-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Thu, 21 Apr 2022 18:39:10 -0700")
Message-ID: <xmqqo80td5wj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F2C92406-C1FF-11EC-909A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> In preparation for a future change that will make perforce installation
> optional in macOS, make sure that the check for it is done without
> triggering scary looking errors and add a user friendly message instead=
.
>
> Only one invocation of type is changed as that is what is only needed
> for the expected future use case, and because `type` is recommended in
> the CodingGuidelines, so changing that recommendation or a more complex
> change has been specifically punted.

This may be in the "POSIX may say this but the real world may not
work that way" territory.  As far as I can tell, "command -v" [*1*]
and "type" [*2*] both ought to give diagnostic messages to their
standard error stream, and they both should signal an error with
non-zero exit status.  It may be that the shell implementation you
have tried had "command -v" that is less noisy than "type" when
given a command that is not installed, but I wonder if the next
shell implementation you find has "command -v" that is as noisy and
scary as "type", in which case this patch amounts to a no-op.

I wonder if "type p4d >/dev/null 2>/dev/null" (or "command -v" with
the same) is a more futureproof fix.


[References]

*1* https://pubs.opengroup.org/onlinepubs/9699919799/utilities/command.ht=
ml
*2* https://pubs.opengroup.org/onlinepubs/9699919799/utilities/type.html

> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  ci/install-dependencies.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index dbcebad2fb2..6de20108775 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -78,12 +78,14 @@ linux-gcc-default)
>  	;;
>  esac
> =20
> -if type p4d >/dev/null && type p4 >/dev/null
> +if command -v p4d >/dev/null && type p4 >/dev/null
>  then
>  	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
>  	p4d -V | grep Rev.
>  	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
>  	p4 -V | grep Rev.
> +else
> +	echo "WARNING: perforce wasn't installed, see above for clues why"
>  fi
>  if type git-lfs >/dev/null
>  then
