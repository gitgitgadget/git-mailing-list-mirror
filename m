From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Proposed config addition: submodules.denyNonFastForward
Date: Fri, 10 Jul 2009 16:26:36 -0700
Message-ID: <7vskh4t903.fsf@alter.siamese.dyndns.org>
References: <20090710195004.GA2371@starfruit.corp.slide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 01:27:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPPUS-0005tt-L5
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 01:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757393AbZGJX0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 19:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757191AbZGJX0n
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 19:26:43 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35949 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756747AbZGJX0m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 19:26:42 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BBB9E266F3;
	Fri, 10 Jul 2009 19:26:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D9902266F1; Fri,
 10 Jul 2009 19:26:37 -0400 (EDT)
In-Reply-To: <20090710195004.GA2371@starfruit.corp.slide.com> (R. Tyler
 Ballance's message of "Fri\, 10 Jul 2009 12\:50\:04 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1F2C2188-6DA9-11DE-AD7D-424D1A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123091>

"R. Tyler Ballance" <tyler@slide.com> writes:

> In my previous thread regarding submodules "Manasging submodules on
> large multi-user projects" I feel that some things were left largely
> unresolved. My options given were:
>
>   * Use repo (and retrain users)
>   * Use Avery's git-subtree(1) addition (and potentially retrain)
>
> After discussing some of the pitfalls that I've had with submodule
> deployment with a kindred spirit in the #github channel, we came to the
> conclusion that submodules would be very usable if one could implement a
> "submodules.denyNonFastForward" configuration.

Perhaps it was obvious to _you_ and that was why you omitted mentioning
it, but it is unclear when you envision this configuration would kick in.

Do you deny changing the commit bound at path "sub" from B to X if X is
not a descendant of B (e.g. A in your example) when the user does "git add
sub"?  When the user makes such a change into a commit?  When the user
pushes a history that contains such a change to the remote repository?

I suspect that it is quite common for a library-ish project to have two
branches, v1.0 and v2.0, that are _not_ strictly fast forwards.  In this
respect, git.git is not a norm but is an exception, where 'maint' is
always a subset of 'master', causing v1.X.Y always be a subset of
v1.X.(Y+1).

And you may want to bind such a project to your project as a submodule.

During the evolution of _your_ superproject, at some point you would
decide to switch from using v1.0 line to v2.0 line of the submodule, and
that won't be a fast forward.  On the other hand, when you are in control
of both submodule and superproject, it is reasonable to worry about the
fast forwardness of your submodule like you depicted in your ERRORCASE
scenario.  Your project may use both kinds of submodules, which leads me
to guess that this shouldn't be a single submodule.denyFastForward, but
should be a per submodule variable, submodule.$name.denyFastForward,
regardless of at what stage the check kicks in.

Also it is plausible that your submodule people are working actively and
from time to time break their tip, and you as a superproject person may
have to temporarily revert to an older and more stable commit from the
submodule history until things stabilize on their end.

The submodule history may look like this:

 ---A---B---C---...---G

where A was a bit stale but proven one, B was a nice bleeding edge but
later turned out to be broken, and the submodule people are working
towards the goal of producing a good one G.

Your superproject's history may first bind B, hoping that submodule people
did a great job.  But then you discover it was not ready and you have to
step back to A temporarily, in order to be able to continue in the
meantime.  That won't be a fast-forward (you listed this as one of your
"problems").

You could fork the submodule history to queue a revert of B on top of it,
to satisfy the fast-forward requirement you are introducing here, and then
keep going.

          B' (revert of B, whose tree is the same as A)
         /       
 ---A---B---C---...---G

When submodule people got their act together, you would want to bind
commit G as the submodule to your project.  However, B' won't fast forward
to G, so you will end up making another merge (checkout G and merge B'
using ours strategy) in the submodule, again just to satisfy the fast
forward requirement.

          B'------------G'
         /             /
 ---A---B---C---...---G

The implication of this is that your history will never converge with the
one from submodule people.  Unless you have a way to force them to take G'
as their tip after they complete G, that is.

Which mekes me think that, even if you _normally_ want to require fast
forward, it is essential for you to be able to override the check to
rebind A in place of B, violating the usual fast forward check.

>    * Is it a server-side (bare repo) config value or a client side
>    config value?  (I'm assuming it fits best client side).

I think the first prototype should be done as a pre-commit hook script.

>    * What if you have a submodule and you explicitly need to roll it
>      back to a previous version of the submodule?

An escape hatch is essential, as I discussed above (not just to "roll B
back to A" example, but also to "switch from v1.0 line to v2.0 line").
You could use "commit --no-verify" if you go the pre-commit hook route.

>    * Does this cross the line of separation between super- and
>      sub-module?

This is purely a Porcelain issue to support your workflow, and we should
allow you to express a little bit of Policy like this, if it helps to make
the workflow safer/saner.  I think it is too premature to worry about "the
line of separation"; it is not like we would be making this check part of
the default behaviour anytime soon.

Another question not in your list:

     * What should happen if the submodule is not even checked out nor
       cloned?

This would happen when a top-level integrator who does not even have to
check out nor modify a particular submodule has to merge two branches that
have different commits for a submodule.  Perhaps their common ancestor in
the superproject history had a commit B bound at the submodule, and one
branch of the superproject kept it as-is while the other branch updated it
to a different commit A.  The three-way merge will bind commit A in the
resulting merge commit, but there is no way for the top-level integrator
who does not even have a clone of the submodule to see how A and B relate
to each other.

I think the right answer to the above question is "ignore the check".  The
branch that changed the submodule from commit B to commit A should have
known what it was doing when it made that change, and the top-level
integrator should be able to trust that change---that is why he is merging
the branch in the first place.
