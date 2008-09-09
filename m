From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Tue, 9 Sep 2008 21:43:54 +0200
Message-ID: <20080909194354.GA13634@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 21:45:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd995-0007zw-BU
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 21:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471AbYIITn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 15:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752873AbYIITn4
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 15:43:56 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:54056 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbYIITnz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 15:43:55 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id B53215465; Tue,  9 Sep 2008 21:43:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m3zlmhnx1z.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95419>

Jakub Narebski wrote:
>"Stephen R. van den Berg" <srb@cuci.nl> writes:
>> The definition of the origin field reads as follows:

>> - There can be an arbitrary number of origin fields per commit.
>>   Typically there is going to be at most one origin field per commit.

>I understand that multiple origin fields occur if you do a squash
>merge, or if you cherry-pick multiple commits into single commit.
>For example:
> $ git cherry-pick -n <a1>
> $ git cherry-pick    <a2>
> $ git commit --amend        #; to correct commit message

Correct.

>I'm not sure if you plan to automatically add 'origin' field for
>rebase, and for interactive rebase...

That is not part of the plan so far.
Can you explain what you would be expecting in the best case?

>> - At the time of creation, the origin field contains a hash B which refers
>>   to a reachable commit pair (B, B~1).  If B has multiple parents and the pair
>>   being referred to needs to be e.g. (B, B~2), then the hash is followed by
>>   a space and followed by an integer (base10, two in this case),
>>   which designates the proper parentnr of B (see: mainline in git
>>   cherry-pick/revert).

>I think you wanted to use "(B, B^2)", which mean B and second parent
>of B.  B~2 means grandparent of B in the straight line:

Correct, sorry about the confusion, I meant B^2 instead of B~2.

>Besides I very much prefer using 'origin <sha1> <sha2>' (as proposed
>in the neighbouring subthread), which would mean together with
>'parent <parent>' (assuming that there are no other parents; if they
>are it gets even more complicated), that the following is true

>  <current> ~= <parent> + (<sha2> - <sha1>),

>where '<rev1> ~= <rev2>' means that <rev1> is based on <rev2> (perhaps
>with some fixups, corrections or the like).  Perhaps 'origin' should
>be then called 'changeset'.

The simplicity sounds inviting.  I'd like to hear from others who have
more experience (than I have) with the git vs. changeset paradigms about
this.  This allows a bit more flexibility in specifying the origin, the
question is if it's needed.

>It would also be easier on implementation to check if
>'origin'/'changeset' weak links are not broken, and to get to know
>which commits are to be protected against pruning than your proposal
>of
>  origin <"cousin" id> [<mainline = parent number>]
>where <mainline> can be omitted if it is 1 (the default).

On the contrary, my current proposal only needs to verify the validity
of a single commit, changing it like this will require the system to
verify the validity of two commits.  Given the rareness of the origin
links this will hardly present a problem, but it *does* increase
the overhead in checking a bit.

>This can also lead to replacing
>  origin <b> <a>
>  origin <c> <b>
>by
>  origin <c> <a>
>for squash merge, or squash in rebase interactive.

Ok, *that* is not possible with the original proposal.  This might just
be the reason why we'd like to go with the dual-hash link.

>> - git cherry-pick/revert allow for the creation of origin links only if
>>   the object they are referring to is presently reachable.

>Errr... shouldn't objects referenced by 'origin' links be reachable in
>order for "cherry-pick" or "revert" to succeed?

True.  But sometimes it's necessary to emphasize the obvious; call it a
preemptive strike against possible objections to the proposal.

>On the other hand this leads to the following question: what happens
>if you cherry-pick or revert a commit which has its own 'origin'
>links?

Nothing special.  cherry-pick/revert behave as if the existing origin links
were not present in the first place.

>> - git rev-list --topo-order will take origin links into account to
>>   ensure proper ordering.

>What do you mean by that?

The order in which commits are listed is defined by the fact that
descendent commits are shown before any of their parents.  The presence
of an origin link will make sure that the current commit will always
appear *before* the origin-commit it is referring to (if the
origin-commit is in the displayed set, that is).

>> - git log would show something like:

>>   commit bbb896d8e10f736bfda8f587c0009c358c9a8599
>>   Origin: d2b9dff..53d1589
>>   Origin: a1184d8..e596cdd
>>   Author: Junio C Hamano <gitster@pobox.com>
>>   Date:   Sat Aug 30 14:35:15 2008 -0700

>>   Note that for easy viewing: git diff d2b9dff..53d1589
>>   will show the exact diff the origin link is referring to.

>> - git log --graph will show a dotted line of somesort just like gitk.

>That is I guess the whole and main reason for 'origin' links to exist,
>as having this information in free-form part, i.e. in the commit
>message might lead to problems (with parsing and extracting, and
>finding spurious links).

Quite.  Also, having them in a well-defined place will allow for easy
fixups in case of rebase/filter-branch.

>> - git blame will follow and use the origin link if the object exists.

>Hmmmm... I'm not sure about that.

Care to explain your doubts?
The reason I want this behaviour, is because it's all about tracking
content, and that part of the content happens to come from somewhere
else, and therefore blame should look there to "dig deeper" into it.

>> - git merge disregards the whole origin field entirely, just like all
>>   the rest of git-core.

>Unless of course one uses more complex merge strategy, which doesn't
>take into account only endpoints (branches to be merged and merge
>bases), but is also affected in some by history...

Quite, but that is not a part of the definition of the origin field.
I can only try and make sure that we have a well-defined, well-behaved
mechanism in core git.  If someone wants to get creative with the
information presented, by all means, be my guest.

>> Anything I missed?

>How would git-rebase make use of 'origin' links.

As far as I can imagine, git rebase should alter the origin links during
rebase if they point to a commit within the strain being rebased.
Are there any other desirable use cases (for rebase)?
-- 
Sincerely,
           Stephen R. van den Berg.

"Be spontaneous!"
