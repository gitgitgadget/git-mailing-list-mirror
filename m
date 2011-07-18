From: "George Spelvin" <linux@horizon.com>
Subject: Re: Git commit generation numbers
Date: 18 Jul 2011 07:48:34 -0400
Message-ID: <20110718114834.12406.qmail@science.horizon.com>
References: <A142F49B-FC91-410A-B3C8-15FC7E5C3C68@gmail.com>
Cc: git@vger.kernel.org, torvalds@linux-foundation.org
To: anthonyvdgent@gmail.com, linux@horizon.com
X-From: git-owner@vger.kernel.org Mon Jul 18 13:48:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QimJV-0000M1-2w
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 13:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756429Ab1GRLsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 07:48:36 -0400
Received: from science.horizon.com ([71.41.210.146]:44373 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753419Ab1GRLsf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 07:48:35 -0400
Received: (qmail 12407 invoked by uid 1000); 18 Jul 2011 07:48:34 -0400
In-Reply-To: <A142F49B-FC91-410A-B3C8-15FC7E5C3C68@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177370>

>> 1) It involves changing the commit format.  Since the change is
>>   backward-compatible, it's not too bad, but this is still fundamentally
>>   A Bad Thing, to be avoided if possible.

> Git is designed to ignore data in this case afaik, so I do not see any
> reason why backwards-compatibility gets broken here.

That's what I just wrote.  "The change is backward-compatible"
is a simpler and shorter way of writing "it doesn't break
backwards-compatibility" (to put the generation number in the commit
object).

I just said that *any* change is still undesirable.

>> 2) It can't be retrofitted to help historical browsing.

> I like to see more (valid) arguments, as I do not see what you are
> trying to explain.

I apologize for being unclear.  I meant that if you store the generation
in the commit, then you can't add generation numbers to an existing
repository ("retrofit") in order to speed up --contains and --topo-sort
operations on pre-existing git repositories.

(Without recomputing all the hashes and breaking the ability to merge
with people not using the feature.)

As Linus points out, this is not likely to be a major performance issue
in practice, as operations like finding merge bases overwhelmingly
use recent objects (which will have generation numbers once the feature
goes in), but it is a measurable disadvantage.

>> 3) You have to support commits without generation numbers forever.
>>   This is a support burden.  If you can generate generation numbers for
>>   an entire repository, including pre-existing commits, you can *throw
>>   out* the commit date heuristic code entirely.

> I'll give you a few months to rethink at this statement until this
> feature does get used widely. I think there was never a moment where
> we would ever think to rebuild older commits as this would break the
> hash of the commits where many people are potential looking for.

I'm afraid that your English grammar is sufficiently mangled here that
I don't understand *your* point.  Which is a shame because it's
one of my more important points.

Storing the generation number inside the commit means that a commit
with a generation number has a different hash than a commit without one.
This means that people won't want to break the hashes of existing commits
by adding them.  In many cases, ever.

Which means that git will have to be able to work without the generation
numbers forever.

If the generation numbers are stored in a separate data structure that
can be added to an existing repository, then a new version of git can
do that when needed.  Which lets git depend on always having the the
generation numbers to do all history walking and stop using commit date
based heuristics completely.

>> 4) It can't be made to work with grafts or replace objects.
>>
>> 5) It includes information which is redundant, but hard to verify,
>>   in git objects.  Leading to potentially bizarre and version-dependent
>>   behaviour if it's wrong.  (Checking that the numbers are consistent
>>   is the same work as regenerating a cache.)

> The data is *consistent* as long as the hash doesn't change, storing the
> data in the commits *can* reduce resource and makes calculations cheaper.

You're mixing up two issues.  Storing the generation number *anywhere*
can make calculations cheaper.  Storing them in the commit is indeed the
*simplest* place, but the calculation cost point is equally true if the
numbers are stored somewhere else.

As for consistency...

I'm defining "consistent" as consistency between the generation number
and the parent pointers.  This is the property that the history-walking
optimizations depend on.

A commit's generation number is consistent if it is larger than the
generation number of any of its parents.  (Optionally, you
may require that it be larger by exatly 1.)

A generation number is *not* consistent if is less than or equal to the
generation number of one of its parents.

If this happens, history walking code that uses the generation numbers
will not produce correct output.

Further, the nature of the incorrectness will depend on implementation
details ("potentially bizarre and version-dependent behaviour") of the
history-walking code.

By computing the generation numbers when needed, the entire "what happens
if someone makes a commit with an inconsistent generation number"
problem goes away.  It goes from "not likely to happen" or "somthing
that has to be checked for when receiving objects" to "can't happen".

The computation to verify that an incoming commit's generation number
is consistent is exactly the same computation needed to compute the
generation number it should have: look up all parent commit generation
numbers and take the maximum.  The only question is whether we store
the result after computing it, or compare with the included generation
number and possibly print an error message.


For example, suppose I generate a commit with a generation number of
UINT_MAX.  Will this crash git?  That's a new error condition the code
has to worry about.  If I generate the generation number locally, I know
that can't happen in any repository that I can download in a reasonable
period of time.

If we had generation numbers from day 1, we could just require that they
always be checked, and an inconsistent object could be always rejected.

But since old git versions ignore the generation number in commits, a
bad generation number could spread a long way before someone notices it.
It becomes a visible problem.  Not a really big one (I'm pretty sure
that refusing to pull it introduces no security holes), but it's an
error condition that we have to actually think about.


> A cache would use more resources because they can become invalid at any
> point and *should* be recalculated by every client. We are processing
> data that *can* be reused by everybody with a git client which has this
> specific feature, but does not break anything with an older client.
>
> So please, calculate things only once as this may save a *lot* of time :-)

This is silly.  The cache can't become invalid except by disk corruption,
which can corrupt numbers stored in the commit object just the same.
(The corruption can be detected by git-fsck, but that's also true
independent of where the numbers are stored.)

And the work to recalculate the numbers is far less than the work to
garbage collect, or repack, or generate the index of an incoming pack,
or any of a dozen operations that are normally done by all clients.
(Don't get me started on rename detection!)

This is a completely misplaced optimization.  Walking every commit in
the repository takes a few seconds and enough memory that we don't want
to do it every "git log" operation, but it's barely perceptible compared
to other repository maintenance operations.

Do it once when you install a new git software version and then you can
forget about it.

> I would see more advantage in a cache if the data could differs on
> every client, but that still doesn't mean that you should use one.

If you use grafts or replace objects, it can be.  That's my point 4)
above.  Supporting these makes maintaining a cache trickier, but it's
simply impossible to do with in-commit generation numbers.
