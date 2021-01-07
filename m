Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E72C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E927230F9
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbhAGGZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 01:25:15 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56327 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbhAGGZP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 01:25:15 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F2871150C4;
        Thu,  7 Jan 2021 01:24:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6+llTm/ZIYcv
        tD6vLnAGYahu/1A=; b=D2Oq7DYqHQ5i+p6EGl1fXXeg0qkBslRZxQZ3UAT7ZNY6
        A4/Xgemso6lzHGfqS/Du752xj+UIvEHSo33CqSKyeNSvTKzyq81Drsd9lmYLHjan
        OABTpVGJZnsRYMPwZPTh7Qoh/4CMF6VpSzUxXGgiMoXjwrSst5xh13xnje1OFfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=W8Uj55
        N5KCAXF3xjozlmN26i8mArLlzR9MhJ2jB01ZpvQ8oDQYqdPHCgXObkrJMa70/WIS
        3z3nnIy+M/CzZyoF/fqLk88qoaWeSA7N0CtyMGdkNUp+T+Jw/vfOAkAMm2qFe5e6
        f0z1OIMYA7QckVH7nyBrSIKiFzbVeVRZQakOU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 795B81150C3;
        Thu,  7 Jan 2021 01:24:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 708041150C1;
        Thu,  7 Jan 2021 01:24:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t7800-difftool: don't accidentally match tmp dirs
References: <20201224092431.13354-1-szeder.dev@gmail.com>
Date:   Wed, 06 Jan 2021 22:24:27 -0800
In-Reply-To: <20201224092431.13354-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 24 Dec 2020 10:24:31 +0100")
Message-ID: <xmqq35zdnu1w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FF6D6012-50B0-11EB-B898-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index a578b35761..fe02fe1688 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -439,73 +439,104 @@ run_dir_diff_test () {
>  }
> =20
>  run_dir_diff_test 'difftool -d' '
> +	cat >expect <<-\EOF &&
> +	file
> +	file2
> +
> +	file
> +	file2
> +	sub
> +	EOF
>  	git difftool -d $symlinks --extcmd ls branch >output &&
> -	grep sub output &&
> -	grep file output
> +	grep -v ^/ output >actual &&

This unfortunately would not catch full paths on certain platforms.

See https://github.com/git/git/runs/1660588243?check_suite_focus=3Dtrue#s=
tep:7:4186
for an example X-<.

> +	test_cmp expect actual
>  '
