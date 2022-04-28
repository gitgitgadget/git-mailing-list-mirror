Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA23FC433EF
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 05:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiD1Fha (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 01:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiD1Fh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 01:37:29 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5025FAF
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 22:34:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CE8DF1A56C8;
        Thu, 28 Apr 2022 01:34:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4xqvQuGMrykp
        8lmVUgSmPNHB0FyCUm4YKNUpPbkJZpM=; b=eZkFUGw6aSJrBArm7q1KMeuy7hAk
        2lHuPCxMDtV9dkSZ/oCnC9gABCGtK6Q+Se2Q/dhnXb3rgLAJemjNSguy3kliPfrG
        N0mBdgt2f5WcI0whEpNDlTbckHhoJI55dR6IpAsQnjvt3D7sfqz6o/q0R8BCsrPo
        cLpBKufaAVdsArE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BBA5B1A56C7;
        Thu, 28 Apr 2022 01:34:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 38E171A56C6;
        Thu, 28 Apr 2022 01:34:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com
Subject: Re: [PATCH 2/2] t: add tests for safe.directory when running with sudo
References: <20220427222649.63516-1-carenas@gmail.com>
        <20220428033544.68188-1-carenas@gmail.com>
        <20220428033544.68188-3-carenas@gmail.com>
Date:   Wed, 27 Apr 2022 22:34:10 -0700
In-Reply-To: <20220428033544.68188-3-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 27 Apr 2022 20:35:44 -0700")
Message-ID: <xmqqsfpxg4a5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D50D1E22-C6B4-11EC-9821-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> In a previous commit the functionality for fixing this regression was
> implemented, so add a test for it and the relevant infrastructure.
>
> This new test file is meant to be run in CI and checks for a SUDO
> prerequisite which requires a passwordless configuration if run
> locally, but that is common there.
>
> It could be run locally by first running sudo, so the credentials are
> temporarily cached and then running it as :
>
>   $ IKNOWWHATIAMDOING=3DYES ./t0034-root-safe-directory.sh
>
> It is slightly ackward as it needs to clean up after itself since the

"awkward", I think.

> test framework would fail to do its own cleanup otherwise, and for
> simplicity creates its own subtree while ignoring the one provided by
> the framework, but doing some better integration has been punted.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  t/t0034-root-safe-directory.sh | 51 ++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100755 t/t0034-root-safe-directory.sh
>
> diff --git a/t/t0034-root-safe-directory.sh b/t/t0034-root-safe-directo=
ry.sh
> new file mode 100755
> index 00000000000..c62bf3777c0
> --- /dev/null
> +++ b/t/t0034-root-safe-directory.sh
> @@ -0,0 +1,51 @@
> +#!/bin/sh
> +
> +test_description=3D'verify safe.directory checks while running as root=
'
> +
> +. ./test-lib.sh
> +
> +if [ "$IKNOWWHATIAMDOING" !=3D "YES" ]; then
> +	skip_all=3D"You must set env var IKNOWWHATIAMDOING=3DYES in order to =
run thi
> +s test"
> +	test_done
> +fi
> +
> +if ! test_have_prereq NOT_ROOT
> +then
> +	skip_all=3D"this test uses sudo to run as root"

As a statement of fact, there is nothing wrong per-se in this
message.  It may be an explanation why you should not run this as
root, but as an explanation of the reason why all tests in this
script are skipped, and more importantly, hint to testers what they
need to do to correct the situation, this is too cryptic to readers.

Perhaps telling them

	skip_all=3D"do not run this test as root"

is more important and useful.

> +	test_done
> +fi
> +
> +doalarm () {
> +	perl -e 'alarm shift; exec @ARGV' -- "$@"
> +}
> +
> +test_lazy_prereq SUDO '
> +	doalarm 1 sudo id -u >u &&
> +	id -u root >r &&
> +	test_cmp u r
> +'
> +
> +test_expect_success SUDO 'setup' '
> +	sudo rm -rf root &&
> +	mkdir -p root/r &&
> +	sudo chown root root &&
> +	(
> +		cd root/r &&
> +		git init
> +	)
> +'
> +
> +test_expect_success SUDO 'sudo git status works' '
> +	(
> +		cd root/r &&
> +		git status &&
> +		sudo git status
> +	)
> +'

All of the above are positive tests.  One possible negative test is
to prepare a root-owned repository and see what "git status" as
yourself in there does.  And also see what "git status" as root
there does.

test_expect_success SUDO 'in root owned repository' '
	mkdir root/p
        sudo chown root root/p &&
	sudo git init root/p &&

	# owned by other person (root), do I see it as a repository?
	(
		cd root/p &&
		test_must_fail git status
	) &&

	# owned by root, can I access it under sudo?
	(
		cd root/p &&
		sudo git status
	)
'

> +test_expect_success SUDO 'cleanup' '
> +	sudo rm -rf root
> +'
> +
> +test_done
