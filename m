Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C4EC2B9F4
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 06:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B4A76117A
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 06:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhFSGXI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 02:23:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53408 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhFSGXH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 02:23:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3A3F313F3C6;
        Sat, 19 Jun 2021 02:20:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9/3zg4STX8KR
        Sas1mbAxoqiEPZWKszLolIKAUH8sU8w=; b=u5FzRxY7k1Pw+4RjYcNfFSt4RnhB
        hUIe6Eg3JVqmqnPSHMXAO47CJ4MKp5AnYguoxtT2Fj9eXg7zaL2cg9VgLu5Ps/wC
        yhPaE8kePfljf41RzagV/RM/AQSHfTXzK5+7xhzvjnlyRX8n/d2YU8FiiUF4PaQO
        HDO9aQEKvYZsDds=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 260A813F3C5;
        Sat, 19 Jun 2021 02:20:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5CEB913F3C3;
        Sat, 19 Jun 2021 02:20:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] t: use portable wrapper for readlink(1)
References: <YMzKlrmHFZdx2ti9@coredump.intra.peff.net>
Date:   Sat, 19 Jun 2021 15:20:52 +0900
In-Reply-To: <YMzKlrmHFZdx2ti9@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 18 Jun 2021 12:32:22 -0400")
Message-ID: <xmqqbl82l6ij.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 80905498-D0C6-11EB-8137-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Not all systems have a readlink program available for use by the shell.
> This causes t3210 to fail on at least AIX. Let's provide a perl
> one-liner to do the same thing, and use it there.
>
> I also updated calls in t9802. Nobody reported failure there, but it's
> the same issue. Presumably nobody actually tests with p4 on AIX in the
> first place (if it is even available there).
>
> I left the use of readlink in the "--valgrind" setup in test-lib.sh, as
> valgrind isn't available on exotic platforms anyway (and I didn't want
> to increase dependencies between test-lib.sh and test-lib-functions.sh)=
.
>
> There's one other curious case. Commit d2addc3b96 (t7800: readlink may
> not be available, 2016-05-31) fixed a similar case. We can't use our
> wrapper function there, though, as it's inside a sub-script triggered b=
y
> Git. It uses a slightly different technique ("ls" piped to "sed"). I
> chose not to use that here as it gives confusing "ls -l" output if the
> file is unexpectedly not a symlink (which is OK for its limited use, bu=
t
> potentially confusing for general use within the test suite). The perl
> version emits the empty string.
>
> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is a re-post that doesn't seem to have made it into "seen"; the
> original[1] was buried in a thread, but =C3=86var reported there that i=
t
> fixes t3210 on his AIX build.

Yeah, I think I've seen this one and thought I have queued it.
Thanks for resurrecting.

By the way, I'll be mostly offline next week and won't be back to
full speed til the end of the month (it's time to migrate in the
other direction).

> [1] https://lore.kernel.org/git/YLk0Zm2J6VOA%2Flks@coredump.intra.peff.=
net/
>
>  t/t3210-pack-refs.sh       | 2 +-
>  t/t9802-git-p4-filetype.sh | 4 ++--
>  t/test-lib-functions.sh    | 6 ++++++
>  3 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
> index 3b7cdc56ec..577f32dc71 100755
> --- a/t/t3210-pack-refs.sh
> +++ b/t/t3210-pack-refs.sh
> @@ -253,7 +253,7 @@ test_expect_success SYMLINKS 'pack symlinked packed=
-refs' '
>  	git for-each-ref >all-refs-packed &&
>  	test_cmp all-refs-before all-refs-packed &&
>  	test -h .git/packed-refs &&
> -	test "$(readlink .git/packed-refs)" =3D "my-deviant-packed-refs"
> +	test "$(test_readlink .git/packed-refs)" =3D "my-deviant-packed-refs"
>  '
> =20
>  test_done
> diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
> index 94edebe272..19073c6e9f 100755
> --- a/t/t9802-git-p4-filetype.sh
> +++ b/t/t9802-git-p4-filetype.sh
> @@ -263,7 +263,7 @@ test_expect_success SYMLINKS 'ensure p4 symlink par=
sed correctly' '
>  	(
>  		cd "$git" &&
>  		test -L symlink &&
> -		test $(readlink symlink) =3D symlink-target
> +		test $(test_readlink symlink) =3D symlink-target
>  	)
>  '
> =20
> @@ -329,7 +329,7 @@ test_expect_success SYMLINKS 'empty symlink target'=
 '
>  	git p4 clone --dest=3D"$git" //depot@all &&
>  	(
>  		cd "$git" &&
> -		test $(readlink empty-symlink) =3D target2
> +		test $(test_readlink empty-symlink) =3D target2
>  	)
>  '
> =20
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index f0448daa74..b2810478a2 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1708,3 +1708,9 @@ test_region () {
> =20
>  	return 0
>  }
> +
> +# Print the destination of symlink(s) provided as arguments. Basically
> +# the same as the readlink command, but it's not available everywhere.
> +test_readlink () {
> +	perl -le 'print readlink($_) for @ARGV' "$@"
> +}
