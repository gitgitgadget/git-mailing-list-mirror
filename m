From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: .git/svn disk usage
Date: Wed, 5 Dec 2007 22:47:17 -0800
Message-ID: <20071206064717.GA7744@muzzle>
References: <65dd6fd50712022217l5f807f31pf3f00d82c3dccf5c@mail.gmail.com> <loom.20071203T182924-435@post.gmane.org> <20071205085451.GA347@soma> <6D1288C9-8FD7-40CB-BA0B-0032F8D2DA6A@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Voit <david.voit@gmail.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 07:47:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0AWJ-0003IT-HW
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 07:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbXLFGrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 01:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752396AbXLFGrT
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 01:47:19 -0500
Received: from hand.yhbt.net ([66.150.188.102]:47436 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751733AbXLFGrT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 01:47:19 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 0E6037DC025;
	Wed,  5 Dec 2007 22:47:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <6D1288C9-8FD7-40CB-BA0B-0032F8D2DA6A@midwinter.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67260>

Steven Grimm <koreth@midwinter.com> wrote:
> How about using git itself to keep some of this information? I'll just  
> throw this idea out there; might or might not make any actual sense.
> 
> Create a new "git-svn metadata" branch. This branch contains a fake  
> directory (never intended for checkout, though you could do it) that  
> has a "file" for each svn revision. The filename is just the svn  
> revision number, maybe divided into subdirectories in case you want to  
> check the branch out for debugging purposes or whatever. The contents  
> are the git commit SHA1 and whatever other metadata you want to keep  
> in the future.
> 
> The advantage of doing it this way? You can pass around svn metadata  
> using the normal git fetch/push tools, query the metadata using "git  
> show", etc. In terms of data integrity, it's as secure as anything  
> else in a git repository, much more so than a separately maintained db  
> file under .git.

I've thought of doing the way you describe in the past, too.

However, a missing ref to the tree you proposed would mean that the
metadata becomes inaccessible unless git-svn-id: lines are retained.

Right now there's a single ref for all data and metadata.  Going to
two refs would mean those two refs would always need to be in sync
with each other.

The basic idea of the git-svn-id: lines is that with the default
settings, the .rev_db files are deletable and can be regenerated from
that metadata.  git-svn will automatically re-create .rev_db files it
cannot find.

This is why the rev_db code in git-svn uses slow, synchronous writes iff
svk props or no-metadata is enabled; and fast, assynchronous writes
when the user sticks with the git-svn defaults.

> Along similar lines, a separate branch where the filenames are commit  
> SHA1s and the file contents are the stuff that currently gets written  
> into the git-svn-id: lines would mean no more need to rewrite history  
> when doing dcommit, and thus easier mixing of native git workflows and  
> interactions with an svn repository.

The current dcommit still has the advantage that commit times match
those in the SVN repository.

> It would be great if you could clone a git-svn repository and then do  
> "git svn dcommit" from the clone, secure in the knowledge that things  
> will stay consistent even if the origin gets your changes via "git svn  
> fetch" rather than from you.

It's actually doable after the [svn-remote "..."] section .git/config is
copied and the refs/remotes/* structure is cloned via git.

The [svn-remote "..."] information can be regenerated based on
git-svn-id: lines (there's no automated way to do that, currently).

-- 
Eric Wong
