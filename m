Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1AA274FDE
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162661; cv=none; b=IkpJqptOc//gC8KbWaKwwPYAOlfIAfOVa10uofY7xi23rLc7EaKxvx+lDBZvM0hUYQT6T4+AQLMwrjZGzDAhsq5UEMigNPPxERoWyFe2UyWJc8MqcsWhQkTVT+yrGJuTjmpztx5jTPiERO0nxsSFCGV2rRlOOVq3I8KR47gzAAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162661; c=relaxed/simple;
	bh=agDmncD5LkBoYcs9DXW29MCvpFKcfHcvy1dlmAHMVRo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AwwrGVH25bxpxBeBB6Vy7r5tVW0Dlp+M3DI4O8lIvPqso0eBro4mY2ql44EtyupLnVdaKWLxa1GGFsQKb6Hb8/jCVHSpltYwKheYj7PAnw9BY7t91BuvsTpfylwlzAVojrVZAtRSqnPN13ve4L90kAd4nYbHZI1stxRjsEUoTg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpsz11t1752162584t1adf3cba
X-QQ-Originating-IP: 2vF53YFEggKke1IJ4YBeoHP6LlOibbRgM1P0H6uJCV0=
Received: from smtpclient.apple ( [202.119.44.124])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Jul 2025 23:49:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8865972795330565231
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v5.1 4/4] bloom: optimize multiple pathspec items in
 revision
From: Lidong Yan <502024330056@smail.nju.edu.cn>
In-Reply-To: <2619038e-05f5-4af8-bb20-e4e01138f839@gmail.com>
Date: Thu, 10 Jul 2025 23:49:40 +0800
Cc: git@vger.kernel.org,
 gitster@pobox.com,
 toon@iotcl.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <EF8BBC5E-52A7-46D4-8B7B-9EFB2B726852@smail.nju.edu.cn>
References: <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
 <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
 <20250710084829.2171855-5-502024330056@smail.nju.edu.cn>
 <2619038e-05f5-4af8-bb20-e4e01138f839@gmail.com>
