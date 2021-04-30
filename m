Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DB0C433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 00:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 096F861418
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 00:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhD3Att (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 20:49:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56498 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhD3Ats (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 20:49:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B5164120943;
        Thu, 29 Apr 2021 20:49:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h3DjnuWea61f1nQCkNrZx+klBHrUWKEqcoB7hh
        ET6sg=; b=KRWXcYOMwG8KCMbxW52CNrc0tmE9Nc7QGA1dHDre4Uck2gzjyT3diT
        CNdKI0qEJeH3nbXIZwSdcwb6DqnAuJqk6OrQdyfpZ7WmFgg1RUw7kRaviJnebqGg
        TNSbi7Mray8LUvRqTLZMso/OnxoD1PsrpnjRFHkzdcnbVXH3WGCq0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AF2BF120942;
        Thu, 29 Apr 2021 20:49:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E386C12093E;
        Thu, 29 Apr 2021 20:48:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org, RyotaK <security@ryotak.me>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] cygwin: disallow backslashes in file names
References: <20210424212117.6165-1-adam@dinwoodie.org>
        <20210429201144.8936-1-adam@dinwoodie.org>
Date:   Fri, 30 Apr 2021 09:48:57 +0900
In-Reply-To: <20210429201144.8936-1-adam@dinwoodie.org> (Adam Dinwoodie's
        message of "Thu, 29 Apr 2021 21:11:44 +0100")
Message-ID: <xmqqsg38egw6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D96038E0-A94D-11EB-A846-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie <adam@dinwoodie.org> writes:

> The backslash character is not a valid part of a file name on Windows.
> If, in Windows, Git attempts to write a file that has a backslash
> character in the filename, it will be incorrectly interpreted as a
> directory separator.
>
> This caused CVE-2019-1354 in MinGW, as this behaviour can be manipulated
> to cause the checkout to write to files it ought not write to, such as
> adding code to the .git/hooks directory.  This was fixed by e1d911dd4c
> (mingw: disallow backslash characters in tree objects' file names,
> 2019-09-12).  However, the vulnerability also exists in Cygwin: while
> Cygwin mostly provides a POSIX-like path system, it will still interpret
> a backslash as a directory separator.
>
> To avoid this vulnerability, CVE-2021-29468, extend the previous fix to
> also apply to Cygwin.
>
> Similarly, extend the test case added by the previous version of the
> commit.  The test suite doesn't have an easy way to say "run this test
> if in MinGW or Cygwin", so add a new test prerequisite that covers both.
>
> As well as checking behaviour in the presence of paths containing
> backslashes, the existing test also checks behaviour in the presence of
> paths that differ only by the presence of a trailing ".".  MinGW follows
> normal Windows application behaviour and treats them as the same path,
> but Cygwin more closely emulates *nix systems (at the expense of
> compatibility with native Windows applications) and will create and
> distinguish between such paths.  Gate the relevant bit of that test
> accordingly.
>
> Reported-by: RyotaK <security@ryotak.me>
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> ---

Thanks, all.  Will queue.

>  read-cache.c               |  2 +-
>  t/test-lib.sh              |  2 ++
>  t/t7415-submodule-names.sh | 13 ++++++++-----
>  3 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 5a907af2fb..b6c13bc04e 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -985,7 +985,7 @@ int verify_path(const char *path, unsigned mode)
>  				}
>  			}
>  			if (protect_ntfs) {
> -#ifdef GIT_WINDOWS_NATIVE
> +#if defined GIT_WINDOWS_NATIVE || defined __CYGWIN__
>  				if (c == '\\')
>  					return 0;
>  #endif
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index d3f6af6a65..e84b8c87f9 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1457,14 +1457,16 @@ case $uname_s in
>  	test_set_prereq NATIVE_CRLF
>  	test_set_prereq SED_STRIPS_CR
>  	test_set_prereq GREP_STRIPS_CR
> +	test_set_prereq WINDOWS
>  	GIT_TEST_CMP=mingw_test_cmp
>  	;;
>  *CYGWIN*)
>  	test_set_prereq POSIXPERM
>  	test_set_prereq EXECKEEPSPID
>  	test_set_prereq CYGWIN
>  	test_set_prereq SED_STRIPS_CR
>  	test_set_prereq GREP_STRIPS_CR
> +	test_set_prereq WINDOWS
>  	;;
>  *)
>  	test_set_prereq POSIXPERM
> diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
> index f70368bc2e..6bf098a6be 100755
> --- a/t/t7415-submodule-names.sh
> +++ b/t/t7415-submodule-names.sh
> @@ -191,7 +191,7 @@ test_expect_success 'fsck detects corrupt .gitmodules' '
>  	)
>  '
>  
> -test_expect_success MINGW 'prevent git~1 squatting on Windows' '
> +test_expect_success WINDOWS 'prevent git~1 squatting on Windows' '
>  	git init squatting &&
>  	(
>  		cd squatting &&
> @@ -219,10 +219,13 @@ test_expect_success MINGW 'prevent git~1 squatting on Windows' '
>  		test_tick &&
>  		git -c core.protectNTFS=false commit -m "module"
>  	) &&
> -	test_must_fail git -c core.protectNTFS=false \
> -		clone --recurse-submodules squatting squatting-clone 2>err &&
> -	test_i18ngrep -e "directory not empty" -e "not an empty directory" err &&
> -	! grep gitdir squatting-clone/d/a/git~2
> +	if test_have_prereq MINGW
> +	then
> +		test_must_fail git -c core.protectNTFS=false \
> +			clone --recurse-submodules squatting squatting-clone 2>err &&
> +		test_i18ngrep -e "directory not empty" -e "not an empty directory" err &&
> +		! grep gitdir squatting-clone/d/a/git~2
> +	fi
>  '
>  
>  test_expect_success 'git dirs of sibling submodules must not be nested' '
