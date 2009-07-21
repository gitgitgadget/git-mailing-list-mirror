From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 0/8] introduce 'git remote add --push' and 'git clone
 --push'
Date: Tue, 21 Jul 2009 14:00:20 -0700
Message-ID: <7vtz157nvf.fsf@alter.siamese.dyndns.org>
References: <1248112195-3761-1-git-send-email-bonzini@gnu.org>
 <7vprbvt30u.fsf@alter.siamese.dyndns.org> <4A659992.4020906@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Finn Arne Gangstad <finnag@pvv.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jul 21 23:00:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTMS2-0008L2-4n
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 23:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755560AbZGUVAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 17:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754950AbZGUVAa
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 17:00:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37024 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111AbZGUVA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 17:00:29 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 18E2ECA6C;
	Tue, 21 Jul 2009 17:00:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 64815CA6A; Tue, 21 Jul 2009
 17:00:22 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 84C912EC-7639-11DE-A14E-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123718>

Paolo Bonzini <bonzini@gnu.org> writes:

>> If I have a local branch X, is it conceivable that if I ever want to push
>> it out to elsewhere on a regular basis, I would likely to push it to the
>> same branch at the same remote?
>
> Yes.  The exception could be if you push to multiple remotes---but in
> that case, you have to issue multiple push commands anyway.  X ->
> (R,Y) is not a function, but (X,R) -> Y is.
>
>> Are these all?  What I am trying to get at is if we can tweak the rules
>> without introducing too much configuration variables to cover all these
>> cases.
>>
>> Traditionally, we said:
>>
>>      $ git push $there $ref
>>
>> is _always_ a shorthand for
>>
>>      $ git push $there $ref:$ref
>>
>> If we somehow tweak
>> this "$ref is a shorthand for $ref:$ref" rule to account for the tracking
>> branch.*.merge gives us, perhaps we can make the push easier to use.
>
> This is nice indeed.  My questions are:
>
> 1) can we assume backwards compatibility is not a problem?  Or, in
> other words, would this be 1.6.5 or 1.7.0 material?  In the past, the
> list has usually been very cautious about that, but if there's good
> reasons I guess the answer can be "yes".

I do not think this is an 1.6.X material.  We _do_ plan a backward
incompatible changes in 1.7.0 (a few series queued in 'pu') in the area,
so if a redesign along these lines is preferable, 1.7.0 would be the
milestone to do so.

I have a suspicion that the compatibility might not even be a huge issue
for this particular change.

 * If I say "git push k.org master", I always mean "git push k.org
   master:master", but I would never have forked my master from something
   else over there to begin with, and looking up branch.master.merge will
   yield master and there is no change in behaviour.  Note that in this
   paragraph, "I" is figurative---for anybody who uses local branch X as a
   local integration branch to be pushed back to the remote X, the end
   result will not change, even though the mechanism may be different.

 * For somebody who uses local branch Y to track branch X from the remote,
   branch.X.merge would say Y.  The above change will not be backward
   compatible in that:

	$ git push $there X

   would start pushing X to Y (currently X is pushed to X).

   But I suspect that people in this camp would already consider the
   current behaviour a misfeature, and they are always doing:

	$ git push $there X:Y

   when they want to push a single branch out, and loathing it (we can be
   reasonably sure about this when we realize that push.default = tracking
   was an attempt to lose :Y from this command line).

   The change would be an improvement for them.  Of course when they
   really mean it, they can say:

	$ git push $there X:X

> 2) if I understand correctly, then "git push HEAD" would behave like
> push.default=tracking rather than push.default=current.  If so, how do
> you provide push.default=current behavior?  (Or maybe you don't care).
>
> Would this apply to remote.*.push = HEAD too?  (I think so).  Are the
> backward compatibility issues stronger in this case?  (I also think
> so).

In either case, one assumption I did not spell out in the message you are
replying to is that in a sane workflow the mapping branch.X.merge = Y
gives us is enough and the (implicit) mapping remote.R.push gives to X is
redundant information.  I.e. if branch.X.merge = Y, branch.X.remote = R,
then remote.R.push would never map local X to anything but remote Y.

But that is just an assumption.  While I do not think of a sane workflow
for which that assumption does not hold, it is not a proof that the
assumption is universally true.

"git push HEAD" would behave like either tracking or current after this
change, but the distinction does not matter in practice exactly for the
same reason as the answer to the item 1) above in your list.

> 3) if the previous item turns out to be a problem, should we invent a
> new kind of refspec?  "HEAD:" is free to use, is it a good idea?  (I
> don't like it).

Likewise, if it is inconvenient that "git push HEAD" follows
branch.X.merge while on branch X, you can say "git push HEAD:HEAD" to be
more explicit.

> 4) From an implementation point of view, how well will it fit the
> existing code, or rather will it have to be special-cased all over the
> place?  I already didn't like the single special case I have in the
> "git push --current" patch, though I think it's unavoidable.

I actually have no idea, as I haven't looked at the code nor tried to
remember how it currently does its thing, while writing the message you
are replying to.

That was why I said "let's step back a bit".  I wanted to see if it is a
good time to start thinking what a design that is easier to use purely
from the end-user standpoint should look like, without being constrained
by the current implementation.  Piling more knobs after knobs may allow
experts who know which knobs to turn and what combination of knobs to
avoid in order to get the desired effect, but it is suboptimal if the end
result is unusable to ordinary users.

> That's true, and I actually liked the idea very much.  The fact that
> it raises many questions is not necessarily a point down---adding new
> configuration keys is definitely simpler to flesh out, but it may be
> that it only reaches a local maximum of simplicity/expressiveness.

Yes, the simplification (of the end user experience, anyway) I outlined
crucially depends on that one assumption that remote.R.push is more or
less redundant information when branch.X.merge is properly used.

I do not know if that is true.
