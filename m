From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 14:21:43 -0800
Message-ID: <7vzmlcrqbs.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	<1138446030.9919.112.camel@evo.keithp.com>
	<7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	<20060130185822.GA24487@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0601310926330.7301@g5.osdl.org>
	<1138734110.18852.26.camel@evo.keithp.com>
	<29639.194.237.142.10.1138741008.squirrel@194.237.142.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 23:22:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F43sl-0007x5-4W
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 23:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbWAaWVs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 17:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbWAaWVs
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 17:21:48 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:61949 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751683AbWAaWVr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 17:21:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060131221905.LAVC17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 Jan 2006 17:19:05 -0500
To: "Sam Ravnborg" <sam@ravnborg.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15358>

"Sam Ravnborg" <sam@ravnborg.org> writes:

> But the primary thing is cg-commit
> I give you a list of files modified which can be edited and
> it have saved me a couple of times commiting to much.
> And I get vi fired up so no need to fiddle with command line argumetns.

[this is what I sent in a separate message but I goofed up the
destination headers and the message did not appear on the list,
so I am reprinting.]

I have always felt "git commit paths..." was a mistake; it
encourages partial commits by individual developers.

By "partial commit", I mean a commit that does not exactly match
the state of the working tree when the commit is made.  There
are two kinds of "partial commits".  Good ones and bad ones.

Being able to make partial commits is handy for people whose
primary role is to integrate many changes from trusted
developers rather than testing each and every commit as a whole
(read: Linus and subsystem maintainers).  Integrators' job may
include testing what have been merged as a whole by a compile
and reboot cycle as the final "wrap-up" step, but the most
important role they play is to sanity check the changes from
architectural perspective.

For that workflow to work effectively, however, the changes fed
by individual developers to the integrators have to be clean and
well tested.  A partial commit records something that never
existed in any working tree as a whole, so by definition it is
an untested change.  You would risk "sorry I forgot to commit
the changes to these paths but without them it does not even
compile", and end up wasting integrators' time.

The integrators make commits out of their working trees using
git-merge and git-apply to record changes made by others after
reviewing them.  These commands ignore unconflicting local
changes (but notices conflicting ones to operate correctly), and
allow them to make partial commits.  This is a good thing;
otherwise they would have to reset their own changes in their
working tree, only to do merges and to accept patches.  However,
people playing the integrator role rarely have reason to use
"git commit paths..." while merging from others to make such a
partial commit.  Only after they resolve conflicts by hand,
perhaps.  But that happens far less often than careless
individual developers making partial commits of bad kind using
the same "git commit paths..." command.

This is the reason why I feel "git commit paths..." is a bad
feature.  It helps to make bad partial commits, without having
to do much with making good partial commits.

Many SCMs may have the ability to do "commit paths...", but that
does not change the fact that it encourages carelessness for
individual developers, which is especially bad in a distributed
development workflow like the Linux kernel style [*1*].

But that was not my change ;-).


[Foornote]

*1* It could be argued that being able to do partial commit is a
good thing in other SCM systems where there is no equivalent to
our "index" file.  It is one way for the developer to snapshot
their work-in-progress state where they might later come back to
if the approach they are currently pursuing does not pan out.
But for that, we have index file we can "check into" without
committing.
