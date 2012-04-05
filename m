From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] add mergesort() for linked lists
Date: Thu, 05 Apr 2012 12:17:32 -0700
Message-ID: <7vpqbm56pf.fsf@alter.siamese.dyndns.org>
References: <201203291818.49933.mfick@codeaurora.org>
 <7v7gy2q1kq.fsf@alter.siamese.dyndns.org>
 <60bff12d-544c-4fbd-b48a-0fdf44efaded@email.android.com>
 <20120330093207.GA12298@sigill.intra.peff.net>
 <20120330094052.GB12298@sigill.intra.peff.net>
 <4F7780C3.2050408@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Martin Fick <mfick@codeaurora.org>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Apr 05 21:17:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFsBh-0001p3-Dl
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 21:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755847Ab2DETRg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Apr 2012 15:17:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47894 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755828Ab2DETRf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Apr 2012 15:17:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13EF27FEA;
	Thu,  5 Apr 2012 15:17:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=f6pP6JRjnUjb
	DhZEWUKQ1IwCxgQ=; b=IfJlIb7jmVMIjIRcEQ4SwSANh3aNQQjfFOjwH/acXM7S
	6I8xyL7LmdaG/gdpk//DkxxQAhepf0Qx7mFcOKNt+Z89HeqlyN6N53ruayq4mM+3
	bUc688yLbJTnaMf9TQCFZo3fnWyP9rGjb6asYVwaNFZVOfkOFOlntw+AjNWKaCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jFd1H/
	+ylFnCTrIYFlTEWjORKIWx/Tdf42w4pm3W2vwaf9KuqEvNCGtixqpnqvbbGITD8G
	a+wgloOOQ950jp3LewDx2drGJFhHB+4g+p0DEZgqRTgKF2oVRXCL6DSefWMsH+te
	HcwgtVk1nAm+WDogUjKwS4ALIxVkZicXg1FU8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B04B7FE9;
	Thu,  5 Apr 2012 15:17:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A9F47FE8; Thu,  5 Apr 2012
 15:17:33 -0400 (EDT)
In-Reply-To: <4F7780C3.2050408@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sun, 01 Apr 2012 00:10:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF01A396-7F53-11E1-8C8C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194794>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> This adds a generic bottom-up mergesort implementation for singly lin=
ked
> lists.  It was inspired by Simon Tatham's webpage on the topic[1], bu=
t
> not so much by his implementation -- for no good reason, really, just=
 a
> case of NIH.
>
> [1] http://www.chiark.greenend.org.uk/~sgtatham/algorithms/listsort.h=
tml
>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> +void *mergesort(void *list,
> +		void *(*get_next_fn)(const void *),
> +		void (*set_next_fn)(void *, void *),
> +		int (*compare_fn)(const void *, const void *))
> +{
> +	unsigned long l;
> +
> +	if (!list)
> +		return NULL;
> +	for (l =3D 1; ; l *=3D 2) {
> +		void *curr;
> +		struct mergesort_sublist p, q;
> +
> +		p.ptr =3D list;
> +		q.ptr =3D get_nth_next(p.ptr, l, get_next_fn);
> +		if (!q.ptr)
> +			break;
> +		p.len =3D q.len =3D l;
> +
> +		if (compare_fn(p.ptr, q.ptr) > 0)
> +			list =3D curr =3D pop_item(&q, get_next_fn);
> +		else
> +			list =3D curr =3D pop_item(&p, get_next_fn);
> +
> +		while (p.ptr) {
> +			while (p.len || q.len) {
> +				void *prev =3D curr;
> +
> +				if (!p.len)
> +					curr =3D pop_item(&q, get_next_fn);
> +				else if (!q.len)
> +					curr =3D pop_item(&p, get_next_fn);
> +				else if (compare_fn(p.ptr, q.ptr) > 0)
> +					curr =3D pop_item(&q, get_next_fn);
> +				else
> +					curr =3D pop_item(&p, get_next_fn);
> +				set_next_fn(prev, curr);
> +			}
> +			p.ptr =3D q.ptr;
> +			p.len =3D l;
> +			q.ptr =3D get_nth_next(p.ptr, l, get_next_fn);
> +			q.len =3D q.ptr ? l : 0;
> +
> +		}
> +		set_next_fn(curr, NULL);
> +	}
> +	return list;
> +}

After seeing "I wrote it myself due to NIH", it strikes me a bit odd th=
at
you still used "start from bunch of singleton sublist, elongating twice
per round as we go" structure from the original.

I wonder if it would be an improvement if you structured the loop so th=
at:

 (1) the first sublist 'p' grabs as many elements in the ascending orde=
r
     as you find;

 (2) the second sublist 'q' begins at the end of the first sublist and
     grabs as many elements in the ascending order;

 (3) 'p' and 'q' are merge-sorted into the result list;

 (4) if your two sublists did not cover "list" in its entirety, process
     the remainder (i.e. where the second sublist stopped because of an
     unordered element) by going back to step (1); and

 (5) if you did not need to jump back to step (1) from step (4), then y=
ou
     had only two sublists (or less), so the result is sorted.  Otherwi=
se,
     the result now has fewer ascending sublists than the original, so =
go
     back to (1) and iterate.

If the input is in a random order, this may end up doing the same numbe=
r
of iterations as the original, but if the input is mostly sorted, would=
n't
it allow us to take advantage of the fact by starting with a longer
sublist in the earlier rounds?