To: Derrick Stolee <stolee@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OUC5DGN0mB58Y3GDSJPVST7diq2QxGf7HJMbyDn+HVV8SQX77h5nNUTs
	6l+Lg9F1KB1DqHu2vIby77Nk1kJC6yfZ8eWPMriTQxylAJKo2JQpA/aSqx3e2wbGPnrkV/E
	Ye/WfFMmmKvDNMz9H3DeT8x4bN6Pkt6jNMA/8ZyTZBOW9RJPoSbXdgSYxk5sRbFFYzMwqhe
	wBDyZy51vOdMuQveJncuhMNV+HCrJPL7tuXrgLZCDIwupfpiOJC0YhcfU+ZPP24EmIaKLpP
	IjhiBmIesrLpaaSHkW654mGYs50tqTgN67mA00Dokh6OE/Vtz35eR68xjX8EkaNpsADnVVY
	V9RjM1tCL2zQAlCmsb0J1LLeJJOqlMVRK4BrcoMuZyHdMH8zVhNFElxCETYms6X3sbQ/SfI
	3+BuZN05FwRy3kjzlMVWFnASz/p/YayAxGT9nCzCVZgpmroZ5RBd3SEc4wGz0YL+DqfMag2
	cl1CaN4vIGVd4+t25YoYcp50i1tMQkLiaKGnWMSxcQBQnlJUgfO3O2LgS1LV1BfHVeSPzzD
	rAcIr6CWBkpMgk7EPR1Zi9am/X4M17yTLrf8/yokJnLXZuK8IAg0OvLoaU59tUfqfg2sLEk
	2WWhMlvIQ7DZE1MHvq9pLs4s3LXPeMZ4FVYKTY4fvFhlokPtgKqnjc22D4G6cat0uh9zKYn
	xglWwpxgHPFc2OIdNMsIUIU2/pRu1ZWzQ98SNIP/XEdDkTvnQGlmAlgG7EIjbYLTA4VWgyX
	h3G+TXCxmhrxa9CHyz299n3jVyJlN21N66TQfzrplFILyhcKugqXyYTgJTS/nOMhiEUrMy6
	jUqAQambHTluT76Z9AfWfg9Z1c4lqrWrwOeTG4PN7bBw9zTbkOoFsoLQtb1beTiy9mlVoDQ
	9MY5wLHQqV2sFPhScGA0zVdb9Eh5V7/vmsBJmpFQ6KdEPdJ33LUNiBzzvqOxdydcwYAZZw3
	iBu8u7uVzz2ljc885+x52QDMud6HRm69Oi8j0xuNdvV+zofAmUTSmgp7gD9Vyp6kwEU2s5b
	DvbZhmc3KptBFW/Qsw
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Derrick Stolee <stolee@gmail.com> wrote:
>=20
> --- >8 ---
>=20
> =46rom fe255b1acfbe90fa8e4c335435ae18ee95e6243c Mon Sep 17 00:00:00 =
2001
> From: Lidong Yan <502024330056@smail.nju.edu.cn>
> Date: Thu, 10 Jul 2025 08:04:34 -0400
> Subject: [PATCH v5.1 4/4] bloom: optimize multiple pathspec items in =
revision
> traversal
>=20
> To enable optimize multiple pathspec items in revision traversal,
> return 0 if all pathspec item is literal in forbid_bloom_filters().
> Add for loops to initialize and check each pathspec item's =
bloom_keyvec
> when optimization is possible.
>=20
> Add new test cases in t/t4216-log-bloom.sh to ensure
>  - consistent results between the optimization for multiple pathspec
>    items using bloom filter and the case without bloom filter
>    optimization.
>  - does not use bloom filter if any pathspec item is not literal.
>=20
> With these optimizations, we get some improvements for multi-pathspec =
runs
> of 'git log'. First, in the Git repository we see these modest =
results:
>=20
> Benchmark 1: old
>  Time (mean =C2=B1 =CF=83):      73.1 ms =C2=B1   2.9 ms
>  Range (min =E2=80=A6 max):    69.9 ms =E2=80=A6  84.5 ms    42 runs
>=20
> Benchmark 2: new
>  Time (mean =C2=B1 =CF=83):      55.1 ms =C2=B1   2.9 ms
>  Range (min =E2=80=A6 max):    51.1 ms =E2=80=A6  61.2 ms    52 runs
>=20
> Summary
>  'new' ran
>    1.33 =C2=B1 0.09 times faster than 'old'
>=20
> But in a larger repo, such as the LLVM project repo below, we get even
> better results:
>=20
> Benchmark 1: old
>  Time (mean =C2=B1 =CF=83):      1.974 s =C2=B1  0.006 s
>  Range (min =E2=80=A6 max):    1.960 s =E2=80=A6  1.983 s    10 runs
>=20
> Benchmark 2: new
>  Time (mean =C2=B1 =CF=83):     262.9 ms =C2=B1   2.4 ms
>  Range (min =E2=80=A6 max):   257.7 ms =E2=80=A6 266.2 ms    11 runs
>=20
> Summary
>  'new' ran
>    7.51 =C2=B1 0.07 times faster than 'old'

Hyperfine do looks better. I will put this into commit message and
cover letter in v6.

