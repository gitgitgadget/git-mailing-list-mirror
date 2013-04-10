From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [rfh] do I need to use something more complex to do this?
Date: Wed, 10 Apr 2013 11:19:57 -0700
Message-ID: <7vr4iimenm.fsf@alter.siamese.dyndns.org>
References: <7vk3oao3e5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 20:21:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPzeB-0000i8-VA
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 20:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937051Ab3DJSUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 14:20:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65274 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936053Ab3DJST7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 14:19:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66DE015BFF;
	Wed, 10 Apr 2013 18:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TraVxuo4LyJH9nW4icvDz0gzwt8=; b=sLXU0A
	1Eup6Tox4e66KD+ufwTob8Z5OAZdou+ZJKFb5LGCPIakgbXhVtTb3w1FxlhD3JxJ
	bnyJZANvn+4sCcEZdNlwpp4ct8rBQPmH/AC86cMmR/unKfryVePk+dOgxTzt3TXH
	Tqu0yEmCx5Nqh81z7KZv6oBprMb+Fivh7918o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZXuiSjDRus227pQqpL4ZyGQrMeJtywYN
	3E2kmSf9X5SB7j+mpPE+AEDUc8S3pLQh4e+LzU2wh8PjOQHtzPZbFTwqukCgyXDK
	LtV/TVkNt7LqXw8H/eYHbcBwlOQOWtk/bjkM4qsB2j3hHSxXDi1Jipg+WNC8lOQS
	Jhs3U/uzklY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E8C915BFE;
	Wed, 10 Apr 2013 18:19:59 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A20F415BFC; Wed, 10 Apr
 2013 18:19:58 +0000 (UTC)
In-Reply-To: <7vk3oao3e5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 10 Apr 2013 07:40:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 409A4846-A20B-11E2-8A49-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220713>

Junio C Hamano <gitster@pobox.com> writes:

> I have set of items with two attributes, <X,Y>, and would like to
> keep them in some data structure in such a way that it is efficient
> to (1) add a new item to the data structure, and (2) pick an item in
> a specific order. There can be multiple items that share the same
> value for X, or Y, or both X and Y, and it does not matter in what
> order items comes out among those that share the same <X,Y>.
>
> The type of X is totally ordered. The type of Y also usually is, but
> Y can take a special value U(nspecified).
>
> Now on to the "specific" order I want to pick an item.  I'd like to
> take the item with the largest value of Y in general, and tiebreaking
> on the value of X which also I prefer to take from larger to smaller.
>
> But with a twist.
>
> When I am picking an item <X=n,Y=m>, there should be no item
> remaining in the data store with a value of Y that is smaller than m
> (duplicates are allowed, so there can still be items with Y=m), and
> also when I am picking <X=n,Y=m>, there should be no item with
> Y=Unspecified that has a value of X that is equal or smaller than n.
>
> E.g. if I have these 6 items (ignore the lines between the items for
> now):
>
>             <104,U>--<105,U>--<106,4>
>            /
>     <101,U>--<100,U>--<102,3>--<104,4>
>
> I would want to pick them up in this order:
>
>     <106,4> <105,U> <104,U> <104,4> <102,3> <101,U> <100,U>

Note that with the above specification, a possible solution is to
show all the items with Y=Unspecified before showing others, but
that would not be ideal for the intended use case; pretending Y=U as
if Y=max_range is not a usable workaround.

This is "I create a stream of items with specified Y in descending
order.  There are some items with Y=Unspecified and I want to find
appropriate places to mix the latter into that stream".

Because the desired ordering is not a total order, I need to go
to the "pair of priority list" route, I think.
>
> I see how this can easily be done by using a two priority lists,
> i.e. one for items with Y=Unspecified that is sorted by X, and the
> other for all other items that is sorted by <Y,X>. Peek the top of
> both, and pick the top of the former until its X is smaller than the
> value of X of the top of the latter, otherwise pick the top of the
> latter.  I am wondering if I can use less complex data structure,
> like a single ordered sorted array, with a clever comparison
> function.
>
> For the curious, the items in the above picture represents commits,
> and lines are ancestry chains between them. I am thinking how we can
> extend the still_interesting() function with an optional generation
> number.
