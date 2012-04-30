From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/5] archive: delegate blob reading to backend
Date: Mon, 30 Apr 2012 23:07:46 +0200
Message-ID: <4F9EFF22.4060105@lsrfire.ath.cx>
References: <1335761837-12482-1-git-send-email-pclouds@gmail.com> <1335761837-12482-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 23:07:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOxp3-0001Ep-4a
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 23:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756813Ab2D3VHt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 17:07:49 -0400
Received: from india601.server4you.de ([85.25.151.105]:57778 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756581Ab2D3VHs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 17:07:48 -0400
Received: from [192.168.2.105] (p4FFDA315.dip.t-dialin.net [79.253.163.21])
	by india601.server4you.de (Postfix) with ESMTPSA id 444B72F805D;
	Mon, 30 Apr 2012 23:07:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <1335761837-12482-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196608>

Am 30.04.2012 06:57, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> archive-tar.c and archive-zip.c now perform conversion check, with
> help of sha1_file_to_archive() from archive.c
>=20
> This gives backends more freedom in dealing with (streaming) large
> blobs.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy<pclouds@gmai=
l.com>
> ---
>   archive-tar.c |   20 +++++++++++++++++---
>   archive-zip.c |   14 ++++++++++++--
>   archive.c     |   28 +++++++++++-----------------
>   archive.h     |   10 +++++++++-
>   4 files changed, 49 insertions(+), 23 deletions(-)
>=20
> diff --git a/archive-tar.c b/archive-tar.c
> index 6c8a0bd..61821f4 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -161,11 +161,15 @@ static int write_extended_header(struct archive=
r_args *args,
>   }
>=20
>   static int write_tar_entry(struct archiver_args *args,
> -		const unsigned char *sha1, const char *path, size_t pathlen,
> -		unsigned int mode, void *buffer, unsigned long size)
> +			   const unsigned char *sha1,
> +			   const char *path, size_t pathlen,
> +			   unsigned int mode)
>   {
>   	struct ustar_header header;
>   	struct strbuf ext_header =3D STRBUF_INIT;
> +	unsigned int old_mode =3D mode;
> +	unsigned long size;
> +	void *buffer;
>   	int err =3D 0;
>=20
>   	memset(&header, 0, sizeof(header));
> @@ -199,7 +203,17 @@ static int write_tar_entry(struct archiver_args =
*args,
>   	} else
>   		memcpy(header.name, path, pathlen);
>=20
> -	if (S_ISLNK(mode)&&  buffer) {
> +	if (S_ISLNK(mode) || S_ISREG(mode)) {
> +		enum object_type type;
> +		buffer =3D sha1_file_to_archive(args, path, sha1, old_mode,&type,&=
size);

This buffer is never freed.

> +		if (!buffer)
> +			return error("cannot read %s", sha1_to_hex(sha1));
> +	} else {
> +		buffer =3D NULL;
> +		size =3D 0;
> +	}
> +
> +	if (S_ISLNK(mode)) {
>   		if (size>  sizeof(header.linkname)) {
>   			sprintf(header.linkname, "see %s.paxheader",
>   			        sha1_to_hex(sha1));
> diff --git a/archive-zip.c b/archive-zip.c
> index 02d1f37..f8039ba 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -121,8 +121,9 @@ static void *zlib_deflate(void *data, unsigned lo=
ng size,
>   }
>=20
>   static int write_zip_entry(struct archiver_args *args,
> -		const unsigned char *sha1, const char *path, size_t pathlen,
> -		unsigned int mode, void *buffer, unsigned long size)
> +			   const unsigned char *sha1,
> +			   const char *path, size_t pathlen,
> +			   unsigned int mode)
>   {
>   	struct zip_local_header header;
>   	struct zip_dir_header dirent;
> @@ -134,6 +135,8 @@ static int write_zip_entry(struct archiver_args *=
args,
>   	int method;
>   	unsigned char *out;
>   	void *deflated =3D NULL;
> +	void *buffer;
> +	unsigned long size;
>=20
>   	crc =3D crc32(0, NULL, 0);
>=20
> @@ -148,7 +151,14 @@ static int write_zip_entry(struct archiver_args =
*args,
>   		out =3D NULL;
>   		uncompressed_size =3D 0;
>   		compressed_size =3D 0;
> +		buffer =3D NULL;
> +		size =3D 0;
>   	} else if (S_ISREG(mode) || S_ISLNK(mode)) {
> +		enum object_type type;
> +		buffer =3D sha1_file_to_archive(args, path, sha1, mode,&type,&size=
);

This one is leaked as well.

> +		if (!buffer)
> +			return error("cannot read %s", sha1_to_hex(sha1));
> +
>   		method =3D 0;
>   		attr2 =3D S_ISLNK(mode) ? ((mode | 0777)<<  16) :
>   			(mode&  0111) ? ((mode)<<  16) : 0;

You could squash this in:


diff --git a/archive-tar.c b/archive-tar.c
index 61821f4..bb320ad 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -235,6 +235,7 @@ static int write_tar_entry(struct archiver_args *ar=
gs,
 	write_blocked(&header, sizeof(header));
 	if (S_ISREG(mode) && buffer && size > 0)
 		write_blocked(buffer, size);
+	free(buffer);
 	return err;
 }
=20
diff --git a/archive-zip.c b/archive-zip.c
index f8039ba..716cc42 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -239,6 +239,7 @@ static int write_zip_entry(struct archiver_args *ar=
gs,
 	}
=20
 	free(deflated);
+	free(buffer);
=20
 	return 0;
 }
