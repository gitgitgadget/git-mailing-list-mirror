From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] push: introduce REJECT_FETCH_FIRST and
 REJECT_NEEDS_FORCE
Date: Wed, 23 Jan 2013 08:28:49 -0800
Message-ID: <7vip6nj22m.fsf@alter.siamese.dyndns.org>
References: <20130121234002.GE17156@sigill.intra.peff.net>
 <1358836230-9197-1-git-send-email-gitster@pobox.com>
 <1358836230-9197-3-git-send-email-gitster@pobox.com>
 <20130123065640.GB10306@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Chris Rorvick <chris@rorvick.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 23 17:29:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty3CN-0007WG-8U
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 17:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756546Ab3AWQ2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 11:28:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40785 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756492Ab3AWQ2x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 11:28:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A67FC187;
	Wed, 23 Jan 2013 11:28:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HjMTr9JCN5EBYKl5ElYwRSjxhXI=; b=sSb8B0
	hRG/zodR7WJBdc4zKc2QmPddP5UauusQNOn227iyts+9s/UoBC4vKGkXx4Hb0zje
	f7gcdOw4RJb2Tg/SPLk+sbYso8Qzg4xi8ZhEgqjYyliPVIGQfsGEnMNZZPEeK73U
	P9A26pU+kAd5se7GDT1I/xVOCtI+rShahQP1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IIweTPQ4ofvj0Vlf4BhqahPoNiGFc8pb
	w/IZlbrZQ8HxIsGt65Zkzr5oOIb7/SnYbpfbTYKA5pdIPKJ3vrRCSbS+I97Fztj0
	bY0aXaC4nzpQvQiP4WNQ3s5EacZZgMjavp0E7KeCkWxdJ2uvj9ztMpdKm+KpowUc
	+VDAozQ7pcg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00211C186;
	Wed, 23 Jan 2013 11:28:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D626C185; Wed, 23 Jan 2013
 11:28:51 -0500 (EST)
In-Reply-To: <20130123065640.GB10306@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 23 Jan 2013 01:56:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F8AAE98C-6579-11E2-A2E1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214332>

Jeff King <peff@peff.net> writes:

> On Mon, Jan 21, 2013 at 10:30:29PM -0800, Junio C Hamano wrote:
>
>> When we push to update an existing ref, if:
>> 
>>  * we do not have the object at the tip of the remote; or
>>  * the object at the tip of the remote is not a commit; or
>>  * the object we are pushing is not a commit,
>> 
>> there is no point suggesting to fetch, integrate and push again.
>> 
>> If we do not have the current object at the tip of the remote, we
>> should tell the user to fetch first and evaluate the situation
>> before deciding what to do next.
>
> Should we? I know that it is more correct to do so, because we do not
> even know for sure that the remote object is a commit, and fetching
> _might_ lead to us saying "hey, this is not something that can be
> fast-forwarded".
>
> But by far the common case will be that it _is_ a commit, and the right
> thing is going to be to pull....
> Is the extra hassle in the common case worth it for the off chance that
> we might give a more accurate message? Should the "fetch first" message
> be some hybrid that covers both cases accurately, but still points the
> user towards "git pull" (which will fail anyway if the remote ref is not
> a commit)?

I was actually much less happy with "needs force" than this one, as
you have to assume too many things for the message to be a useful
and a safe advise: the user has actually examined the situation and
forcing the push is the right thing to do.  Both old and new objects
exist, so the user _could_ have done so, but did he really check
them, thought about the situation and made the right decision?
Perhaps the attempted push had a typo in the object name it wanted
to update the other end with, and the right thing to do is not to
force but to fix the refspec instead?  "You need --force to perform
this push" was a very counter-productive advice in this case, but I
didn't think of a better wording.

The "fetch first and inspect" was an attempt to reduce the risk of
that "needs force" message that could encourage brainless forced
pushes.  Perhaps if we reword "needs force" to something less risky,
we do not have to be so explicit in "You have to fetch first and
examine".

How about doing this?

For "needs force" cases, we say this instead:

 hint: you cannot update a ref that points at a non-commit object, or
 hint: update a ref to point at a non-commit object, without --force.

Being explicit about "non-commit" twice will catch user's eyes and
cause him to double check that it is not a mistyped LHS of the push
refspec (if he is sending a non-commit) or mistyped RHS (if the ref
is pointing at a non-commit).  If he _is_ trying to push a blob out,
the advice makes it clear what to do next: he does want to force it.

If we did that, then we could loosen the "You should fetch first"
case to say something like this:

 hint: you do not have the object at the tip of the remote ref;
 hint: perhaps you want to pull from there first?

This explicitly denies one of Chris's wish "we shouldn't suggest to
merge something that we may not be able to", but in the "You should
fetch first" case, we cannot fundamentally know if we can merge
until we fetch.  I agree with you that the most common case is that
the unknown object is a commit, and that suggesting to pull is a
good compromise.

Note that you _could_ split the "needs force" case into two, namely,
"cannot replace a non-commit" and "cannot push a non-commit".  You
could even further split them into combinations (e.g. an attempt to
replace an annotated tag with a commit and an attempt to replace a
tree with a commit may be different situations), but I think the
advices we can give to these cases would end up being the same, so I
tend to think it is not worth it.  That is what I meant by "I do not
expect me doing the type-based policy myself" in the concluding
message of the series.
