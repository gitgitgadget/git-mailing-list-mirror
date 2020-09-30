Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71705C4727C
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 19:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10F5C20719
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 19:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FqYMAnIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgI3TYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 15:24:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54467 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgI3TYM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 15:24:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4CA2F10172E;
        Wed, 30 Sep 2020 15:24:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gioNZNZjmaAHdQNSF8tNBFvKfm8=; b=FqYMAn
        Ig5DMXg0oOSNJT+rhD+eXHC9HFmFVepU7eW6IJjuRc2KoY5DWV3jSaek8LvIT/e4
        6WObJei6A4lsD6sc9e5Fzhi/JZbesaR/fMvQWSgCEZLGUhrLUE1WgHAde8wSEJbh
        0bMRkBOq7JO/Ks5ZML409G4xxoRZlJQiBgNJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Uo7FXLDYPvF/SOz+cZwdhKJ6d2UFId/4
        eCMhWDXbRLAnJv6Db5nj1hyt4haQmvzPVhik4KMZPWxh7MP+fLgWC4LBJNpU+1bI
        VhXUhAlePYa/lFptIYprNL+3UgH0z2gfH8fj4MB47kYDrKDuNl29Rj43Lu53fxL5
        a1wMItGkAtU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4535010172D;
        Wed, 30 Sep 2020 15:24:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7E2C710172C;
        Wed, 30 Sep 2020 15:24:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Theodore Dubois <tbodt@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Propagate --quiet on submodule update to merge/rebase
References: <20200930074729.99629-1-tbodt@google.com>
Date:   Wed, 30 Sep 2020 12:24:04 -0700
In-Reply-To: <20200930074729.99629-1-tbodt@google.com> (Theodore Dubois's
        message of "Wed, 30 Sep 2020 00:47:30 -0700")
Message-ID: <xmqqft6zgjaj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81D43F78-0352-11EB-9611-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Theodore Dubois <tbodt@google.com> writes:

> Without this, commands such as
> git pull --rebase --recurse-submodules --quiet
> might produce non-quiet output from the merge or rebase.
>
> Signed-off-by: Theodore Dubois <tbodt@google.com>
> ---
>  git-submodule.sh            | 4 ++--
>  t/t7406-submodule-update.sh | 9 +++++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git git-submodule.sh git-submodule.sh
> index 6fb12585cb..5c22b17221 100755
> --- git-submodule.sh
> +++ git-submodule.sh
> @@ -614,13 +614,13 @@ cmd_update()
>  				say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
>  				;;
>  			rebase)
> -				command="git rebase"
> +				command="git rebase ${GIT_QUIET:+--quiet}"
>  				die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$displaypath'")"
>  				say_msg="$(eval_gettext "Submodule path '\$displaypath': rebased into '\$sha1'")"
>  				must_die_on_failure=yes
>  				;;
>  			merge)
> -				command="git merge"
> +				command="git merge ${GIT_QUIET:+--quiet}"
>  				die_msg="$(eval_gettext "Unable to merge '\$sha1' in submodule path '\$displaypath'")"
>  				say_msg="$(eval_gettext "Submodule path '\$displaypath': merged in '\$sha1'")"
>  				must_die_on_failure=yes

This is not the problem this patch introduces, but the way GIT_QUIET
variable is set up does not allow us to do the above so nicely, I
suspect.  Wouldn't the above change make "git submodule update -v"
invoke the underlying commands with "--quiet" option?


The problematic piece of code is this part:

        cmd_update()
        {
                # parse $args after "submodule ... update".
                while test $# -ne 0
                do
                        case "$1" in
                        -q|--quiet)
                                GIT_QUIET=1
                                ;;
                        -v)
                                GIT_QUIET=0
                                ;;
                        --progress)
                                progress=1
                                ;;


I think this is the only place in the script that GIT_QUIET is set
to 0, but all the places that refer to the variable do not even
check the value held in it.  Makes me wonder if it was used
differently back when e84c3cf3dc3 was written.

    ... goes and looks at the offending commit ...

I think the right fix could have been "unset GIT_QUIET" instead of
assigning 0 that means the same thing as GIT_QUIET=1

In any case, the posted patch is a good first step but it makes the
existing problem worse.  Let's fix GIT_QUIET=0 at the same time.

Thanks.

> diff --git t/t7406-submodule-update.sh t/t7406-submodule-update.sh
> index aa19ff3a2e..5213e47af8 100755
> --- t/t7406-submodule-update.sh
> +++ t/t7406-submodule-update.sh
> @@ -1022,4 +1022,13 @@ test_expect_success 'git clone passes the parallel jobs config on to submodules'
>  	rm -rf super4
>  '
>  
> +test_expect_success 'submodule update --quiet passes quietness to merge/rebase' '
> +	(cd super &&
> +	 test_commit -C rebasing message &&
> +	 git submodule update --rebase --quiet >out 2>err &&

IOW, I suspect that this test will still pass with s/--quiet/-v/ .

> +	 test_must_be_empty out &&
> +	 test_must_be_empty err
> +	)
> +'

