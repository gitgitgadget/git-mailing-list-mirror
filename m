Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63229C43334
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 18:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351478AbiFASIE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 14:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244739AbiFASIB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 14:08:01 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087BF30F4C
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 11:07:59 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 69ECC1A7055;
        Wed,  1 Jun 2022 14:07:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DTN0RwvXOxWBNop+Oij4ReiRJW0IuNmeQVDt/M
        u5N9U=; b=Dhtn9zLajHl/H4Lqgh6NmrMnj50+IR321iixixKMg6k9n2vwSnT8Ip
        5X1petNMJFhoXB69v+17WumZB6C+ixBf1COt9SZc8L5lPfqT9A14pcltaA6awla6
        dzXEY4tMAeFh35K42sr8PEF+4U01mIxB8c65UCJ0y+LkuDCgGjtyo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 608DB1A7054;
        Wed,  1 Jun 2022 14:07:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0A9471A7053;
        Wed,  1 Jun 2022 14:07:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joakim Petersen <joak-pet@online.no>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] git-prompt: make colourization consistent
References: <20220601134414.66825-1-joak-pet@online.no>
Date:   Wed, 01 Jun 2022 11:07:54 -0700
In-Reply-To: <20220601134414.66825-1-joak-pet@online.no> (Joakim Petersen's
        message of "Wed, 1 Jun 2022 15:44:14 +0200")
Message-ID: <xmqq7d60tfyd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C32F56C0-E1D5-11EC-9B31-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joakim Petersen <joak-pet@online.no> writes:

> The short upstream state indicator inherits the colour of the last short
> state indicator before it (if there is one), and the sparsity state
> indicator inherits this colour as well. Make the colourization of these
> state indicators consistent by clearing any colour before printing the
> short upstream state indicator, as this immediately follows the last
> coloured indicator.
>
> Signed-off-by: Joakim Petersen <joak-pet@online.no>
> ---

> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 87b2b916c0..dfd6cef35f 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -286,6 +286,7 @@ __git_ps1_colorize_gitstring ()
>  	if [ -n "$u" ]; then
>  		u="$bad_color$u"
>  	fi
> +	p="$c_clear$p"
>  	r="$c_clear$r"
>  }

Hmph, am I correct to understand that the general flow of __git_ps1 is 

 (1) various pieces of information like $h, $w, $i, $s, $r, $b, $p,
     etc.  are declared "local" and values computed for them,
     either inside __git_ps1() itself, or by various helper
     functions it calls;

 (2) When GIT_PS1_SHOWCOLORHINTS is in effect, we may call the
     __git_ps1_colorize_gitstring helper (which is touched by the
     above hunk), that modifies these variables with color codes.
     Upon entry to this helper function, these variables prepared in
     (1) have no color effects.  Upon leaving, they do.

 (3) Finally, the PS1 is asseembled by concatenating these
     variables, whose text was prepared in (1) and then prefixed by
     color codes in (2), one of the earliest steps begins like so:

     local f="$h$w$i$s$u"
     local gitstring="$c$b${f:+$z$f}${sparse}$r$p"

In the final step of formulation, $p immediately follows $r in the
resulting $PS1, and the existing code at the end of the (2) prefixes
$c_clear before $r, and $r before such prefixing is free of coloring,
so it is curious how this patch makes difference (other than emitting
$c_clear one more time).  Unless there is a use of $p that does not
immediately follow $r, that is.

Thanks.
