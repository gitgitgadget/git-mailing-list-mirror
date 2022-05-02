Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC38C433F5
	for <git@archiver.kernel.org>; Mon,  2 May 2022 22:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbiEBWNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 18:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiEBWNo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 18:13:44 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F52B2E
        for <git@vger.kernel.org>; Mon,  2 May 2022 15:10:13 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D9461092BF;
        Mon,  2 May 2022 18:10:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4XpjUYa9z4qH
        Yn1QwhFcUt0YmoYw9FD1QS6Bit8HioQ=; b=DyH4buwiBC+3TEBwaoXLDDYnktQ2
        3g5H5NX5N8NXSooJWp66pzDArYncIgNNV8EIpCjnX3vaM/AeueU4v9CNgyic76n+
        LDCeSRu9by5zdKcZH4yUO+Knfdm4b79UTbYzZsgljmlSESS6UhRYfDzzgzFCyUmr
        u6CZ6EVH+PeH9wI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D2ED1092BE;
        Mon,  2 May 2022 18:10:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CE9761092BD;
        Mon,  2 May 2022 18:10:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com
Subject: Re: [RFC PATCH v3 3/3] t0034: enhance framework to allow testing
 more commands under sudo
References: <20220428105852.94449-1-carenas@gmail.com>
        <20220502183920.88982-1-carenas@gmail.com>
        <20220502183920.88982-4-carenas@gmail.com>
Date:   Mon, 02 May 2022 15:10:09 -0700
In-Reply-To: <20220502183920.88982-4-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Mon, 2 May 2022 11:39:20 -0700")
Message-ID: <xmqqo80fvb5q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A2364380-CA64-11EC-94E2-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> +# Runs a scriplet passed through stdin under sudo.
> +run_with_sudo () {
> +	local ret
> +	local SH=3D${1-"$TEST_SHELL_PATH"}
> +	local RUN=3D"$HOME/$$.sh"
> +	{
> +		echo "#!$SH"
> +		echo "set -e"
> +		echo ". \"$HOME/env\""
> +		cat
> +	} >"$RUN" &&
> +	chmod +x "$RUN" &&
> +	sudo "$SH" -c "\"$RUN\""
> +	ret=3D$?
> +	rm -f "$RUN"
> +	return $ret
> +}

I wonder if write_script can be used for better readability.  It is
especially true as I am going to suggest ripping out $HOME/env stuff
that is not absolutely needed (and its support with this patch looks
inadequate when we do need one).

	local RUN=3D$HOME/$$.sh &&
	write_script "$RUN" "$TEST_SHELL_PATH" &&
	sudo "$RUN"

or something?

> +# Makes all variables passed as parameters available to the scriplet t=
hat
> +# run under sudo with run_with_sudo
> +export_to_sudo () {
> +	while test -n "$1"
> +	do
> +		local v
> +		eval v=3D"\$$1"
> +		echo "$1=3D$v" >>"$HOME/env"
> +		shift
> +	done
> +}

Two potential issues:

 - This forces the caller to list _all_ the relevant environment
   variables that would ever matter, which would not be feasible and
   would not be maintainable.  For example, by forgetting to export
   GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS, "git" commands run in the
   sudo tests change their behaviour.  Whoever writing a new test
   need to see what obscure GIT_TEST_* thing may affect the test
   they want to write, and whoever enhancing the test framework to
   add new GIT_TEST_* knob need to pay attention to the users of
   export_to_sudo if their new knob need to be exported.

 - I think the assignment to $v under eval is correct, but I am not
   sure the string accumulated in the $HOME/env file is safe to
   eval.  We can pass TEST_DIRECTORY via this mechanism, where the
   value deliberately has a whitespace in it, but if the leading
   path to our source directory had a single-quote in it, it
   probably would not work well.  Of course, any variable that has
   LF in its value would not work without proper quoting.

I think both are not impossible but are hard to do right.  Because I
do not see anything that absolutely needs the $HOME/env mechanism to
work in the rest of the tests in this patch, I am inclined to say
that I'd prefer keeping things simple and only make sure we use the
right $SHELL to run our script (which write_script may help).

