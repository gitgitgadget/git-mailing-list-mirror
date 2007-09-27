From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and branches
Date: Thu, 27 Sep 2007 00:24:04 -0700
Message-ID: <20070927072404.GB1782@hand.yhbt.net>
References: <20070927021252.GA23777@dervierte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 09:24:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IanjM-0003q2-BG
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 09:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927AbXI0HYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 03:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752780AbXI0HYG
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 03:24:06 -0400
Received: from hand.yhbt.net ([66.150.188.102]:59279 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753927AbXI0HYF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 03:24:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 0D1907DC093;
	Thu, 27 Sep 2007 00:24:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070927021252.GA23777@dervierte>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59273>

Steven Walter <stevenrwalter@gmail.com> wrote:
> I'm using git-svn to track a rather large subversion repository with a
> non-standard layout.  In the past, I've only cared about trunk, but now
> I need to occasionally use branches, too.  By adding a second git-svn
> remote with the branch URL, I can fetch the branch, and git-svn is even
> intelligent enough to notice that the branch was copied off of trunk.
> 
> However, git-svn also does a complete checkout for the first revision of
> the branch.  By this, I mean it goes through shows "A    file" for every
> file in the repository.  This takes quite a while, and seems rather
> unnecessary given that git-svn already noticed that the branch shares a
> history with trunk, which is already fetched.
> 
> Knowing just enough of what git-svn is doing to be dangerous, I whipped
> up a short little patch.  This patch seems to work for the common case,
> and avoids fetching every file from subversion.  It does break
> sometimes, however, and I don't understand why.
> 
> Maybe someone with a better grasps of the code can see what I did wrong,
> or suggest a better means to my end?

I believe your case handles where a branch is created directly from a
trunk copy with no file modifications in the branch, but not when a
branch is created and files are modified in the trunk (or branch) within
the same revision.  Is this what's happening?

Additionally, I think this breaks when an entire trunk or branch is
moved around because the original directory has moved or gone away:

  /trunk => /project-a/trunk

Anyways, as Sam said, newer SVN (1.4.4+) has a working do_switch()
function and that code path will never be hit at all.

> diff --git a/git-svn.perl b/git-svn.perl
> index 484b057..1bc92b6 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1848,9 +1848,10 @@ sub find_parent_branch {
>                                               $self->full_url, $ed)
>                           or die "SVN connection failed somewhere...\n";
>                 } else {
> +                       $self->assert_index_clean($parent);
>                         print STDERR "Following parent with do_update\n";
>                         $ed = SVN::Git::Fetcher->new($self);
> -                       $self->ra->gs_do_update($rev, $rev, $self, $ed)
> +                       $self->ra->gs_do_update($rev, $r0, $self, $ed)
>                           or die "SVN connection failed somewhere...\n";
>                 }
>                 print STDERR "Successfully followed parent\n";

-- 
Eric Wong
