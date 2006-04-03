From: Junio C Hamano <junkio@cox.net>
Subject: Re: n-heads and patch dependency chains
Date: Mon, 03 Apr 2006 12:37:11 -0700
Message-ID: <7vsloucuxk.fsf@assigned-by-dhcp.cox.net>
References: <4430D352.4010707@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 21:37:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQUrZ-00046d-Fn
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 21:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWDCThP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 15:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWDCThP
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 15:37:15 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:27032 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S964840AbWDCThN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Apr 2006 15:37:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060403193712.XUWZ6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Apr 2006 15:37:12 -0400
To: Sam Vilain <sam@vilain.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18348>

Sam Vilain <sam@vilain.net> writes:

> I think we can conclude from this:
>
>   - this is not impossible using the current model, and some extra
>     useful information can be seen in the tree that shows more real
>     dependency information and relationships between individual commits
>
>   - doing automatic n-head creation would probably be madness, as
>     far too many useless heads are created (though it is almost
>     guaranteed that supporting 'patch commuting' a la darcs would
>     make this *even worse* as it would mean that you could potentially
>     have even more heads)

I suspect people have hard time grasping _why_ you are jumping
through hoops.  At least I do.  What problem are you trying to
solve?  You perhaps described your mechanism well enough, but it
is not quite clear to me what kind of operations are made easier
with this exercise, against which possible downside of it, if
any, would be judged.

>   - the current tools make this style of development difficult.

Git was born from necessity, and we have been aiming to have
tools to do what are commonly needed.  It is not surprising to
see existing tools do not support modes of operations that are
"unusual" (meaning, things we have not done with git so far).
Also we do not tend to do things only because we can.

Now admittably I am guilty of having done a few things only
because we can.  Octopus is an example.  Making an Octopus only
because you can does not buy you much, other than its coolness
value, and it would make exporting the history to other SCMs
somewhat harder I suspect, and it makes bisecting more
expensive [*1*].

For example, the point jdl raised during the discussion is far
easier to understand.  When working on multiple topics, he often
needs to test them as a whole, so he pulls them into a test
branch (can be a throwaway branch).  When he needs to do fixups,
it is most efficient to do compile/run test while still in the
test branch, but after things test out, in order to keep
logically different things separate, he needs to go back to
relevant topic branches and make a commit.  This is painful --
are there ways to make this easier [*2*]?

Would patch commutation calculus help with his problem?

I suspect patch commutation could be used to solve his problem,
but if it does not, it does not mean what you are trying to do
with hydra is not interesting.  It just means from your
descriptions it is not clear what real problems hydra is trying
to solve, and I misunderstood that it is related to his problem
(just like jdl did, I suspect).

So can you step back a bit and start from describing what
problem you are trying to solve, before describing the
mechanisms you think would help?

One thing I can think of that could potentially come out of your
approach would be an alternative implementation of what StGIT
does.  Inside a local developer repository, being able to
reorder patches and rewrite them flexibly is very useful.

While I agree with Linus's reaction "I want my merges fast", I
am not necessarily so negative about the approach.  For example,
if you use it only as a tool to reorder and clean-up local
development history to a presentable form (IOW, using hydra to
manage your development, but the result exposed to the outside
world is exported from that hydra into a more linear form, that
does not give other people a heart attach when they look at the
ancestry graph in gitk), you would not negatively affect other
people who work with you.


[Footnote]

*1* Do not get me wrong.  Octopus is sometimes the most natural
way to express what happened, but the case it applies to is
quite narrowly defined -- to merge in independent branches that
happened to mature at the same time together.  So the tool
discourages you from making an Octopus that is not trivial,
deliberately.

*2* I see two approaches, the more obvious being "git checkout
-m that-topic".  Just edit (but not update-index) on top of
test, have "checkout -m" adjust your changes to the topic branch
you want to commit to, make a commit there, and then come back
to the test branch, and merge the topic branch again.

Another obvious strategy would be to make commits on top of
"test" and then cherry-pick them back on top of the relevant
topics later.
    
        topicA                  You have three topics
         o---o                  you need to test together...
        /
    ---o---o topicB
        \ 
         o---o
        topicC

 ==>
    
        topicA                  So merge them up and start testing.
         o---o
        /     \      
    ---o---o---T
        \     /
         o---o
        topicB

 ==>
     
        topicA                  But you find problems, and fix them
         o---o                  up as you go along...
        /     \      
    ---o---o---T---1---2
        \     /
         o---o
        topicB

 ==>
    
        topicA                  Later you cherry-pick them into
         o---o---1'             relevant topics.
        /
    ---o---o topicB
        \ 
         o---o---2'
        topicC

 ==>

        topicA                  Next round of test will continue
         o---o---1'             by rebuilding the test branch
        /         \
    ---o---o-------T
        \         /
         o---o---2'
        topicC
