From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] pre-rebase: Refuse to rewrite commits that are reachable
 from upstream
Date: Mon, 20 Feb 2012 23:44:41 -0800
Message-ID: <7vehtoiqae.fsf@alter.siamese.dyndns.org>
References: <201202111445.33260.jnareb@gmail.com>
 <1329772071-11301-1-git-send-email-johan@herland.net>
 <7vobstjfcs.fsf@alter.siamese.dyndns.org>
 <CALKQrgcDDVH8rxn80ZTMyR3y3n3Vs1LSCtH=ZiwG7it_LE2wgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com, philipoakley@iee.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Feb 21 08:45:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzkP7-00059O-Cs
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 08:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602Ab2BUHop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 02:44:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57184 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752519Ab2BUHop (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 02:44:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F0962873;
	Tue, 21 Feb 2012 02:44:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cfMtPRLnEQIdsEe+ftR/4W9fWK4=; b=UqL8F9
	gb70k5nEE8ORja5mvpkkymjNvidEyl2nmdCImqwOZPQTlclToxQWzpQpREt3ppzX
	tpq4fz1GxKn0EtVUlV26PaTRC+XOJFC0OTGg8psqq1kyVnekpf/sO5+8Ut5qPqpt
	Zwl5SSZmsK8G5R5AZjuBSebXCG7MmK0bQlLdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M4ADonytd6oM4xyl2o5QnmATGF1ZE7ja
	fC3SfwpLORRv64qWNrcTzF40gTPsCaoNCxhb6tK2ySknuhTeE2TpbitCcAeujFot
	ziXvno51bxCh6pa4T2AKZg0HAroSlXIqxZrpHro5zKoczwzaUyBTwUv/uTyImaxH
	rsX1ppi4b00=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06B0A2872;
	Tue, 21 Feb 2012 02:44:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CAC92871; Tue, 21 Feb 2012
 02:44:43 -0500 (EST)
In-Reply-To: <CALKQrgcDDVH8rxn80ZTMyR3y3n3Vs1LSCtH=ZiwG7it_LE2wgQ@mail.gmail.com> (Johan
 Herland's message of "Tue, 21 Feb 2012 01:03:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB1B636A-5C5F-11E1-8D6C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191139>

Johan Herland <johan@herland.net> writes:

> What  you are describing here may be a common workflow, but
> "rebase.bottomLimit" is still very specific to that kind of workflow.
> What I'm after is a much more workflow-agnostic concept of:
>
>   "If I have pushed something, I should probably not rebase it"

Your "this branch pushes directly to that remote branch, so I can check if
it will result in rewrite of published commit" is even *less* generic than
having a single bottomLimit in my illustration.

I may not push out my topic branches directly, only the aggregate of them
in 'next', but once 'next' is pushed out, they are not eligible for
rebasing.  A per-branch bottom, e.g. rebase.$branch.bottomLimit, might
make it more flexible to cover such a case, though.

On the other hand, without any such safety, a merge to 'next' would give
many conflicts and "shortlog master..next" will show many duplicates after
any topic that are already merged to it are accidentally rewritten, and it
is just the matter of using reflog on topic branches to recover from such
a mistake.

>> I wonder if it would be a more direct solution to the issue you are
>> raising to give them a good tool to help them to be more careful with less
>> effort on their part before they publish (not before they rebase).
> 
> ..., I'm not sure how we can help the user _not_ publish the
> branch until it's ready.

I think we are in agreement that we do not think of a good solution
offhand to the real cause of the issue, except by encouraging the use of
throw-away review branches, perhaps.

> I think the following decribes what often happens for many users:
>
>  1. User A pushes the branch to a public repo.
>  2. User B points out a simple mistake in the branch.

That's the CVS workflow, and it is not "a" public repo but "the" public
repo shared between A and B (and also with all the project participants).

>  3. User A makes a fix
>  4. User A squashes the fix into the (already-published) history.
>  5. User A attempts to push the "fixed" history (but is rejected by
> the public repo because of non-fast-forward).
> At this point, the damage is already done,...

Which is probably a sufficient safety which the user can learn from.  If
this happens too often, that probably means we are not helping them enough
to learn not to "commit --amend" or "rebase" if they are using Git as a
better CVS.

> You could say that User A should be more careful and push to a "less
> public" repo in step #1 (thus allowing the fix to be squashed before
> pushing to a "more public" repo in step #5),...

That is essentially a workflow that uses throw-away review branches in a
distributed environment, and at that point, we are not constrained by the
limitation of the CVS workflow. While still in early review cycles (which
corresponds to being in our 'pu'), "commit --amend" and "rebase" are fine
tool to be used.  And...

> but how "public" is
> "public" enough to have someone point out the bug, but still
> "unpublic" enough to allow rebase?

... I can imagine that currently that is determined purely by project
convention. Perhaps there needs a way to mark throw-away review branches
like 'pu' (or saying the same thing from the different perspective, to
mark cast-in-stone integration branches like 'next') so that tools can
mechanically decide what should and should not be rewritten.

To extend the idea of promoting throw-away review branches further,
perhaps it might help if there is an easy way to let the users publish
their "master" to a branch that is not the "master" of the central shared
repository even in the CVS workflow (e.g. by default a push from user A
always goes to refs/review/A/master), and to have an option to "git push"
that makes it go to the "master" when the user really means the branch is
ready (and it would move refs/review/A/master to attic to be later gc'ed).

> ... And I
> think that refusing rewrites of commits that are already present in
> the @{upstream} remote-tracking branch is good enough to help most
> users avoid steps #4 through #6 (in a push-based workflow[1]).

See above regarding branches that should not be rebased even if they are
not directly pushed out.

> In
> fact, from a pedagogical POV, I think step #4 is probably the best
> spot for novice users to learn exactly the distinction between
> acceptable and unacceptable history rewrites (instead of having it
> explained to them as a consequence of the step #5).

I doubt you have enough information at point #4, unless you restrict the
workflow you allow your novice users to use fairly severely, to give
appropriate advice.  While I agree with you that it would be the best if
we could do so at step #4 without stopping the user from doing what s/he
needs to do with false positive, I think it is not pedagogical POV but
dreaming if the world were ideal without knowing what it would take to
make it ideal.

At least I don't know offhand what kind of changes are needed to restrict
the user actions to an "approved" workflow so that step #4 can make a
useful decision (that is, no false positives and small enough false
negatives).
