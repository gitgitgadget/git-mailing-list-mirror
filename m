From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/2] refs.c: SSE4.2 optimizations for check_refname_component
Date: Tue, 03 Jun 2014 15:05:51 -0700
Message-ID: <xmqqd2epwsw0.fsf@gitster.dls.corp.google.com>
References: <1401690015-19191-1-git-send-email-dturner@twitter.com>
	<1401690015-19191-2-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 00:06:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwqH-0006ad-T7
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 00:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbaFCWF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 18:05:58 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54127 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750941AbaFCWF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 18:05:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8647F1DB30;
	Tue,  3 Jun 2014 18:05:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5qBX6DZQgW6AjWca1nisV3biXbQ=; b=E1e93b
	rCbwBAGOhTTochXWKidsXRPtmDRc+tqMz3cJkNCchhJEzPMOUkFuTWX0/Oif4+AZ
	oDq+w/rJAGqJ1T758CF/9FewmCnTOH6sucqKiokJ1Djxhwap+Qyqe52N1OUpvwmV
	zE11Vhci4gCTDc4fkVewcnr7DCoz4QgzwGWpE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d3smMhFR4ywiFSK+nFOoF6KlgA5mF9bR
	4xLhC8voVyEgNBb0udjdcWi00bKE8hmWgyLx0fuyyZAPHDpeSqmDAPTvJDXjoZs4
	porMcdX45s2nzH8eeLxElxI+l7DxP7DDj9NQcOzJYgSfjRKaFf7ZrYVhu3OysfR7
	8xRhMWfrb+w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7B7211DB2F;
	Tue,  3 Jun 2014 18:05:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9D8281DB29;
	Tue,  3 Jun 2014 18:05:52 -0400 (EDT)
