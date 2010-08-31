From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Reduce zlib deflate code duplication
Date: Tue, 31 Aug 2010 10:46:59 -0700
Message-ID: <7vpqwybros.fsf@alter.siamese.dyndns.org>
References: <1282856164-5126-1-git-send-email-pclouds@gmail.com>
 <1283132815-3277-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>, git@vger.kernel.org,
	spearce@spearce.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 19:47:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqUvX-0001FI-1z
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 19:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330Ab0HaRrN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 13:47:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab0HaRrM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 13:47:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E7929D2B92;
	Tue, 31 Aug 2010 13:47:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+3x1kTe0ns0y
	js641APL8YfbM3o=; b=veWBflBzlaBhYG9PQ3nMlVagekBgDaqDBkzlchGCpc7H
	yjQAjiCzBUnhoWJDcaBG19af+oOXeJ14FTc0yKKD0qD1FoSA8Li/KdGTNBjmJe5G
	g0PJxmdOw98oKwovE97cWB3bR6ymP22yRbOni5cQw5owKRkPANR6vPMT2We7mzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Rc9Jnm
	55US0MM7OG8D8tUM1xQlAMPRGYlrChai569syvpT/0ZJacJju5D2NT7ib4QbeN6t
	Tdm00+UvwAFFyl0znJVx9nsYBRUiaBY8L0opCnm9ukJjJ9pr41EYrUtW1zAfqFSA
	GaTnEG6HnzJwuFBCgB2JkQoOqzpWkFxPfdonI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A694BD2B91;
	Tue, 31 Aug 2010 13:47:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 92BD7D2B90; Tue, 31 Aug
 2010 13:47:01 -0400 (EDT)
In-Reply-To: <1283132815-3277-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Mon\, 30 Aug
 2010 11\:46\:55 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C5849C38-B527-11DF-840E-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154947>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> diff --git a/archive-zip.c b/archive-zip.c
> index cf28504..ed176ca 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -87,39 +87,6 @@ static void copy_le32(unsigned char *dest, unsigne=
d int n)
>  	dest[3] =3D 0xff & (n >> 030);
>  }
> =20
> -static void *zlib_deflate(void *data, unsigned long size,
> -		int compression_level, unsigned long *compressed_size)
> -{

This name makes more sense than git_deflate() as it is about "deflating=
 by
calling zlib".  For a common library routine "frotz", git_frotz tends t=
o
be used to name our own replacement for it, but with this patch we are =
not
creating our own implementation of deflate algorithm.

> - ...
> -	deflateEnd(&stream);

We used not to check the return value of this call here; the new functi=
on
in wrapper.c insists that this returns Z_OK.  I think it is an improvem=
ent
that deserves to be mentioned in the proposed log message.

> @@ -164,8 +131,8 @@ static int write_zip_entry(struct archiver_args *=
args,
>  	}
> =20
>  	if (method =3D=3D 8) {
> -		deflated =3D zlib_deflate(buffer, size, args->compression_level,
> -				&compressed_size);
> +		compressed_size =3D size;

Isn't it awkward that you have to assign the size of the uncompressed
input to a variable you are planning to use to hold the compressed size
with your API?  I do not see a compelling reason that we would want to =
use
an in-out parameter here.

> @@ -1708,12 +1684,19 @@ static void emit_binary_diff_body(FILE *file,=
 mmfile_t *one, mmfile_t *two, char
>  	unsigned long delta_size;
>  	unsigned long deflate_size;
>  	unsigned long data_size;
> +	int zlib_error;
> =20
>  	/* We could do deflated delta, or we could do just deflated two,
>  	 * whichever is smaller.
>  	 */
>  	delta =3D NULL;
> -	deflated =3D deflate_it(two->ptr, two->size, &deflate_size);
> +	deflate_size =3D two->size;
> +	deflated =3D git_deflate(two->ptr, &deflate_size, zlib_compression_=
level, &zlib_error);
> +	if (!deflated) {
> +		error("failed to compress for binary diff prefix %s, zlib error %d=
",
> +		      prefix, zlib_error);

What is this "prefix" about?

I think the callchain here is that builtin_diff() sets its local variab=
le
line_prefix according to the o->output_prefix (used by graphing cruft) =
and
it is passed to emit_binary_diff().  It certainly shouldn't be in the
middle of any line, and I don't think you want it in the error message =
in
the first place.  Likewise for another error message nearby.

Thanks.
