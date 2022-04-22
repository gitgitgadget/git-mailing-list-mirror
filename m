Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C15C433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 23:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiDVXIX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 19:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbiDVXH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 19:07:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E02180EF3
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 15:40:09 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 333B3182EA5;
        Fri, 22 Apr 2022 18:40:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GmpVL/yyRcb9
        CEZwY8F/94YLghLdxQTtBiP2Kl5Aon4=; b=c302qHb7jFY1NRkOFlCvJBRaG2xF
        /364h0h06O/v6Gk79a0MShjMQmLUXRJK4lOWajIHqTnZfaJ03kAjXi9LKoLbDseJ
        IQgmemXIKQb9/XJvGQLnIgqqQtgKm9tM1UUX8RMh4KicDTczf3b283uCtCbhCMFr
        moSZL/fUu9eOUgI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B883182EA4;
        Fri, 22 Apr 2022 18:40:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0CB30182EA3;
        Fri, 22 Apr 2022 18:40:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Arenas <carenas@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v3] CI: select CC based on CC_PACKAGE (again)
References: <patch-v2-1.1-92acf9420a9-20220421T174733Z-avarab@gmail.com>
        <patch-v3-1.1-8b3444ecc87-20220422T092015Z-avarab@gmail.com>
Date:   Fri, 22 Apr 2022 15:40:02 -0700
In-Reply-To: <patch-v3-1.1-8b3444ecc87-20220422T092015Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 22 Apr
 2022 11:20:53
        +0200")
Message-ID: <xmqqy1zw4u9p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 26E99350-C28D-11EC-9A47-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix a regression in 707d2f2fe86 (CI: use "$runs_on_pool", not
> "$jobname" to select packages & config, 2021-11-23).
>
> In that commit I changed CC=3Dgcc from CC=3Dgcc-9, but on OSX the "gcc"=
 in
> $PATH points to clang, we need to use gcc-9 instead. Likewise for the
> linux-gcc job CC=3Dgcc-8 was changed to the implicit CC=3Dgcc, which wo=
uld
> select GCC 9.4.0 instead of GCC 8.4.0.
>
> Furthermore in 25715419bf4 (CI: don't run "make test" twice in one
> job, 2021-11-23) when the "linux-TEST-vars" job was split off from
> "linux-gcc" the "cc_package: gcc-8" line was copied along with
> it, so its "cc_package" line wasn't working as intended either.
>
> As a table, this is what's changed by this commit, i.e. it only
> affects the linux-gcc, linux-TEST-vars and osx-gcc jobs:
>
> 	|-------------------+-----------+-------------------+-------+-------|
> 	| jobname           | vector.cc | vector.cc_package | old   | new   |
> 	|-------------------+-----------+-------------------+-------+-------|
> 	| linux-clang       | clang     | -                 | clang | clang |
> 	| linux-sha256      | clang     | -                 | clang | clang |
> 	| linux-gcc         | gcc       | gcc-8             | gcc   | gcc-8 |
> 	| osx-clang         | clang     | -                 | clang | clang |
> 	| osx-gcc           | gcc       | gcc-9             | clang | gcc-9 |
> 	| linux-gcc-default | gcc       | -                 | gcc   | gcc   |
> 	| linux-TEST-vars   | gcc       | gcc-8             | gcc   | gcc-8 |
> 	|-------------------+-----------+-------------------+-------+-------|
>
> Reported-by: Carlo Arenas <carenas@gmail.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>
> I just dropped the linux-TEST-vars change from the v2 in lieu of
> trying to get the wording in the commit message right.

I plan to fast-track this; the revamp of ci/lib.sh in the other huge
series would probably need to be rebased on top, or independently
fix it the same way.

In the meantime, here is what I'll throwing into today's 'seen'.

diff --cc ci/lib.sh
index 86e37da9bc,80e89f89b7..0000000000
--- i/ci/lib.sh
+++ w/ci/lib.sh
@@@ -195,6 -224,79 +224,79 @@@ ubuntu-latest
  esac
 =20
  case "$jobname" in
+ windows-build)
+ 	setenv --build NO_PERL NoThanks
+ 	setenv --build ARTIFACTS_DIRECTORY artifacts
+ 	;;
+ windows-test)
+ 	setenv --test MAKEFLAGS "$COMMON_MAKEFLAGS"
+ 	;;
+ vs-build)
+ 	setenv --build DEVELOPER $DEVELOPER
+ 	setenv --build SKIP_DASHED_BUILT_INS $SKIP_DASHED_BUILT_INS
+=20
+ 	setenv --build NO_PERL NoThanks
+ 	setenv --build NO_GETTEXT NoThanks
+ 	setenv --build ARTIFACTS_DIRECTORY artifacts
+ 	setenv --build INCLUDE_DLLS_IN_ARTIFACTS YesPlease
+ 	setenv --build MSVC YesPlease
+=20
+ 	setenv --build GIT_CONFIG_COUNT 2
+ 	setenv --build GIT_CONFIG_KEY_0 user.name
+ 	setenv --build GIT_CONFIG_VALUE_0 CI
+ 	setenv --build GIT_CONFIG_KEY_1 user.emailname
+ 	setenv --build GIT_CONFIG_VALUE_1 ci@git
+ 	setenv --build GIT_CONFIG_VALUE_1 ci@git
+ 	;;
+ vs-test)
+ 	setenv --test NO_SVN_TESTS YesPlease
+ 	setenv --test MAKEFLAGS "$COMMON_MAKEFLAGS"
+ 	;;
+ linux-gcc)
 -	CC=3Dgcc
++	CC=3Dgcc-8
+ 	setenv --test GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME main
+ 	;;
+ linux-gcc-default)
+ 	CC=3Dgcc
+ 	;;
+ linux-TEST-vars)
 -	CC=3Dgcc
++	CC=3Dgcc-8
+ 	setenv --test GIT_TEST_SPLIT_INDEX yes
+ 	setenv --test GIT_TEST_MERGE_ALGORITHM recursive
+ 	setenv --test GIT_TEST_FULL_IN_PACK_ARRAY true
+ 	setenv --test GIT_TEST_OE_SIZE 10
+ 	setenv --test GIT_TEST_OE_DELTA_SIZE 5
+ 	setenv --test GIT_TEST_COMMIT_GRAPH 1
+ 	setenv --test GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS 1
+ 	setenv --test GIT_TEST_MULTI_PACK_INDEX 1
+ 	setenv --test GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP 1
+ 	setenv --test GIT_TEST_ADD_I_USE_BUILTIN 1
+ 	setenv --test GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME master
+ 	setenv --test GIT_TEST_WRITE_REV_INDEX 1
+ 	setenv --test GIT_TEST_CHECKOUT_WORKERS 2
+ 	;;
+ osx-gcc)
+ 	MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D$(which python3)"
 -	CC=3Dgcc
++	CC=3Dgcc-9
+ 	;;
+ osx-clang)
+ 	MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D$(which python2)"
+ 	CC=3Dclang
+ 	;;
+ linux-clang)
+ 	CC=3Dclang
+ 	setenv --test GIT_TEST_DEFAULT_HASH sha1
+ 	;;
+ linux-sha256)
+ 	CC=3Dclang
+ 	setenv --test GIT_TEST_DEFAULT_HASH sha256
+ 	;;
+ pedantic)
+ 	CC=3Dgcc
+ 	# Don't run the tests; we only care about whether Git can be
+ 	# built.
+ 	setenv --build DEVOPTS pedantic
+ 	;;
  linux32)
  	CC=3Dgcc
  	;;

