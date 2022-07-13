Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC78C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 21:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbiGMVyb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 17:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiGMVy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 17:54:29 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EA041980
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 14:54:28 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E9F881B6770;
        Wed, 13 Jul 2022 17:54:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zcYdf6gzEAKnIfDDfyOi4ofkLCP3wh0rSjma0Q
        r2NOo=; b=sUGqasaz1ReZKUn42+/v/7XyE3akQ3krvFtEfR33TwTlDu85IBwzir
        gCk/6TWEtPYbBMHbm23dWF6CYP/u/La0bfqphJJcF1kotxM12O/OTCZsfO1c20u+
        HKrwQZvYgORj+uRH/WZ5WIiOS8jll3WoDK6UE81A3+Ldq3i3sVRok=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E23A91B676F;
        Wed, 13 Jul 2022 17:54:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 976A11B676E;
        Wed, 13 Jul 2022 17:54:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] mergetool(vimdiff): allow paths to contain spaces again
References: <pull.1287.git.1657726969774.gitgitgadget@gmail.com>
        <xmqq7d4gbu10.fsf@gitster.g> <Ys86MnwhembiXRxj@zacax395.localdomain>
Date:   Wed, 13 Jul 2022 14:54:23 -0700
In-Reply-To: <Ys86MnwhembiXRxj@zacax395.localdomain> (Fernando Ramos's message
        of "Wed, 13 Jul 2022 23:33:38 +0200")
Message-ID: <xmqqr12oadbk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BF4ABF8-02F6-11ED-B7CE-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fernando Ramos <greenfoo@u92.eu> writes:

> On 22/07/13 02:08PM, Junio C Hamano wrote:
>> 
>> I think s/1/true/ or something is in order, perhaps?
>> 
>
> Yes. I was just looking into that.
>
> For one, as you said, "1" should be "true". That also changes the expected
> output.

OK, because "1" fails to execute, the expected output Dscho had
(which is for the case without base) would become invalid when we
use "true".

Perhaps we should use "false" instead?  Or do we need to test both?

> Then, in addition, the expected output needs to be re-adjusted once again if we
> plan to apply this patch on top of the other one from two days ago (the one that
> adds the "leftabove" keyword to split subcommands).

> After these changes, this is how the original patch from Johannes needs to be
> updated:
>
>
> diff --git a/mergetools/vimdiff b/mergetools/vimdiff
> index 56516ae271..3046dcd0dc 100644
> --- a/mergetools/vimdiff
> +++ b/mergetools/vimdiff
> @@ -623,7 +623,7 @@ run_unit_tests () {
>  		done
>  	}
>  
> -	base_present=1
> +	base_present=true
>  	LOCAL='lo cal'
>  	BASE='ba se'
>  	REMOTE="' '"
> @@ -635,10 +635,11 @@ run_unit_tests () {
>  	cat >expect <<-\EOF
>  	-f
>  	-c
> -	echo | split | vertical split | 1b | wincmd l | vertical split | quit | wincmd l | 2b | wincmd j | 3b | tabdo windo diffthis
> +	echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis
>  	-c
>  	tabfirst
>  	lo cal
> +	ba se
>  	' '
>  	mer ged
>  	EOF
