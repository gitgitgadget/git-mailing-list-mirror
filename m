From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: inexplicable failure to merge recursively across cherry-picks
Date: Thu, 11 Oct 2007 15:33:04 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710111455220.20690@woody.linux-foundation.org>
References: <20071010015545.GA17336@lapse.madduck.net>
 <alpine.LFD.0.999.0710091926560.3838@woody.linux-foundation.org>
 <20071010102528.GB20390@lapse.madduck.net>
 <alpine.LFD.0.999.0710100808150.3838@woody.linux-foundation.org>
 <470E9AD5.2090002@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Oct 12 00:33:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig6az-0000th-QB
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 00:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950AbXJKWdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 18:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754177AbXJKWdW
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 18:33:22 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36971 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753034AbXJKWdV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2007 18:33:21 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9BMX5Db019521
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 11 Oct 2007 15:33:06 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9BMX4Av018884;
	Thu, 11 Oct 2007 15:33:05 -0700
In-Reply-To: <470E9AD5.2090002@vilain.net>
X-Spam-Status: No, hits=-2.727 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60648>



On Fri, 12 Oct 2007, Sam Vilain wrote:
> 
> 1. do a --cherry-pick rev-list on just the file being merged and see if
> all the changes on one side disappear, in which case just take the result.
> 
> 2. see if the files were identical at some point, in which case use a
> new merge base for that file based on the changes since that revision.
> 
> I actually thought #2 was already the way recursive worked!

Actually, I think both of these are fundamentally wrong.

The reason is that you talk about "the file".

Anything that is based on per-file heuristics is going to mean that you 
use a history that is not necessarily compatible with the _other_ files in 
the project.

I agree 100% that per-file history information is going to find more 
things to merge automatically. But the point I was trying to make was that 
"automatic merges" aren't always *good*. 

I realize that pretty much every single theoretical merge algorithm out 
there tries to make merges happen automatically as much as possible, but 
they all en dup having strange issues.

For example, take a patch that cherry-picked into mainline from a 
development branch, but that partly depended on some support-feature that 
wasn't in mainline yet. So then there is another patch that removes part 
of that patch from mainline. So mainline is fine.

Now, three months later, the development branch is stable, and is fully 
merged. What happens?

Git will largely get this right. Git will look at the last *global* common 
base, and will just look at the contents, and do a reasonable job. Yes, 
there will probably be conflicts (because both the development branch and 
the mainline ended up touching the same parts of the files thanks to the 
cherry-pick, and yet mainline has some added hacks on top to disable it), 
but on the whole that's exactly what you want!

(Alternatively, maybe the "remove the part that wasn't supported yet" 
ended up meaning that that particular part of the patch was excised 
entirely from mainline, and there was no conflict at all, and git just 
merged the new stuff from the development branch cleanly! So I'm not 
saying that it *has* to conflict, I'm just saying that it might have).

In other words: git always "does the right thing". Assuming both branches 
are stable and working, git does a very reasonable thing. It's obviously 
not always the thing people may *want*, but it's guaranteed to be a 
reasonable and simple guess, and there's no way it's "too clever for its 
own good, and just screwed the pooch entirely".

In contrast, your suggested merge strategy would be HORRIBLY BROKEN!

Why? Because it doesn't look at the *common* history to the project, it 
looks at some per-file state that is totally bogus and has no relevance. 
Think it through: what happens if there were files with the same content 
(because of the cherry-pick), and then the file history for one of the 
branches was later changed to disable something because the support for it 
wasn't in the "whole history"?

Right: the final merge will contain that change! Because there as a time 
where the file was identical (the cherry-pick), so you're taking all the 
later changes to that file (the undo)!

Notice? Totally the wrong thing to do!

So this is a classic case of trying to make "easier" merges, but where the 
whole approach is totally broken! You simply MUST NOT add logic like that. 
It's a lot better to give a conflict, than to try to be "clever", and 
silently do the wrong thing.

Yes, you can be really stupid, and silently do the wrong thing too, but if 
you're stupid, at least the "silent wrong thing" is never really subtle, 
it's pretty much guaranteed to easily explainable. And the good news is 
that you didn't have a complicated and fragile algorithm just to get the 
wrong answer.

(Put another way: if you are always going to have situations where you get 
the wrong answer, you'd better take the simple and stupid algorithm, 
because people are more likely to then be able to _predict_ that wrong 
answer and are thus more ready to handle it!)

So being clever really is the wrong thing to do. And using history that 
isn't global and true history (ie just looking at one file, and deciding 
that matching that one file "means" something) is fundamnetally broken.

In fact, in general, individual pieces of history are totally worthless. 
The fact that some individual change was done in one branch doesn't really 
tell you *anything*. The reason that change was done may be implied by all 
the previous changes, or conversely, later changes may have undone the 
change, so any merge algorithm that starts to look at individual commits 
is likely to be pure and utter crap - exactly because it's starting to 
make decisions based on local information that may not be valid in the big 
picture.

(Where the "big picture" may be either about "space" - other files - or 
about "time" - other commits, that simply mean that the individual changes 
of one commit are meaningless on their own).

Btw, one thing to note is how well the simple and stupid git merge 
strategy works. It turns out that doing things with the "big picture" 
model actually does work really well. People think that they need 
"finegrained history" to make good merges, but I think most people who 
have actually done a fair number of merges with git have noticed that it's 
actually pretty dang painless.

But to be honest, there are cases where git isn't being very helpful. In 
particular, I think there *are* things that git could probably be more 
helpful with, but looking at local history is not one of them, I think.

So here are some suggestions on things I think we could improve on:

 - I think it would be wonderful to have a helper tool for handling 
   conflicts. 

   In particular, while I don't think per-file history is good for 
   resolving conflicts *automatically*, I actually do think that per-file 
   history can be a good way to *manually* resolve conflicts.

   In other words, it you have a conflict, I think it would be wonderful 
   to have some git-gui-like thing that can show the history (with 
   patches) for that file, and basically combine a three-way graphical 
   merge *with* some per-commit information where you can say "choose the 
   thing that that commit did for this conflict".

   So I think git already has tools to help resolve conflicts, and I 
   personally love doing "gitk --merge" or "git log -p --merge" when a 
   conflict does happen, but I think some smart GUI person could do 
   something even much better!

   And notice how I think that it's *really* wrong to use per-file history 
   automatically, but that I think it's not wrong at all to use it when 
   there's a human that says "ok, obviously pick that case". Things that 
   are horrible when they cause subtle and automatic resolves can be very 
   good when they cause subtle resolves that a human looked at!

 - I suspect we have issues with common whitespace changes, where we again 
   could probably help people resolve whitespace changes etc better. 

   Again, I don't think those are necessarily things you want to do 
   automatically, but I know from personal experience that handling things 
   like one side having done a re-indent can be *really* annoying, just 
   because you end up doing tons of mindless stuff when you fix up all the 
   totally idiotic and usually trivial conflicts.

.. and I'm sure there are other things we could do better too, but the 
above two are things that while they haven't happened for me for the 
kernel (probably because we have learnt how to not cause them over the 
years), I've seen them in other places.

And yes, the above two suggestions fall solidly in the "conflicts aren't 
bad per se, but you want to make the tool really help you resolve them!" 
camp. 

			Linus
