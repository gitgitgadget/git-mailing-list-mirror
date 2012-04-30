From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 4/5] archive-tar: stream large blobs to tar file
Date: Mon, 30 Apr 2012 23:08:09 +0200
Message-ID: <4F9EFF39.4010804@lsrfire.ath.cx>
References: <1335761837-12482-1-git-send-email-pclouds@gmail.com> <1335761837-12482-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 23:08:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOxpR-0001Qg-Up
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 23:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757227Ab2D3VIL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 17:08:11 -0400
Received: from india601.server4you.de ([85.25.151.105]:57784 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757222Ab2D3VIK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 17:08:10 -0400
Received: from [192.168.2.105] (p4FFDA315.dip.t-dialin.net [79.253.163.21])
	by india601.server4you.de (Postfix) with ESMTPSA id 9747E2F805D;
	Mon, 30 Apr 2012 23:08:09 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <1335761837-12482-5-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196610>

Am 30.04.2012 06:57, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy<pclouds@gmai=
l.com>
> ---
>   archive-tar.c    |   38 +++++++++++++++++++++++++++++++++++---
>   t/t1050-large.sh |    4 ++++
>   2 files changed, 39 insertions(+), 3 deletions(-)
>=20
> diff --git a/archive-tar.c b/archive-tar.c
> index 61821f4..865ef6d 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -4,6 +4,7 @@
>   #include "cache.h"
>   #include "tar.h"
>   #include "archive.h"
> +#include "streaming.h"
>   #include "run-command.h"
>=20
>   #define RECORDSIZE	(512)
> @@ -62,6 +63,29 @@ static void write_blocked(const void *data, unsign=
ed long size)
>   	write_if_needed();
>   }
>=20
> +static int stream_blob_to_file(const unsigned char *sha1)
> +{
> +	struct git_istream *st;
> +	enum object_type type;
> +	unsigned long sz;
> +
> +	st =3D open_istream(sha1,&type,&sz, NULL);
> +	if (!st)
> +		return error("cannot stream blob %s", sha1_to_hex(sha1));
> +	for (;;) {
> +		char buf[BLOCKSIZE];
> +		ssize_t readlen;
> +
> +		readlen =3D read_istream(st, buf, sizeof(buf));
> +
> +		if (readlen <=3D 0)
> +			return readlen;
> +		write_blocked(buf, readlen);
> +	}
> +	close_istream(st);
> +	return 0;
> +}

The stream is never closed.  Perhaps squash this in?


diff --git a/archive-tar.c b/archive-tar.c
index 506c8cb..6109fd3 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -66,6 +66,7 @@ static void write_blocked(const void *data, unsigned =
long size)
 static int stream_blob_to_file(const unsigned char *sha1)
 {
 	struct git_istream *st;
+	ssize_t readlen;
 	enum object_type type;
 	unsigned long sz;
=20
@@ -74,16 +75,15 @@ static int stream_blob_to_file(const unsigned char =
*sha1)
 		return error("cannot stream blob %s", sha1_to_hex(sha1));
 	for (;;) {
 		char buf[BLOCKSIZE];
-		ssize_t readlen;
=20
 		readlen =3D read_istream(st, buf, sizeof(buf));
=20
 		if (readlen <=3D 0)
-			return readlen;
+			break;
 		write_blocked(buf, readlen);
 	}
 	close_istream(st);
-	return 0;
+	return readlen;
 }
=20
 /*
