Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3DBCCA47A
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 21:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379028AbiFPVJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 17:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378803AbiFPVJT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 17:09:19 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EA760B83
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 14:09:17 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E18D312AD5F;
        Thu, 16 Jun 2022 17:09:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VCfMYEafMijWFhgXgQPM90L8g9SDEyCLW8WUbG
        hu5zE=; b=ElCUciI0XrJvoASlNAhBZAb16dX0/cf4dcifdD23l9yd1vJgdW+V1o
        kR/LgW/j7rykvRZDCmypY8q0ZkyWMFalB2s+VowhqUd+SYpYW1pVzAaAEpSzqLsR
        UlsM+TnuT1HlVm43c3mx3U9HYWrQUqa81uLKBuqmtsRD9pfK2/YFQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D8BD112AD5E;
        Thu, 16 Jun 2022 17:09:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4290D12AD5D;
        Thu, 16 Jun 2022 17:09:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 1/5] t5505: remove sub shell use in favor of git -C
References: <20220616205456.19081-1-jacob.e.keller@intel.com>
        <20220616205456.19081-2-jacob.e.keller@intel.com>
Date:   Thu, 16 Jun 2022 14:09:15 -0700
In-Reply-To: <20220616205456.19081-2-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Thu, 16 Jun 2022 13:54:52 -0700")
Message-ID: <xmqq8rpws4ck.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94812EEA-EDB8-11EC-B064-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

>  check_remote_track () {
> -	actual=$(git remote show "$1" | sed -ne 's|^    \(.*\) tracked$|\1|p')
> +	actual=$(git -C test remote show "$1" | sed -ne 's|^    \(.*\) tracked$|\1|p')

This has become less generic.

>  	shift &&
>  	tokens_match "$*" "$actual"
>  }
>  
>  check_tracking_branch () {
>  	f="" &&
> -	r=$(git for-each-ref "--format=%(refname)" |
> +	r=$(git -C test for-each-ref "--format=%(refname)" |
>  		sed -ne "s|^refs/remotes/$1/||p") &&

Likewise.

They used to be usable in any test repository, but now they have to
be used in a repository whose name is "test".

I wonder if something like

	check_foo () {
		if test "$1" = -C
		then
			in_repo=$2
			shift 2
		else
			in_repo=
		fi &&
		actual=$(git ${in_repo:+-C "$in_repo"} subcmd ...) &&
		do things ... &&
		do more things
	}

would work better?  

> @@ -44,10 +44,7 @@ check_tracking_branch () {
>  test_expect_success setup '
>  	setup_repository one &&
>  	setup_repository two &&
> -	(
> -		cd two &&
> -		git branch another
> -	) &&
> +	git -C two branch another &&
>  	git clone one test
>  '

Clear improvement.

> @@ -57,25 +54,19 @@ test_expect_success 'add remote whose URL agrees with url.<...>.insteadOf' '
>  '
>  
>  test_expect_success 'remote information for the origin' '
> -	(
> -		cd test &&
> -		tokens_match origin "$(git remote)" &&
> -		check_remote_track origin main side &&
> -		check_tracking_branch origin HEAD main side
> -	)
> +	tokens_match origin "$(git -C test remote)" &&

This is a clear improvement.

> +	check_remote_track origin main side &&
> +	check_tracking_branch origin HEAD main side

These two are a bit questionable (it hides the fact that all these
names refer to stuff in "test" subdirectory).

