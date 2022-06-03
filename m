Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A401C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 17:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242907AbiFCRXi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 13:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344403AbiFCRXh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 13:23:37 -0400
Received: from nmsh5.e.nsc.no (nmsh5.e.nsc.no [148.123.160.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ACC52B12
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 10:23:30 -0700 (PDT)
Received: from [192.168.1.110] (unknown [194.19.73.58])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: joak-pet)
        by nmsh5.e.nsc.no (smtp.online.no) with ESMTPSA id 2FA8E520FA;
        Fri,  3 Jun 2022 19:23:28 +0200 (CEST)
Message-ID: <7d391d82-b15e-4a31-5207-c4037fec0bf9@online.no>
Date:   Fri, 3 Jun 2022 19:23:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] git-prompt: make colourization consistent
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
References: <20220602145935.10512-1-joak-pet@online.no>
 <20220603142521.42863-1-joak-pet@online.no> <xmqqy1ydhfcc.fsf@gitster.g>
From:   Joakim Petersen <joak-pet@online.no>
In-Reply-To: <xmqqy1ydhfcc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: 194.19.73.58
X-Scanned-By: MIMEDefang 2.84 on 10.123.160.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/06/2022 18:38, Junio C Hamano wrote:
> This is not a new issue, but seeing this:
> 
>   	if [ $detached = no ]; then
>   		branch_color="$ok_color"
>   	else
>   		branch_color="$bad_color"
>   	fi
>   	c="$branch_color$c"
>   
>   	z="$c_clear$z"
>   	if [ "$w" = "*" ]; then
>   		w="$bad_color$w"
>   	fi
>   	if [ -n "$i" ]; then
>   		i="$ok_color$i"
>   	fi
>   	if [ -n "$s" ]; then
>   		s="$flags_color$s"
>   	fi
>   	if [ -n "$u" ]; then
>   		u="$bad_color$u"
>   	fi
> +	if [ -n "$p" ]; then
> +		p="$c_clear$p"
> +	fi
> +	if [ -n "$sparse" ]; then
> +		sparse="$c_clear$sparse"
> +	fi
>   	r="$c_clear$r"
>   }
> 
> it makes me wonder if the more forward looking and future-proof way
> that is resistant to any future and random reshuffling like what
> 0ec7c23c (git-prompt: make upstream state indicator location
> consistent, 2022-02-27) did would be to make it a rule to maintain
> that there is no coloring by default, and when any of these tokens
> like w, i, s, ... are not empty, enclose them inside "color-on" and
> "color-off" sequence.
> 
> For example,
> 
>   	if [ "$w" = "*" ]; then
>   		w="$bad_color$w"
>   	fi
> 
> would mean $w, when it is "*", would cause gitstring to contain an
> asterisk that is painted in $bad_color, but ALSO causes whatever
> that happens to come AFTER $w in gitstring to be painted in the same
> color UNLESS it tries to protect itself.  Right now, $w may be
> immediately followed by $i, and $i does protect itself by prefixing
> with $ok_color, but if $i is empty, $w's coloring will extend to $s.
> 
> So, if we did this instead:
> 
> - 	z="$c_clear$z"
>   	if [ "$w" = "*" ]; then
> - 		w="$bad_color$w"
> + 		w="$bad_color$w$c_clear"
>   	fi
> 
> and make similar changes to everything else we see above, we
> probably can lose the ones that prefix with $c_clear, because each
> token that paints itself in unusual color is now responsible for
> returning the terminal state to normal with the $c_clear sequence
> after it is done with it.  We do not have to special case sparse, p,
> or r in this helper function at all if we go that route, no?
> 
> If the helper were written that way, then reshuffling the order of
> the tokens done in 0ec7c23c (git-prompt: make upstream state
> indicator location consistent, 2022-02-27) wouldn't have made the
> patch under discussion necessary at all, which is what I see is
> valuable from the "maintainability" point of view.
> 

That does seem like a much better idea for maintainability, I can
change the patch to do this instead. I have one question, though: the
sequence $c$b (bare state and branch name) is a special case, where
they're intended to have the same colour, should I wrap both in colour
set, colour clear, or only clear after $b? The former requires rewriting
the tests or changing $gitstring to not include $c when $c is empty,
while the latter keeps the tests unchanged, but may pose a problem if
"BARE:" should at any point not appear immediately before the branch
name.
