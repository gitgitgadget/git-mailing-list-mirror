From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Fetching from peer's public repo
Date: Fri, 02 Feb 2007 11:25:58 +0100
Organization: At home
Message-ID: <epv3h5$4f7$1@sea.gmane.org>
References: <17858.1586.41833.597819@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 02 11:24:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCvbF-0005HU-Dy
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 11:24:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbXBBKYy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 05:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933316AbXBBKYy
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 05:24:54 -0500
Received: from main.gmane.org ([80.91.229.2]:36190 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932666AbXBBKYx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 05:24:53 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCvb6-0006UH-FH
	for git@vger.kernel.org; Fri, 02 Feb 2007 11:24:48 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 11:24:48 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 11:24:48 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38486>

Bill Lear wrote:

> My fetch from a peer's public repo seems to be failing:
> 
> % git --bare fetch git://source/public/project topic:topic
> remote: Generating pack...
> remote: Done counting 48 objects.
> remote: Result has 34 objects.
> remote: Deltifying 34 objects.
> remote:  100% (34/34) done
> remote: Total 34, written 34 (delta 22), reused 24 (delta 12)
> Unpacking 34 objects
>  100% (34/34) done
> * refs/heads/topic: not updating to non-fast forward branch 'topic' of git://source/public/project
>   old...new: 1c332f5...f3b18ff
> 
> I assume that is because his public repo does not contain changes I
> have pushed into my public repo.  So, I asked him to pull from
> my public repo into his.  He did, and said that git blathered that
> there were 12 changed files, etc.

First, git did good and protected you from losing your changes which
were in "your public repo" but not in "his public repo" (well, not exacly
lose, as you can very easy revert fetch thanks to ORIG_HEAD and reflog
if you have it enabled).

Second, if you know what you are doing, for example if you know that
topic branch was rebased (has it's history changed), so you know that
non-fast forward case is not an error, you can use euther "+topic:topic"
refspec, or use --force option to git-fetch.

Third, you do not pull into bare repo: you fetch into bare repository.
But, fourth, it looks like he has some changes and you have some changes;
unless you want to have those changes in separate branches, you have to
merge your and his changes; or he has to merge your and his changes
(but in working repo, i.e. with working directory, not a bare one, as
merge might result in conflicts) using git-pull.

Fifth, this situation is what tracking branches are for: you fetch
his from his working branch changes into tracking branch and merge
into your working branch when you want; he fetches your changes
from your working branch into tracking branch and merge your changes
into his working branch when he wants.

[...]
> Also, what is the difference between:
> 
> % git log 1c332f5..f3b18ff
> 
> and
> 
> % git log 1c332f5...f3b18ff
> 
> with the latter having three dots instead of two?  It seems to show
> much more output, but I don't know what the intent is.

"git log 1c332f5..f3b18ff" is equivalent to "git log f3b18ff --not 1c332f5"
which means whowing all changes reachable from f3b18ff but which are not
reachable from 1c332f5, which result in all changes from 1c332f5 (non
inclusive) to f3b18ff (inclusive).

"git log 1c332f5...f3b18ff" is equivalent to
  git log 1c332f5 f3b18ff --not $(git merge-base --all 1c332f5 f3b18ff)
which result in all changes which are either in 1c332f5 xor in f3b18ff,
but not in both.

git 1.5.0 would have --left-right option to mark which side (1c332f5 or
f3b18ff) revisions in 1c332f5...f3b18ff belong to.


P.S. RTFM.

git-log(1):
       The command takes options applicable to the git-rev-list(1) command to con-
       trol what is shown and how

git-rev-list(1):
       Another  special  notation  is  "<commit1>...<commit2>" which is useful for
       merges. The resulting set of commits is the  symmetric  difference  between
       the two operands. The following two commands are equivalent:

               $ git-rev-list A B --not $(git-merge-base --all A B)
               $ git-rev-list A...B
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
