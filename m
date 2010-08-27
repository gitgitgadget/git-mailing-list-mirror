From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Reduce zlib deflate code duplication
Date: Thu, 26 Aug 2010 21:37:54 -0500
Message-ID: <20100827023754.GB23924@burratino>
References: <1282856164-5126-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 27 04:40:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoorD-00005O-Kd
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 04:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381Ab0H0Cjk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Aug 2010 22:39:40 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40476 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab0H0Cjj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Aug 2010 22:39:39 -0400
Received: by gyd8 with SMTP id 8so933919gyd.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 19:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZEzt6I30/2wJhHCaCDnFH3BNFKqoWB1HU0LiWd2/qxc=;
        b=OisHO7iOZ2p/nvRGrqN6jf/9SHCR0wKr03R4lkdV/5eY6Rw8qNooceof0mTRBOUKH2
         R26OQDrXoarLWLaiNRWOfqYvws5iVT+GEpi1Nw6kqiKfMEaKnpzIJlgdDTSDF2U0Mq47
         ou2joBnOd7YYnZlMOk3kgQHa4DFIGaaMl2PAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=kriep40nUr1pTMH2vh4+YNR/XYAYHdsgQ77BeIcBo80iqLBNCTIqcJJbs38uRMlKcU
         XKbTJqU/0CxchdI4rUrwpywy526cR7tLFxbw7hWFqsiT8+U55q7c/IXHMan8Sa/wGSLZ
         GyPBWQhEe6Dw6jAIjWTkNz8zcrF4dde2ntgR0=
Received: by 10.101.72.4 with SMTP id z4mr132840ank.77.1282876778767;
        Thu, 26 Aug 2010 19:39:38 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t24sm5220015ano.12.2010.08.26.19.39.37
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 26 Aug 2010 19:39:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282856164-5126-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154574>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Most of deflation code is simply "given this buffer, just deflate
> it". Make a common routine and reuse it instead.=20

I like this idea.  But:

>  There is possibly a regression here.

Right.

> --- a/archive-zip.c
> +++ b/archive-zip.c

Looks good.

> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -130,28 +130,10 @@ static void *get_delta(struct object_entry *ent=
ry)
> =20
>  static unsigned long do_compress(void **pptr, unsigned long size)
>  {
> -	z_stream stream;
> -	void *in, *out;
> -	unsigned long maxsize;
> -
> -	memset(&stream, 0, sizeof(stream));
> -	deflateInit(&stream, pack_compression_level);
> -	maxsize =3D deflateBound(&stream, size);
> -
> -	in =3D *pptr;
> -	out =3D xmalloc(maxsize);
> +	void *out =3D git_deflate(*pptr, &size, pack_compression_level);
> +	free(*pptr);
>  	*pptr =3D out;

On error, previously *pptr and size would reflect a truncated result,
but now *pptr is NULL and size is 0.  Both results are silly.

It would be nicer if the caller (or do_compress itself) could check
for errors and report them.

> --- a/diff.c
> +++ b/diff.c
> @@ -1713,7 +1689,8 @@ static void emit_binary_diff_body(FILE *file, m=
mfile_t *one, mmfile_t *two, char
>  	 * whichever is smaller.
>  	 */
>  	delta =3D NULL;
> -	deflated =3D deflate_it(two->ptr, two->size, &deflate_size);
> +	deflate_size =3D two->size;
> +	deflated =3D git_deflate(two->ptr, &deflate_size, zlib_compression_=
level);
[...]
> @@ -1721,7 +1698,7 @@ static void emit_binary_diff_body(FILE *file, m=
mfile_t *one, mmfile_t *two, char
>  		if (delta) {
>  			void *to_free =3D delta;
>  			orig_size =3D delta_size;
> -			delta =3D deflate_it(delta, delta_size, &delta_size);
> +			delta =3D git_deflate(delta, &delta_size, zlib_compression_level)=
;
[...]
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1025,24 +1025,13 @@ static int store_object(
[...]
> -	while (deflate(&s, Z_FINISH) =3D=3D Z_OK)
> -		/* nothing */;
> -	deflateEnd(&s);
> +	compressed_size =3D delta ? deltalen : dat->len;
> +	out =3D git_deflate(delta ? delta : dat->buf, &compressed_size,
> +			  pack_compression_level);
[...]
> @@ -1053,15 +1042,10 @@ static int store_object(
[...]
> -			s.next_out =3D out =3D xrealloc(out, s.avail_out);
> -			while (deflate(&s, Z_FINISH) =3D=3D Z_OK)
> -				/* nothing */;
> -			deflateEnd(&s);
> +			free(out);
> +			compressed_size =3D dat->len;
> +			out =3D git_deflate(dat->buf, &compressed_size,
> +					  pack_compression_level);

Likewise.

> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -420,33 +420,10 @@ static int post_rpc(struct rpc_state *rpc)
>  		 * we can try to deflate it ourselves, this may save on.
>  		 * the transfer time.
>  		 */
> -		size_t size;
> -		z_stream stream;
> -		int ret;
> -
> -		memset(&stream, 0, sizeof(stream));
> -		ret =3D deflateInit2(&stream, Z_BEST_COMPRESSION,
> -				Z_DEFLATED, (15 + 16),

As Shawn mentioned, this requests gzip encoding with the default
window size.

> -		ret =3D deflate(&stream, Z_FINISH);
> -		if (ret !=3D Z_STREAM_END)
> -			die("cannot deflate request; zlib deflate error %d", ret);
> -
> -		ret =3D deflateEnd(&stream);
> -		if (ret !=3D Z_OK)
> -			die("cannot deflate request; zlib end error %d", ret);
> -
> -		size =3D stream.total_out;
> +		unsigned long size =3D rpc->len;
> +		gzip_body =3D git_deflate(rpc->buf, &size, Z_BEST_COMPRESSION);
> +		if (!gzip_body)
> +			die("cannot deflate request; zlib deflate error");

The zlib error codes are very helpful for debugging, so I would be sad
to see them go.

Thanks,
Jonathan
