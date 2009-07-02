From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn seems confused about current HEAD
Date: Thu, 2 Jul 2009 00:54:38 -0700
Message-ID: <20090702075438.GA11119@dcvr.yhbt.net>
References: <auto-000019790488@sci.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: tfogal@sci.utah.edu
X-From: git-owner@vger.kernel.org Thu Jul 02 09:56:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMH87-00037f-GB
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 09:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbZGBHyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 03:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbZGBHyi
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 03:54:38 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45128 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622AbZGBHyi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 03:54:38 -0400
Received: from localhost (user-118bg3p.cable.mindspring.com [66.133.192.121])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 046D01F78F;
	Thu,  2 Jul 2009 07:54:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <auto-000019790488@sci.utah.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122627>

tom fogal <tfogal@alumni.unh.edu> wrote:
> I've got a repository that git-svn won't grab the most recent commits
> for:
> 
>   tf@shigeru tuvok ~/sw/bin/git svn find-rev HEAD
>   1164
>   tf@shigeru tuvok ~/sw/bin/git svn fetch
>   tf@shigeru tuvok ~/sw/bin/git --version
>   git version 1.6.3.3
> 
> The repository is actually at revision 1184.  It's browsable online:
> 
>   https://gforge.sci.utah.edu/gf/project/Tuvok/scmsvn/
> 
> and publicly clonable:
> 
>   https://gforge.sci.utah.edu/svn/Tuvok
> 
> Interestingly, 1165 is also a commit which contains a string which
> is not representable in 8bit ASCII in the commit log.  This is very
> likely to be the only such commit in the repository's history.  After
> cloning, setting i18n.commitencoding and i18n.logoutputencoding to
> ISO-8859-1 and then trying another `git svn fetch' does not seem to
> have any effect.

Wow, "svn log" seems to croak on 1165, too.  How did you manage that?  I
guess SVN servers don't check for UTF-8 validity at all in the
commits...

I would get your SVN administrator to propedit the r1165 log entry
so people can see it in the future.  Basically git svn relies
on the library version of "svn log", so if "svn log" fails, then
git svn usually has no chance of getting those revisions.

> Revisions 1166-1169 actually correspond to some commits I did to split
> a particular directory of that repository into another repository, and
> then add an svn:external for it.  I did that via an svn checkout.
> 
> This is actually a `secondary' clone.  In the clone I use to do daily
> work, I have somehow magically convinced my git repository that commits
> 116[56] do not exist.  A contiguous snippet from `git log':
> 
>   commit 351dedb982af09e170b17001340208af46b197b5
>   Author: tfogal <tfogal@c36c8488-0289-0348-9b64-b301f74bd9a7>
>   Date:   Sat Jun 6 20:42:11 2009 +0000
> 
>       Use external `scio' repository.
> 
>       git-svn-id: https://gforge.sci.utah.edu/svn/Tuvok@1167
>   c36c8488-0289-0348-9b64-b301f74bd9a7
> 
>   commit 401493d9175ebdb3c62d6524c701944f208aba94
>   Author: tfogal <tfogal@c36c8488-0289-0348-9b64-b301f74bd9a7>
>   Date:   Fri Jun 5 22:54:48 2009 +0000
> 
>       no newline at EOF issue.
> 
>       git-svn-id: https://gforge.sci.utah.edu/svn/Tuvok@1164
>   c36c8488-0289-0348-9b64-b301f74bd9a7
> 
> I have no idea how I managed to do that, but it seems to have done
> the trick; I haven't noticed any issues with that clone, and I've
> apparently been working with it for a couple weeks now.

I think one of your clones worked for you because 1166 was the latest
revision for you when you ran "git svn fetch", so the next time you ran
"git svn fetch" it would've started exactly at 1166.

> Is there a known workaround for this issue (or, how did I manage to
> `ignore' those commits in my initial repo)?

Here's what I did when the initial clone got stuck at 1164:

# kill the revmap, it caches the max revision to start scanning
# (if you're using using noMetadata you'll need to use dd or a
# a hex editor and delete the last 24 bytes instead.
$ rm .git/svn/git-svn/.rev_map.c36c8488-0289-0348-9b64-b301f74bd9a7

# Instead of attempting to scan starting at 1164, start at 1166 instead
$ git svn fetch -r1166:HEAD

I was stuck on this problem for a while, too... 1165 seems
unrepresentable at the moment because of the log message.

-- 
Eric Wong
