From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem with a push
Date: Tue, 12 Jun 2007 10:00:26 -0700
Message-ID: <7vk5u9hzv9.fsf@assigned-by-dhcp.pobox.com>
References: <Pine.LNX.4.64.0706111632050.4406@www.mintpixels.com>
	<alpine.LFD.0.98.0706111556160.14121@woody.linux-foundation.org>
	<200706121007.17044.andyparkins@gmail.com>
	<alpine.LFD.0.98.0706120800430.14121@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	plexq@plexq.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 19:00:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy9jM-0001oJ-6Q
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 19:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366AbXFLRA3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 13:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754917AbXFLRA3
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 13:00:29 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:57840 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366AbXFLRA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 13:00:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070612170028.FVWU6565.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 12 Jun 2007 13:00:28 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Ah0S1X0071kojtg0000000; Tue, 12 Jun 2007 13:00:26 -0400
In-Reply-To: <alpine.LFD.0.98.0706120800430.14121@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 12 Jun 2007 08:07:59 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49973>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> IOW, the notion of "remote" refs really logically implies a mirror image, 
> exactly like you have it set up in your config: what is a local ref in one 
> repository is a remote ref in another. But that's not what the default 
> "git push" semantics are: it just matches refs directly, without that 
> mirroring.
>
> And the _reason_ for it doing that are obviously historical: we didn't use 
> to have the notion of "remotes", so back when I did that, it made sense. 
> It just doesn't make sense any more.

There are two aspects of this issue.  If "matching refs"
semantics makes sense, and if pushing refs/remotes makes sense.

I think the above description risks confusing new people by
sounding as if you are saying no to the former question.

"Pushing to the ref of the same path" makes _PERFECT_ sense even
today for a push into a bare repository used for publishing.

It only is not the right thing to do 50% of the time when you
are pushing into a live repository.

And I everyday use an example of why "matching refs" makes sense
for the other 50% of "push into a live repository" case.  When I
work on git.git, the second-from-final step every day is to push
into a live repository I have at k.org for final build in an
environment different from what I use for development.  I do
"matching refs" push, go there and "git reset --hard" to update
the working tree to build all four branches (there is the issue
that I am too lazy to install receive-pack hook in the live
repository to do that reset --hard to sync the working tree for
me, but that is a separate issue).

So it is not like "matching refs" is always wrong.  It is wrong
in some cases, and is perfectly good in some other cases.

What does not make sense AT ALL is to push what you keep under
refs/remotes/ to outside.  This issue actually has existed from
the very beginning, and we had a specific instruction that said
"remove 'refs/heads/origin' from your published repository
otherwise you will confuse yourself with push".  This was before
separate-remote layout was invented and refs/heads/origin was
the remote tracking branch for the 'master' at the other side.

Back when you did the original "send-pack", there was nothing
outside of refs/{heads,tags}, so historically it made sense to
say "ALL matching", but even then we had to be careful about
'heads/origin'.  Now it does not make sense anymore(I am saying
that not-renaming is OK but sending refs/remotes is Bad, which
is quite different from what you said).

Probably we should not do push anything other than refs/heads/
when we do "matching refs"

I think what we might want to do around this area are:

 - Don't change anything, if the command line says refspec, or
   the remote has push refspec specified.

 - When doing 'matching refs', do it only under refs/heads/.

 - Ship with a receive-pack hook that attempts a 3-way merge
   update when the currently checked out branch is updated.

Additionally we can give an option to "git clone" (or "git
remote add") to arrange the cross-push configuration for
mothership-satellite Andy showed in the clone's .git/config;
but I think that is a separate issue.
