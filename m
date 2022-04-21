Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A051EC433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 22:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442433AbiDUWZK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 18:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238958AbiDUWZI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 18:25:08 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A85142EF4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 15:22:17 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BD0A12A5C1;
        Thu, 21 Apr 2022 18:22:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=aExuotFGok2a
        fyuJl83LPYE8i4rJ6TeeIBF/oXQ85Zs=; b=cnAkiNfx2vM27UrHz3z/HVOI4aPY
        AC8lMen8zo01LvMt1i9v+OymxNHqQkoSrIVGqoIxfEwqhk1mBGONUsNg+lWxoKXb
        HOKPK0+k6vUO3CAC7Ms9xlhRNxZVN2fgjAlxXuvDzszN2uXBFthmVEj0Qcx4X0sU
        AO0T9OeYtiUhw7A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 715CA12A5C0;
        Thu, 21 Apr 2022 18:22:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E017C12A5BF;
        Thu, 21 Apr 2022 18:22:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Hans Jerry Illikainen <hji@dyntopia.com>
Subject: Re: [PATCH 1/4] tests: make RUNTIME_PREFIX compatible with --valgrind
References: <cover-0.4-00000000000-20220421T200733Z-avarab@gmail.com>
        <patch-1.4-315da7c2df0-20220421T200733Z-avarab@gmail.com>
Date:   Thu, 21 Apr 2022 15:22:14 -0700
In-Reply-To: <patch-1.4-315da7c2df0-20220421T200733Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Apr
 2022 22:14:34 +0200")
Message-ID: <xmqqlevydqll.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7FD792E0-C1C1-11EC-822C-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Subject: Re: [PATCH 1/4] tests: make RUNTIME_PREFIX compatible with --v=
algrind

The patch text looks more like=20

	tests: --valgrind does not work with RUNTIME_PREFIX

to me.  Is it true that a test that only works with RUNTIME_PREFIX
does not work under --valgrind at all?  I am wondering if we can do
this without introducing a new prerequisite, and if it makes sense
to do so if it can be done.  The output from

    $ git grep 'test_expect_success .*RUNTIME_PREFIX' t/

tells me that there are two test pieces that must be run under
RUNTIME_PREFIX, and this patch touches both of them.

I guess it is not RUNTIME_PREFIX build itself per-se, but it is
the way we test RUNTIME_PREFIX is incompatible with how we run our
tests under --valgrind, so neither the title on the Subject: header
of this message or "looks more like" above is a good one.  It is
more like

	tests: using custom GIT_EXEC_PATH breaks --valgrind tests

I think.

And after having looked at the patch text and thought about the
issues enough to come up with the above updated title, I can say
that the change looks quite reasonable, both the body of the
proposed log message and the solution.  Nicely done.

It would have been even nicer if I didn't have to think about the
issues myself, though ;-)

Thanks.

> Fix a regression in b7d11a0f5d2 (tests: exercise the RUNTIME_PREFIX
> feature, 2021-07-24) where tests that want to set up and test a "git"
> wrapper in $PATH conflicted with the t/bin/valgrind wrapper(s) doing
> the same.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t0060-path-utils.sh | 4 ++--
>  t/test-lib.sh         | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index 2fe6ae6a4e5..aa35350b6f3 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -542,7 +542,7 @@ test_lazy_prereq CAN_EXEC_IN_PWD '
>  	./git rev-parse
>  '
> =20
> -test_expect_success RUNTIME_PREFIX,CAN_EXEC_IN_PWD 'RUNTIME_PREFIX wor=
ks' '
> +test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD 'RUNTIME_=
PREFIX works' '
>  	mkdir -p pretend/bin pretend/libexec/git-core &&
>  	echo "echo HERE" | write_script pretend/libexec/git-core/git-here &&
>  	cp "$GIT_EXEC_PATH"/git$X pretend/bin/ &&
> @@ -550,7 +550,7 @@ test_expect_success RUNTIME_PREFIX,CAN_EXEC_IN_PWD =
'RUNTIME_PREFIX works' '
>  	echo HERE >expect &&
>  	test_cmp expect actual'
> =20
> -test_expect_success RUNTIME_PREFIX,CAN_EXEC_IN_PWD '%(prefix)/ works' =
'
> +test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD '%(prefix=
)/ works' '
>  	mkdir -p pretend/bin &&
>  	cp "$GIT_EXEC_PATH"/git$X pretend/bin/ &&
>  	git config yes.path "%(prefix)/yes" &&
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 531cef097db..7f3d323e937 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1666,6 +1666,7 @@ test -n "$USE_LIBPCRE2" && test_set_prereq PCRE
>  test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
>  test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
>  test -n "$SANITIZE_LEAK" && test_set_prereq SANITIZE_LEAK
> +test -n "$GIT_VALGRIND_ENABLED" && test_set_prereq VALGRIND
> =20
>  if test -z "$GIT_TEST_CHECK_CACHE_TREE"
>  then
