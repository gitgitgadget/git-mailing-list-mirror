From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/3] revision.c: tighten up TREESAME handling of merges
Date: Sun, 28 Apr 2013 11:38:00 -0700
Message-ID: <7v61z6sdpz.fsf@alter.siamese.dyndns.org>
References: <517AD304.6020807@bracey.fi>
	<1367004718-30048-1-git-send-email-kevin@bracey.fi>
	<7vppxfsirl.fsf@alter.siamese.dyndns.org> <517CC9AE.30407@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Sun Apr 28 20:38:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWWUS-0002pV-4Y
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 20:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756154Ab3D1SiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 14:38:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47214 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755633Ab3D1SiD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 14:38:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B1EA1A240;
	Sun, 28 Apr 2013 18:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RMKmA3vmGk3ETVytq2j1z3WTpVU=; b=oGa1CM
	sXu38ox00napb/648t3wysjc0drt5cDdnFuUhFSHUMApmJyFffUdAJxph6Y1FwMv
	GGKg8n6FzP2rbFvxfgBQbzVtFurydYVZy31G8bPbyoV5R4fkrws1CDo1e26WxD7K
	TFz32bSfnnXSv6xpOBEDcVZFBKsttZt3zbGNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dw2Wbl4DiE4wxaUO9pwLh37b/+hddEWS
	RZLpuWteP0yVTg4CRgTW/vZrBC9vzHGnqJlSFd20LprB6T/3uAfD1jkNNEK5m/jT
	lGqw57Sg/FXKNoVwC+Vcn4c3G0hwebb4xpYI6CgQYi0RE0B8ZFVwYyQbxMIBekcn
	jxMbAGH4Vc0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DED91A23F;
	Sun, 28 Apr 2013 18:38:03 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67A7C1A23C;
	Sun, 28 Apr 2013 18:38:02 +0000 (UTC)
In-Reply-To: <517CC9AE.30407@bracey.fi> (Kevin Bracey's message of "Sun, 28
	Apr 2013 10:03:10 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2024390-B032-11E2-8D64-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222739>

Kevin Bracey <kevin@bracey.fi> writes:

>> Do we want to discard the decoration data when the commit becomes a
>> non-merge?
>
> Would seem reasonable, and would also help make concrete why we update
> TREESAME immediately, and not in update_treesame(), but I didn't spot
> a mechanism to discard decoration. I'll recheck.

What I meant was a simple "free(it)" and a call to add_decoration()
to register a NULL for the object whose treesame[] we no longer
need.

> I could insert an "if (!commit->object.flags & TREESAME)" test to skip
> the entire update. I'd be inclined to do that as the caller of
> update_treesame(). I think update_treesame() itself should be
> general-purpose without assumptions about what changes have been made,
> so it's a pure treesame[]->TREESAME calculation, without TREESAME as
> an input.

Makes sense.

> (Aside - just occurred to me we could swap the loop for
> "strlen(st->treesame) == st->nparents", if we kept a zero terminator
> in the array. Maybe a bit too smart-ass?)

Probably ;-)

>>> +	for (pp = &commit->parents;
>>> +	     (parent = *pp) != NULL;
>>> +	     pp = &parent->next, nth_parent++) {
>> I see the reason to change from while to for is because you wanted
>> to count, and I think it makes sense; but it is more readable to
>> initialise the counter here, too, if that is the case. I.e.
>>
>> 	for (pp = &commit->parents, nth_parent = 0;
>> 	     !(parent = *pp);
>> 	     pp = &parent->next, nth_parent++) {
>
> Agree on nth_parent, but  "!(parent = *pp)"  isn't "(parent = *pp) !=
> NULL", mind. Did you mean "!!"? In which case I still prefer it my
> way.

Droppage of NULL check was a typo.  I only meant A part of for(A;B;C).

>>>   @@ -773,6 +861,9 @@ static void limit_to_ancestry(struct
>>> commit_list *bottom, struct commit_list *li
>>>   	 * NEEDSWORK: decide if we want to remove parents that are
>>>   	 * not marked with TMP_MARK from commit->parents for commits
>>>   	 * in the resulting list.  We may not want to do that, though.
>>> +	 *
>>> +	 * Maybe it should be considered if we are TREESAME to such
>>> +	 * parents - now possible with stored per-parent flags.
>>>   	 */
>> Hmm, that is certainly a thought.
>
> My comment's wrong though. Reconsidering, what I think needs removing
> is actually off-ancestry parents that we are !TREESAME to, when we are
> TREESAME on the ancestry path.

I thought I read you meant exactly that, i.e. !TREESAME, but now I
re-read what is quoted, you did say "we are TREESAME" ;-).  I think
I agree with you that we do not want any side branch that is not on
the ancestry path we are interested in to affect the sameness
assigned to the merge commit.

> I've realised while testing this that there's been one thing that's
> confused me repeatedly, and I think this comment was an example of
> it. The example in the rev-list-options manual is wrong.
>
>                   *   *
>           .-A---M---N---O---P
>          /*    /   /*  /*  /*
>         I     B   C   D   E
>          \   /*  /   /*  /
>           `-------------'

I've added '*' next to each arc between a commit-pair whose contents
at 'foo' are different to the illustration, following the set-up the
manual describes.  E is the same as I for 'foo' and P would resolve
'foo' to be the same as O.

> Contrary to the manual, merge P is !TREESAME to E (or I).  E's base is
> old enough that E isn't up-to-date w.r.t. "foo". Thus merge "P" is no
> longer TREESAME and does become subject to display with the new
> --full-history:
>
>    I  A  B  N  D  O  P

Assuming N's parents-list is rewritten to be A and B, this sounds
sensible.

> I believe this is correct, because P is a merge that determined the
> fate of "foo", so merits --full-history inspection. (--simplify-merges
> obviously knocks P back out again: --simplify-merges becomes more
> important if --full-history gets fuller).

E simplifies to I which is already an ancestor of O and is redundant
when inspecting P, hence P becomes a single-parent child of O and
further simplifies to O because it has the same 'foo'.  Makes sense.

> Given this error, and this change, I think this example may want a
> slight rethink. Do we want a proper "messing with other paths but
> TREESAME merge" example? Say if E's parent was O, P would not be
> TREESAME and not included in --full-history.

I am not sure if I follow your last sentence.   

Do you mean this topology, where E's sole parent is O, i.e.

              E
             / \
	N---O---P
           /*
          D

and E does not change 'foo' from O?  Then P is TREESAME to all its
parents and would not have to appear in the full history for the
same reason M does not appear in your earlier IABNDOP output, no?

>> OK, even though the use of TMP_MARK (meant to be very localized)
>> across two functions feel somewhat yucky, they are file scope
>> statics next to each other and hopefully are called back to back.
>
> Well, by the end of the series you've got two functions setting it, in
> preparation for later input to this function.

As long as "setting" and "using and then cleaning after done" are
localized enough so that nobody will be tempted to insert another
complex processing in between that might need TMP_MARK we should be
OK.
