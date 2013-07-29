From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] commit-slab.h: Fix memory allocation and addressing
Date: Mon, 29 Jul 2013 08:42:55 -0700
Message-ID: <7vppu11if4.fsf@alter.siamese.dyndns.org>
References: <51F418B7.30507@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Jul 29 17:43:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3pbD-0001gH-FV
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 17:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756241Ab3G2Pm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 11:42:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61838 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752944Ab3G2Pm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 11:42:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CA6B33DA1;
	Mon, 29 Jul 2013 15:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zXc8mv8CL4nX0nd0advc4EAxi10=; b=pjNnsT
	q3+OXaYYYB5TLuO2UCvlBi6UpzNCQzOHA2cbmvYonCJ5mk8hIGEo5SW3DFZxAb1U
	jRQj+RFo7YYFrftuF864lkqYJp6G+RnrHWSeqhRun68EzkowHmSq6kjXKI+esPJg
	uwU3BbASQ2Fm505CdwER6k5qOldCnU1L9fu3g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YfHYi6HS0dsVJDukpIznod0w+yHeQ1Oz
	dWATShUKOqSn9p5Je5k4+yWrzaDkCsLEMsxlePLX5hxyMPVif/OXP1sGktMrPL9Y
	s/QSqpkjipX9xPz0ZtRIUl+F+Mg64LtL6lEIaGm9w0JzB2AfZ90AHP1aTRx8UWNk
	kSdTr7skI9g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90EF633DA0;
	Mon, 29 Jul 2013 15:42:57 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B95CD33D9D;
	Mon, 29 Jul 2013 15:42:56 +0000 (UTC)
In-Reply-To: <51F418B7.30507@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Sat, 27 Jul 2013 20:00:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A264572-F865-11E2-ADF7-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231293>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> I was convinced, just by reading the code in the header, that when
> used with stride > 1, the memory allocated to a slab would not be
> sufficient. (ie it would be too small by:
>     s->slab_size * (sizeof(**s->slab) * (stride - 1))
> ). So, I had expected t3202-show-branch-octopus.sh to provoke memory
> error reports when run under valgrind.
>
> Hmm, it didn't ... so much for that theory! :-D
>
> So, I'm a little puzzled; I must be missing something obvious, which
> is why this is marked RFC.
>
> What am I missing?

Because sizeof(struct reachabe_cslab) is much larger than
sizeof(unsigned char), and the test does not use that many commits
to cause us to spill to more than one slab?

Your fix of elem_size in your first hunk is correct; for stride N,
we want to allocate N*sizeof(elemtype) consecutive bytes in a single
slab (we do not want to split the array of N elements across two
slabs).  So "elem_size" is the size of the array for a single commit
(when stride==1, we are storing an array with a single element).

And we can fit arrays for s->slab_size = (COMMIT_SLAB_SIZE /
elem_size) commits in a single slab.  c->index / s->slab_size gives
us which slab the array for the commit goes, and modulus gives us
which slot in that slab the array sits.  So the second hunk looks
correct, too.

And of course, the slab must be allocated as an array with
s->slab_size elements, each of which holds s->stride elements of
elem_type that is sizeof(**s->slab) bytes long.

Thanks; the patch looks correct to me.

It is somewhat embarrassing that nobody caught it X-<.

>  commit-slab.h | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/commit-slab.h b/commit-slab.h
> index 7d48163..d4c8286 100644
> --- a/commit-slab.h
> +++ b/commit-slab.h
> @@ -48,7 +48,7 @@ static void init_ ##slabname## _with_stride(struct slabname *s,		\
>  	if (!stride)							\
>  		stride = 1;						\
>  	s->stride = stride;						\
> -	elem_size = sizeof(struct slabname) * stride;			\
> +	elem_size = sizeof(elemtype) * stride;				\
>  	s->slab_size = COMMIT_SLAB_SIZE / elem_size;			\
>  	s->slab_count = 0;						\
>  	s->slab = NULL;							\
> @@ -72,11 +72,10 @@ static void clear_ ##slabname(struct slabname *s)			\
>  static elemtype *slabname## _at(struct slabname *s,			\
>  				const struct commit *c)			\
>  {									\
> -	int nth_slab, nth_slot, ix;					\
> +	int nth_slab, nth_slot;						\
>  									\
> -	ix = c->index * s->stride;					\
> -	nth_slab = ix / s->slab_size;					\
> -	nth_slot = ix % s->slab_size;					\
> +	nth_slab = c->index / s->slab_size;				\
> +	nth_slot = c->index % s->slab_size;				\
>  									\
>  	if (s->slab_count <= nth_slab) {				\
>  		int i;							\
> @@ -89,8 +88,8 @@ static elemtype *slabname## _at(struct slabname *s,			\
>  	}								\
>  	if (!s->slab[nth_slab])						\
>  		s->slab[nth_slab] = xcalloc(s->slab_size,		\
> -					    sizeof(**s->slab));		\
> -	return &s->slab[nth_slab][nth_slot];				\
> +					    sizeof(**s->slab) * s->stride);		\
> +	return &s->slab[nth_slab][nth_slot * s->stride];				\
>  }									\
>  									\
>  static int stat_ ##slabname## realloc
