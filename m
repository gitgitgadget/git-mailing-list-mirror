From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH 4/4] Add git-rewrite-commits
Date: Sun, 08 Jul 2007 11:04:22 -0700
Message-ID: <46912726.5080807@midwinter.com>
References: <11839118073186-git-send-email-skimo@liacs.nl> <1183911808787-git-send-email-skimo@liacs.nl> <Pine.LNX.4.64.0707081729040.4248@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: skimo@liacs.nl, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 08 20:04:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7b7P-0003na-AR
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 20:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbXGHSEU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 14:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbXGHSET
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 14:04:19 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:53137
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1752981AbXGHSET (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 14:04:19 -0400
Received: (qmail 10724 invoked from network); 8 Jul 2007 18:04:18 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO pinklady.local) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 8 Jul 2007 18:04:18 -0000
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <Pine.LNX.4.64.0707081729040.4248@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51898>

Johannes Schindelin wrote:
> I am really unhappy that so much is talked about filtering out commits.  
> That is amost certainly not what you want in most cases.  In particular, I 
> suspect that most users would expect the _changes_ filtered out by such a 
> command, which is just not true.
>   

I agree that unless it's named and documented very carefully, users 
might expect this to tweak history such that the commits in question 
never happened (unlike revert, which of course adds a new commit and 
leaves the old ones alone.) The documentation for this command could 
stand to be more explicit about that.

> Further, I do not see much value in making this operation faster.  It is 
> meant to be a one-time operation, for example when you open-source a 
> product and have to cull a lot of history that you must not show for legal 
> reasons.  It is a one-shot operation.
>   

Your recent changes to git-rebase (which, BTW, are great) include a 
feature that's very similar to this: the "squash these commits together 
in my history" feature. That'd be my use case for this, when I want to 
publish my changes to other developers who don't care about all my 
intermediate checkpoints of work in progress, and when the commits I'm 
removing haven't been published anywhere else yet.

With this command, I could do something like:

git rewrite-commits --grep="!@@@checkpoint"
git push

and it would strip out all my intermediate checkpoint commits (assuming 
I've marked them as such in my commit comments, which I always do) 
before pushing to my project's shared repo. Right now that's a much more 
cumbersome, and very manual, operation. Even with the new git-rebase 
changes, I still have to pick out those commits by hand, and it assumes 
that I otherwise want to do a rebase in the first place.

> So there are two things I see here that filter-branch cannot do yet.  The 
> first is to rewrite _all_ branches, which should be easy to do, it only 
> has to be done.
>   

I wonder if it makes sense to go that direction, though, or to make this 
command do the things that filter-branch can do, for the simple reason 
that filter-branch is a shell script and this is already a nice 
non-shell-dependent C program. Obviously you end up in the same place 
either way eventually once filter-branch percolates to the top of the 
"port these scripts to C" list, but it seems odd to me to port features 
from a C program back to a shell script only to have to convert the 
shell script to C later on.

Ironically, this app doesn't really speed up the one thing I find too 
slow in filter-branch: the "remove a file from the tree in all 
revisions" case. To do that you still have to launch a filter app for 
every commit, which is especially bad when the file in question only 
appears in a few revisions deep in the history of a repo.

This command points us in the direction of a "remove/rename this file in 
history" feature that doesn't require forking tens of thousands of child 
processes on a repo with lots of history. For that alone I think it's 
worthwhile, even though it's not there yet; that will never happen with 
a shell script. And yeah, that's not a frequent operation, but it's sure 
nice when even the infrequent operations are lightning fast.

-Steve
