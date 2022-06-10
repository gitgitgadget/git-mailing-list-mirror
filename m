Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29D2C43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 00:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbiFJAFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 20:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbiFJAFx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 20:05:53 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB362FB413
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 17:05:52 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1CB9519B5E7;
        Thu,  9 Jun 2022 20:05:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8lLc+bqP8gt3iuA4iDbbQv2bm2ia+LZ1LJXir1
        LJCUc=; b=WNxGkbqsbP03qRIDW8nTRNx+mGfGRs6yPfRVagqihH8ZPgTgKM//se
        6pYQIk1s6joRUb6nqTtM03W6gGNe9pFeLZHPaZU90JWDvTneZWgSbvBCVe9l4u0R
        ka8RzfoY9iIQPzUpU0xVN6KIvpB/efV851y007BaFWFpC1d8I3lyE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 14E5419B5E6;
        Thu,  9 Jun 2022 20:05:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B586119B5E5;
        Thu,  9 Jun 2022 20:05:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joakim Petersen <joak-pet@online.no>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bo?= =?utf-8?Q?r?= 
        <szeder.dev@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] git-prompt: fix expansion of branch colour codes
References: <20220607115024.64724-1-joak-pet@online.no>
        <20220609204447.32841-1-joak-pet@online.no>
Date:   Thu, 09 Jun 2022 17:05:47 -0700
In-Reply-To: <20220609204447.32841-1-joak-pet@online.no> (Joakim Petersen's
        message of "Thu, 9 Jun 2022 22:44:47 +0200")
Message-ID: <xmqq4k0tgz6s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 153731AA-E851-11EC-B07B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joakim Petersen <joak-pet@online.no> writes:

> Because of the wrapping of the branch name variable $b, the colour codes
> in the variable don't get applied, but are instead printed directly in
> the output. Move the wrapping of $b to before colour codes are inserted
> to correct this.
>
> Signed-off-by: Joakim Petersen <joak-pet@online.no>
> ---
>  contrib/completion/git-prompt.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

t9903 seems to fail with this, though...?

> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index cb01c2fd5d..1435548e00 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -556,9 +556,14 @@ __git_ps1 ()
>  		fi
>  	fi
>  
> -	b=${b##refs/heads/}
>  	local z="${GIT_PS1_STATESEPARATOR-" "}"
>  
> +	b=${b##refs/heads/}
> +	if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
> +		__git_ps1_branch_name=$b
> +		b="\${__git_ps1_branch_name}"
> +	fi
> +
>  	# NO color option unless in PROMPT_COMMAND mode or it's Zsh
>  	if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
>  		if [ $pcmode = yes ] || [ -n "${ZSH_VERSION-}" ]; then
> @@ -566,11 +571,6 @@ __git_ps1 ()
>  		fi
>  	fi
>  
> -	if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
> -		__git_ps1_branch_name=$b
> -		b="\${__git_ps1_branch_name}"
> -	fi
> -
>  	local f="$h$w$i$s$u$p"
>  	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}"
>  
>
> base-commit: 9470605a1b03dac8fc4f801132e36964b4fbb8c3
