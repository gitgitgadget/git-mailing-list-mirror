From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8] refs.c: SSE2 optimizations for check_refname_component
Date: Mon, 16 Jun 2014 17:06:31 -0700
Message-ID: <xmqqha3ko0vs.fsf@gitster.dls.corp.google.com>
References: <1402946566-14923-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, neleai@seznam.cz,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 02:06:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwgvC-0001FI-H7
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 02:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbaFQAGj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jun 2014 20:06:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51890 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750775AbaFQAGi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jun 2014 20:06:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A02CC20AD4;
	Mon, 16 Jun 2014 20:06:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=M8Yh1+X4B8lO
	NGH75rZ6qdLOoVA=; b=M3Ah5yx069NwMcfA2IoIyV7PTBVnLEgYTmHQ7aln5+qx
	i9kLsS4KUGQplU4vfH8y92hs+AeZhn0XpwbTfDd/Bhp++hf7ec7tBfI8kMVrpfUm
	l5zZZ5dbajAjxaiKB4KwDPlEK2gBdJbUpvFg6O5VdJc3PX+S4F3ZSjJB0hVe7kg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=e/uCV+
	x90mzimaUxunhG0n6fNZeTafbX4wZUZucirzu/epcKRBSQwAWrCkkbtXhVy5hpFA
	D6TT++5NYZDo/3jAYgAnztiYu50AGh2Gle3uQRo1szDJ/xKHkUue0nPkbAr1fr1I
	1PUAFro3Jouj8mRlEC4L1P5ZRuLYHB/T4Cqi0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9510620AD3;
	Mon, 16 Jun 2014 20:06:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1F90120ACB;
	Mon, 16 Jun 2014 20:06:31 -0400 (EDT)
In-Reply-To: <1402946566-14923-1-git-send-email-dturner@twitter.com> (David
	Turner's message of "Mon, 16 Jun 2014 15:22:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3C54E136-F5B3-11E3-B321-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251836>

David Turner <dturner@twopensource.com> writes:

> Optimize check_refname_component using SSE2 on x86_64.
>
> git rev-parse HEAD is a good test-case for this, since it does almost
> nothing except parse refs.  For one particular repo with about 60k
> refs, almost all packed, the timings are:
>
> Look up table: 29 ms
> SSE2:          23 ms
>
> This cuts about 20% off of the runtime.
>
> The configure.ac changes include code from the GNU C Library written
> by Joseph S. Myers <joseph at codesourcery dot com>.
>
> Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz> suggested an SSE2 approach =
to the

One e-mail address is obfuscated while the other not; intended?

> substring searches, which netted a speed boost over the SSE4.2 code I
> had initially written.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
> diff --git a/git-compat-util.h b/git-compat-util.h
> index f6d3a46..291d46b 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -668,6 +668,16 @@ void git_qsort(void *base, size_t nmemb, size_t =
size,
>  #endif
>  #endif
> =20
> +#if defined(__GNUC__) && defined(__x86_64__)
> +#include <emmintrin.h>
> +/* This is the system memory page size; it's used so that we can rea=
d

Style (there are other instances of the same kind).

/*
 * This is the ...

> + * outside the bounds of an allocation without segfaulting.
> + */

> +static int check_refname_component_trailer(const char *cp, const cha=
r *refname, int flags)
> +{
> +	if (cp =3D=3D refname)
> +		return 0; /* Component has zero length. */
> +	if (refname[0] =3D=3D '.') {
> +		if (!(flags & REFNAME_DOT_COMPONENT))
> +			return -1; /* Component starts with '.'. */
> +		/*
> +		 * Even if leading dots are allowed, don't allow "."
> +		 * as a component (".." is prevented by a rule above).
> +		 */
> +		if (refname[1] =3D=3D '\0')
> +			return -1; /* Component equals ".". */
> +	}
> +	if (cp - refname >=3D 5 && !memcmp(cp - 5, ".lock", 5))
> +		return -1; /* Refname ends with ".lock". */

This is merely a moved code that retained the same comment, but it
is more like "the current refname component ends with .lock", I
suspect.  In other words, we do not allow "refs/heads/foo.lock/bar".
Am I reading the patch correctly?

> +#if defined(__GNUC__) && defined(__x86_64__)
> +#define SSE_VECTOR_BYTES 16
> +
> +/* Vectorized version of check_refname_format. */
> +int check_refname_format(const char *refname, int flags)
> +{
> +	const char *cp =3D refname;
> +
> +	const __m128i dot =3D _mm_set1_epi8 ('.');

Style (there are other instances of the same kind).  No SP between
function/macro name and opening parenthesis.

> +	if (refname[0] =3D=3D '.') {
> +		if (refname[1] =3D=3D '/' || refname[1] =3D=3D '\0')
> +			return -1;
> +		if (!(flags & REFNAME_DOT_COMPONENT))
> +			return -1;
> +	}
> +	while(1) {
> +		__m128i tmp, tmp1, result;
> +		uint64_t mask;
> +
> +		if ((uintptr_t) cp % PAGE_SIZE > PAGE_SIZE - SSE_VECTOR_BYTES  - 1=
)

OK, so we make sure we do not overrun by reading too much near the
end of the page, as the next page might be unmapped.

I am showing my ignorance but does cp (i.e. refname) upon entry to
this function need to be aligned in some way?

Thanks.
