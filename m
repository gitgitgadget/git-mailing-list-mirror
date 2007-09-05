From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and a nested branches folder
Date: Tue, 4 Sep 2007 17:15:13 -0700
Message-ID: <20070905001513.GA9362@soma>
References: <46DD6EEA.9010304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Russ Brown <pickscrape@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 02:15:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISiYE-0003ow-IC
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 02:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486AbXIEAPR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 20:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754959AbXIEAPQ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 20:15:16 -0400
Received: from hand.yhbt.net ([66.150.188.102]:54440 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755455AbXIEAPP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 20:15:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id E1FAD7F4110;
	Tue,  4 Sep 2007 17:15:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <46DD6EEA.9010304@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57661>

Russ Brown <pickscrape@gmail.com> wrote:
> Hi,

Hi Russ,

> I'm having some trouble with using git-svn to fetch a repository, and I
> think it's because the repository doesn't store branches as a flat list
> directly under the 'branches' directory.
> 
> Basically, we have a structure like this:
> 
> |
> +-trunk
> +-tags
> +-branches
>   + category-a
>     + branch-a
>     + branch-b
>   + category-b
>     + branch-c
>     + branch-d
> 
> etc. category-a and category-b are simple directories created using svn
> mkdir. The branches are created using svn cp.
> 
> It helps us to organise the branches better, but the rationale is
> besides the point. The problem is that git-svn seems to want to treat
> category-a and category-b as branches, which isn't right at all. As a
> result, git-svn seems to skip most (if not all) revisions that occur in
> these directories and creates a lot of entries in unhandled.log.

This is a known problem with the way git-svn handles branches and tags.
Nested branch (and tags) structures aren't supported with globbing and
so you can't have more than one branches/tags specification in your
config.

> I've also encountered an index corruption in one of the
> .git/svn/<branch>/index files which I think it probably related.

Not sure about that.  git-svn should detect and attempt to fix index
corruptions (which happened for me since I interrupt git-svn quite
often when working on it).

> I've had a quick look at the source myself, but perl isn't my strong
> point. What I think it should do is something like recurse down the tree
> from the directory given looking for folders that copy from trunk (or
> some other branch that already exists). That would work perfectly well
> for the default flat branch storage method as well as the one we use.

The globbing functionality of branches in git-svn is some of the ugliest
code I've ever written in my life.  Somehow I got it working for the
simple general cases but I've been afraid to touch it for a while...

> The only other problem is in branch naming, which could clash if you
> only use the outer-most directory name, so I'd suggest something that
> involves concatenating the folders in the path relative to 'branches' to
> keep them unique (if git can handle slashes in branch names then all the
> better).

As Peter suggested, disable globbing for branches and use explicit
fetch refspecs for now...

-- 
Eric Wong
