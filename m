Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8638C433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 18:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32716103A
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 18:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhKKSok (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 13:44:40 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64717 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbhKKSoj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 13:44:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B0DC2163C9B;
        Thu, 11 Nov 2021 13:41:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=coreQRbLuoJy
        bx5x+qV6lNIx/9ay9LXv8atteYERFd0=; b=yTQUVUH7Ugz2zMGsn2VjnkWymo/R
        vMQKkmVGVRXXJIzbJI2JG2XiflU/fMlELfUCREIqAHQhHVU5K4R62UKjRQcmTRfZ
        o46mxcsocSO29Gtv16VgV1tNKXWjVOH/LGq3DN95kQ04k0STXq2RCwErgHZlnZQ1
        TR6nstCzRf7Q8Tw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A9726163C9A;
        Thu, 11 Nov 2021 13:41:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 15AB7163C95;
        Thu, 11 Nov 2021 13:41:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han Xin <chiyutianyi@gmail.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/2] object-file: fix SEGV on free() regression in
 v2.34.0-rc2
References: <20211111030532.75910-1-hanxin.hx@alibaba-inc.com>
        <cover-0.2-00000000000-20211111T051800Z-avarab@gmail.com>
        <patch-1.2-811242178e4-20211111T051800Z-avarab@gmail.com>
Date:   Thu, 11 Nov 2021 10:41:46 -0800
In-Reply-To: <patch-1.2-811242178e4-20211111T051800Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 11 Nov
 2021 06:18:55 +0100")
Message-ID: <xmqqtugilel1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0656FBC0-431F-11EC-AEA6-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix a regression introduced in my 96e41f58fe1 (fsck: report invalid
> object type-path combinations, 2021-10-01). When fsck-ing blobs larger
> than core.bigFileThreshold we'd free() a pointer to uninitialized
> memory.

s/d we'd/d, we'd/; no need to resend.

> This issue would have been caught by SANITIZE=3Daddress, but since it
> involves core.bigFileThreshold none of the existing tests in our test
> suite covered it.

s/d none/d, none/; likewise.

> Running them with the "big_file_threshold" in "environment.c" changed
> to say "6" would have shown this failure, but let's add a dedicated
> test for this scenario based on Han Xin's report[1].

Yeah, it is a good and focused test. =20

By the way, I do not think changing big_file_threshold _blindly_ to
smaller values, instead of in a focused test like this, is a good
idea in general.  Some tests check if a file with a normal size that
is smaller than the threshold correctly is treated as a binary file,
and lowering threshold for them without understanding what they are
meant to test would trigger a "bug" that is not a bug at all, for
example.

> It would be a good follow-up change to add a GIT_TEST_* mode to run
> all the tests with a low core.bigFileThreshold threshold.

So, no, please don't do that.

>  object-file.c    | 2 ++
>  t/t1050-large.sh | 8 ++++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/object-file.c b/object-file.c
> index 02b79702748..ac476653a06 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2528,6 +2528,8 @@ int read_loose_object(const char *path,
>  	char hdr[MAX_HEADER_LEN];
>  	unsigned long *size =3D oi->sizep;
> =20
> +	*contents =3D NULL;
> +
>  	map =3D map_loose_object_1(the_repository, path, NULL, &mapsize);
>  	if (!map) {
>  		error_errno(_("unable to mmap %s"), path);
> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
> index 4bab6a513c5..6bc1d76fb10 100755
> --- a/t/t1050-large.sh
> +++ b/t/t1050-large.sh
> @@ -17,6 +17,14 @@ test_expect_success setup '
>  	export GIT_ALLOC_LIMIT
>  '
> =20
> +test_expect_success 'enter "large" codepath, with small core.bigFileTh=
reshold' '
> +	test_when_finished "rm -rf repo" &&
> +
> +	git init --bare repo &&
> +	echo large | git -C repo hash-object -w --stdin &&
> +	git -C repo -c core.bigfilethreshold=3D4 fsck
> +'
> +
>  # add a large file with different settings
>  while read expect config
>  do
