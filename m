From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Fast forward strategies only, common, fork and path
Date: Tue, 05 Feb 2008 01:40:49 -0800
Message-ID: <7v7ihjd9lq.fsf@gitster.siamese.dyndns.org>
References: <402c10cd0802031654r3e0275a8s1d2163af9525e7d2@mail.gmail.com>
	<402c10cd0802032251y626f373eke66c35b200ccf5b1@mail.gmail.com>
	<7vwsplkwuq.fsf@gitster.siamese.dyndns.org>
	<402c10cd0802040006yb654688l8dfc7140c507bc26@mail.gmail.com>
	<7v8x21ku6b.fsf@gitster.siamese.dyndns.org>
	<402c10cd0802042332i4e49cdaxf1fa1a7fc09c15b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 10:41:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMKIz-0000M9-BH
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 10:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbYBEJk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 04:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752657AbYBEJk5
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 04:40:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49757 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbYBEJk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 04:40:56 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BB79545A8;
	Tue,  5 Feb 2008 04:40:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B54245A5;
	Tue,  5 Feb 2008 04:40:51 -0500 (EST)
In-Reply-To: <402c10cd0802042332i4e49cdaxf1fa1a7fc09c15b9@mail.gmail.com>
	(Sverre Hvammen Johansen's message of "Mon, 4 Feb 2008 23:32:45
	-0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72637>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

> On Feb 4, 2008 12:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> The documentation updates talked about what the options do, but
>> it was unclear why they could be useful in what situations and
>> workflows.  At least it was not apparent to me on my cursory
>> read.
>
> Common, fork, and path only make sense where there are at least three
> repositories or two plus an observer involved.
>
> Lets explain the observer cases.

This is a good material.  The information here should reach the
end users who will be exposed to these new features in the
documentation patch before the final submission.

> The observer is interested in changes that X, Y and Z agree upon.  He
> can merge as follows:
>
>   git merge --ff=common X Y Z

Just to avoid confusion by making sure I understand.  Earlier
you said two plus an observer above but the example is about one
observer and three other repositories, and the "merge" operation
happens inside the observer's one.

This reminds me of an ancient message I sent to darcs list,
before or soon after I took git.git over, with a topic (iirc)
"mutually supervised developer workflow".  Each developer may
make excellent and crap changes, but they communicate with each
other.  The "consensus" can be made by picking the changes that
appear in all repositories (or majority of repositories).

That is unfortunately hard to arrange in git workflow if you do
not use topic branches and/or if you rebase often (but would be
more natural match to darcs's world view).  Even if you have a
set of changes in the same spirit (i.e. "the same patch text"),
the committer and the author information would make the actual
commit objects different, so you would need to identify
different commits that introduce the same change for this to be
really useful.

And it may not work well in practice, even if we somehow solved
that "changes in the same spirit are often made into different
commits" issue.  If the place they agree last is a dud, and some
have fix-ups that others lack, the observer will end up getting
that common dud commit.

> The observer is interested in changes up to the point where someone is
> known to disagree.  He can merge as follows:
>
>   git merge --ff=fork X Y Z

If --ff=common fast-forwards to the commit all of X, Y, and Z
have in common, that means commits on X, Y or Z that are beyond
that point are the ones these three do not agree with.  How's
that different from --ff=fork?

>  The observer is interested in any give path up to one of the true
> parents.  He can merge as follows:
>
>   git merge --ff=path X Y Z
>
> This will give priority to X then Y.

"Any given path up to one of the true parents?"  Path from
where?  How is "true parent" (as opposed to untrue ones?)
defined?

> This + only are all the interesting cases for fast forward.  Some work
> flows between more than two repositories in the general case would
> require additional features for rebase:  Rebase on any patch, the fork
> point, or common ancestor of the remote branches.  This is something I
> would like to discuss at some later time.
>
>> > --ff=never will turn this off together with fast forward.  Maybe we
>> > should have --ff=traditional that is the old behavior.
>>
>> Sure, and I mildly suspect that it should be the default.
>
> I would argue that it should not be the default, simply because we
> already use the real parents when only two branches are involved, This
> is most convenient for most users.

Sorry, I referred --ff=traditional by "it".  Are we talking
about the same thing?
