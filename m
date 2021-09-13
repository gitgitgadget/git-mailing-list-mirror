Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D412CC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 01:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A70FE60F4A
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 01:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbhIMBF3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 21:05:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59427 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbhIMBF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 21:05:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E5480F6704;
        Sun, 12 Sep 2021 21:04:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1zesLi/R+/TB
        iJrJGDLnpBK9osptjAny6DVQu/T21DE=; b=REkjc/0JqHEiUS4AwO8W5JEB5fO3
        tlsT3JXdfD4ZHMSI5kUR/iJjtkE4iCo0/wKJDlTHS46Q/C4BcJl07NUqxnIKK2OH
        0YtE7COpsRhnrYy8n5Fe+X7usJ9uKLe1JN87UnG62JJeRFqUR6tedyOuUnfUVX6g
        yf7jsBhtyesQfBk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD125F6703;
        Sun, 12 Sep 2021 21:04:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E4C2F6702;
        Sun, 12 Sep 2021 21:04:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, lehmacdj@gmail.com
Subject: Re: [PATCH 1/3] t0301: fixes for windows compatibility
References: <20210912202830.25720-1-carenas@gmail.com>
        <20210912202830.25720-2-carenas@gmail.com>
Date:   Sun, 12 Sep 2021 18:04:12 -0700
In-Reply-To: <20210912202830.25720-2-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 12 Sep 2021 13:28:28 -0700")
Message-ID: <xmqq1r5ti8vn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 82A6F420-142E-11EC-A5FD-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> In preparation for a future patch that will allow building with
> Unix Sockets in Windows, workaround a couple of issues from the
> Mingw-W64 compatibility layer.
>
> test -S is not able to detect that a file is a socket, so use
> test -f instead.

The cause deserves to be sympathized, but ...

> +# in Windows, Unix Sockets look just like regular files
> +uname_s=3D$(uname -s)
> +case $uname_s in
> +*MINGW*)
> +	FLAG=3D-f
> +	;;
> +*)
> +	FLAG=3D-S
> +	;;
> +esac
> +
>  # don't leave a stale daemon running
>  test_atexit 'git credential-cache exit'
> =20
> @@ -21,7 +32,7 @@ test_expect_success 'socket defaults to ~/.cache/git/=
credential/socket' '
>  		rmdir -p .cache/git/credential/
>  	" &&
>  	test_path_is_missing "$HOME/.git-credential-cache" &&
> -	test -S "$HOME/.cache/git/credential/socket"
> +	test $FLAG "$HOME/.cache/git/credential/socket"

This is horrible.  Unlike the original, it is now impossible for a
casual reader to tell what this thing is testing, because $FLAG is
so generic a name that does not convey anything to readers.

Introduce a helper, say, "test_socket_exists", and replace "test -S"
with it.  In the implementation of that test_socket_exists() helper,
you can hide the difference between -f and -S.  In such a small scope,
you can even call the variable $FLAG if you want, as it is so isolated.

> -	mkdir -p -m 700 "$HOME/.git-credential-cache/" &&
> +	mkdir -p "$HOME/.git-credential-cache/" &&
> +	chmod 700 "$HOME/.git-credential-cache/" &&

OK.  This is the only use of "mkdir -m MODE" in the test suite.  It
is strange that you are OK with "mkdir && chmod 700" but not OK with
"mkdir -m 700" (it just is illogical, but we have to live with it,
as the real world may not be logical after all).

It is somewhat strange that we insist on mode 700 but the test does
not have SANITY as its prerequisite.  Does it really matter if we
set the permission bits to close the directory from others?  If not,
our "portability clean-up" could just be to lose "-m 700" here.

Thanks.

>  	check approve cache <<-\EOF &&
>  	protocol=3Dhttps
>  	host=3Dexample.com
>  	username=3Dstore-user
>  	password=3Dstore-pass
>  	EOF
> -	test -S "$HOME/.git-credential-cache/socket"
> +	test $FLAG "$HOME/.git-credential-cache/socket"
>  '
> =20
>  test_expect_success SYMLINKS 'use user socket if user directory is a s=
ymlink to a directory' '
> @@ -103,7 +115,7 @@ test_expect_success SYMLINKS 'use user socket if us=
er directory is a symlink to
>  	username=3Dstore-user
>  	password=3Dstore-pass
>  	EOF
> -	test -S "$HOME/.git-credential-cache/socket"
> +	test $FLAG "$HOME/.git-credential-cache/socket"
>  '
> =20
>  helper_test_timeout cache --timeout=3D1
