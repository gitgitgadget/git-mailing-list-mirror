Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rjrNt1PI"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA559BD
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 14:30:43 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9E7492F9D8;
	Tue, 12 Dec 2023 17:30:43 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XzBzfs1U994y
	04gQsdLNraCXB9OzkDZb+DXTuyfI4+I=; b=rjrNt1PIkdZxUIXMSgfEINwvC1De
	yYrIT3DwFLGBh27aOr8KRAo/imgH7uQ9RxMWpzouu0TUMfUrBMIlSdxhpln5Kgrp
	+a2lwLIUePknuPax4TosEFPgwlPyhSomFvcudRUZ6pTeugIx8SsfyBthr3Vgp2sf
	9K921TrHH103xLs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 96C4D2F9D7;
	Tue, 12 Dec 2023 17:30:43 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 37B532F9D5;
	Tue, 12 Dec 2023 17:30:40 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Ondrej Pohorelsky <opohorel@redhat.com>,  git@vger.kernel.org,  "brian m
 . carlson" <sandals@crustytoothpaste.net>
Subject: Re: Test breakage with zlib-ng
In-Reply-To: <9feeb6cf-aabf-4002-917f-3f6c27547bc8@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Tue, 12 Dec 2023 18:04:55 +0100")
References: <CA+B51BEpSh1wT627Efpysw3evVocpiDCoQ3Xaza6jKE3B62yig@mail.gmail.com>
	<9feeb6cf-aabf-4002-917f-3f6c27547bc8@web.de>
Date: Tue, 12 Dec 2023 14:30:38 -0800
Message-ID: <xmqqv893oxyp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 144971FA-993E-11EE-B374-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Or we could get the sizes of the objects by checking their files,
> which would not require  hard-coding anymore.  Patch below.

That was my first reaction to seeing the original report.  It is a
bit surprising that the necessary fix is so small and makes me wonder
why we initially did the hardcoded values, which feels more work to
initially write the test vector.

Looking good.  Thanks.

> --- >8 ---
> Subject: [PATCH] t6300: avoid hard-coding object sizes
>
> f4ee22b526 (ref-filter: add tests for objectsize:disk, 2018-12-24)
> hard-coded the expected object sizes.  Coincidentally the size of commi=
t
> and tag is the same with zlib at the default compression level.
>
> 1f5f8f3e85 (t6300: abstract away SHA-1-specific constants, 2020-02-22)
> encoded the sizes as a single value, which coincidentally also works
> with sha256.
>
> Different compression libraries like zlib-ng may arrive at different
> values.  Get them from the file system instead of hard-coding them to
> make switching the compression library (or changing the compression
> level) easier.
>
> Reported-by: Ondrej Pohorelsky <opohorel@redhat.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  t/t6300-for-each-ref.sh | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 54e2281259..843a7fe143 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -20,12 +20,13 @@ setdate_and_increment () {
>      export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
>  }
>
> -test_expect_success setup '
> -	test_oid_cache <<-EOF &&
> -	disklen sha1:138
> -	disklen sha256:154
> -	EOF
> +test_object_file_size () {
> +	oid=3D$(git rev-parse "$1")
> +	path=3D".git/objects/$(test_oid_to_path $oid)"
> +	test_file_size "$path"
> +}
>
> +test_expect_success setup '
>  	# setup .mailmap
>  	cat >.mailmap <<-EOF &&
>  	A Thor <athor@example.com> A U Thor <author@example.com>
> @@ -94,7 +95,6 @@ test_atom () {
>  }
>
>  hexlen=3D$(test_oid hexsz)
> -disklen=3D$(test_oid disklen)
>
>  test_atom head refname refs/heads/main
>  test_atom head refname: refs/heads/main
> @@ -129,7 +129,7 @@ test_atom head push:strip=3D1 remotes/myfork/main
>  test_atom head push:strip=3D-1 main
>  test_atom head objecttype commit
>  test_atom head objectsize $((131 + hexlen))
> -test_atom head objectsize:disk $disklen
> +test_atom head objectsize:disk $(test_object_file_size refs/heads/main=
)
>  test_atom head deltabase $ZERO_OID
>  test_atom head objectname $(git rev-parse refs/heads/main)
>  test_atom head objectname:short $(git rev-parse --short refs/heads/mai=
n)
> @@ -203,8 +203,8 @@ test_atom tag upstream ''
>  test_atom tag push ''
>  test_atom tag objecttype tag
>  test_atom tag objectsize $((114 + hexlen))
> -test_atom tag objectsize:disk $disklen
> -test_atom tag '*objectsize:disk' $disklen
> +test_atom tag objectsize:disk $(test_object_file_size refs/tags/testta=
g)
> +test_atom tag '*objectsize:disk' $(test_object_file_size refs/heads/ma=
in)
>  test_atom tag deltabase $ZERO_OID
>  test_atom tag '*deltabase' $ZERO_OID
>  test_atom tag objectname $(git rev-parse refs/tags/testtag)
> --
> 2.43.0
