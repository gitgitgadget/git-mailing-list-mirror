From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] zlib: initialize git_zstream in git_deflate_init{,_gzip,_raw}
Date: Thu, 05 Mar 2015 15:02:49 -0800
Message-ID: <xmqqd24n1206.fsf@gitster.dls.corp.google.com>
References: <54F8DD8A.8020202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 06 00:03:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTenC-0000mz-4G
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 00:02:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbbCEXCw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2015 18:02:52 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51719 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750914AbbCEXCv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2015 18:02:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 542133D623;
	Thu,  5 Mar 2015 18:02:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=u6V8BHA0Aswh
	5Z+gWyCKRo2bWxo=; b=s66CV9QoOSfVlSw68Sgr/ndzyGqHb8/Ae5sTqDi/bTrB
	J0hbhhQw7t8tPrUy65S/8hXbUVCwEJbC4g3TfRL8oQ1tjtD5dbAyIG46pQUtId2+
	eC8g7xAdFR6V/KK+Q3kzx0lfQ7YKdpT6jHY5j56UmjZs4zf07QbnVUHYS12K2Ww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=k7Kxek
	Fl7MA2jdqX23g2Lm0mI5JgGzBLUDe78b7yXqCzbXP2RpLPVlS66QNfsLZ00XNPyf
	+N2zdSmnLkFtZ2kxXJI8MKFzMs6fmQut9ae8mgJ72GAw5zLixP7mVncEgX9OTwhj
	KVV/DlqTLbbnTm5GLAxMDnGoGNUVmlR1lgMII=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B0083D622;
	Thu,  5 Mar 2015 18:02:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A75D73D620;
	Thu,  5 Mar 2015 18:02:50 -0500 (EST)
In-Reply-To: <54F8DD8A.8020202@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Thu, 05
	Mar 2015 23:49:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BF668754-C38B-11E4-A419-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264878>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Clear the git_zstream variable at the start of git_deflate_init() etc=
=2E
> so that callers don't have to do that.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>

Nice.  "git grep -B1 git_deflate_init" tells me that all existing
callers of the function do this memset().  Clearly the above is a
very good idea and is a safe and sane thing to do.

Thanks.

