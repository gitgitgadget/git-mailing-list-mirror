X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: sizeof(struct ...)
Date: Thu, 23 Nov 2006 13:55:50 +0000
Message-ID: <4565A866.8020201@shadowen.org>
References: <20061123101609.1711.qmail@8b73034525b1a6.315fe32.mid.smarden.org> <45659781.5050005@lsrfire.ath.cx> <4565A46C.6090805@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 23 Nov 2006 13:56:24 +0000 (UTC)
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
In-Reply-To: <4565A46C.6090805@lsrfire.ath.cx>
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32140>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnF3n-0003Yz-Bt for gcvg-git@gmane.org; Thu, 23 Nov
 2006 14:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933719AbWKWN4E convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006 08:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933720AbWKWN4D
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 08:56:03 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:13327 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S933719AbWKWN4B
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 08:56:01 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1GnF2h-0000Ye-Lz; Thu, 23 Nov 2006 13:55:07 +0000
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org

Ren=E9 Scharfe wrote:
> Oh no, whitespace damage!  The major downside of getting a new
> machine is that Thunderbird needs to be beaten into submission
> again. :-(  Here's the patch a second time, hopefully intact.
>=20
> Ren=E9
>=20

This structure represents an on-disk/on-the-wire thing, should we not b=
e
specifying it in some architecture neutral way?  You are going to get
the length right in the case of tail padding but not in the face of any
other padding internally.

You see packing attributes applied to similar things in the kernel.
Perhaps they are relevant here?
Is there not some kind of attribute thing we can apply to this structur=
e
to prevent the padding?  You see that in the kernel from time to time.

struct foo {
} __attribute__((packed));

-apw

>=20
>  archive-zip.c |   24 ++++++++++++++++++------
>  1 files changed, 18 insertions(+), 6 deletions(-)
>=20
> diff --git a/archive-zip.c b/archive-zip.c
> index ae5572a..4caaec4 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -35,6 +35,7 @@ struct zip_local_header {
>  	unsigned char size[4];
>  	unsigned char filename_length[2];
>  	unsigned char extra_length[2];
> +	unsigned char _end[0];
>  };
> =20
>  struct zip_dir_header {
> @@ -55,6 +56,7 @@ struct zip_dir_header {
>  	unsigned char attr1[2];
>  	unsigned char attr2[4];
>  	unsigned char offset[4];
> +	unsigned char _end[0];
>  };
> =20
>  struct zip_dir_trailer {
> @@ -66,8 +68,18 @@ struct zip_dir_trailer {
>  	unsigned char size[4];
>  	unsigned char offset[4];
>  	unsigned char comment_length[2];
> +	unsigned char _end[0];
>  };
> =20
> +/*
> + * On ARM, padding is added at the end of the struct, so a simple
> + * sizeof(struct ...) reports two bytes more than the payload size
> + * we're interested in.
> + */
> +#define ZIP_LOCAL_HEADER_SIZE	offsetof(struct zip_local_header, _end=
)
> +#define ZIP_DIR_HEADER_SIZE	offsetof(struct zip_dir_header, _end)
> +#define ZIP_DIR_TRAILER_SIZE	offsetof(struct zip_dir_trailer, _end)
> +
>  static void copy_le16(unsigned char *dest, unsigned int n)
>  {
>  	dest[0] =3D 0xff & n;
> @@ -211,7 +223,7 @@ static int write_zip_entry(const unsigne
>  	}
> =20
>  	/* make sure we have enough free space in the dictionary */
> -	direntsize =3D sizeof(struct zip_dir_header) + pathlen;
> +	direntsize =3D ZIP_DIR_HEADER_SIZE + pathlen;
>  	while (zip_dir_size < zip_dir_offset + direntsize) {
>  		zip_dir_size +=3D ZIP_DIRECTORY_MIN_SIZE;
>  		zip_dir =3D xrealloc(zip_dir, zip_dir_size);
> @@ -234,8 +246,8 @@ static int write_zip_entry(const unsigne
>  	copy_le16(dirent.attr1, 0);
>  	copy_le32(dirent.attr2, attr2);
>  	copy_le32(dirent.offset, zip_offset);
> -	memcpy(zip_dir + zip_dir_offset, &dirent, sizeof(struct zip_dir_hea=
der));
> -	zip_dir_offset +=3D sizeof(struct zip_dir_header);
> +	memcpy(zip_dir + zip_dir_offset, &dirent, ZIP_DIR_HEADER_SIZE);
> +	zip_dir_offset +=3D ZIP_DIR_HEADER_SIZE;
>  	memcpy(zip_dir + zip_dir_offset, path, pathlen);
>  	zip_dir_offset +=3D pathlen;
>  	zip_dir_entries++;
> @@ -251,8 +263,8 @@ static int write_zip_entry(const unsigne
>  	copy_le32(header.size, uncompressed_size);
>  	copy_le16(header.filename_length, pathlen);
>  	copy_le16(header.extra_length, 0);
> -	write_or_die(1, &header, sizeof(struct zip_local_header));
> -	zip_offset +=3D sizeof(struct zip_local_header);
> +	write_or_die(1, &header, ZIP_LOCAL_HEADER_SIZE);
> +	zip_offset +=3D ZIP_LOCAL_HEADER_SIZE;
>  	write_or_die(1, path, pathlen);
>  	zip_offset +=3D pathlen;
>  	if (compressed_size > 0) {
> @@ -282,7 +294,7 @@ static void write_zip_trailer(const unsi
>  	copy_le16(trailer.comment_length, sha1 ? 40 : 0);
> =20
>  	write_or_die(1, zip_dir, zip_dir_offset);
> -	write_or_die(1, &trailer, sizeof(struct zip_dir_trailer));
> +	write_or_die(1, &trailer, ZIP_DIR_TRAILER_SIZE);
>  	if (sha1)
>  		write_or_die(1, sha1_to_hex(sha1), 40);
>  }
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
