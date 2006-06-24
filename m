From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: A series file for git?
Date: Sat, 24 Jun 2006 11:54:02 -0600
Message-ID: <m1r71exww5.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org>
	<7virno79a7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605291739430.5623@g5.osdl.org>
	<7vmzd05i25.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605292112530.5623@g5.osdl.org>
	<7vpshtyffk.fsf@assigned-by-dhcp.cox.net>
	<m1odwkyuf5.fsf_-_@ebiederm.dsl.xmission.com>
	<7vac83ylk6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 24 19:54:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuCL9-0004xU-7e
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 19:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWFXRya (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 13:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWFXRya
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 13:54:30 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35042 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750938AbWFXRy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 13:54:29 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Debian-1) with ESMTP id k5OHs5Wh008507;
	Sat, 24 Jun 2006 11:54:05 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Submit) id k5OHs2kw008506;
	Sat, 24 Jun 2006 11:54:02 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vac83ylk6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 24 Jun 2006 02:01:13 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22534>

Junio C Hamano <junkio@cox.net> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> I was using:
>> 	git-rev-list $revargs | tac > list
>> 	for sha1 in $(cat list); do git-cherry-pick -r $sha1 ; done
>>...
>> - Keeping patches in git and just remembering their sha1 is nice
>>   but it has the downside that it can be really easy to loose
>>   the sha1, and thus the patch.  So some sort of history mechanism
>>   so you can get back to where you were would be nice.
>
> Actually, the $revargs above is composed of your branch names
> (e.g. "^master this-topic that-topic"), so as long as you do not
> lose these branches they are protected.

Right but typically I have something that looks like.
"git-rev-list --pretty=oneline 2.6.17-rc6-mm2..HEAD | tac > list"
and HEAD changes.

I could be careful and before I do each operation save a branch
name.

>> - This is a similar technique to topic branches.  However in some
>>   of the more interesting cases a topic branch can't be used because
>>   you have a whole series of little changes, that allow depend on
>>   each other.  So topic branches need not apply.
>
> Sorry I fail to see why.  A series of little changes that depend
> on each other would be a string of pearls on a topic branch in
> the simplest case, or a handful of topic branches that
> occasionally merge with each other if you want to get fancier.
> Cherry-picking from a DAG of the latter kind with your rev-list
> piped to tac is no different than cherry-picking from a simple
> straight line of the former kind, isn't it?

It is exactly a string of perls on a topic branch.  My point
is that when things are sufficiently interrelated that you
can't use more than one topic branch. 

With topic branches when you find a small fix to an existing
perl you just commit it to that branch, and it works
because each branch really is composed of a single pearl.
(At least that is my intuition).  

When you have multiple highly interrelated pearls and you
are testing you can easily put the fix for a pearl at
the end of the branch.  But before you push your changes
upstream that fix needs to be merged with the original
pearl that it fixes.  Which is fundamentally a history
editing kind of action.

>> - One of the places where we currently uses series files
>>   (patch-scripts && quilt), and heavy cherry picking is for patch
>>   aging.  That is letting patches sit in a testing branch for 
>>   a while so people have a chance to test and look at them.
>
> I agree that patch aging and updating does not mesh well with
> how git inherently works, as git regards commits immutable
> objects.  Even then, I use my "pu" branch (and topics that
> hasn't merged to "next" but in "pu") pretty much as patch aging
> area and I regularly do "git commit --amend" to update them.
> This however is cumbersome with core git tools alone, and I
> suspect is better done with StGIT.

I have a similar suspicion.  I am glad we pretty much see
the same problem.

>> If we create a meta data branch with just the series file
>> we can remove the risk of loosing things, as we always
>> have a path back to the old history if we want it.
>
> I am not sure about that.  What does the series file contain,
> and what other things the meta data branch contain?  If you are
> listing commit SHA1 in the series file, you _do_ have the risk
> of losing things -- git-fsck-objects needs to look at such blob
> object and consider that as the root of reachability chain; to
> me that seems too specialized hack.

When described that way I agree.   The best I can imagine
is to list those commits as ancestors of the current commit.
Hmm.  Or possibly I could collect up tag objects and work
with them.  In any case representing this in a non-hackish
way is my goal.

> I have a feeling that I really should study how well StGIT does
> things before talking about this further.  It may suit your
> needs perfectly.  What do you feel is lacking in StGIT that you
> need?

What I want and what I see lacking in the git and StGit is
the ability to record the history of editing the history
of a branch. 

A mundane example.  It would be nice if I rebased a branch if
I could record in some fashion what that branch was before
I rebased it.

So I am trying to figure out how to construct a meta branch
that records that kind of information about a branch.

Intuitively this feels like the history of a series file
to me.  Did I add commits?  Did I remove commits?  Did
I reorder commits?  Did I merge commits?

Andrew in his patch-scripts documentation recommends using
CVS to record this information (The documentation predates
git).  I think this is something that got lost with quilt when Andrews
patch-scripts were cleaned up and made more general.

I need to look some more but I don't think recording the history
of editing a branch is problem that has been solved in any of
the git flavors.

I will certainly look at StGit more and at the core git data
structures some more and see if I can come up with a creative
way of representing the history of branch edit operations
that will not break existing tools.

Eric
