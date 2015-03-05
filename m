From: =?windows-1252?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] archive-zip: add --text parameter
Date: Thu, 05 Mar 2015 16:27:48 +0100
Message-ID: <54F875F4.1080508@web.de>
References: <12g5ss8uqwflv.dlg@nililand.de> <54F77573.80109@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: luatex@nililand.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 16:28:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTXh6-0005UX-SD
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 16:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932848AbbCEP2G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2015 10:28:06 -0500
Received: from mout.web.de ([212.227.15.4]:60589 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932797AbbCEP2F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 10:28:05 -0500
Received: from [192.168.178.27] ([79.250.191.206]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LyUy6-1XRCya0Ea6-015n4R; Thu, 05 Mar 2015 16:28:02
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <54F77573.80109@web.de>
X-Provags-ID: V03:K0:2Cnm/svnmVBzlU6T5VoioLeIDlqDl13n8kuooSbDUpxmVyb6q7r
 42ej9leoZ0G9bTcFYC6mSXeFZTj7z1441MR5vq1toysRUzsNFI0vJ0Tr5bTY/A6I1P00TL3
 awoVbvxLudPWzh2nHeiQfTkKViEabtR/xVw+7zL4CmUgNgvlx6EHqul/zCg0ukczIOiOmVN
 uxVxLXWZk4RSBH3GBNQeg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264841>

Am 04.03.2015 um 22:13 schrieb Ren=E9 Scharfe:
> diff --git a/archive-zip.c b/archive-zip.c
> index 4bde019..3767940 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -5,6 +5,7 @@
>   #include "archive.h"
>   #include "streaming.h"
>   #include "utf8.h"
> +#include "xdiff-interface.h"
>
>   static int zip_date;
>   static int zip_time;
> @@ -210,6 +211,7 @@ static int write_zip_entry(struct archiver_args *=
args,
>   	struct git_istream *stream =3D NULL;
>   	unsigned long flags =3D 0;
>   	unsigned long size;
> +	int is_binary =3D -1;
>
>   	crc =3D crc32(0, NULL, 0);
>
> @@ -238,8 +240,14 @@ static int write_zip_entry(struct archiver_args =
*args,
>   		method =3D 0;
>   		attr2 =3D S_ISLNK(mode) ? ((mode | 0777) << 16) :
>   			(mode & 0111) ? ((mode) << 16) : 0;
> -		if (S_ISREG(mode) && args->compression_level !=3D 0 && size > 0)
> -			method =3D 8;
> +		if (S_ISREG(mode)) {
> +			if (args->compression_level !=3D 0 && size > 0)
> +				method =3D 8;
> +			if (args->text =3D=3D ARCHIVE_TEXT_ALL)
> +				is_binary =3D 0;
> +			else if (args->text =3D=3D ARCHIVE_TEXT_NONE)
> +				is_binary =3D 1;
> +		}
>
>   		if (S_ISREG(mode) && type =3D=3D OBJ_BLOB && !args->convert &&
>   		    size > big_file_threshold) {
> @@ -256,6 +264,8 @@ static int write_zip_entry(struct archiver_args *=
args,
>   				return error("cannot read %s",
>   					     sha1_to_hex(sha1));
>   			crc =3D crc32(crc, buffer, size);
> +			if (is_binary < 0)
> +				is_binary =3D buffer_is_binary(buffer, size);
>   			out =3D buffer;
>   		}
>   		compressed_size =3D (method =3D=3D 0) ? size : 0;
> @@ -300,7 +310,6 @@ static int write_zip_entry(struct archiver_args *=
args,
>   	copy_le16(dirent.extra_length, ZIP_EXTRA_MTIME_SIZE);
>   	copy_le16(dirent.comment_length, 0);
>   	copy_le16(dirent.disk, 0);
> -	copy_le16(dirent.attr1, 0);
>   	copy_le32(dirent.attr2, attr2);
>   	copy_le32(dirent.offset, zip_offset);
>
> @@ -328,6 +337,8 @@ static int write_zip_entry(struct archiver_args *=
args,
>   			if (readlen <=3D 0)
>   				break;
>   			crc =3D crc32(crc, buf, readlen);
> +			if (is_binary < 0)
> +				is_binary =3D buffer_is_binary(buffer, size);

buffer is NULL here, so this crashes.  buf and readlen have to be used=20
instead.  This code path is only used for entries that are too big to b=
e=20
compressed in one go.

>   			write_or_die(1, buf, readlen);
>   		}
>   		close_istream(stream);
> @@ -361,6 +372,8 @@ static int write_zip_entry(struct archiver_args *=
args,
>   			if (readlen <=3D 0)
>   				break;
>   			crc =3D crc32(crc, buf, readlen);
> +			if (is_binary < 0)
> +				is_binary =3D buffer_is_binary(buffer, size);

Same here.

>   			zstream.next_in =3D buf;
>   			zstream.avail_in =3D readlen;
> @@ -405,6 +418,8 @@ static int write_zip_entry(struct archiver_args *=
args,
>   	free(deflated);
>   	free(buffer);
>
> +	copy_le16(dirent.attr1, !is_binary);
> +
>   	memcpy(zip_dir + zip_dir_offset, &dirent, ZIP_DIR_HEADER_SIZE);
>   	zip_dir_offset +=3D ZIP_DIR_HEADER_SIZE;
>   	memcpy(zip_dir + zip_dir_offset, path, pathlen);
> @@ -466,7 +481,7 @@ static int write_zip_archive(const struct archive=
r *ar,
>   static struct archiver zip_archiver =3D {
>   	"zip",
>   	write_zip_archive,
> -	ARCHIVER_WANT_COMPRESSION_LEVELS|ARCHIVER_REMOTE
> +	ARCHIVER_WANT_COMPRESSION_LEVELS|ARCHIVER_REMOTE|ARCHIVER_TEXT_ATTR=
IBUTE
>   };
>
>   void init_zip_archiver(void)
