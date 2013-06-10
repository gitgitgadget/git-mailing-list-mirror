From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] commit-queue: LIFO or priority queue of commits
Date: Mon, 10 Jun 2013 00:21:00 -0700
Message-ID: <7vwqq2l9cz.fsf@alter.siamese.dyndns.org>
References: <1370581872-31580-1-git-send-email-gitster@pobox.com>
	<1370820277-30158-1-git-send-email-gitster@pobox.com>
	<1370820277-30158-3-git-send-email-gitster@pobox.com>
	<20130610052500.GD3621@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Elliott Cable <me@ell.io>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 10 09:21:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlwPc-00060H-NW
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 09:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450Ab3FJHVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 03:21:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38680 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318Ab3FJHVC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 03:21:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D377243DF;
	Mon, 10 Jun 2013 07:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U3pi6H94zosjZsMan0m/yELSvYU=; b=QRo5Ss
	hQMvWDA+PY1u/vbA33OcWFczUJ8yaku7XmR2qdGz0+lPGgrKXaS8A09u/oZCziOC
	7dfiQD5Jk8VVVaJpYjZXvnq1FQklzm2K52QehALSBZlx4V59Zc/AcBZcbeUUUd42
	Q0aLkr0Zv8ViyvbhkadblyW0FTVEMo5cvBEes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wAUxrkJJU1JtSaINqmuqXVbVGjHdPZNn
	AcBEaZzxUXo9VQfwSr6CTEMWBosdQhyoD8KbLPmUfiwhBBBZAwd5dTvx0Ieetxqc
	mT9qMrf2a2IxCKt5tJxpSb1h6ggHAeDQRXe/FJIQKAaFZWOet3Lt5aukxBuvekLj
	RkHQJxBwNWc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01458243DE;
	Mon, 10 Jun 2013 07:21:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A8A7243DC;
	Mon, 10 Jun 2013 07:21:01 +0000 (UTC)
In-Reply-To: <20130610052500.GD3621@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 10 Jun 2013 01:25:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4DD0EBCE-D19E-11E2-AD0A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227246>

Jeff King <peff@peff.net> writes:

> It may be worth looking again for other places to use this over
> commit_list, but even the caller you are introducing here justifies its
> presence.

The next candidate is paint-down-to-common, probably.

> Also, I wrote some basic tests to cover the priority queue as a unit. I
> can rebase them on your commit if you are interested.

It would be great.

> A few comments on the code itself:
>
>> +void commit_queue_put(struct commit_queue *queue, struct commit *commit)
>
> Is it worth making this "struct commit *" a void pointer, and handling
> arbitrary items in our priority queue? The compare function should be
> the only thing that dereferences them.
>  
> I do not have any non-commit priority queue use in mind, but I do not
> think it adds any complexity in this case.

I didn't either (and still I don't think of one), but I agree that
the implementation can be reused for pq of any type, as long as it
is a pointer to struct.

>> +	/* Bubble up the new one */
>> +	for (ix = queue->nr - 1; ix; ix = parent) {
>> +		parent = (ix - 1) / 2;
>> +		if (compare(queue->array[parent], queue->array[ix],
>> +			    queue->cb_data) < 0)
>> +			break;
>
> In my implementation, I stopped on "compare() <= 0". It is late and my
> mind is fuzzy, but I recall that heaps are never stable with respect to
> insertion order, so I don't think it would matter.

It would matter in the sense that we cannot replace linked-list, if
the caller wants stability.  It is more like "we cannot do anything
about it" than "it would not matter".

We can make each queue element a pair of <pointer to payload,
insertion counter>, and tiebreak using the insertion order, if the
callers want the same stability as linked-list implementation, but
I tend to think it really matters.