In-Reply-To: <1401690015-19191-2-git-send-email-dturner@twitter.com> (David
	Turner's message of "Mon, 2 Jun 2014 02:20:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3A7D6312-EB6B-11E3-BDF8-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250692>

David Turner <dturner@twopensource.com> writes:

> diff --git a/git-compat-util.h b/git-compat-util.h
> index f6d3a46..254487a 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -668,6 +668,26 @@ void git_qsort(void *base, size_t nmemb, size_t size,
>  #endif
>  #endif
>  
> +#ifndef NO_SSE42
> +#include <nmmintrin.h>
> +/* Clang ships with a version of nmmintrin.h that's incomplete; if
> + * necessary, we define the constants that we're going to use. */

As pointed out by Michael already, we format multiline comments with
no text on the opening line:

/*
 * Clang ships
 * ... to use.
 */

> +#ifndef _SIDD_UBYTE_OPS
> +#define _SIDD_UBYTE_OPS                 0x00
> +#define _SIDD_CMP_EQUAL_ANY             0x00
> +#define _SIDD_CMP_RANGES                0x04
> +#define _SIDD_CMP_EQUAL_ORDERED         0x0c
> +#define _SIDD_NEGATIVE_POLARITY         0x10
> +#endif
> +
> +/* This is the system memory page size; it's used so that we can read
> + * outside the bounds of an allocation without segfaulting. It is
> + * assumed to be a power of 2. */
> +#ifndef PAGE_SIZE
> +#define PAGE_SIZE 4096
> +#endif
> +#endif
> +
>  #ifdef UNRELIABLE_FSTAT
>  #define fstat_is_reliable() 0
>  #else
> diff --git a/refs.c b/refs.c
> index dd28f2a..22a2dae 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -24,6 +24,25 @@ static unsigned char refname_disposition[256] = {
>  	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 4, 4
>  };
>  
> +static int check_refname_component_trailer(const char *cp, const char *refname, int flags)
> +{
> +	if (cp == refname)
> +		return 0; /* Component has zero length. */
> +	if (refname[0] == '.') {
> +		if (!(flags & REFNAME_DOT_COMPONENT))
> +			return -1; /* Component starts with '.'. */
> +		/*
> +		 * Even if leading dots are allowed, don't allow "."
> +		 * as a component (".." is prevented by a rule above).
> +		 */
> +		if (refname[1] == '\0')
> +			return -1; /* Component equals ".". */
> +	}
> +	if (cp - refname >= 5 && !memcmp(cp - 5, ".lock", 5))
> +		return -1; /* Refname ends with ".lock". */
> +	return cp - refname;
> +}
> +
>  /*
>   * Try to read one refname component from the front of refname.
>   * Return the length of the component found, or -1 if the component is
> @@ -37,7 +56,7 @@ static unsigned char refname_disposition[256] = {
>   * - it ends with ".lock"
>   * - it contains a "\" (backslash)
>   */
> -static int check_refname_component(const char *refname, int flags)
> +static int check_refname_component_1(const char *refname, int flags)
>  {
>  	const char *cp;
>  	char last = '\0';
> @@ -47,7 +66,7 @@ static int check_refname_component(const char *refname, int flags)
>  		unsigned char disp = refname_disposition[ch];
>  		switch(disp) {
>  		case 1:
> -			goto out;
> +			return check_refname_component_trailer(cp, refname, flags);
>  		case 2:
>  			if (last == '.')
>  				return -1; /* Refname contains "..". */
> @@ -61,23 +80,86 @@ static int check_refname_component(const char *refname, int flags)
>  		}
>  		last = ch;
>  	}
> -out:
> -	if (cp == refname)
> -		return 0; /* Component has zero length. */
> -	if (refname[0] == '.') {
> -		if (!(flags & REFNAME_DOT_COMPONENT))
> -			return -1; /* Component starts with '.'. */
> -		/*
> -		 * Even if leading dots are allowed, don't allow "."
> -		 * as a component (".." is prevented by a rule above).
> -		 */
> -		if (refname[1] == '\0')
> -			return -1; /* Component equals ".". */
> +}
> +
> +#ifdef NO_SSE42
> +#define check_refname_component check_refname_component_1
> +#else
> +#define BLOCK_SIZE 16

Is this macro name safe?  It feels a bit too generic/broad and
asking to collide with some system-defined block size constant
coming from random <*.h> header file, but maybe it's just me.

> +/* Vectorized version of check_refname_component */
> +static int check_refname_component(const char *refname, int flags)
> +{
> +	const __m128i *refname_vec = (__m128i*) refname;
> +
> +	/* Character ranges for characters forbidden in refs; see
> +	 * above */
> +	static const __v16qi bad = {
> +		0x01, 0x20,  0x7e, 0x7f,  0x5e, 0x5e,  0x3a, 0x3a,
> +		0x5b, 0x5c,  0x2a, 0x2a,  0x3f, 0x3f,  0x3f, 0x3f};
> +
> +	static const __v16qi nonslashes = {
> +		'\001', '/' -1, '/' + 1, 0xff,
> +	};
> +
> +	static const __v16qi dotdot = {'.','.',0};
> +	static const __v16qi atcurly = {'@','{',0};

s/,/, /g; please.

> +	const __m128i *vp;
> +	const char *cp = (const char *)refname_vec;
> +
> +	int dotdotpos = BLOCK_SIZE, atcurlypos = BLOCK_SIZE;
> +	for (vp = refname_vec; ; vp++) {
> +		__m128i tmp;
> +		int endpos;
> +
> +		/* Handle case of forbidden substrings .. and @{ crossing
> +		 * sixteen-byte boundaries */
> +		if (dotdotpos == 15 && *cp == '.')
> +			return -1;
> +
> +		if (atcurlypos == 15 && *cp == '{')
> +			return -1;
> +
> +		if (((uintptr_t) vp & (PAGE_SIZE - 1)) > PAGE_SIZE - BLOCK_SIZE)
> +			/* End-of-page; fall back to slow method for
> +			 * this entire component. */
> +			return check_refname_component_1(refname, flags);

It is somewhat sad that we have to redo the whole thing, but nobody
higher in the callchain knows how long the refname will be before
calling us, so this cannot be avoided.
