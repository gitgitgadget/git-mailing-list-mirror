Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A72C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B7FA64DEC
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhBQVq4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:46:56 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64636 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhBQVqr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 16:46:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2DF971211F5;
        Wed, 17 Feb 2021 16:46:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gb1NQw1wNSSI0q3cgpM+LaDYRa4=; b=i6Ikoi
        jouO1DqMSaNz7Qzi+GolwNrlbcUwchQvIpGcIPh/Q2dY7Ea3fakTt/sE+k3bNRDZ
        yul+JXCu4BrpOMHqJYspcVzkm9PATtaPO/cd0Zzi5NvTmV+ytfFkPN6taSp08eXw
        i1B99Agb99ADJzbuzy7rd2yOhruUli4vS07sY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tvkxkgoxbl2jJShubQvTOA5CT/3dDx+6
        iYj2pNL++5ePU+k8N5XAr7RHXsgna7Kd4qbxL6QEg1Ps0L+ZEckgRkls07Z5wzOH
        fZ+fFUrw0qcp+VMw96RPf4fF+nSMqi3ICQ54b44TFtDcSNmiu3LGE7Q50K0OJsNi
        RECUOVm4fP8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1FF711211F4;
        Wed, 17 Feb 2021 16:46:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 13E131211F0;
        Wed, 17 Feb 2021 16:45:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, newren@gmail.com, stolee@gmail.com
Subject: Re: [RFC PATCH 1/7] add --chmod: don't update index when --dry-run
 is used
References: <cover.1613593946.git.matheus.bernardino@usp.br>
        <2256132f9de01cc06a001aa8c44e29dc5a218441.1613593946.git.matheus.bernardino@usp.br>
Date:   Wed, 17 Feb 2021 13:45:54 -0800
In-Reply-To: <2256132f9de01cc06a001aa8c44e29dc5a218441.1613593946.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Wed, 17 Feb 2021 18:02:24 -0300")
Message-ID: <xmqqa6s2jrl9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83C1DB58-7169-11EB-8ED7-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> `git add --chmod` applies the mode changes even when `--dry-run` is
> used. Fix that and add some tests for this option combination.

Well spotted.  I hope we can split this out of the series and fast
track, as it is an obvious bugfix.

I by mistake wrote error(_("...")) in the snippet below, but as a
bugfix, we should stick to the existing fprintf(stderr, "...") without
_().  i18n should be left outside the "bugfix" change.

> -static void chmod_pathspec(struct pathspec *pathspec, char flip)
> +static void chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
>  {
>  	int i;
>  
> @@ -48,7 +48,8 @@ static void chmod_pathspec(struct pathspec *pathspec, char flip)
>  		if (pathspec && !ce_path_match(&the_index, ce, pathspec, NULL))
>  			continue;
>  
> -		if (chmod_cache_entry(ce, flip) < 0)
> +		if ((show_only && !S_ISREG(ce->ce_mode)) ||
> +		    (!show_only && chmod_cache_entry(ce, flip) < 0))
>  			fprintf(stderr, "cannot chmod %cx '%s'\n", flip, ce->name);
>  	}
>  }

This is a bit dense, especially when the reader does not know by
heart that chmod_cache_entry() refuses to chmod anything that is not
a regular file.

Even when dry-run, we know chmod will fail when the thing is not a
regular file.  When not dry-run, we will try chmod and it will
report an failure.  And we report an error under these conditions.

	if (show_only
	    ? !S_ISREG(ce->ce_mode)
	    : chmod_cache_entry(ce, flip) < 0)
		error(_("cannot chmod ..."), ...);

may express the same idea in a way that is a bit easier to follow.

In any case, that "idea", while it is not wrong per-se, makes it as
if the primary purpose of this code is to give an error message,
which smells a bit funny.

	if (!show_only)
        	err = chmod_cache_entry(ce, flip);
	else 
        	err = S_ISREG(ce->ce_mode) ? 0 : -1;

	if (err < 0)
		error(_("cannot chmod ..."), ...);

would waste one extra variable, but may make the primary point
(i.e. we call chmod_cache_entry() unless dry-run) more clear.

> @@ -609,7 +610,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  		exit_status |= add_files(&dir, flags);
>  
>  	if (chmod_arg && pathspec.nr)
> -		chmod_pathspec(&pathspec, chmod_arg[0]);
> +		chmod_pathspec(&pathspec, chmod_arg[0], show_only);
>  	unplug_bulk_checkin();

OK, this side is straight-forward.  We know if we are doing --dry-run;
we have to pass it down.

> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index b7d4ba608c..fc81f2ef00 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -386,6 +386,26 @@ test_expect_success POSIXPERM 'git add --chmod=[+-]x does not change the working
>  	! test -x foo4
>  '
>  
> +test_expect_success 'git add --chmod honors --dry-run' '
> +	git reset --hard &&
> +	echo foo >foo4 &&
> +	git add foo4 &&
> +	git add --chmod=+x --dry-run foo4 &&
> +	test_mode_in_index 100644 foo4
> +'
> +
> +test_expect_success 'git add --chmod --dry-run reports error for non regular files' '
> +	git reset --hard &&
> +	test_ln_s_add foo foo4 &&
> +	git add --chmod=+x --dry-run foo4 2>stderr &&
> +	grep "cannot chmod +x .foo4." stderr
> +'

Nice that test_ln_s_add lets write this without SYMLINKS
prerequisite, as all that matters is what is in the index
and not in the working tree.

> +test_expect_success 'git add --chmod --dry-run reports error for unmatched pathspec' '
> +	test_must_fail git add --chmod=+x --dry-run nonexistent 2>stderr &&
> +	test_i18ngrep "pathspec .nonexistent. did not match any files" stderr
> +'
> +
>  test_expect_success 'no file status change if no pathspec is given' '
>  	>foo5 &&
>  	>foo6 &&

Thanks.
