From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] utf8.c: fix strbuf_utf8_replace copying the last NUL to dst string
Date: Tue, 29 Jul 2014 12:56:24 -0700
Message-ID: <xmqqha202b2v.fsf@gitster.dls.corp.google.com>
References: <1406639429-28748-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 21:56:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCDVm-0004si-I3
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 21:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbaG2T4f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2014 15:56:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50614 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751459AbaG2T4e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2014 15:56:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 543522D58A;
	Tue, 29 Jul 2014 15:56:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=W/4R8Wpdi2gs
	hSry+heWC+f9o0I=; b=lClc2ZumU3JZ+JJ7iRo81Q5AbQm0x9Sir+BLuIfDOZow
	7YLFM7ranGe6EYuJP67FuckKHh5yrwYdDKEGlcbU2Ll9NMwxd4QxYWA9ER4N+f09
	yAFGaqlK3TmKeMqBHX5cr+Dh0enNslb3MI1rgbHVGf/MH1qevEcu7AScMT9cyJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XM9YsX
	l7MZHEPQrLodU8emYTMaNBN+sNRht5WRZGFl3DfSk8AyUdtMYkewGJwZhPiOEnNd
	MJoYkiY3BqjZ8bPC021YcS4X21t5t245PsS7+Z2URfA3238FAVWg13b40BdORV1r
	kbeSKkfWR77ngCrspmK3dW0BSh/bq6OLL8h8g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4A36D2D589;
	Tue, 29 Jul 2014 15:56:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DAFD02D57A;
	Tue, 29 Jul 2014 15:56:25 -0400 (EDT)
In-Reply-To: <1406639429-28748-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 29
 Jul 2014 20:10:29 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6C478628-175A-11E4-BE79-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254465>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> When utf8_width(&src) is called with *src =3D=3D NULL (because the
> source string ends with an ansi sequence),

I am not sure what you mean by "because" here.  Do you mean somebody
(who?) decides to call the utf8_width() with NULL pointer stored in
*src because of "ansi sequence"?

What do you mean by "ansi sequence"?  I'll assume that you mean
those terminal control that all use bytes with hi-bit clear.

At the very beginning of utf8_width(), *start can be cleared to
point at a NULL pointer by pick_one_utf8_char() if the pointer that
comes into utf8_width() originally points at an invalid UTF-8
string, but as far as I can see, ESC (or any bytes that would be
used in those terminal control sequences like colors and cursor
control) will simply be returned as a single byte, without going
into error path that clears *start =3D NULL.

Puzzled...

> it returns 0 and steps
> 'src' by one.=20

Here "it" refers to utf8_width()?  Who steps 'src' by one?

Ahh, did you mean *src =3D=3D NUL, i.e. "already at the end of the
string"?

I think utf8_width() called with an empty string should not move the
pointer past that end-of-string NUL in the first place.  It makes me
wonder if it would be a better fix to make it not to do that (and
return 0), but if we declare it is the caller's fault, perhaps we
may want to add

	if (!**start)
        	die("BUG: empty string to utf8_width()???");

at the very beginning of utf8_width(), even before it calls
pick-one-utf8-char.

Still puzzled...

> This stepping makes strbuf_utf8_replace add NUL to the
> destination string at the end of the loop. Check and break the loop
> early.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  utf8.c | 2 ++
>  1 file changed, 2 insertions(+)

Tests?

> diff --git a/utf8.c b/utf8.c
> index b30790d..cd090a1 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -381,6 +381,8 @@ void strbuf_utf8_replace(struct strbuf *sb_src, i=
nt pos, int width,
>  			src +=3D n;
>  			dst +=3D n;
>  		}
> +		if (src >=3D end)
> +			break;
> =20
>  		old =3D src;
>  		n =3D utf8_width((const char**)&src, NULL);
