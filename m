From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Real-life kernel debugging scenario
Date: Mon, 7 Nov 2005 17:31:34 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511071721200.3247@g5.osdl.org>
References: <dkosr7$f4s$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 02:32:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZIKt-000510-6B
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 02:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbVKHBbi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 20:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbVKHBbi
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 20:31:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21224 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965023AbVKHBbh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 20:31:37 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA81VZnO003563
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 7 Nov 2005 17:31:35 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA81VYw8010515;
	Mon, 7 Nov 2005 17:31:35 -0800
To: walt <wa1ter@myrealbox.com>
In-Reply-To: <dkosr7$f4s$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11301>



On Mon, 7 Nov 2005, walt wrote:
> 
> Okay.  On rare occasions I get a kernel panic on reboot.  So...
> I know that something Linus committed in the last 24 hours is
> responsible for the problem.
> 
> The last two times this happened I was able to guess which
> commit caused the problem and I emailed the developer off-
> list and got the problem fixed very quickly. (This is why
> I love open-source software!)
> 
> My worry:  what happens when I'm not smart enough to guess
> which developer to email?  My first instinct is to back out
> the most recent commits one-by-one until the bug goes away.

No. This is what "git bisect" is there for.

It works wonderfully well. To the point where I don't even try to be smart 
about things: I've had two cases in the last month of merges that caused 
problems for me, and instead of even trying to guess which patch it was, I 
just bisected it.

> First:  is this an optimal tactic?
> 
> Second:  how to back out individual commits using git or
> cogito?  I suppose this is already spelled out in the docs,
> but I invite everyone to point me to the relevant places
> in the docs that have escaped my attention so far.

First, try "git bisect". It doesn't depend on backing out individual 
commits, instead it starts a special "bisect" branch, and (as the name 
implies) does a binary search within that branch to figure out what is 
wrong.

The way to use "git bisect" couldn't be easier.

Figure out what the oldest bad state you know about is (that's usually the 
head of "master", since that's what you just tried to boot and failed at). 
Also, figure out the most recent known-good commit (usually the _previous_ 
kernel you ran: and if you've only done a single "pull" in between, it 
will be ORIG_HEAD).

Then do

	git bisect start
	git bisect bad master		<- mark "master" as the bad state
	git bisect good ORIG_HEAD	<- mark ORIG_HEAD as good (or
					   whatever other known-good 
					   thing you booted laste)

and at this point "git bisect" will churn for a while, and tell you what 
the mid-point between those two commits are, and check that state out as 
the head of the bew "bisect" branch.

Compile and reboot.

If it's good, just do

	git bisect good		<- mark current head as good

otherwise, reboot into a good kernel instead, and do (surprise surprise, 
git really is very intuitive):

	git bisect bad		<- mark current head as bad

and whatever you do, git will select a new half-way point. Do this for a 
while, until git tells you exactly which commit was the first bad commit. 
That's your culprit.

It really works wonderfully well, except for the case where there was 
_another_ commit that broke something in between, like introduced some 
stupid compile error. In that case you should not mark that commit good or 
bad: you should try to find another commit close-by, and do a "git reset 
--hard <newcommit>" to try out _that_ commit instead, and then test that 
instead (and mark it good or bad).

You can do "git bisect visualize" while you do all this to see what's 
going on by starting up gitk on the bisection range.

Finally, once you've figured out exactly which commit was bad, you can 
then go back to the master branch, and try reverting just that commit:

	git checkout master
	git revert <bad-commit-id>

to verify that the top-of-kernel works with that single commit reverted.

		Linus
