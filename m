From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git-svn doesn't recognise trunk as parent of branch
Date: Sun, 12 Apr 2009 20:54:40 +0200
Message-ID: <20090412185440.GA25300@m62s10.vlinux.de>
References: <F562B0FA-6E9F-45AD-ADD5-D6EE1AD9C248@orestis.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Orestis Markou <orestis@orestis.gr>
X-From: git-owner@vger.kernel.org Sun Apr 12 20:52:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lt4n5-0002Y5-7S
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 20:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbZDLSus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 14:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbZDLSus
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 14:50:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:48466 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751758AbZDLSur (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 14:50:47 -0400
Received: (qmail invoked by alias); 12 Apr 2009 18:50:45 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp002) with SMTP; 12 Apr 2009 20:50:45 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+KCxI0aG+K30bvMXVVEbQ1NRuXfozFOEG996lkIK
	Vioh1XzYnRSWjS
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 3A8831ACD6; Sun, 12 Apr 2009 20:54:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <F562B0FA-6E9F-45AD-ADD5-D6EE1AD9C248@orestis.gr>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116388>

On Sun, Apr 12, 2009 at 07:40:46PM +0300, Orestis Markou wrote:
> Hello there - this is my first post to this ML, so please be kind!
>
> I have previously used git-svn with great success. However, in this  
> project, the svn repo layout is a bit unusual and I'm having getting  
> git-svn to do the correct thing.
>
> The repository I'm trying to clone is a subdirectory under a huge repo:
>
> http://svn.example.com/projects/trunk/MyProject/Production
>
> which has trunk, branches and tags and a couple of other directories  
> (which I'm not interested in).
>
> Complications so far:
>
> * I don't have read access to the lower directories, only to Production
> * Being a part of a big repo, the initial revision is something like  
> 2000
> * trunk, branches, tags where not created in the same revision. trunk  
> didn't exist until revision say 2050.
>
>
> Doing 'git svn init -s 
> http://svn.example.com/projects/trunk/MyProject/Production' produces the 
> following configuration:
>
> [svn-remote "svn"]
> url = http://svn.example.com/trunk/projects/MyProject/Production
> fetch = trunk:refs/remotes/trunk
> branches = trunk/projects/MyProject/Production/branches/*:refs/remotes/*
> tags = trunk/projects/MyProject/Production/tags/*:refs/remotes/tags/*
>
> Fetching this fetches only trunk and no branches.
>
> Amending the config to be:
>
> [svn-remote "svn"]
> 	url = http://svn.example.com/trunk/projects/MyProject/Production/
> 	fetch = trunk:refs/remotes/trunk
> 	branches = branches/*:refs/remotes/*
> 	tags = tags/*:refs/remotes/tags/*
>
>
> and fetching (minor issue - have to start from scratch again), does  
> fetch all commits. However, there is no link between branches and trunk. 
> Using gitk (don't know how else to visualise this) shows branches as 
> having no parent. Indeed, in the fetch messages there is no 'found 
> possible parent' message. Also, when creating new branches in svn, 
> nothing shows up in git until a change happens. Then the branch is 
> created (again, with no parent).
>
> The only case where a correct parent was set was when someone branched  
> *from a branch*. Then the usual 'found possible parent' message  
> appeared, and gitk shows a sane tree.
>
> I'm on Mac OS X, git version 1.6.2.2.471.g6da14 (built from source,  
> master branch). This includes a recent commit that fixed an issue with  
> deep directories in git-svn, (without it I couldn't get the branches  
> anyway), but it doesn't seem to have fixed the problem completely.
>
> Any pointers welcome.

It might be that git svn can't work with this strange repo or with trunk
created after the branches (no idea if this is a bug or intentional), but I'll
show you a easy way how to fix the git repo after the import by using grafts.

If you have a wrongly connected development (which you are trying to fix) line like
the following example:

Time goes from left to right

	1 - 2 - 3 - 5 - 6       branchA

       	        a - b - c - d   trunk

you could fix it by connecting the graph using

	echo a 2 >> .git/info/grafts

to get something like this

	1 - 2 - 3 - 5 - 6       branchA
	      \
       	        a - b - c - d   trunk

Replace 'a' and '2' with the sha1 value of the corresponding commit. The same
way you could teach git about merges in svn. To make the changes permantent,
use something like

	git filter-branch --tag-name-filter cat -- --all

(Pls. check the manpage, I'm not that familiar with git filter-branch)

-Peter
