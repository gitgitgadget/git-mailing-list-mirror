Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EDAC48BE8
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 04:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21604601FC
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 04:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhFNEyv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 00:54:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62451 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhFNEyv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 00:54:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EDF3914CECE;
        Mon, 14 Jun 2021 00:52:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+JlSQ0j4Z2bToa76tq3IaOgjwsRA117swltQf8
        IbfTE=; b=RF7/jQSKutqzh+DmIRjSzeBBtl6S1ffiV6Rc2bVb/tpv0FbJMSNTuP
        31QRzbh6tll6KbA5VJ63L/didqxXrT0BlTQL9ckDOjFLEv14hjYEQDb/AyLkgWmp
        rBtxR7WMfW3QoF+IW3X/lH/DZ3+EafHG6aJbOSNrzG9DH4Wh4I5kk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E80EC14CECC;
        Mon, 14 Jun 2021 00:52:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3A55514CECB;
        Mon, 14 Jun 2021 00:52:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] t7400-submodule-basic: modernize inspect() helper
References: <20210611225428.1208973-1-emilyshaffer@google.com>
        <20210611225428.1208973-2-emilyshaffer@google.com>
Date:   Mon, 14 Jun 2021 13:52:44 +0900
In-Reply-To: <20210611225428.1208973-2-emilyshaffer@google.com> (Emily
        Shaffer's message of "Fri, 11 Jun 2021 15:54:25 -0700")
Message-ID: <xmqq5yyhyrmr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C849E72-CCCC-11EB-B8E4-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Since the inspect() helper in the submodule-basic test suite was
> written, 'git -C <dir>' was added. By using -C, we no longer need a
> reference to the base directory for the test. This simplifies callsites,
> and will make the addition of other arguments in later patches more
> readable.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  t/t7400-submodule-basic.sh | 37 +++++++++++++++----------------------
>  1 file changed, 15 insertions(+), 22 deletions(-)
>
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index a924fdb7a6..f5dc051a6e 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -107,25 +107,18 @@ test_expect_success 'setup - repository to add submodules to' '
>  # generates, which will expand symbolic links.
>  submodurl=$(pwd -P)
>  
> -listbranches() {
> -	git for-each-ref --format='%(refname)' 'refs/heads/*'
> -}
> -
>  inspect() {
>  	dir=$1 &&
> -	dotdot="${2:-..}" &&
>  
> -	(
> -		cd "$dir" &&
> -		listbranches >"$dotdot/heads" &&
> -		{ git symbolic-ref HEAD || :; } >"$dotdot/head" &&
> -		git rev-parse HEAD >"$dotdot/head-sha1" &&
> -		git update-index --refresh &&
> -		git diff-files --exit-code &&
> -		git clean -n -d -x >"$dotdot/untracked"
> -	)
> +	git -C "$dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
> +	{ git -C "$dir" symbolic-ref HEAD || :; } >head &&
> +	git -C "$dir" rev-parse HEAD >head-sha1 &&
> +	git -C "$dir" update-index --refresh &&
> +	git -C "$dir" diff-files --exit-code &&
> +	git -C "$dir" clean -n -d -x >untracked
>  }

Quite straight-forward.

> -	inspect addtest/submod ../.. &&
> +	inspect addtest/submod &&

And specifically the losing ../.. is pleasing to the eye, especially
because the old "dotdot" thing was mechanically computable from "dir".

Nicely done.
