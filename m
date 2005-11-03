From: Petr Baudis <pasky@suse.cz>
Subject: Re: little conundrum
Date: Thu, 3 Nov 2005 21:06:31 +0100
Message-ID: <20051103200631.GJ1431@pasky.or.cz>
References: <200511031741.20496.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 21:08:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXlM9-0008Ml-PQ
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 21:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbVKCUGe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 15:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbVKCUGe
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 15:06:34 -0500
Received: from w241.dkm.cz ([62.24.88.241]:9179 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751050AbVKCUGe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2005 15:06:34 -0500
Received: (qmail 9224 invoked by uid 2001); 3 Nov 2005 21:06:31 +0100
To: Alan Chandler <alan@chandlerfamily.org.uk>
Content-Disposition: inline
In-Reply-To: <200511031741.20496.alan@chandlerfamily.org.uk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11090>

Dear diary, on Thu, Nov 03, 2005 at 06:41:20PM CET, I got a letter
where Alan Chandler <alan@chandlerfamily.org.uk> told me that...
> Since I don't actually have a list of the files, I thought I would establish 
> these automatically by going into each directory and doing a cg-init.  So I 
> now have two disjoint repositories each with their source tree in it.
> 
> My next thought was to add a branch to one of them and then pull the resultant 
> code over and merge it using cg-branch-add followed by a cg-update.  But when 
> I do that it complains that there is no common base.  
> 
> I tried creating an empty directory and separately merging the two versions 
> with it, so that I have a common parent, but whatever I do, I can't get one 
> of those nice little gitk diagrams that has any linkage between the two 
> versions of the source code.

The empty directory is the good approach to do the merge, but you are
going to get a huge number of conflicts. Anyway, this is probably the
most sensible behaviour for cg-merge, so I added cg-merge -j which does
exactly that - use empty tree as a base for three-way merge.

But you actually do not want to do a merge, but:

	$ cd original-version
	$ cg-init
	$ cd ../modified-version
	$ cg-init
	$ cg-branch-add orig ../original-version
	$ cg-fetch orig
	$ echo `cg-object-id` `cg-object-id orig` >.git/info/grafts

Voila, now your commit in 'modified' has the commit in 'original' as its
parent.

PS: And to be able to even commit the cg-merge -j, I had to back out the
git-read-tree -u usage in cg-Xlib's tree_timewarp, which made it racy as
hell - basically, it could be argued that it working _properly_ would be
a race now. Besides, keeping local changes wouldn't work, and stuff.
cg-admin-uncommit was painfully broken.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
