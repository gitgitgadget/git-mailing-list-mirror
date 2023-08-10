Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD91FC001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 01:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjHJBFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 21:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjHJBFg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 21:05:36 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FE51982
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 18:05:35 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 43C6618B94B;
        Wed,  9 Aug 2023 21:05:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PrJaQl/kS5uR9Ca0fd97tuVItAN694CcXW4yC5
        gDYC8=; b=qxJrSHzQUuZcqi5+IUSLMHudPF1RPnaDKen7k2eDsnHawCFJI4J0cp
        qCa1MQUedIqMS59NiWy+rdgP4N2a3V9Vk5ZWAKhV4zS8/LLeOHUoXK/5ymekmC5A
        goMglAOUeiYA2QHc9ab8y46HWyBxOSd/947oVecjacaBm0YSG4qjo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3BAAE18B949;
        Wed,  9 Aug 2023 21:05:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9F37918B948;
        Wed,  9 Aug 2023 21:05:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wesley Schwengle <wesleys@opperschaap.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix bug when more than one readline instance is used
References: <20230810003939.1420306-1-wesleys@opperschaap.net>
Date:   Wed, 09 Aug 2023 18:05:33 -0700
In-Reply-To: <20230810003939.1420306-1-wesleys@opperschaap.net> (Wesley
        Schwengle's message of "Wed, 9 Aug 2023 20:39:33 -0400")
Message-ID: <xmqqil9nk8pu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0290009A-371A-11EE-BD0A-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wesley Schwengle <wesleys@opperschaap.net> writes:

If I recall correctly, this was fixed by Peff yesterday?  

https://lore.kernel.org/git/20230808181531.GB2097200@coredump.intra.peff.net/

> diff --git a/git-send-email.perl b/git-send-email.perl
> index affbb88509..7fdcf9084a 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -971,8 +971,10 @@ sub get_patch_subject {
>  	do_edit(@files);
>  }
>  
> +my $term;
>  sub term {
> -	my $term = eval {
> +	return $term if $term;
> +	$term = eval {
>  		require Term::ReadLine;
>  		$ENV{"GIT_SEND_EMAIL_NOTTY"}
>  			? Term::ReadLine->new('git-send-email', \*STDIN, \*STDOUT)

The patch I queued yesterday wraps this lexical inside another block
to hide it from the outside, but otherwise it should achieve the
same goal.
