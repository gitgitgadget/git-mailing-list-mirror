From: Jean-Marc Valin <jean-marc.valin@usherbrooke.ca>
Subject: Error trying to use dcommit
Date: Thu, 07 Jun 2007 16:12:56 +1000
Message-ID: <4667A1E8.7010005@usherbrooke.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 08:37:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwBcW-0004ee-NP
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 08:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbXFGGhJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 02:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbXFGGhJ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 02:37:09 -0400
Received: from panoramix.CeNTIE.NET.au ([202.9.6.85]:60318 "EHLO
	panoramix.centie.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbXFGGhI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 02:37:08 -0400
X-Greylist: delayed 1402 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jun 2007 02:37:07 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by panoramix.centie.net.au (Postfix) with ESMTP id 4FC02CFA15
	for <git@vger.kernel.org>; Thu,  7 Jun 2007 16:12:56 +1000 (EST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49358>

Hi,

I've made some changes to an svn project in git and trying to dcommit, I
get:

% git-svn dcommit
Merge conflict during commit: Your file or directory 'TODO' is probably
out-of-date: The version resource does not correspond to the resource
within the transaction.  Either the requested version resource is out of
date (needs to be updated), or the requested version resource is newer
than the transaction root (restart the commit). at
/usr/local/bin/git-svn line 405

Basically, I did an git-svn init http://svn.xiph.org/trunk/speex and
then modified the TODO file in both svn and git. I did a fetch & rebase
of the git repository, then made another modification in git and tried
to dcommit. Some bits of potentially useful info from an IRC discussion:

<mugwump> git-log shows HEAD~2 as the last SVN commit (ie, includes the
git-svn-id: in the commit message)
<mugwump> the commitid is a9b9f3c
<mugwump> so, I used this to see what git-svn expects the file to be:
<mugwump> git-cat-file blob a9b9f3c:TODO > TODO.gitsvn
<mugwump> svn cat http://svn.xiph.org//trunk/speex/TODO > TODO.svn
<mugwump> however those files are identical
<mugwump> which is good.  but makes the error confusing

The rest of below.

Cheers,

	Jean-Marc


<jmworx> "Merge conflict during commit: Your file or directory 'TODO' is
probably out-of-date: The version resource does not correspond to the
resource within the transaction.  Either the requested version resource
is out of date (needs to be updated), or the requested version resource
is newer than the transaction root (restart the commit). at
/usr/local/bin/git-svn line 405"
<jmworx> I'm getting this trying to do a "git-svn dcommit" and I had
done a "git-svn fetch; git-svn rebase" just before that.
<mugwump> jmworx: perhaps send that to the list...
<jmworx> mugwump: What should I say? Don't even know whether it's a bug
or a feature...
<mugwump> that out of date message shouldn't appear if you've
successfully rebased
<mugwump> you could perhaps diagnose by comparing the contents of the
file that you're checking in and the version in the last svn commit in
your git history
<mugwump> was there a merge involved?  it might be the "choosing the
wrong base" problem
<jmworx> mugwump: basically, I grabbed the content of svn. Then I
modified the file locally (git) and remotely (svn).
<jmworx> Then I did git-svn fetch and git-svn rebase.
<jmworx> The modifications from the svn were merged (did not conflict).
<jmworx> Then I made another modification locally (git) and committed it.
<jmworx> At last, I attempted to dcommit and got this error.
<mugwump> alright, so you're testing this case - you make a change to
the same file someone else does
<mugwump> so, git-svn will expect that file to have the contents in svn
the same as the last svn commit it knows
<jmworx> shouldn't the rebase have fixed that?
<mugwump> yes
<mugwump> so, find the first commit in `git log` that shows a git-svn-id:
<mugwump> get its commitid, then use: git-cat-file blob commitid:PATH |
md5sum
<mugwump> then use svn cat svnurl/trunk/PATH | md5sum
<mugwump> just to see what's going on
<jmworx> what do I substitute PATH for exactly?
<mugwump> TODO I guess
<jmworx> my svn repo is http://svn.xiph.org/ and I checked out only
trunk/speex
<mugwump> can you share the git repo somewhere temporary?  or just the
packfile even
<jmworx> git-cat-file blob commitid:TODO doesn't work
<jmworx> I can upload the git repo if you tell me how (or just a tarball?
<mugwump> well you can just rsync the .git dir to a web server somewhere
<jmworx> http://people.xiph.org/~jm/speex-git.tar.gz
<jmworx> It's only 6 MB
<jmworx> mugwump: Got the tarball?
<mugwump> sorry jmworx was providing internal git support too :)
<mugwump> right, so here's what I did:
<mugwump> git-log shows HEAD~2 as the last SVN commit (ie, includes the
git-svn-id: in the commit message)
<mugwump> the commitid is a9b9f3c
<jmworx> so...
<mugwump> so, I used this to see what git-svn expects the file to be:
<mugwump> git-cat-file blob a9b9f3c:TODO > TODO.gitsvn
<mugwump> svn cat http://svn.xiph.org//trunk/speex/TODO > TODO.svn
<mugwump> however those files are identical
<mugwump> which is good.  but makes the error confusing
<jmworx> So the rebased worked?
<mugwump> looks like it
<mugwump> but I'm not sure why your dcommit isn't working ... but that
debugging info will be useful for eric
<jmworx> where should I post then?
<mugwump> git@vger.kernel.org
<jmworx> mugwump: Just to make sure, you're getting the same error while
doing a dcommit?
<mugwump> well no I get authorization failed :)
<jmworx> Right...
<jmworx> Just to make sure, the command is "git-svn dcommit", right?
<mugwump> sure
