From: Andreas Ericsson <ae@op5.se>
Subject: Re: Why can't git-rebase back up?
Date: Fri, 17 Feb 2006 15:36:59 +0100
Message-ID: <43F5DF8B.6050307@op5.se>
References: <20060217135938.7412.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 15:37:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FA6jQ-0003T8-PI
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 15:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWBQOhH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 09:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWBQOhH
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 09:37:07 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:17577 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751451AbWBQOhF
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 09:37:05 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 636056BD06; Fri, 17 Feb 2006 15:37:04 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: linux@horizon.com
In-Reply-To: <20060217135938.7412.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16351>

linux@horizon.com wrote:
> Newbie question...  In what I assume is a usual technique, I maintain a
> "build" branch off of the linux-2.6 history which is what I check out
> to build a kernel.  I usually keep it at an official tagged releas,
> such as v2.6.16-rc2.
> 
> [[ This is because core git won't allow the checked-out HEAD to point
> to anything but a branch,


Yes it will. That's how "git reset" works (i.e. pointing HEAD to some 
random object). Think of branches and tags as short and humanly 
understandable names for certain points in the history. You can visit 
any point in history without having a special short name for it.

> and checking out something without having
> HEAD point to it is fragile and delicate.  Cogito lets you do this with
> cg-seek. ]]
> 

It's more than delicate. It's impossible (even for Cogito). You can take 
snapshots of how the tree looked at a certain state and export that 
using git-tar-tree if you wish, but other than that it's impossible to 
visit a certain point in history without pointing HEAD to it (that's how 
visiting that point is done, actually).

> Now, if I want to migrate to a newer base version, I can always use
> git-reset --hard v2.6.16-rc3, but that's a bit dangerous.
> Preferable is to use git-rebase v2.6.16-rc3, which will preserve
> any local edits.
> 
> (I could also do it as a merge, but that seems like unnecessary history
> clutter.  It's not like local edits are common, anyway.)
> 
> But suppose discover a nasty bug in -rc3 and want to move my build branch
> back to -rc2.  "git-rebase v2.6.16-rc2" does nothing.  After a bit
> of thought, I realize why, but sometime I do want to back up.
> 

I'd suggest doing something like this when changing base version (of any 
project, really). Let's say you start, for the first time, with 
v2.6.16-rc2. The workflow would look something like this:

$ git checkout -b mod-2.6.16-rc2 v2.6.16-rc2; # create a branch at the 
desired point in history
$ apply your changes

2.6.16-rc3 is out, and you want to use that instead.
$ git checkout -b mod-2.6.16-rc3 v2.6.16-rc3; # new branch for new trial
$ git rebase mod-2.6.16-rc2; # apply patches you've already made

Now a couple of different things can happen:
1. The rebase works fine. Oh, joy of joy!
2. The rebase doesn't work, but a merge does:
$ git pull . mod-2.6.16-rc2
3. Neither merge or rebase works, but you can manually apply your 
patches, drop the offending ones or resolve the conflicts.
4. There's a bug so you want to regress. Just do:
$ git checkout mod-2.6.16-rc2

In this scenario, only option 3 means trouble and that's inevitable no 
matter how you work since your patches no longer apply.


> What's the best way to do that?  Should git-rebase take an optional
> third argument which is the branch head we are moving away from?
> E.g. what I want to do would be
> 
> 	git-rebase v2.6.16-rc2 build v2.6.16-rc3
> 
> Or is there some other tool already suited to the job?
> 
> (Yes, I'm aware the operations cannot be exact inverses, because if
> I applied a local patch that was also included in -rc3, git-rebase
> will delete the redundant copy from the build branch, and the backing
> up will have no way to know to put it back.  If I wanted to do that,
> I would use a merge.)
> 

If you merge a branch based on top of a later head you'd end up with the 
same commits in your history anyways, since it would have to merge all 
commits up to the merge-base. In essence, you'd do a complicated 
fast-forward, but with reverse history to what I think you think (i.e. 
you'd be pulling 2.6.16-rc3 in on top of your patches).

One way to accomplish this would be to do:
$ git checkout mod-2.6.16-rc3; # get to that point, one way or another
$ git format-patch -k --stdout v2.6.16-rc3 > 2.6.16-rc3.patches.mbox
$ git reset --hard v2.6.16-rc2; # get to that point, one way or another
$ git am -k 2.6.16-rc3.patches.mbox

However, branches and tags are cheap to create, efficient to use, easy 
to remove once you're done with them. They make life easier. Use them. 
You'll be glad you did.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
