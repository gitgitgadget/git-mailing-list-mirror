From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git commit --branch
Date: Tue, 30 May 2006 15:52:21 -0700
Message-ID: <7vd5dvyvkq.fsf@assigned-by-dhcp.cox.net>
References: <20060529202851.GE14325@admingilde.org>
	<7vr72b27x9.fsf@assigned-by-dhcp.cox.net>
	<20060530210551.GI14325@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 00:52:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlD4b-0001F3-UU
	for gcvg-git@gmane.org; Wed, 31 May 2006 00:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWE3WwX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 18:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWE3WwX
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 18:52:23 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:8699 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932531AbWE3WwW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 18:52:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060530225222.COPJ18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 30 May 2006 18:52:22 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060530210551.GI14325@admingilde.org> (Martin Waitz's message
	of "Tue, 30 May 2006 23:05:52 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21048>

Martin Waitz <tali@admingilde.org> writes:

>> And your approach is to backport the fix to its original topic
>> and then re-pull the topic onto the test branch.
>
> yes. I was doing this after working on gitweb a bit.
> In order to test gitweb, I need some local adaptations.

Funny you mention this.  I had exactly the same arrangement for
hacking on gitweb.  One "localconf" branch to tell it where the
repositories are, "origin" to track upstream, "master" to use
for deployment, and other topic branches.  I used git-fetch to
keep updating "origin" (not git-pull), grew and rebased topics
based on "origin".  "master" was rebuilt from "origin" by
merging "localconf" and topics.  Some of the stuff I did in my
topics involved changing the way local configuration is done, so
I had an extra topic "newconf" which branched from "localconf"
but merged from the topic branch.

>> What Johannes suggested would
>> equally work fine, and honestly speaking probably is a better
>> discipline.
>
> He suggested to create a new branch (based on current HEAD) for the
> new commit.  Unfortunately that doesn't solve my problem.

When I re-read his suggestion, literally he talks about creating
a new topic, but I assumed he just meant "you could _even_
create a new branch if you wanted to" -- you can switch to
another existing topic branch do with "git checkout", perhaps
with the -m flag.  While I was on the "master" to figure out why
gitweb was not behaving for me, and figured out a mis-
configuration that should be fixed in "newconf" topic, I
switched to that topic and committed the fix there, after
testing the change there.  Then either merging it back to
"master" or rebuilding "master" from scratch based on "origin"
and merging my topics got me a working gitweb back.

>> You carry the fix in your working tree back to its
>> original topic and make a commit, without pulling the topic onto
>> the test branch immediately.  This has two advantages:
>> 
>>  - With your workflow, you will have a merge commit onto the
>>    testing branch immediately when you commit this fix to the
>>    original topic.  But often when I encounter this situation,
>>    after moving to the topic to backport the fix to it, I find
>>    myself reviewing what is in the topic and making other
>>    changes to the topic.
>
> Of course you can do this also while you are still on the test branch.

That is something you cannot.  The merged test branch contains
other unrelated changes.  As you describe, the test branch in
your (and mine) workflow is throw-away in nature, so a proper
fix should go to the relevant topic, and while working on a
single topic, I do not want to see what other topics introduced
to the file -- I may accidentally depend on them, creating
unnecessary interdependencies between topics.

> While looking at code I often see unrelated stuff which can be cleaned
> up.  With something like commit --branch it would be possible to stuff
> these changes to a "trivial" branch without having to change branches
> explicitly.

I often find myself spending too much time fixing what I
committed without thinking and testing -- assuming something is
"trivial" which turns out to be not so -- so I try to stay away
from the idea of having a "trivial" branch.  But if you want to
do things that way, you could trivially do so by having a
wrapper around git commit.  By building something into
git-commit command, you are actively encouraging one workflow,
and commit without testing is one thing I do not particularly
want to encourage people to do.  We have selective commit with
"git commit [-i] <paths>..." which is already bad enough.

>> Johannes's workflow feels more natural
>>    to me from this aspect -- I take the fix I discovered while
>>    on the testing branch to the relevant topic to fix it.  I may
>>    or may not make the commit only with that fix (the first
>>    commit I make after switching the branches from testing to
>>    the topic may contain more than that fix), and after I make
>>    one commit, I may keep working on the topic a bit more before
>>    I decide it is a good time to test the whole thing again (to
>>    pull the topic into testing).  I do not necessarily want that
>>    extra merge immediately in the test branch.
>
> But if your commit to the topic is really different to previous
> commit on the test branch then you may have merge problems later.

I am not sure what you want to say here.  You realize some
breakage, do initial/preliminary fix while on the test branch,
take the change to the relevant topic branch to do the real
fix.  You can merge the result back to the test branch when your
changes on the topic is ready.  I do not see where conflicting
change makes a difference. 
