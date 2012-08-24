From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch -v: align even when the first column is in UTF-8
Date: Fri, 24 Aug 2012 10:25:02 -0700
Message-ID: <7vvcg8yzgx.fsf@alter.siamese.dyndns.org>
References: <1345817872-7943-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 19:26:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4xeL-0001fo-32
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 19:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758818Ab2HXRZX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Aug 2012 13:25:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36639 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758560Ab2HXRZH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2012 13:25:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2EFD9DF9;
	Fri, 24 Aug 2012 13:25:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QSPxusGXnyMg
	i+bWYM6SeVW49u4=; b=R/oe6bs1m0Ret+GxkawMsd0XaI1cijQwAInCIXfGcwtJ
	kFF0ILdhrpa4yKD3pd1Eqo/Nnj8AqEmJWvYizAeOpb3bjIvd/AsxeBBI5gSxF1Dr
	SzS3v9FGjejpSQ4sK2OgAlFVt3eP3fvIwAXYykMcuODaeuAyA2R1v7CLb64OQnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iZwX/J
	ShAWS4ZkETS0N2HBXgPcuTqtEomtCnG84GmM/TnXthwc5n3LKt807ca6/kHb00pT
	XfZghpA6kD02C6ETUf99fnMd87i9RUGJI6uR6MAwF/y4DJyAPund+tKbQJ2Ty7xB
	1gfBBigPy4B087po2nSM/eVVPC/IxoTVZk3x0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0E149DF8;
	Fri, 24 Aug 2012 13:25:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F75D9DF6; Fri, 24 Aug 2012
 13:25:04 -0400 (EDT)
In-Reply-To: <1345817872-7943-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 24 Aug
 2012 21:17:52 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A46D28FC-EE10-11E1-8ABE-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204222>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Branch names are usually in ASCII so they are not the problem. The
> problem most likely comes from "(no branch)" translation, which is in
> UTF-8 and makes length calculation just wrong.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  So far all git translations are utf-8 compatible. Branch names may
>  use filesystem encoding, but then packed-refs specifies no encoding.
>  Anyway branch names should be in utf-8.. at least internally, imo.

I agree with all of the above, but shouldn't you be computing the
"maxwidth" based on the strwidth in the first place?  The use of
maxwidth in strbuf_addf() here clearly wants "we know N columns is
sufficient to show all output items, so pad the string to N columns"
here.  Looking for assignment "item.len =3D xxx" in the same file
shows these are computed as byte length, so you are offsetting off
of an incorrectly computed value.

Giving fewer padding bytes when showing a string that will occupy
fewer columns than it has bytes is independently necessary, once we
have the correct maxwidth that is computed in terms of the strwidth,
so this patch is not wrong per-se, but it is incomplete without a
correct maxwidth, no?

>  builtin/branch.c | 8 +++++---
>  1 t=E1=BA=ADp tin =C4=91=C3=A3 b=E1=BB=8B thay =C4=91=E1=BB=95i, 5 =C4=
=91=C6=B0=E1=BB=A3c th=C3=AAm v=C3=A0o(+), 3 b=E1=BB=8B x=C3=B3a(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 0e060f2..7c1ffa8 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -17,6 +17,7 @@
>  #include "revision.h"
>  #include "string-list.h"
>  #include "column.h"
> +#include "utf8.h"
> =20
>  static const char * const builtin_branch_usage[] =3D {
>  	"git branch [options] [-r | -a] [--merged | --no-merged]",
> @@ -490,11 +491,12 @@ static void print_ref_item(struct ref_item *ite=
m, int maxwidth, int verbose,
>  	}
> =20
>  	strbuf_addf(&name, "%s%s", prefix, item->name);
> -	if (verbose)
> +	if (verbose) {
> +		int utf8_compensation =3D strlen(name.buf) - utf8_strwidth(name.bu=
f);
>  		strbuf_addf(&out, "%c %s%-*s%s", c, branch_get_color(color),
> -			    maxwidth, name.buf,
> +			    maxwidth + utf8_compensation, name.buf,
>  			    branch_get_color(BRANCH_COLOR_RESET));
> -	else
> +	} else
>  		strbuf_addf(&out, "%c %s%s%s", c, branch_get_color(color),
>  			    name.buf, branch_get_color(BRANCH_COLOR_RESET));
