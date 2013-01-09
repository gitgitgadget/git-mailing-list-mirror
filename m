From: Bob Lavey <bob.lavey@hp.com>
Subject: git interaction between push and auto-gc
Date: Wed, 09 Jan 2013 09:56:49 -0600
Message-ID: <kck3vv$mg7$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 17:00:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsy4k-0005lm-Lj
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 17:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122Ab3AIQAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 11:00:00 -0500
Received: from plane.gmane.org ([80.91.229.3]:44192 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932114Ab3AIQAA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 11:00:00 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Tsy4T-0005YG-Sf
	for git@vger.kernel.org; Wed, 09 Jan 2013 17:00:05 +0100
Received: from ip70-178-53-12.ks.ks.cox.net ([70.178.53.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 17:00:05 +0100
Received: from bob.lavey by ip70-178-53-12.ks.ks.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 17:00:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ip70-178-53-12.ks.ks.cox.net
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213065>

Greetings,

We are seeing some unexpected behavior with git that we'd like to better 
understand.  We are running git 1.7.11.1 on the remote repo server 
(CentOS 6.3-x86) and the clients (mostly Windows 7), and we are running 
gitolite 3.04 on the server.

At times, our repos can get many unreachable loose objects, and if we 
don't clean them up, we will see instances where a push to the remote 
repo does not work correctly.  This almost always occurs when we try to 
delete a remote branch with a "git push origin :branch" call, but this 
week we saw two occurrences where a push failed to create a branch (as 
well as about a dozen cases where a push failed to delete the branch). 
This behavior does not occur for every push, however: I'd guess 10% of 
pushes fail.

Here is output from a user's machine:

d:\git\jedi\jedifw>git push origin 
configMgrTestBuilder:refs/23s/iq/qbar/user.name@hp.com/jit20073
Counting objects: 59, done.
Delta compression using up to 16 threads.
Compressing objects: 100% (29/29), done.
Writing objects: 100% (30/30), 129.69 KiB, done.
Total 30 (delta 24), reused 1 (delta 0)
Auto packing the repository for optimum performance.
warning: There are too many unreachable loose objects; run 'git prune' 
to remove them.
To git@git.boi.hp.com:/jedi/jedifw.git


After a couple of hours, that user was concerned that their branch 
hadn't started processing, so they sent an email to support and the 
re-pushed.  Here are the lines from the gitolite log showing both of 
those pushes:

gitolite-2013-01-07.log:2013-01-07.15:57:58     23285   update 
jedi/jedifw     user.name@hp.com    W 
refs/23s/iq/qbar/user.name@hp.com/jit20073 
0000000000000000000000000000000000000000 
2ab0e6626c7a51799179993ea0fdbb829a1ea852

gitolite-2013-01-07.log:2013-01-07.19:57:16     30374   update 
jedi/jedifw     user.name@hp.com    W 
refs/23s/iq/qbar/user.name@hp.com/jit20073 
0000000000000000000000000000000000000000 
2ab0e6626c7a51799179993ea0fdbb829a1ea852


There are no log entries for that branch or that SHA in between those 
two lines.  My understanding is that both of those lines show a new 
branch being created on the remote repo.  I'm not sure what happened to 
the first push, though: I expected that the branch would have been 
created at that time, and subsequent fetches from the remote repo would 
show the branch.  However, fetches from the remote repo did not show the 
branch until after the second push.

We've been running git for about 3 years, and this happened occasionally 
when we first started with git, but we always found it was related to a 
huge number of unreachable loose objects, which triggered an auto-gc on 
the remote repo.  When we performed manual gc --aggressive and prune 
operations on the remote repo, the problem stopped.  It happened this 
week because we'd deleted over 4,000 refs/topics branches on 
Friday/Saturday, which left a huge number of unreachable loose objects. 
  Our cleanup script was only pruning objects older than 2.weeks.ago, 
and when I pruned objects older than 2.days.ago the problem again stopped.

Is this expected behavior for the interaction between pushes and auto-gc 
on the remote repo?

Also, I went through the release notes for the latest versions of git, 
and I found this for 1.7.11.6:

* When "git push" triggered the automatic gc on the receiving end, a
    message from "git prune" that said it was removing cruft leaked to
    the standard output, breaking the communication protocol.

Could that be related to what we're seeing?

Thanks,
Bob Lavey
