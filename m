Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AB8C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 17:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C918C60E93
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 17:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhG3RQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 13:16:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55202 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhG3RQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 13:16:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75084E8C08;
        Fri, 30 Jul 2021 13:16:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MUYNvHYUUdkA
        1Lhd3uINymxS0R1c3G6Bmq7eduQS6do=; b=ipFiQr8pg/wVyQuimi7BUhr0g9pQ
        PyG1swpYviYkp5G8q3O8q9viprx6hXIAmjZnT91pJtvhZ3ISVBZlqcZefrN9Jr/Q
        /6D/QeLPH3G1H/egxkaWjHGIHsXc6gPlekQ4KegqMaekpYtjfFNLXO8OiBpGrV/n
        88iBvOpBg81LY9A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BCF6E8C07;
        Fri, 30 Jul 2021 13:16:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EF914E8C06;
        Fri, 30 Jul 2021 13:16:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        David Coppa <dcoppa@openbsd.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] t0001: fix broken not-quite getcwd(3) test in
 bed67874e2
References: <patch-1.1-c70791bbd3-20210601T003743Z-avarab@gmail.com>
        <patch-v2-1.1-d7d071441b0-20210730T161540Z-avarab@gmail.com>
Date:   Fri, 30 Jul 2021 10:16:51 -0700
In-Reply-To: <patch-v2-1.1-d7d071441b0-20210730T161540Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 30 Jul
 2021 18:18:14
        +0200")
Message-ID: <xmqqmtq3203g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EE7507AC-F159-11EB-8E51-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The problem with that fix is that while its analysis of the problem is
> correct, it doesn't actually call getcwd(3), instead it invokes "pwd
> -P". There is no guarantee that "pwd -P" is going to call getcwd(3),
> as opposed to e.g. being a shell built-in.
>
> On AIX under both bash and ksh this test breaks because "pwd -P" will
> happily display the current working directory, but getcwd(3) called by
> the "git init" we're testing here will fail to get it.

Well described.  And logically it leads to "when we want to know
getcwd() is OK to use, trying to run getcwd() to see it works is the
right way to do so", which is your test-getcwd.c?  Nice.

Will queue.

> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index 490ac026c51..3ce5585e53a 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -33,6 +33,7 @@ static struct test_cmd cmds[] =3D {
>  	{ "fast-rebase", cmd__fast_rebase },
>  	{ "genrandom", cmd__genrandom },
>  	{ "genzeros", cmd__genzeros },
> +	{ "getcwd", cmd__getcwd },
>  	{ "hashmap", cmd__hashmap },
>  	{ "hash-speed", cmd__hash_speed },
>  	{ "index-version", cmd__index_version },
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index f8dc266721f..9f0f5228508 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -23,6 +23,7 @@ int cmd__example_decorate(int argc, const char **argv=
);
>  int cmd__fast_rebase(int argc, const char **argv);
>  int cmd__genrandom(int argc, const char **argv);
>  int cmd__genzeros(int argc, const char **argv);
> +int cmd__getcwd(int argc, const char **argv);
>  int cmd__hashmap(int argc, const char **argv);
>  int cmd__hash_speed(int argc, const char **argv);
>  int cmd__index_version(int argc, const char **argv);
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index acd662e403b..df544bb321f 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -356,7 +356,10 @@ test_lazy_prereq GETCWD_IGNORES_PERMS '
>  	chmod 100 $base ||
>  	BUG "cannot prepare $base"
> =20
> -	(cd $base/dir && /bin/pwd -P)
> +	(
> +		cd $base/dir &&
> +		test-tool getcwd
> +	)
>  	status=3D$?
> =20
>  	chmod 700 $base &&
