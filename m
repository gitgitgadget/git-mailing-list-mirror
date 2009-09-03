From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: git-svn-Cloning repository with complicate nesting
Date: Thu, 03 Sep 2009 10:31:38 -0400
Message-ID: <4A9FD34A.7020101@xiplink.com>
References: <9accb4400908270132vaccc4eegb58e2f0ee8de0797@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 16:42:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjDW3-0001b1-44
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 16:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbZICOl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 10:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbZICOl7
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 10:41:59 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:47348 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbZICOl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 10:41:58 -0400
X-Greylist: delayed 609 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Sep 2009 10:41:58 EDT
Received: from relay19.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay19.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id E85781B40CC;
	Thu,  3 Sep 2009 10:31:49 -0400 (EDT)
Received: by relay19.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 5BEAE1B4056;
	Thu,  3 Sep 2009 10:31:45 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <9accb4400908270132vaccc4eegb58e2f0ee8de0797@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127655>

Hi Daniele,

I think you're stuck.  Someone who knows git-svn better than I might be able to figure out a solution (I haven't played with using wildcards in the middle of branches refspecs), but as far as I can tell git-svn can't support your repository's structure.

The fundamental problem is that the BRANCHES/ hierarchy isn't consistent.  git-svn expects the directories under a 'branches' path to be branch names.  In your case, you can't specify a configuration that covers your whole repository.

This:

	branches = <url>/BRANCHES/DEV/*:refs/remotes/svn/dev/*
	branches = <url>/BRANCHES/BUILDS/*:refs/remotes/svn/builds/*

will let you track the stuff under BRANCHES/DEV and BRANCHES/BUILDS, but won't let you see the V*.* branches.

This:

	branches = <url>/BRANCHES/*:refs/remotes/svn/*

will let you see the V*.* branches, but will get confused over the DEV and BUILDS stuff (because it's expecting the layout to be DEV/root and BUILDS/root).

So I think git-svn would need to be modified to support your situation.

One possible approach is to make git-svn smart about what it considers a branch's name.  In theory, what you'd like is to just specify

	branches = <url>/BRANCHES/*:refs/remotes/svn/*

and have git-svn properly identify all the branches:

	V1.0
	V1.1
	V1.2
	DEV/FEATURE1
	DEV/FEATURE2
	DEV/FEATURE3
	BUILDS/BUILD1
	BUILDS/BUILD2
	BUILDS/BUILD3

To do this, git-svn could track the current 'trunk' directory structure (just the top-level contents of the root should suffice).  Then when it detects a new path under BRANCHES it could search through that path until it finds the same 'trunk' directory structure, and then use the path as the full branch name.

For example, say a repository's trunk has 3 directories and a file:
	trunk/
		foo/...
		bar/...
		baz/...
		readme.txt
When a commit creates a new branch:
	branches/some/path/
		foo/...
		bar/...
		baz/...
		readme.txt
git-svn sees that the commit is to a new path under branches/ and looks through branches/some/ and branches/some/path/ to find the trunk's contents, deciding in this case that 'some/path' is the branch's name.

Anyway, this is just an idea of how things might work.  There are probably some corner-cases that could make this a bit tricky to implement...

		M.


Daniele Segato wrote:
> Hi, this is my first message in the list: this may be a newbie
> question and my English may not be very good.
> 
> I've an SVN repository structured like this:
> 
> http://<url>/path/to/repo
>     |
>   HEAD
>     |----- root
>     |
>   BRANCHES
>     |----- V1.0
>     |         |----- root
>     |
>     |----- V1.1
>     |         |----- root
>     |
>     |----- V1.2
>     |         |----- root
>     |
>     |----- DEV
>     |         |----- FEATURE1
>     |         |            |----- root
>     |         |
>     |         |----- FEATURE2
>     |         |            |----- root
>     |         |
>     |         |----- FEATURE3
>     |                      |----- root
>     |
>     |----- BUILDS
>               |----- BUILD1
>               |            |----- root
>               |
>               |----- BUILD2
>               |            |----- root
>               |
>               |----- BUILD3
>                            |----- root
> 
> the same for TAGS.
> 
> I did this:
> 
> git init
> git svn init <url>
> vim .git/config
> 
> [core]
> 	repositoryformatversion = 0
> 	filemode = true
> 	bare = false
> 	logallrefupdates = true
> [svn-remote "svn"]
> 	url = <url>
> 	fetch = <url>/HEAD/root:refs/remotes/trunk
> 	branches = <url>/BRANCHES/*/root:refs/remotes/branches/*
> 	branches = <url>/BRANCHES/*/*/root:refs/remotes/devel/*
> 	tags = <url>/TAGS/*/root:refs/remotes/tags/*
> 
> 
> git svn fetch
> 
> 
> It is now cloning the repo (it is a really big repo)
> 
> 
> It is my configuration ok for the repository structure?
> 
> if from another terminal I execute "git branch -r" I get:
>   tags/V1.3.0
>   tags/V1.3.0@3260
>   tags/V1.3.1
>   tags/V1.3.1@3359
>   tags/V1.3.2
>   tags/V1.3.2@4256
>   tags/V1.4.0-COMMUNITY-FINAL
>   tags/V1.4.0-ENTERPRISE-BETA@4241
>   trunk
>   trunk@4475
> 
> It should have already created some branch but I don't see any...
> 
> what are those @XXXX number for some of those branches?
> 
> Is the syntax of the svn-remote configuration correct?
> 
> with this:
> branches = <url>/BRANCHES/*/*/root:refs/remotes/devel/*
> how does git choose the name of the branch? (
> refs/remotes/devel/WHAT_GOES_HERE ? )
> 
> I would like it to use the tuple */* of the directory
> 
> 
> If the syntax of my configuration is not correct, where can I found a
> documentation about it? I couldn't find one.
> 
> 
> Thanks
> Regards,
> Daniele
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