> ---
>  archive-zip.c          | 2 --
>  builtin/index-pack.c   | 1 -
>  builtin/pack-objects.c | 2 --
>  bulk-checkin.c         | 1 -
>  diff.c                 | 1 -
>  fast-import.c          | 3 ---
>  http-push.c            | 1 -
>  remote-curl.c          | 1 -
>  sha1_file.c            | 1 -
>  zlib.c                 | 2 ++
>  10 files changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/archive-zip.c b/archive-zip.c
> index 4bde019..1a54e1b 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -120,7 +120,6 @@ static void *zlib_deflate_raw(void *data, unsigne=
d long size,
>  	void *buffer;
>  	int result;
> =20
> -	memset(&stream, 0, sizeof(stream));
>  	git_deflate_init_raw(&stream, compression_level);
>  	maxsize =3D git_deflate_bound(&stream, size);
>  	buffer =3D xmalloc(maxsize);
> @@ -349,7 +348,6 @@ static int write_zip_entry(struct archiver_args *=
args,
>  		size_t out_len;
>  		unsigned char compressed[STREAM_BUFFER_SIZE * 2];
> =20
> -		memset(&zstream, 0, sizeof(zstream));
>  		git_deflate_init_raw(&zstream, args->compression_level);
> =20
>  		compressed_size =3D 0;
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 4632117..cf654df 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1204,7 +1204,6 @@ static int write_compressed(struct sha1file *f,=
 void *in, unsigned int size)
>  	int status;
>  	unsigned char outbuf[4096];
> =20
> -	memset(&stream, 0, sizeof(stream));
>  	git_deflate_init(&stream, zlib_compression_level);
>  	stream.next_in =3D in;
>  	stream.avail_in =3D size;
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index d816587..c3a7516 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -125,7 +125,6 @@ static unsigned long do_compress(void **pptr, uns=
igned long size)
>  	void *in, *out;
>  	unsigned long maxsize;
> =20
> -	memset(&stream, 0, sizeof(stream));
>  	git_deflate_init(&stream, pack_compression_level);
>  	maxsize =3D git_deflate_bound(&stream, size);
> =20
> @@ -153,7 +152,6 @@ static unsigned long write_large_blob_data(struct=
 git_istream *st, struct sha1fi
>  	unsigned char obuf[1024 * 16];
>  	unsigned long olen =3D 0;
> =20
> -	memset(&stream, 0, sizeof(stream));
>  	git_deflate_init(&stream, pack_compression_level);
> =20
>  	for (;;) {
> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 0c4b8a7..8d157eb 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -105,7 +105,6 @@ static int stream_to_pack(struct bulk_checkin_sta=
te *state,
>  	int write_object =3D (flags & HASH_WRITE_OBJECT);
>  	off_t offset =3D 0;
> =20
> -	memset(&s, 0, sizeof(s));
>  	git_deflate_init(&s, pack_compression_level);
> =20
>  	hdrlen =3D encode_in_pack_object_header(type, size, obuf);
> diff --git a/diff.c b/diff.c
> index d1bd534..dad875c 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2093,7 +2093,6 @@ static unsigned char *deflate_it(char *data,
>  	unsigned char *deflated;
>  	git_zstream stream;
> =20
> -	memset(&stream, 0, sizeof(stream));
>  	git_deflate_init(&stream, zlib_compression_level);
>  	bound =3D git_deflate_bound(&stream, size);
>  	deflated =3D xmalloc(bound);
> diff --git a/fast-import.c b/fast-import.c
> index aac2c24..77fb2ff 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1062,7 +1062,6 @@ static int store_object(
>  	} else
>  		delta =3D NULL;
> =20
> -	memset(&s, 0, sizeof(s));
>  	git_deflate_init(&s, pack_compression_level);
>  	if (delta) {
>  		s.next_in =3D delta;
> @@ -1090,7 +1089,6 @@ static int store_object(
>  			free(delta);
>  			delta =3D NULL;
> =20
> -			memset(&s, 0, sizeof(s));
>  			git_deflate_init(&s, pack_compression_level);
>  			s.next_in =3D (void *)dat->buf;
>  			s.avail_in =3D dat->len;
> @@ -1190,7 +1188,6 @@ static void stream_blob(uintmax_t len, unsigned=
 char *sha1out, uintmax_t mark)
> =20
>  	crc32_begin(pack_file);
> =20
> -	memset(&s, 0, sizeof(s));
>  	git_deflate_init(&s, pack_compression_level);
> =20
>  	hdrlen =3D encode_in_pack_object_header(OBJ_BLOB, len, out_buf);
> diff --git a/http-push.c b/http-push.c
> index 0beb7ab..bfb1c96 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -365,7 +365,6 @@ static void start_put(struct transfer_request *re=
quest)
>  	hdrlen =3D sprintf(hdr, "%s %lu", typename(type), len) + 1;
> =20
>  	/* Set it up */
> -	memset(&stream, 0, sizeof(stream));
>  	git_deflate_init(&stream, zlib_compression_level);
>  	size =3D git_deflate_bound(&stream, len + hdrlen);
>  	strbuf_init(&request->buffer.buf, size);
> diff --git a/remote-curl.c b/remote-curl.c
> index deb4bfe..af7b678 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -567,7 +567,6 @@ retry:
>  		git_zstream stream;
>  		int ret;
> =20
> -		memset(&stream, 0, sizeof(stream));
>  		git_deflate_init_gzip(&stream, Z_BEST_COMPRESSION);
>  		gzip_size =3D git_deflate_bound(&stream, rpc->len);
>  		gzip_body =3D xmalloc(gzip_size);
> diff --git a/sha1_file.c b/sha1_file.c
> index 69a60ec..88f06ba 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2943,7 +2943,6 @@ static int write_loose_object(const unsigned ch=
ar *sha1, char *hdr, int hdrlen,
>  	}
> =20
>  	/* Set it up */
> -	memset(&stream, 0, sizeof(stream));
>  	git_deflate_init(&stream, zlib_compression_level);
>  	stream.next_out =3D compressed;
>  	stream.avail_out =3D sizeof(compressed);
> diff --git a/zlib.c b/zlib.c
> index 61e6df0..4223f1a 100644
> --- a/zlib.c
> +++ b/zlib.c
> @@ -159,6 +159,7 @@ void git_deflate_init(git_zstream *strm, int leve=
l)
>  {
>  	int status;
> =20
> +	memset(strm, 0, sizeof(*strm));
>  	zlib_pre_call(strm);
>  	status =3D deflateInit(&strm->z, level);
>  	zlib_post_call(strm);
> @@ -172,6 +173,7 @@ static void do_git_deflate_init(git_zstream *strm=
, int level, int windowBits)
>  {
>  	int status;
> =20
> +	memset(strm, 0, sizeof(*strm));
>  	zlib_pre_call(strm);
>  	status =3D deflateInit2(&strm->z, level,
>  				  Z_DEFLATED, windowBits,
