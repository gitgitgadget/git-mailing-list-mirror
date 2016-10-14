Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 687831F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 13:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932929AbcJNNUx (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:20:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932911AbcJNNUv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:20:51 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C07A8A7560;
        Fri, 14 Oct 2016 13:20:50 +0000 (UTC)
Received: from [10.36.4.60] (vpn1-4-60.ams2.redhat.com [10.36.4.60])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u9EDKlrb003629
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 14 Oct 2016 09:20:49 -0400
Subject: Re: [PATCH 2/2] resolve_ref_unsafe(): limit the number of "stat_ref"
 retries
To:     git@vger.kernel.org
References: <1476451012-9925-1-git-send-email-pstodulk@redhat.com>
 <1476451012-9925-3-git-send-email-pstodulk@redhat.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
From:   Petr Stodulka <pstodulk@redhat.com>
Message-ID: <855173d3-12b1-5b6c-4910-f19a8f3395b7@redhat.com>
Date:   Fri, 14 Oct 2016 15:20:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1476451012-9925-3-git-send-email-pstodulk@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="h7pju3rdwOo1xmOl2aNWvWPldWHxJjvDb"
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 14 Oct 2016 13:20:50 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h7pju3rdwOo1xmOl2aNWvWPldWHxJjvDb
Content-Type: multipart/mixed; boundary="kPo8273c9ouPd0UgrtxwDr7wMVR1DftUH";
 protected-headers="v1"
From: Petr Stodulka <pstodulk@redhat.com>
To: git@vger.kernel.org
Cc: Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <855173d3-12b1-5b6c-4910-f19a8f3395b7@redhat.com>
Subject: Re: [PATCH 2/2] resolve_ref_unsafe(): limit the number of "stat_ref"
 retries
References: <1476451012-9925-1-git-send-email-pstodulk@redhat.com>
 <1476451012-9925-3-git-send-email-pstodulk@redhat.com>
In-Reply-To: <1476451012-9925-3-git-send-email-pstodulk@redhat.com>

--kPo8273c9ouPd0UgrtxwDr7wMVR1DftUH
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

FYI,
I modified the patch slightly.

On 14.10.2016 15:16, Petr Stodulka wrote:
> From: Michael Haggerty <mhagger@alum.mit.edu>
>=20
> If there is a broken symlink where a loose reference file is expected,
> then the attempt to open() it fails with ENOENT. This error is
> misinterpreted to mean that the loose reference file itself has
> disappeared due to a race, causing the lookup to be retried. But in
> this scenario, the retries all suffer from the same problem, causing
> an infinite loop.
>=20
> So put a limit (of 5) on the number of times that the stat_ref step
> can be retried.
>=20
> Based-on-patch-by: Petr Stodulka <pstodulk@redhat.com>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs/files-backend.c | 6 ++++--
>  refs/refs-internal.h | 6 ++++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index d16feb1..245a0b5 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1353,6 +1353,7 @@ static int files_read_raw_ref(struct ref_store *r=
ef_store,
>  	int fd;
>  	int ret =3D -1;
>  	int save_errno;
> +	int retries =3D 0;
> =20
>  	*type =3D 0;
>  	strbuf_reset(&sb_path);
> @@ -1390,7 +1391,8 @@ static int files_read_raw_ref(struct ref_store *r=
ef_store,
>  	if (S_ISLNK(st.st_mode)) {
>  		strbuf_reset(&sb_contents);
>  		if (strbuf_readlink(&sb_contents, path, 0) < 0) {
> -			if (errno =3D=3D ENOENT || errno =3D=3D EINVAL)
> +			if ((errno =3D=3D ENOENT || errno =3D=3D EINVAL) &&
> +				retries++ < MAXRETRIES)=20
>  				/* inconsistent with lstat; retry */
>  				goto stat_ref;
>  			else
> @@ -1426,7 +1428,7 @@ static int files_read_raw_ref(struct ref_store *r=
ef_store,
>  	 */
>  	fd =3D open(path, O_RDONLY);
>  	if (fd < 0) {
> -		if (errno =3D=3D ENOENT)
> +		if (errno =3D=3D ENOENT && retries++ < MAXRETRIES)
>  			/* inconsistent with lstat; retry */
>  			goto stat_ref;
>  		else
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 708b260..37e6b99 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -255,6 +255,12 @@ int rename_ref_available(const char *old_refname, =
const char *new_refname);
>  /* We allow "recursive" symbolic refs. Only within reason, though */
>  #define SYMREF_MAXDEPTH 5
> =20
> +/*=20
> + * We allow only MAXRETRIES tries to jump on stat_ref, because of poss=
ible
> + * infinite loop
> + */
> +#define MAXRETRIES 5
> +
>  /* Include broken references in a do_for_each_ref*() iteration: */
>  #define DO_FOR_EACH_INCLUDE_BROKEN 0x01
> =20
>=20


--kPo8273c9ouPd0UgrtxwDr7wMVR1DftUH--

--h7pju3rdwOo1xmOl2aNWvWPldWHxJjvDb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYANurAAoJEPiGu5hNgNqPc+AQAJ80tgoLOwGw0713NNnBxhhA
YXqMpIZZsl34h7fU7nfI12ZwvWlTF4K6h0iiDdHv9ydwT8E2Kow2H/ya57+VRsPO
/RtkUa/A9gsNhtfCoT3WaJtMfurqMo2sKtGe0JAaGs+L84408rR2KHccKfvKJ/f1
F5tKgV7Ffdv7FKUeq2C+4XkyXprS8HPheVFAHkRPY4k85kc7DuKkMtWUSt74hSp2
P9LyMH4RtLr10/zlBLA6VuNjCSq2GmfUycWnCfmuMwhJ/d7GA89lkEqnCiJNLPF1
Iz3b0SZJV4yFcFQJLzeMLhimIOL1B35QJVYUSXc4vz2ztzNOGOzYC3ep6WRAR7f7
6sd309PpSpbIAtZrMAsr18UcU7x+AuUE/nWTr71vnl+uk07aFiDQilK0Rrfdyu+p
V+RDZzkV2Q6tE3K/a+zEuVqvXxcNYWAYHdCgKpqDkdNSwXcsBl7hHMGY7RZ6chb5
EPm/VjJWfTVOM4iTSAADpY9V7tAKPyLpwofGEsDZz7fQ+YTPYaae6dF86cHAzuns
zYV3HbkF+khXI+tQUs3dwL+r4EBNhk4KkGUg7r+z/GnAWXqBofsK4atOmbURUHcE
lIQwALfaqP8qO3g563OFDoA/f0fZWH5J1kh0sQk9+mkL/nHmEykoeivQo5nwWy8Q
nWpoduWjQlSOkFWODF9x
=sPcb
-----END PGP SIGNATURE-----

--h7pju3rdwOo1xmOl2aNWvWPldWHxJjvDb--
