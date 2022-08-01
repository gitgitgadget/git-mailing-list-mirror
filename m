Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B41EC00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 18:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiHASys (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 14:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiHASyo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 14:54:44 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0B31AF24
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 11:54:43 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7A82E1A3545;
        Mon,  1 Aug 2022 14:54:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qz9gmrls3ER7YDMnuvuUiKwuGNcI0KN5LI4FhX
        qRzgM=; b=doY8bpDGPfOa1xW2jdiQEAjxe4Hu7TJIhFSwBrssS9/7i+/2OaWXUW
        4BFXkpGwPITiLvQhGBSmFkHtw/BfYjbrIFB9YnznsMsTz0RBkI/SdWSjIoCPz2QN
        avgbLBBuZ2FCMlKxXSkl5YJkeiq8jjKEl8pC+XHHheTbfhR4WDkgo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 739E21A3544;
        Mon,  1 Aug 2022 14:54:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F1D7A1A3543;
        Mon,  1 Aug 2022 14:54:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: "git symbolic-ref" doesn't do a very good job
References: <CAHk-=wh9f0EmsNFgoxUa8BzVej06+7MbLr-MLBjDjtj_=Pf90A@mail.gmail.com>
        <CAHk-=wg9LaHeg0UmZ90gLOaBpO-5fhoaH22iNNm=1eror95pFg@mail.gmail.com>
        <YuXKaLXhnR3mVlWk@coredump.intra.peff.net>
        <YuXLtIBXYG+JBKdV@coredump.intra.peff.net>
        <CAHk-=wi5pfUcuaAUz=rifon9d51mshE7k6bkpMXddog0On9jow@mail.gmail.com>
        <YugQqp4oN26OFOpt@coredump.intra.peff.net>
        <YugYNzQYWqDCmOqN@coredump.intra.peff.net>
Date:   Mon, 01 Aug 2022 11:54:36 -0700
In-Reply-To: <YugYNzQYWqDCmOqN@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 1 Aug 2022 14:15:19 -0400")
Message-ID: <xmqqfsifyetv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 647971C6-11CB-11ED-ABED-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Just to keep things moving forward, here it is with a commit message. I
> left you as the author, but if you're OK with it, please tell Junio he
> can forge your sign-off.
>
> -- >8 --
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Subject: [PATCH] symbolic-ref: refuse to set syntactically invalid target
>
> You can feed absolute garbage to symbolic-ref as a target like:
>
>   git symbolic-ref HEAD refs/heads/foo..bar
>
> While this doesn't technically break the repo entirely (our "is it a git
> directory" detector looks only for "refs/" at the start), we would never
> resolve such a ref, as the ".." is invalid within a refname.
>
> Let's flag these as invalid at creation time to help the caller realize
> that what they're asking for is bogus.
>
> A few notes:
>
>   - We use REFNAME_ALLOW_ONELEVEL here, which lets:
>
>      git update-ref refs/heads/foo FETCH_HEAD
>
>     continue to work. It's unclear whether anybody wants to do something
>     so odd, but it does work now, so this is erring on the conservative
>     side. There's a test to make sure we didn't accidentally break this,
>     but don't take that test as an endorsement that it's a good idea, or
>     something we might not change in the future.

OK.  Even if it were HEAD, it does look like a funny thing to do to
point at a shallower ref with a more concrete ref.

>   - The test in t4202-log.sh checks how we handle such an invalid ref on
>     the reading side, so it has to be updated to touch the HEAD file
>     directly.
>
>   - We need to keep our HEAD-specific check for "does it start with
>     refs/". The ALLOW_ONELEVEL flag means we won't be enforcing that for
>     other refs, but HEAD is special here because of the checks in
>     validate_headref().

OK.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/symbolic-ref.c  |  2 ++
>  t/t1401-symbolic-ref.sh | 10 ++++++++++
>  t/t4202-log.sh          |  4 ++--
>  3 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
> index e547a08d6c..1b0f10225f 100644
> --- a/builtin/symbolic-ref.c
> +++ b/builtin/symbolic-ref.c
> @@ -71,6 +71,8 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
>  		if (!strcmp(argv[0], "HEAD") &&
>  		    !starts_with(argv[1], "refs/"))
>  			die("Refusing to point HEAD outside of refs/");
> +		if (check_refname_format(argv[1], REFNAME_ALLOW_ONELEVEL) < 0)
> +			die("Refusing to set '%s' to invalid ref '%s'", argv[0], argv[1]);

Makes sense.  Rejecting syntactically invalid thing like double-dot
is something we should have done from day one.

> diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
> index 9fb0b90f25..0c204089b8 100755
> --- a/t/t1401-symbolic-ref.sh
> +++ b/t/t1401-symbolic-ref.sh
> @@ -165,4 +165,14 @@ test_expect_success 'symbolic-ref can resolve d/f name (ENOTDIR)' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'symbolic-ref refuses invalid target for non-HEAD' '
> +	test_must_fail git symbolic-ref refs/heads/invalid foo..bar
> +'

Good.

> +test_expect_success 'symbolic-ref allows top-level target for non-HEAD' '
> +	git symbolic-ref refs/heads/top-level FETCH_HEAD &&
> +	git update-ref FETCH_HEAD HEAD &&
> +	test_cmp_rev top-level HEAD
> +'
>  test_done

Strange, but OK.

> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 6e66352558..f0aaa1fa02 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -2112,9 +2112,9 @@ test_expect_success REFFILES 'log diagnoses bogus HEAD hash' '
>  	test_i18ngrep broken stderr
>  '
>  
> -test_expect_success 'log diagnoses bogus HEAD symref' '
> +test_expect_success REFFILES 'log diagnoses bogus HEAD symref' '
>  	git init empty &&
> -	git --git-dir empty/.git symbolic-ref HEAD refs/heads/invalid.lock &&
> +	echo "ref: refs/heads/invalid.lock" > empty/.git/HEAD &&

OK.

>  	test_must_fail git -C empty log 2>stderr &&
>  	test_i18ngrep broken stderr &&
>  	test_must_fail git -C empty log --default totally-bogus 2>stderr &&
