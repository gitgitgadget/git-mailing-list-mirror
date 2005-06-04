From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [doc]playing with git, and netdev/libata-dev trees
Date: Sat, 04 Jun 2005 06:26:09 -0400
Message-ID: <42A181C1.3010902@pobox.com>
References: <42955DF7.4000805@pobox.com> <21d7e99705060401405cfd5a11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020508080102060905080009"
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jun 04 12:24:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeVoO-00078b-GV
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 12:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVFDK0a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 06:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVFDK0a
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 06:26:30 -0400
Received: from mail.dvmed.net ([216.237.124.58]:3010 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261212AbVFDK0P (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 06:26:15 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DeVr2-0002NR-MN; Sat, 04 Jun 2005 10:26:14 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Dave Airlie <airlied@gmail.com>
In-Reply-To: <21d7e99705060401405cfd5a11@mail.gmail.com>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------020508080102060905080009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Dave Airlie wrote:
>>When I merge a patch for drivers/net/forcedeth.c, I merge it into a
>>brand new 'forcedeth' repository, a peer to the 40+ other such
>>repository.  Under BitKeeper, I made these repositories available merged
>>together into one big "netdev-2.6" repository because it was too time
>>consuming to make the individual 50+ trees publicly available.  With
>>git, developers have direct access to the individual trees.
>>
>>I thought I would write up a quick guide describing how to mess around
>>with the netdev and libata-dev trees, and with git in general.
>>
> 
> 
> Thanks for this, I'm starting to get up to speed on git now...
> 
> Two questions,
> 
> 1. when you want to publish your tree what do you do? just rsync it
> onto kernel.org?

Basically.  I copy the attached script into each repo, customize the 
script for the upload destination.

When I publish the tree, I just cd to the toplevel dir on my local 
workstation, and run "./push"


> 2. When you are taking things from your queue for Linus do you create
> another tree and merge your branches into it or what?

Not quite sure what you're asking, but I'll attempt to answer anyway :)

When I prepare a submission for Linus, I will pull several branches into 
a single 'for-linus' conglomeration branch.  I do this with the 
following incantation, for each branch I am pushing upstream:

git-resolve-script $(cat .git/HEAD) $(cat .git/refs/heads/$branch) \
	`pwd` $branch

(Note that I modified my git-resolve-script to take an additional $4 
argument, which causes the string " branch $4" to be added to the merge 
cset's commit msg)

After I take care of all the merge conflicts[1] from the 
git-resolve-script run, I give the big pile of mush a final build and 
test, and then run "./push".

For the "please pull" email, I use diffstat, git-diff-tree, 
git-changes-script and the newly written git-shortlog.

	Jeff



[1] I'm still scared of conflicts in the merge process.  Simple and 
automatic merging works just fine, like it did under BitKeeper.  But if 
there are conflicts that cause git-pull-script/git-resolve-script to 
bail, then I bail as well:  I export a patch, run patch(1), and then 
handle the merge the Old Fashioned Way(tm) by looking at .rej files.

I really wish somebody would write a merge helper for git that places 
the conflicts side-by-side in the code [in the working dir].  BitKeeper 
and CVS both presented conflicts to you in this manner.

The "I resolved this conflict, now let's continue where we left off" 
process is still quite raw in git.  I suppose this is something that is 
left for others to script, above the plumbing, but hey...


--------------020508080102060905080009
Content-Type: text/plain;
 name="push"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="push"

#!/bin/sh

rsync -e ssh --verbose --delete --stats --progress -az .git/ master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git

--------------020508080102060905080009--
