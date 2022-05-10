Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54371C433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 22:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiEJWKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 18:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiEJWK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 18:10:29 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5CC28B6AD
        for <git@vger.kernel.org>; Tue, 10 May 2022 15:10:28 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A871718D75C;
        Tue, 10 May 2022 18:10:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=j6hh8dyjkXS2
        x5L3uw2yL16sbiK6onyU7FSLDU0BFf8=; b=wGCmvrYodglAIl9ZAPEFUIU3X1jS
        7ylZM/ZG3344FsHjVqqnZPoTwQaEkObhyh4qUYo5VtQdMkCrM/w+9Vyx1gKynLx3
        rUz5F6ihIEvX25EhePpA8iKK6SHCNsPFQxa0G/XldBR44MAcpp03lbePL5ju7ryB
        qB5q4DBQ9XsUX54=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A0BA018D75B;
        Tue, 10 May 2022 18:10:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4795D18D75A;
        Tue, 10 May 2022 18:10:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 1/3] t: regression git needs safe.directory when
 using sudo
References: <20220507163508.78459-1-carenas@gmail.com>
        <20220510174616.18629-1-carenas@gmail.com>
        <20220510174616.18629-2-carenas@gmail.com>
Date:   Tue, 10 May 2022 15:10:21 -0700
In-Reply-To: <20220510174616.18629-2-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 10 May 2022 10:46:14 -0700")
Message-ID: <xmqqczgl6nua.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FD87A5AE-D0AD-11EC-A33B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> Note that because of the way sudo interacts with the system, a much
> more complete integration with the test framework will require a lot
> more work and that was therefore intentionally punted for now.
>
> The current implementation requires ...
> ...
> If it fails to run, then it means your local setup wouldn't work for th=
e
> test because of the configuration sudo has or other system settings, an=
d
> things that might help are to comment out sudo's secure_path config, an=
d
> make sure that the account you are using has no restrictions on the
> commands it can run through sudo, just like is provided for the user in
> the CI.
>
> For example (assuming a username of marta for you) something probably
> similar to the following entry in your /etc/sudoers (or equivalent) fil=
e:
>
>   marta	ALL=3D(ALL:ALL) NOPASSWD: ALL
>
> Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

Very well written.

> +test_lazy_prereq SUDO '
> +	sudo -n id -u >u &&
> +	id -u root >r &&
> +	test_cmp u r &&
> +	command -v git >u &&
> +	sudo command -v git >r &&
> +	test_cmp u r
> +'

I vaguely recall mentions of older dash that lack "command -v" made
earlier, but implementations of dash I have handy seem to know it.
I am personally fine with this as this script has a very narrow and
limited audience in mind.

> +test_expect_success SUDO 'setup' '
> +	sudo rm -rf root &&
> +	mkdir -p root/r &&
> +	sudo chown root root &&
> +	(
> +		cd root/r &&
> +		git init
> +	)
> +'

So, "root/" is owned by root, "root/r" is owned by the tester.

> +test_expect_failure SUDO 'sudo git status as original owner' '
> +	(
> +		cd root/r &&
> +		git status &&

The tester runs "git status" in "root/r" owned by the tester and it
should succeed.

> +		sudo git status

We want the tester to be able to do the same while temporarily
becoming 'root' with "sudo", but we know it fails right now.

> +	)
> +'

Mental note.  We do not need root to be owned by 'root' with the
tests we see here.  Perhaps we would add some that requires it in
later patches.  We'll see.

> +# this MUST be always the last test
> +test_expect_success SUDO 'cleanup' '
> +	sudo rm -rf root
> +'
> +
> +test_done

So far, looking good.

Thanks.
