From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] commit-queue: LIFO or priority queue of commits
Date: Mon, 10 Jun 2013 11:56:33 -0700
Message-ID: <7v1u89iyla.fsf@alter.siamese.dyndns.org>
References: <1370581872-31580-1-git-send-email-gitster@pobox.com>
	<1370820277-30158-1-git-send-email-gitster@pobox.com>
	<1370820277-30158-3-git-send-email-gitster@pobox.com>
	<20130610052500.GD3621@sigill.intra.peff.net>
	<7vwqq2l9cz.fsf@alter.siamese.dyndns.org>
	<20130610181557.GA2084@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Elliott Cable <me@ell.io>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 10 20:56:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um7Gt-0002a7-5G
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 20:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975Ab3FJS4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 14:56:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50801 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557Ab3FJS4q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 14:56:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8959B26F4E;
	Mon, 10 Jun 2013 18:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uf6Eecn64rObgNYmx7cs6WyZ+68=; b=HHWaLY
	qXlk7N6UF3d8Hy6t04H3g6fbAh6JpPKwBBrTpu2MpGy04FAEqbNzKI5Bs3DWJN8h
	KHG9mzhe+8FeDYnWYi/HGnHjSEmtLa6m7G42aSnCzml66comspCuiAv1v/wTaMp2
	nEIQaGLYAlqZ0tGNPbj5GsaKNXyZNgKgb/I7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L8R5vnkvyDJIrQjxnt9iwC00On+ckAO+
	oDhk1fH56hKVrszNLa9GX9o1o6hJqhn8QMc/+HYNTisUd54wboMkG5fCmLVKlZZ1
	dEoU36HBavtGUupbBqUa+HJXmcAc5Vr2VqkbEwn7xMMIvy+iZlYfsIIxT4JV9gxX
	gAXsCaNhtWQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AB8626F4D;
	Mon, 10 Jun 2013 18:56:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB34526F48;
	Mon, 10 Jun 2013 18:56:34 +0000 (UTC)
In-Reply-To: <20130610181557.GA2084@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 10 Jun 2013 14:15:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 78E631AA-D1FF-11E2-92D1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227357>

Jeff King <peff@peff.net> writes:

> On Mon, Jun 10, 2013 at 12:21:00AM -0700, Junio C Hamano wrote:
>
>> > It may be worth looking again for other places to use this over
>> > commit_list, but even the caller you are introducing here justifies its
>> > presence.
>> 
>> The next candidate is paint-down-to-common, probably.
>
> Yeah, I don't think I looked at that at all last time (mostly because it
> only large as the graph gets wide, which is typically acceptable for
> us). But it should be easy to do.
>
>> > Also, I wrote some basic tests to cover the priority queue as a unit. I
>> > can rebase them on your commit if you are interested.
>> 
>> It would be great.
>
> Squashable patch is below.
>
>> > Is it worth making this "struct commit *" a void pointer, and handling
>> > arbitrary items in our priority queue? The compare function should be
>> > the only thing that dereferences them.
>> >  
>> > I do not have any non-commit priority queue use in mind, but I do not
>> > think it adds any complexity in this case.
>> 
>> I didn't either (and still I don't think of one), but I agree that
>> the implementation can be reused for pq of any type, as long as it
>> is a pointer to struct.
>
> I converted this to a void pointer in my patch below, simply because it
> makes it easier to write a test-queue that operates on ints. Due to
> implicit casting, it should work for the most part without changing the
> calling code unless you have a caller that does something like:
>
>   commit_queue_get(&q)->date
>
> or similar. I didn't change the name, either. It may be silly to call it
> "commit_queue" still since it is now more general. I simply called mine
> "queue" (I wanted "pqueue", but that conflicted with globals defined by
> OpenSSL; yours is a more general queue anyway, so maybe that is a good
> name).

I agree that it makes sense not to call it either commit-queue or
pqueue.  While at it, the filenames should probably be moved as
well, no?

> Here's the patch with the tests, meant to be squashed into your 2/4. As
> I mentioned above, you may want to further tweak the name, which would
> require fixing up the rebase patches on top.
>
> If you don't want to do the "s/struct commit/void/" change now, we can
> probably just have test-queue stuff the ints into commit pointers.
>
> The tests themselves are not extremely extensive, but at least let you
> check that you implemented the heap correctly. :)

Thanks.