>=20
> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
> revision.c           | 22 +++++++++++-----------
> t/t4216-log-bloom.sh | 23 ++++++++++++++---------
> 2 files changed, 25 insertions(+), 20 deletions(-)
>=20
> diff --git a/revision.c b/revision.c
> index 4c09b594c55..ca8c1dde8ca 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -675,12 +675,11 @@ static int forbid_bloom_filters(struct pathspec =
*spec)
> {
> if (spec->has_wildcard)
> return 1;
> - if (spec->nr > 1)
> - return 1;
> if (spec->magic & ~PATHSPEC_LITERAL)
> return 1;
> - if (spec->nr && (spec->items[0].magic & ~PATHSPEC_LITERAL))
> - return 1;
> + for (size_t nr =3D 0; nr < spec->nr; nr++)
> + if (spec->items[nr].magic & ~PATHSPEC_LITERAL)
> + return 1;
>=20
> return 0;
> }
> @@ -733,13 +732,14 @@ static void prepare_to_use_bloom_filter(struct =
rev_info *revs)
> if (!revs->pruning.pathspec.nr)
> return;
>=20
> - revs->bloom_keyvecs_nr =3D 1;
> - CALLOC_ARRAY(revs->bloom_keyvecs, 1);
> -
> - if (convert_pathspec_to_filter(&revs->pruning.pathspec.items[0],
> -       &revs->bloom_keyvecs[0],
> -       revs->bloom_filter_settings))
> - goto fail;
> + revs->bloom_keyvecs_nr =3D revs->pruning.pathspec.nr;
> + CALLOC_ARRAY(revs->bloom_keyvecs, revs->bloom_keyvecs_nr);
> + for (int i =3D 0; i < revs->pruning.pathspec.nr; i++) {
> + if (convert_pathspec_to_filter(&revs->pruning.pathspec.items[i],
> +       &revs->bloom_keyvecs[i],
> +       revs->bloom_filter_settings))
> + goto fail;
> + }
>=20
> if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
> atexit(trace2_bloom_filter_statistics_atexit);
> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> index 8910d53cac1..639868ac562 100755
> --- a/t/t4216-log-bloom.sh
> +++ b/t/t4216-log-bloom.sh
> @@ -66,8 +66,9 @@ sane_unset GIT_TRACE2_CONFIG_PARAMS
>=20
> setup () {
> rm -f "$TRASH_DIRECTORY/trace.perf" &&
> - git -c core.commitGraph=3Dfalse log --pretty=3D"format:%s" $1 =
>log_wo_bloom &&
> - GIT_TRACE2_PERF=3D"$TRASH_DIRECTORY/trace.perf" git -c =
core.commitGraph=3Dtrue log --pretty=3D"format:%s" $1 >log_w_bloom
> + eval git -c core.commitGraph=3Dfalse log --pretty=3D"format:%s" "$1" =
>log_wo_bloom &&
> + eval "GIT_TRACE2_PERF=3D\"$TRASH_DIRECTORY/trace.perf\"" \
> + git -c core.commitGraph=3Dtrue log --pretty=3D"format:%s" "$1" =
>log_w_bloom
> }
>=20
> test_bloom_filters_used () {
> @@ -138,10 +139,6 @@ test_expect_success 'git log with --walk-reflogs =
does not use Bloom filters' '
> test_bloom_filters_not_used "--walk-reflogs -- A"
> '
>=20
> -test_expect_success 'git log -- multiple path specs does not use =
Bloom filters' '
> - test_bloom_filters_not_used "-- file4 A/file1"
> -'
> -
> test_expect_success 'git log -- "." pathspec at root does not use =
Bloom filters' '
> test_bloom_filters_not_used "-- ."
> '
> @@ -151,9 +148,17 @@ test_expect_success 'git log with wildcard that =
resolves to a single path uses B
> test_bloom_filters_used "-- *renamed"
> '
>=20
> -test_expect_success 'git log with wildcard that resolves to a =
multiple paths does not uses Bloom filters' '
> - test_bloom_filters_not_used "-- *" &&
> - test_bloom_filters_not_used "-- file*"
> +test_expect_success 'git log with multiple literal paths uses Bloom =
filter' '
> + test_bloom_filters_used "-- file4 A/file1" &&
> + test_bloom_filters_used "-- *" &&
> + test_bloom_filters_used "-- file*"
> +'
> +
> +test_expect_success 'git log with path contains a wildcard does not =
use Bloom filter' '
> + test_bloom_filters_not_used "-- file\*" &&
> + test_bloom_filters_not_used "-- A/\* file4" &&
> + test_bloom_filters_not_used "-- file4 A/\*" &&
> + test_bloom_filters_not_used "-- * A/\*"
> '
>=20
> test_expect_success 'setup - add commit-graph to the chain without =
Bloom filters' '
> --=20
> 2.47.2.vfs.0.2
>=20

Looks great, I will apply this above patch 3.

Thanks,
Lidong

