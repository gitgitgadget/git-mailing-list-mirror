Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895CDC433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 16:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68EAA61156
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 16:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhJNQ3C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 12:29:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63183 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbhJNQ3B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 12:29:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A9C71155DB7;
        Thu, 14 Oct 2021 12:26:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yNiNGL4JJaK/
        S09PN57PzoL3JdfLD3YBHVCiiyaXgKo=; b=M546c+6mbQGx/05cC2G6bIaHN+z8
        kdJXUtT8zi93zJDwircQ83y9t1ALhb12j5Lcu8I5vTz08OIaaLbceb/Xd8LWO960
        OKl6VIgm4vEBYL9tzvEFyyNK/Fai/YHow153OukVt2kjOTn/YdsdX5VcW6pxO63c
        mV7RyYj9KBkhNZw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2B5F155DB6;
        Thu, 14 Oct 2021 12:26:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0502A155DB5;
        Thu, 14 Oct 2021 12:26:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] test-lib.sh: de-duplicate error() teardown code
References: <cover-0.2-00000000000-20211014T004542Z-avarab@gmail.com>
        <patch-1.2-d4c67829076-20211014T004542Z-avarab@gmail.com>
Date:   Thu, 14 Oct 2021 09:26:52 -0700
In-Reply-To: <patch-1.2-d4c67829076-20211014T004542Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 14 Oct
 2021 02:47:28 +0200")
Message-ID: <xmqqzgrbd12r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8AEDA5FC-2D0B-11EC-BEF5-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> De-duplicate the "finalize_junit_xml; GIT_EXIT_OK=3Dt; exit 1" code
> shared between the "error()" and "--immediate on failure" code paths,
> in preparation for adding a third user in a subsequent commit.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/test-lib.sh | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Nice.  I do recall seeing the duplication when these finalize-junit
calls were introduced and thought about marking it as a leftover
clean-up candidate.  Nice to see it done here.

Thanks.

>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 8361b5c1c57..c610f09ddb1 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -589,13 +589,17 @@ USER_TERM=3D"$TERM"
>  TERM=3Ddumb
>  export TERM USER_TERM
> =20
> -error () {
> -	say_color error "error: $*"
> +_error_exit () {
>  	finalize_junit_xml
>  	GIT_EXIT_OK=3Dt
>  	exit 1
>  }
> =20
> +error () {
> +	say_color error "error: $*"
> +	_error_exit
> +}
> +
>  BUG () {
>  	error >&7 "bug in the test script: $*"
>  }
> @@ -720,7 +724,7 @@ test_failure_ () {
>  	say_color error "not ok $test_count - $1"
>  	shift
>  	printf '%s\n' "$*" | sed -e 's/^/#	/'
> -	test "$immediate" =3D "" || { finalize_junit_xml; GIT_EXIT_OK=3Dt; ex=
it 1; }
> +	test "$immediate" =3D "" || _error_exit
>  }
> =20
>  test_known_broken_ok_ () {
