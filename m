From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: git-svn: Trouble after project has moved in svn
Date: Thu, 17 Jul 2008 10:55:39 +0200
Message-ID: <487F090B.3080800@fastmail.fm>
References: <510143ac0807161512w44a612bcndc53713639b0b70a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 10:57:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJPIF-0007wz-JB
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 10:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbYGQIz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 04:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754533AbYGQIzz
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 04:55:55 -0400
Received: from main.gmane.org ([80.91.229.2]:44596 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753616AbYGQIzy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 04:55:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KJPHD-0004as-0u
	for git@vger.kernel.org; Thu, 17 Jul 2008 08:55:51 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 08:55:51 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 08:55:51 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <510143ac0807161512w44a612bcndc53713639b0b70a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88819>

Jukka Zitting venit, vidit, dixit 17.07.2008 00:12:
> Hi,
> 
> Somewhat related to the recent thread about Apache Synapse, I'm having
> trouble making a git-svn clone of a project that has been moved around
> in a Subversion repository.
> 
> See the script at the end of this message for a simple test case that
> does the following svn commits:
> 
>     PREPARE: creates projectA with the standard trunk,branches,tags structure
>     VERSION1: first version of README.txt in projectA/trunk
>     TAG1: tags projectA/trunk to projectA/tags/v1
>     MOVE: moves projectA to projectB
>     VERSION2: second version of README.txt in projectB/trunk
>     TAG2: tags projectB/trunk to projectB/tags/v2
> 
> The resulting repository structure is:
> 
>     /projectB/
>         trunk/
>             README.txt # version 2
>         branches/
>         tags/
>             v1/
>                 README.txt # version 1
>             v2/
>                 README.txt # version 2
> 
> Here's the git commit graph created by the test case:
> 
>     * TAG2 <- refs/remotes/tags/v2
>     | * VERSION2 <- refs/remotes/trunk
>     |/
>     * MOVE
>     * VERSION1 <- refs/remotes/trunk@3
>     | * MOVE <- refs/remotes/tags/v1
>     | * TAG1 <- refs/remotes/tags/v1@3
>     |/
>     * PREPARE <- refs/remotes/tags/v1@1
> 
> The most pressing issue is that the refs/remotes/tags/v1 branch starts
> directly from the first PREPARE commit instead of VERSION1. Also, the
> branch point of refs/remotes/tags/v2 seems to be incorrect, it should
> be based on the VERSION2 commit instead of MOVE.

In the script below, you use copies inside your svn working copy for 
tagging, which is generally a bad idea: it stores the exact state of 
your wc as a "tag". Use this for creating "mixed states", but not for 
ordinary tagging (or make sure you svn up). See the detailed comments below.

If you want to create an svn tag (as far as svn has tags at all) use 
repo urls, or make sure your wc is up to date.

> =====
> #!/bin/sh
> 
> REPO=`pwd`/repo
> svnadmin create $REPO
> 
> svn checkout file://$REPO checkout
> cd checkout
> 
> svn mkdir projectA
> svn mkdir projectA/trunk
> svn mkdir projectA/branches
> svn mkdir projectA/tags
> svn commit -m PREPARE
> 
> echo VERSION1 > projectA/trunk/README.txt
> svn add projectA/trunk/README.txt
> svn commit -m VERSION1

Now, README.txt is at r2, but trunk is still at r1.
Use "svn update" here to get trunk to r2!

> svn copy projectA/trunk projectA/tags/v1

This copies r1 of trunk to the tags dir (unless you've inserted svn up 
above)!

> svn commit -m TAG1
> svn update
> 
> svn move projectA projectB
> svn commit -m MOVE
> 
> echo VERSION2 > projectB/trunk/README.txt
> svn commit -m VERSION2

Now, README.txt is at r5, but trunk is at r4.
"svn update"!

> svn copy projectB/trunk projectB/tags/v2

This tags (copies to tags/) r4 of trunk

> svn commit -m TAG2
> svn update

This produces r6: the tagging.

> 
> mkdir ../git
> cd ../git
> 
> git svn init -s file://$REPO/projectB
> git svn fetch

The results perfectly as expected. Compare "svn log -v" with git-svn's 
results, and you'll see that git (tag) branches fork off exactly at the 
revisions which you tagged in svn. Because the last commit occurs on 
tags/v2, git-svn checks out that branch as master, the supposedly 
"active" branch.

If you insert the two missing "svn update" commands which bring your wc 
up to date before tagging your git-svn results will be what you expected.

Cheers,
Michael
