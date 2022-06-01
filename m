Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0473C43334
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 18:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbiFASck (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 14:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiFAScg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 14:32:36 -0400
Received: from nmsh5.e.nsc.no (nmsh5.e.nsc.no [148.123.160.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1849AE44B
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 11:32:34 -0700 (PDT)
Received: from [192.168.1.110] (unknown [194.19.73.58])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: joak-pet)
        by nmsh5.e.nsc.no (smtp.online.no) with ESMTPSA id 698925217A;
        Wed,  1 Jun 2022 20:32:32 +0200 (CEST)
Message-ID: <47ba2296-10f3-4590-dbf5-38d92ed3e29e@online.no>
Date:   Wed, 1 Jun 2022 20:32:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH] git-prompt: make colourization consistent
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20220601134414.66825-1-joak-pet@online.no>
 <xmqq7d60tfyd.fsf@gitster.g>
From:   Joakim Petersen <joak-pet@online.no>
In-Reply-To: <xmqq7d60tfyd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: 194.19.73.58
X-Scanned-By: MIMEDefang 2.84 on 10.123.160.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/06/2022 20:07, Junio C Hamano wrote:
> Hmph, am I correct to understand that the general flow of __git_ps1 is
> 
>   (1) various pieces of information like $h, $w, $i, $s, $r, $b, $p,
>       etc.  are declared "local" and values computed for them,
>       either inside __git_ps1() itself, or by various helper
>       functions it calls;
> 
>   (2) When GIT_PS1_SHOWCOLORHINTS is in effect, we may call the
>       __git_ps1_colorize_gitstring helper (which is touched by the
>       above hunk), that modifies these variables with color codes.
>       Upon entry to this helper function, these variables prepared in
>       (1) have no color effects.  Upon leaving, they do.
> 
>   (3) Finally, the PS1 is asseembled by concatenating these
>       variables, whose text was prepared in (1) and then prefixed by
>       color codes in (2), one of the earliest steps begins like so:
> 
>       local f="$h$w$i$s$u"
>       local gitstring="$c$b${f:+$z$f}${sparse}$r$p"
> 
> In the final step of formulation, $p immediately follows $r in the
> resulting $PS1, and the existing code at the end of the (2) prefixes
> $c_clear before $r, and $r before such prefixing is free of coloring,
> so it is curious how this patch makes difference (other than emitting
> $c_clear one more time).  Unless there is a use of $p that does not
> immediately follow $r, that is.
> 
> Thanks.
> 

Your understanding is correct for the flow before the change I
referenced (0ec7c23cdc6 (git-prompt: make upstream state
indicator location consistent, 2022-02-27)), however, that commit
changed the definition of $f and $gitstring to

	local f="$h$w$i$s$u$p"
	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}"

This makes it so $p is no longer immediately preceded by $r, but rather
$u, which, like all the preceding variables, except $h, will be
colourized if enabled.
