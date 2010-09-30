From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3 v2] use cache for function names in hunk headers
Date: Thu, 30 Sep 2010 11:33:20 -0700
Message-ID: <7v62xnjd3j.fsf@alter.siamese.dyndns.org>
References: <1284890369-4136-1-git-send-email-drizzd@aon.at>
 <20100923070439.GA29764@localhost> <4C9F7450.9060208@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Sep 30 20:33:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1Nwo-00017Z-MF
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 20:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117Ab0I3Sdd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 14:33:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957Ab0I3Sdd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 14:33:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FADBDA3E9;
	Thu, 30 Sep 2010 14:33:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bSwMnEO510B6
	T4pG8/qCUgzxvlE=; b=cJCPFT4DMrG15+P5iehwFawO8Iw1yDJ33vodydvG9NEV
	X2N9SGtvULL6ePjfg9t/rO/T9tdfzqb5Y6gzh5f80Nf6kXN/ACUvSmg2BxasEgG7
	IdADNeNZOpnvrKcFvTaagdUDMl6hsmMk8NkZlX7VffwttU6BN287JHZd+U2SYho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=s8AsRy
	v18FELt8Byj1H4p8AG1nhQvzCNq5SYgNHWdlgvWzp1qEMMOLsiXWU0yNSz4LjfI5
	U0QqkHDN2ZK7wDOKrCxDEwMLFkPN1CqNaNi9pO2gvNOHQuT6DrOqfKhDx/AacWU4
	ECyG7q9o2g/hnNXNM41yg4ow8+OUcYAay4WAA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 24F92DA3E6;
	Thu, 30 Sep 2010 14:33:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97564DA3E3; Thu, 30 Sep
 2010 14:33:22 -0400 (EDT)
In-Reply-To: <4C9F7450.9060208@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sun\, 26 Sep 2010 18\:26\:56 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3732AFE0-CCC1-11DF-9F66-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157699>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 23.09.2010 09:04, schrieb Clemens Buchacher:
>> For each hunk, xdl_find_func searches the preimage
>> for a function name until the beginning of the
>> file. If the file does not contain any function
>> names, this search has complexity O(n2) in the
>> number of hunks n.
> ...
> How about something like this?  It also removes an outdated comment. =
 The
> inlining part should probably split out in its own patch..
>
>  xdiff/xemit.c |   38 ++++++++++++++------------------------
>  1 files changed, 14 insertions(+), 24 deletions(-)

I had to wonder if this optimization closes a door for us to extend the
function header patterns to allow inspecting multiple lines.

Suppose that a rule says that a header line is a first non-blank line t=
hat
follows two or more blank lines.  E.g.

    ... the end of a paragraph that is not followed by two blank lines.
    (blank line)
    This is not a header, but is part of the previous paragraph group.
    ... body of the paragraph here ...
    and this is the tail of the paragraph group.
    (blank line)
    (blank line)
    This begins a new paragraph group.
    And this is the second line of it.

Under such a rule, "This begins a new paragraph group." is a header lin=
e.
If the first hunk begins at the second blank line before that header, w=
e
will scan down to the beginning of the file and will find a header that
comes before that header line, and remember it in funclen/funcbuf[].  T=
he
next scan will stop after looking at one blank line before "This begins=
 a
new paragraph group.", instead of going down to the beginning, and woul=
d
not to have a chance to notice that "This begins a new paragraph group.=
"
indeed has two blank lines before it.  It would instead keep returning =
the
header we found before this header.

I do not think this is such a big issue, though.  In order to allow suc=
h a
multi-line matching, the loop in xdl_find_func(), now inlined, needs to=
 be
restructured anyway, and whoever is doing such an enhancement hopefully
will notice that s/he needs to look behind beyond (s1-1) at that point.

So an Ack from me.

Thanks.

> diff --git a/xdiff/xemit.c b/xdiff/xemit.c
> index c4bedf0..a663f21 100644
> --- a/xdiff/xemit.c
> +++ b/xdiff/xemit.c
> @@ -85,27 +85,6 @@ static long def_ff(const char *rec, long len, char=
 *buf, long sz, void *priv)
>  	return -1;
>  }
> =20
> -static void xdl_find_func(xdfile_t *xf, long i, char *buf, long sz, =
long *ll,
> -		find_func_t ff, void *ff_priv) {
> -
> -	/*
> -	 * Be quite stupid about this for now.  Find a line in the old file
> -	 * before the start of the hunk (and context) which starts with a
> -	 * plausible character.
> -	 */
> -
> -	const char *rec;
> -	long len;
> -
> -	while (i-- > 0) {
> -		len =3D xdl_get_rec(xf, i, &rec);
> -		if ((*ll =3D ff(rec, len, buf, sz, ff_priv)) >=3D 0)
> -			return;
> -	}
> -	*ll =3D 0;
> -}
> -
> -
>  static int xdl_emit_common(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_=
t *ecb,
>                             xdemitconf_t const *xecfg) {
>  	xdfile_t *xdf =3D &xe->xdf1;
> @@ -127,6 +106,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr,=
 xdemitcb_t *ecb,
>  	xdchange_t *xch, *xche;
>  	char funcbuf[80];
>  	long funclen =3D 0;
> +	long funclineprev =3D -1;
>  	find_func_t ff =3D xecfg->find_func ?  xecfg->find_func : def_ff;
> =20
>  	if (xecfg->flags & XDL_EMIT_COMMON)
> @@ -150,9 +130,19 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr=
, xdemitcb_t *ecb,
>  		 */
> =20
>  		if (xecfg->flags & XDL_EMIT_FUNCNAMES) {
> -			xdl_find_func(&xe->xdf1, s1, funcbuf,
> -				      sizeof(funcbuf), &funclen,
> -				      ff, xecfg->find_func_priv);
> +			long l;
> +			for (l =3D s1 - 1; l >=3D 0 && l > funclineprev; l--) {
> +				const char *rec;
> +				long reclen =3D xdl_get_rec(&xe->xdf1, l, &rec);
> +				long newfunclen =3D ff(rec, reclen, funcbuf,
> +						     sizeof(funcbuf),
> +						     xecfg->find_func_priv);
> +				if (newfunclen >=3D 0) {
> +					funclen =3D newfunclen;
> +					break;
> +				}
> +			}
> +			funclineprev =3D s1 - 1;
>  		}
>  		if (xdl_emit_hunk_hdr(s1 + 1, e1 - s1, s2 + 1, e2 - s2,
>  				      funcbuf, funclen, ecb) < 0)
