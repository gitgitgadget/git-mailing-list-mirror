From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH 4/4] diff: mark any file larger than
 core.bigfilethreshold binary
Date: Thu, 19 Jun 2014 14:27:25 +0200
Message-ID: <1403180845.10052.16.camel@thomas-debian-x64>
References: <CACsJy8BM1f1pJPzGPf--a-kUim6wyX+Mr1AfMupY3mpREY+8DA@mail.gmail.com>
	 <1401368227-14469-1-git-send-email-pclouds@gmail.com>
	 <1401368227-14469-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, worley@alum.mit.edu,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 14:27:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxbRH-0006v3-KX
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 14:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbaFSM1b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2014 08:27:31 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:37045 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932336AbaFSM1a (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jun 2014 08:27:30 -0400
Received: from p5ddc18b9.dip0.t-ipconnect.de ([93.220.24.185] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1WxbR8-0004us-Az; Thu, 19 Jun 2014 14:27:26 +0200
In-Reply-To: <1401368227-14469-4-git-send-email-pclouds@gmail.com>
X-Mailer: Evolution 3.4.4-3 
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1403180850;1661c079;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252110>

Am Donnerstag, den 29.05.2014, 19:57 +0700 schrieb Nguy=E1=BB=85n Th=C3=
=A1i Ng=E1=BB=8Dc Duy:

Hi,

sorry for chiming in so late.

I've just played around with patch 3 and 4 of that series.
And I like it very much as I work often with large files so any further=
=20
enhancement in that area is really nice.

(see comments below)

> Too large files may lead to failure to allocate memory. If it happens
> here, it could impact quite a few commands that involve
> diff. Moreover, too large files are inefficient to compare anyway (an=
d
> most likely non-text), so mark them binary and skip looking at their
> content.
>=20
> Noticed-by: Dale R. Worley <worley@alum.mit.edu>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  diff.c           | 26 ++++++++++++++++++--------
>  diffcore.h       |  1 +
>  t/t1050-large.sh |  4 ++++
>  3 files changed, 23 insertions(+), 8 deletions(-)
>=20
> diff --git a/diff.c b/diff.c
> index 54281cb..0a2f865 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2185,8 +2185,8 @@ int diff_filespec_is_binary(struct diff_filespe=
c *one)
>  			one->is_binary =3D one->driver->binary;
>  		else {
>  			if (!one->data && DIFF_FILE_VALID(one))
> -				diff_populate_filespec(one, 0);
> -			if (one->data)
> +				diff_populate_filespec(one, DIFF_POPULATE_IS_BINARY);
> +			if (one->is_binary =3D=3D -1 && one->data)
>  				one->is_binary =3D buffer_is_binary(one->data,
>  						one->size);
>  			if (one->is_binary =3D=3D -1)
> @@ -2721,6 +2721,11 @@ int diff_populate_filespec(struct diff_filespe=
c *s, unsigned int flags)
>  		}
>  		if (size_only)
>  			return 0;
> +		if ((flags & DIFF_POPULATE_IS_BINARY) &&
> +		    s->size > big_file_threshold && s->is_binary =3D=3D -1) {
> +			s->is_binary =3D 1;
> +			return 0;
> +		}

Why do you check for s->is_binary =3D=3D -1 here? I think it does not m=
atter
what s_is_binary says here.

>  		fd =3D open(s->path, O_RDONLY);
>  		if (fd < 0)
>  			goto err_empty;
> @@ -2742,16 +2747,21 @@ int diff_populate_filespec(struct diff_filesp=
ec *s, unsigned int flags)
>  	}
>  	else {
>  		enum object_type type;
> -		if (size_only) {
> +		if (size_only || (flags & DIFF_POPULATE_IS_BINARY)) {
>  			type =3D sha1_object_info(s->sha1, &s->size);
>  			if (type < 0)
>  				die("unable to read %s", sha1_to_hex(s->sha1));
> -		} else {
> -			s->data =3D read_sha1_file(s->sha1, &type, &s->size);
> -			if (!s->data)
> -				die("unable to read %s", sha1_to_hex(s->sha1));
> -			s->should_free =3D 1;
> +			if (size_only)
> +				return 0;
> +			if (s->size > big_file_threshold && s->is_binary =3D=3D -1) {
same as above.
> +				s->is_binary =3D 1;
> +				return 0;
> +			}
>  		}
> +		s->data =3D read_sha1_file(s->sha1, &type, &s->size);
> +		if (!s->data)
> +			die("unable to read %s", sha1_to_hex(s->sha1));
> +		s->should_free =3D 1;
>  	}
>  	return 0;
>  }
> diff --git a/diffcore.h b/diffcore.h
> index a186d7c..e7760d9 100644
> --- a/diffcore.h
> +++ b/diffcore.h
> @@ -56,6 +56,7 @@ extern void fill_filespec(struct diff_filespec *, c=
onst unsigned char *,
>  			  int, unsigned short);
> =20
>  #define DIFF_POPULATE_SIZE_ONLY 1
> +#define DIFF_POPULATE_IS_BINARY 2
>  extern int diff_populate_filespec(struct diff_filespec *, unsigned i=
nt);
>  extern void diff_free_filespec_data(struct diff_filespec *);
>  extern void diff_free_filespec_blob(struct diff_filespec *);
> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
> index 333909b..4d922e2 100755
> --- a/t/t1050-large.sh
> +++ b/t/t1050-large.sh
> @@ -112,6 +112,10 @@ test_expect_success 'diff --raw' '
>  	git diff --raw HEAD^
>  '
> =20
> +test_expect_success 'diff --stat' '
> +	git diff --stat HEAD^ HEAD
> +'
> +
>  test_expect_success 'hash-object' '
>  	git hash-object large1
>  '

I would also add a note to the documentation e. g:

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9f467d3..7a2f27d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -499,7 +499,8 @@ core.bigFileThreshold::
        Files larger than this size are stored deflated, without
        attempting delta compression.  Storing large files without
        delta compression avoids excessive memory usage, at the
-       slight expense of increased disk usage.
+       slight expense of increased disk usage.  Additionally files
+       larger than this size are allways treated as binary.
 +
 Default is 512 MiB on all platforms.  This should be reasonable
 for most projects as source code and other text files can still

Thomas
