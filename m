From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] push: indicate partialness of error message
Date: Tue, 19 Feb 2008 16:09:51 -0800
Message-ID: <7vir0kfpyo.fsf@gitster.siamese.dyndns.org>
References: <20080219162501.GA30451@sigill.intra.peff.net>
 <7vablwiqa7.fsf@gitster.siamese.dyndns.org>
 <20080219215441.GA7778@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Garber <jgarber@ionzoft.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 20 01:10:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRcY0-0002Fz-9n
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 01:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754969AbYBTAKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 19:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754829AbYBTAKQ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 19:10:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49838 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbYBTAKO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 19:10:14 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BC0802D27;
	Tue, 19 Feb 2008 19:10:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 80DA02D22; Tue, 19 Feb 2008 19:10:06 -0500 (EST)
In-Reply-To: <20080219215441.GA7778@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 19 Feb 2008 16:54:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74481>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 19, 2008 at 01:34:40PM -0800, Junio C Hamano wrote:
>
>> Distinguishing between [rejected] and [stale] would belong in
>> 1.5.5 if it is really needed.  Together with the "git checkout
>> notices forks" enhancement on Daniel's git-checkout rewritten in
>> C, I think it would solve the issue in the "push [rejected]
>> question".
>
> I am still a little uncomfortable with the rejected/stale distinction,
> because the semantics aren't clear.
>
> Let's say we figure out which is which in send-pack. Do we:
>
>   - simply change the "rejected" text to "stale, and leave as-is? I
>     think that is safe, but I also think it isn't a significant
>     improvement for workflows that leave lots of stale branches around
>     (they clutter the push output).
>   - omit stale listings when -v is not given?
>     - this is dangerous with the patch I posted, because "git push; #
>       oops, I forgot I amended; git push -f" will push stale branches
>       that weren't even mentioned in the first case.
>     - instead, should we require some extra magic to force stale
>       branches to be pushed? Forcing such a push is almost never a good
>       idea, whereas forked branches are not too uncommon.
>     - instead, should we disallow "-f" without an explicit refspec (or
>       --all, or --mirror, etc) I can't think of a workflow where you
>       want to force _many_ branches at once, except the special case of
>       mirroring.
>     - we could also combine the two: don't respect -f on stale pushes,
>       but do respect pushing "+stale"
>
> Thoughts?

I think the "push -f is unsafe and forbidden unless you are
using --all, --mirror or being explicit" is extremely sensible,
with or without the "omit [stale] unless -v".  You can even
throw in --matching to the mix.

By the way, I am not opposed to adding --matching to push.  Just
don't make anything but --matching the default, nor introduce
configuration, in the first round.  We might want to do that
later when we have a solid migration path.  I just still do not
think it is necessary to make a backward incompatible changes.

When your workflow is to work against a shared more-or-less
central repository with many branches, I think it is reasonable
to want be able to push out the work in your current branch and
nothing else after you are done with a change you made in your
branch and are convinced that it is in a good enough shape to be
shared with others,

When the --matching behaviour was made the default at the very
beginning, the prevalent git workflow was not about a shared
repository, but to work with a set of _owned_ public
distribution points.  Also the model strongly discouraged the
developer to be unorganized.  You use "matching" push only when
your public branches in your private working area are all good
and ready.  You can still work on private topic branches to
build on top of what are "public" all you want, but until you
are ready, you do not start merging your half-baked ideas you
have on your topic to the "matching" branches.  Because the
repositories you would be pushing into are owned by you, there
is no "staleness" issue with it, as long as you worked that way.
The branches are either ready or unchanged, as long as you are
organized well enough.

But with a central shared repository, even if you are well
organized and your changes to your "matching" branches are
ready, your other branches can now go "stale".  It is a new
problem "sharedness" introduces.

So in that sense, not showing individual [stale] branches by
default would be a sensible solution to that new problem.  The
solution does not break existing users.  We may even want to
squelch down [failed] somewhat, because the users may have WIP
on their matching topics that have diverged but are not ready to
be pushed out.  So perhaps saying "N stale branches and M
diverged branches did not get pushed out" at the end might be a
good idea, even when run without -v option.

HOWEVER.

It is only half a solution.  It still requires you to be well
organized for you to use "matching" semantics.

For example, if you did this:

	$ git checkout -b origin/ticket-99 ticket-99
        $ hack hack half baked hack well that does not work blech
        $ git commit -a -m 'WIP: I give up for now'

        $ git checkout -b origin/ticket-47 ticket-47
        $ hack hack this is easy and I am done
	$ test suite runs well
        $ git commit -a -m 'Fixed ticket#47 issue'

you cannot use "matching" push without pushing out your
half-baked attempt to fix issue #99 when you are done with
issue#47.  Instead you would have done this if you are
organized and really wanted to use "matching":

	$ git checkout -b origin/ticket-99 ticket-99
        $ hack hack half baked hack well that does not work blech
        $ git commit -a -m 'WIP: I give up for now'
	$ git branch -m wip-ticket-99

        $ git checkout -b origin/ticket-47 ticket-47
        $ hack hack this is easy and I am done
	$ test suite runs well
        $ git commit -a -m 'Fixed ticket#47 issue'
        $ some other cleanups, perhaps rebase -i to make it presentable
	$ test suite runs well
        $ git push

But I tend to think it is easier to train your finger to say
"git push origin ticket-47" (or "HEAD").  New user questions
would also become easier and unambiguous to deal with, as
mentioned in another message in that "[rejected]" thread.

By the way, we might want to add

	$ git checkout -B origin/ticket-74

that pretends the user said "-b origin/ticket-74 ticket-74" by
stripping the "remote/$nick" part of the dwimmed starting point
ref to come up with the local refname.