> diff --git a/t/t0034-root-safe-directory.sh b/t/t0034-root-safe-directo=
ry.sh
> index 67dd96b9321..0f79648a2fb 100755
> --- a/t/t0034-root-safe-directory.sh
> +++ b/t/t0034-root-safe-directory.sh
> @@ -3,6 +3,19 @@
>  test_description=3D'verify safe.directory checks while running as root=
'
> =20
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-sudo.sh
> +
> +if [ "$IKNOWWHATIAMDOING" !=3D "YES" ]
> +then
> +	skip_all=3D"You must set env var IKNOWWHATIAMDOING=3DYES in order to =
run this test"
> +	test_done
> +fi
> +
> +if ! test_have_prereq NOT_ROOT
> +then
> +	skip_all=3D"No, you don't; these tests can't run as root"
> +	test_done
> +fi

OK.

> @@ -19,6 +32,7 @@ test_lazy_prereq SUDO '
>  test_expect_success SUDO 'setup' '
>  	sudo rm -rf root &&
>  	mkdir -p root/r &&
> +	export_to_sudo GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME &&
>  	sudo chown root root &&
>  	(
>  		cd root/r &&

I know I brought up the "git init" during the previous review, but
as long as the test does not depend on the GIT_TEST_* knob
(i.e. either we say "git init --initial-branch" explicitly, or we do
not rely on the initial branch having a certain name), we do not
have to worry.  We do not check what branch we are on after we do
this test, we do not check what branch "git status" reports that we
are on in later tests, we obviously do not care between main and
master in this test script.

I am tempted to suggest dropping the whole $HOME/env business.

> @@ -34,6 +48,50 @@ test_expect_success SUDO 'sudo git status as origina=
l owner' '
>  	)
>  '
> =20
> +test_expect_success SUDO 'setup root owned repository' '
> +	sudo mkdir -p root/p &&
> +	run_with_sudo <<-END
> +		git init root/p
> +	END
> +'

OK.

> +test_expect_success SUDO 'cannot access if owned by root' '
> +	(
> +		cd root/p &&
> +		test_must_fail git status
> +	)
> +'

OK, but strictly speaking, we do not need the SUDO prerequisite for
this one.  It still need it for the test directories prepared in
previous steps anyway, so perhaps we want one check upfront, just
like we do for NOT_ROOT?

	if ! test_have_prereq SUDO
	then
		skip_all=3D"You do not seem to have a working 'sudo'"
		test_done
	fi

> +test_expect_success SUDO 'cannot access with sudo' '
> +	(
> +		# TODO: test_must_fail needs additional functionality
> +		# 6a67c759489 blocks its use with sudo
> +		cd root/p &&
> +		! sudo git status
> +	)
> +'

OK.  So we cannot by default access root-owned repository by
default, which is OK.  I wonder what happens if we did "sudo sudo
git status".  Perhaps the inner sudo will notice that SUDO_UID is
set in its environment and does not update it to 0?

	... goes and checks ...
	$ sudo sudo sh -c 'echo $SUDO_UID; whoami'
	0
	root

So that gives us another workaround, I guess, which might be even
simpler.

> +test_expect_success SUDO 'can access using a workaround' '
> +	# provide explicit GIT_DIR
> +	(
> +		cd root/p &&
> +		run_with_sudo <<-END
> +			GIT_DIR=3D.git
> +			GIT_WORK_TREE=3D.
> +			export GIT_DIR GIT_WORK_TREE
> +			git status
> +		END
> +	) &&
> +	# discard SUDO_UID
> +	(
> +		cd root/p &&
> +		run_with_sudo <<-END
> +			unset SUDO_UID
> +			git status
> +		END
> +	)

	# double sudo
	(
		cd root/p &&
		sudo sudo git status
	)

I do not know if it is worth adding this third workaround.

> +'
> +
>  # this MUST be always the last test
>  test_expect_success SUDO 'cleanup' '
>  	sudo rm -rf root

Looking much better otherwise.
