Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C99C433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 23:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiEJXLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 19:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiEJXLv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 19:11:51 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEA7B7C0
        for <git@vger.kernel.org>; Tue, 10 May 2022 16:11:50 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B710F13EA2D;
        Tue, 10 May 2022 19:11:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UteAz+h/FTl1
        SHzOYtyIk+aF8plug/FXOrLMTYSf0vo=; b=hb4e2GKXGtEHZRVXkZWNjgC5GV1Q
        zp9+8ob5CN7EYeHKkLHCWvKdMkhyTbCJ9a3AWhuDOdMKKrAyPmqvIyExAOhozjyL
        PcPsf5yXC7uGwT73YSji9LwDDtLWgBYDNfddwp7uMsr2TC4tfbloox3UweW1TTDC
        Cf9TGh6jhbgm1ds=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD1DC13EA2C;
        Tue, 10 May 2022 19:11:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1116113EA2B;
        Tue, 10 May 2022 19:11:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v4 3/3] t0034: add negative tests and allow git init to
 mostly work under sudo
References: <20220507163508.78459-1-carenas@gmail.com>
        <20220510174616.18629-1-carenas@gmail.com>
        <20220510174616.18629-4-carenas@gmail.com>
Date:   Tue, 10 May 2022 16:11:45 -0700
In-Reply-To: <20220510174616.18629-4-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 10 May 2022 10:46:16 -0700")
Message-ID: <xmqqczgl56fi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 90A2BEE8-D0B6-11EC-8553-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> Note that the specific test that documents that after the previous
> changes, it is no longer possible for root (if obtained through sudo)
> to NOT add an exception or NOT need a "workaround" to be able to run gi=
t
> commands in a repository owned by thyself, is marked as a regression
> and is expected to be fixed with a future change, which hasn't been
> provided yet and that is not part of this series.

Do you mean "you can easily unset SUDO_UID to access root-owned
repositories as root"?  Ahh, no, "after tentatively becoming root,
you can access your own (via SUDO_UID) and root-owned repositories"
is what you meant, I think.  I think that is reasonable to stop the
current round before adding the support for it.

> As described in the comments from the test itself, at least one of the
> documented workarounds could fail if sudo doesn't allow root to call su=
do
> or if root is not in sudoers, but that is very unlikely, and more
> importantly actually not what is provided by the currently supported su=
do
> configuration this test already relies on and therefore adding a way to
> validate it works in the prerequisite has been punted for now.

OK.

> diff --git a/t/lib-sudo.sh b/t/lib-sudo.sh
> new file mode 100644
> index 0000000000..d8a88fb9db
> --- /dev/null
> +++ b/t/lib-sudo.sh
> @@ -0,0 +1,12 @@
> +# Helpers for running git commands under sudo.
> +
> +# Runs a scriplet passed through stdin under sudo.
> +run_with_sudo () {
> +	local ret
> +	local RUN=3D"$TEST_DIRECTORY/$$.sh"
> +	write_script "$RUN" "$TEST_SHELL_PATH"
> +	sudo "$TEST_SHELL_PATH" -c "\"$RUN\""

This is not wrong per-se, but I think

	sudo "$RUN"

would be sufficient, wouldn't it?=20

> @@ -19,6 +26,12 @@ test_lazy_prereq SUDO '
>  	test_cmp u r
>  '
> =20
> +if ! test_have_prereq SUDO
> +then
> +	skip_all=3D"Your sudo/system configuration is either too strict or un=
supported"
> +	test_done
> +fi

Quite sensible and understandable.

> @@ -37,6 +50,51 @@ test_expect_success SUDO 'sudo git status as origina=
l owner' '
>  	)
>  '
> =20
> +test_expect_success SUDO 'setup root owned repository' '
> +	sudo mkdir -p root/p &&
> +	sudo git init root/p
> +'

OK, so=20

	root/ is owned by 'root',
	root/r is owned by the tester, and
	root/p is owned by 'root'.

> +test_expect_success 'cannot access if owned by root' '
> +	(
> +		cd root/p &&
> +		test_must_fail git status
> +	)
> +'

OK.

Mark this point as [A] for future reference.

> +test_expect_failure SUDO 'can access with sudo if root' '
> +	(
> +		cd root/p &&
> +		sudo git status
> +	)
> +'

OK.


> +test_expect_success SUDO 'can access with sudo using a workaround' '
> +	# run sudo twice; would fail if root is not in sudoers

It probably is a good idea to check "you can run nested sudo" before
setting SUDO prerequisite.  Then we do not have to say "would fail"
here.

> +	(
> +		cd root/p &&
> +		sudo sudo git status
> +	) &&
> +	# provide explicit GIT_DIR
> +	(
> +		cd root/p &&
> +		run_with_sudo <<-END
> +			GIT_DIR=3D.git &&
> +			GIT_WORK_TREE=3D. &&
> +			export GIT_DIR GIT_WORK_TREE &&
> +			git status
> +		END
> +	) &&

OK.  We probably want to highlight that this "by default you can
only access your own repository" is *not* a security measure that
protects the repositories---it is a security measure to protect
you from potentially malicious repositories by unknowingly stepping
into them.  To do so, let's go back to point [A] and add a similar
"I as a tester can still access repository owned by root, as long as
I express that I want to access it explicitly" test after it. i.e.

	(
		cd root/p &&
		GIT_DIR=3D.git GIT_WORK_TREE=3D. git status
	)

> +	# discard SUDO_UID
> +	(
> +		cd root/p &&
> +		run_with_sudo <<-END
> +			unset SUDO_UID &&
> +			git status
> +		END
> +	)
> +'

OK.

Thanks.
