From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] push: introduce implicit push
Date: Sat, 13 Apr 2013 21:42:51 -0700
Message-ID: <7vehed7ilu.fsf@alter.siamese.dyndns.org>
References: <1365780835-2853-1-git-send-email-artagnon@gmail.com>
 <7v38uvcrjl.fsf@alter.siamese.dyndns.org>
 <CALkWK0=-GcOF17Q-y-Aqj0ThX5pPQFrriDqoJ2qsr=CS+wUNGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 14 08:05:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URG3z-0001Io-PK
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 08:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718Ab3DNGFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 02:05:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63169 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766Ab3DNGFE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 02:05:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EE5DE3E7;
	Sun, 14 Apr 2013 06:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=l35YhJ145SMoM0HYj4Q3+9cWkKw=; b=YNbo/biPTxmJohCOPJ1s
	GwyEyA6vKIl3VLmjvFMd/mX4OozuYfoqeuqBsFxhsnlLIdnXPoTuwlsymdOvuDIg
	6K7XnbLmweLnI09CDO8exEvvIUKDxr8/j2Hge2CZpspLm5M2vAdgZvq8lHY4LdW/
	OkR21YjVIcPC9UX3f8Nnwtw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=L6l3KogBUkv9n2fc9CLIATM55SJ8AAgsCPq3NUzdcowE4M
	cgJ7/m7h1nsNEQ50VjUlBm7hXrhi8ePYrP66JswYi7yavB9/bxRuU0t9gmacrUiD
	DzeA21xzQbrOTlNbPs+12+vxkY0tOjnhRoqr9lBBCN8s/C3zdq7SIbpW6WaLA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85DE5E3E4;
	Sun, 14 Apr 2013 06:05:03 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F21F1E3E1; Sun, 14 Apr 2013
 06:05:02 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F2FA7B0-A4C9-11E2-9D5F-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221082>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I agree with you largely, but I would still argue that choosing a
> destination based on the current branch is a historical mistake made
> by "matching".

"matching" is not necessarily a good default for everybody, and we
are fixing that historical mistake in Git 2.0.

Step back and think again. "matching" has never been about where the
push goes.  It is about what are pushed out, once you decide where
to push.

If a user often wants to push out a branch as soon as he made a
commit on it (even when other branches that go to the same
publishing point should not be pushed out yet), an instructoin "Ok,
I'll push to that repository" that pushes all matching branches will
not work well, because it will publish uncooked other branches, too.

That is the historical mistake of making "matching" the unconfigured
default. The historical mistake of "matching" does not have anything
to do with the choice of "where to push". It is only about "what to
push".

If you re-read your three-remote example involving "upstream" (me),
"ram" (your wip publishing point) and "peff":

  Cf. http://thread.gmane.org/gmane.comp.version-control.git/220769/focus=220933

you'll see that the only reason why you thought you need the hack to
set pushremote to null was because you did _not_ use matching. It
illustrates one reason why blaming matching for selection of
destination misses the point.

In any case, dispelling a misplaced blame on "matching" is not the
main point of this message.

> With this patch, users must mandatorily know about
> remote.pushdefault and branch.<name>.pushremote, if they want to
> work in multiple-remote scenarios.

I am afraid that it is neither sufficient nor a good solution.

I do not necessarily think that the best course is to devise an
unintuitive (to unsuspecting users) set of rules and force users to
understand it. That is where my secondary unhappiness comes from,
and that was why I said that limiting the magic only to a very
simple and easy to understand case might make it more sellable.

"git push" that pays attention to "branch.*.remote" was the original
sin.

To casual users with push.default=current/upstream, the two branches
(my current branch?  the branch I am pushing out?) have always been
the same when branch.*.remote is used.  These users don't even have
to think about the distinction between the two [*1*].  But the
distinction starts mattering once you start wishing to omit saying
_where_ to push, because at that point, _what_ to push is the only
thing the user would give us, but the end users are not used to see
the destination chosen based on what is being pushed out.

The new branch.*.pushremote does not alleviate this confusion. It
gives the same "when on this branch, we push out to that remote"
(and not "when pushing this branch out, it goes there" impression.

The new remote.pushdefault _is_ a definite improvement: "If I do not
say where to push, this is where things go". It makes a very clear
statement, and does not have that confusion.

> - In git push master, master is verified not to be a path on the
> filesystem, not a remote, and finally a local branch.

Yes.

> - In git push master:next, master:next is interpreted as a destination.

Ideally it should notice and diagnose it as a syntax error and error
out (of course an attempt to locate master: URL handler will fail,
but that is less nice).

> - In git push master next:pu, master is verified as usual, and next:pu
> is pushed to the remote specified by next.  My patch currently does
> this (checks that <src> and <dst> are branches).

I am not sure what you mean by "and next:pu is...".  If "git push
next:pu master" should error out without mistaking "next:pu" as
destination, so should "git push master next:pu", I think.

The last one is also the same.  The "guess destination" magic should
kick in only when we can verify _all_ the refs we are pushing out
are simple ones (branch names, and possibly tag names), and the
behaviour should not depend on the order. Anything more complex is
too confusing.

I personally think it is much more sellable to use an even simpler
rule than what Jeff suggested, to make

	git push -- <refspec>

go to the remote.pushdefault (falling back to remote.default that is
"origin"), without even paying attention to what branch you are on,
and ignoring branch.*.remote/pushremote configuration.

That is sufficient to support the triangular, the publish-to-mine,
and the centralized workflows, no?  In any of these cases, the
repository you push out to is _one_, even though it may be a
different one from where you pull from.  If you have a very special
branch that goes to a different place than all the other branches,
you can always push out while on that branch without any refspec,
anyway.


[Footnote]

*1* If you really think about what branch.*.remote is _for_, it says
"I want this branch to integrate with that branch at this remote".
If the user were to push the branch out using the configuration, it
is more logical to think of it as "When pushing this branch out, it
goes there", and not as "When I am on this branch and say 'git
push', 'git push' pushes there".

But that is clear and logical _only_ to Git-heads who have thought
about this hard enough.
