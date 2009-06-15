From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: git svn: Supporting multiple branch subdirs?
Date: Mon, 15 Jun 2009 13:29:45 -0400
Message-ID: <4A368509.9070801@xiplink.com>
References: <4A32CCA5.7040404@xiplink.com> <4A339182.1090204@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>, normalperson@yhbt.net
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jun 15 19:30:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGG0f-0007il-3h
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 19:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757279AbZFORaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 13:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752942AbZFORaD
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 13:30:03 -0400
Received: from smtp142.dfw.emailsrvr.com ([67.192.241.142]:57186 "EHLO
	smtp142.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbZFORaC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 13:30:02 -0400
Received: from relay4.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay4.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id 5205B10CC063
	for <git@vger.kernel.org>; Mon, 15 Jun 2009 13:29:59 -0400 (EDT)
Received: by relay4.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id D62CD10CBE24;
	Mon, 15 Jun 2009 13:29:54 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
In-Reply-To: <4A339182.1090204@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121618>

Michael J Gruber wrote:
> 
> After doing the init with "--branches=stable" (without releng), do
> git config --add svn-remote.svn.branches 'releng/*:refs/remotes/*'
> 
> This gives you two branches refspecs in .git/config (feel free to put
> them in different dirs under remotes if there may be name clashes
> between stable and releng branches).

That doesn't seem to work...

Here's my .git/config file before the first fetch:

[svn-remote "svn"]
        useSvnsyncProps = 1
        ignore-paths = ^[^/]+/(?:cvs2svn|projects|svnadmin|user|vendor.*)
        url = file:///home/marcnarc/Code/FreeBSD-all-mirror/base
        fetch = head:refs/remotes/trunk
        branches = stable/*:refs/remotes/stable/*
        branches = releng/*:refs/remotes/releng/*
        tags = release/*:refs/remotes/tags/*

(Shouldn't that fetch line be head:refs/remots/head, since there's nothing called "trunk" in the svn repo?  I used git-svn init --trunk=head ...)

With this, git-svn seems to be (mostly) ignoring the branches in stable/.  I've run the first fetch past the point where the first stable/ branch is created ("stable/2.0.5"), but in the repository (while the fetch command is still going, BTW, currently somewhere around commit 15,000), I get:

	$ git branch -a
	  remotes/releng/2.0.5
	  remotes/releng/ALPHA_2_0
	  remotes/releng/BETA_2_0
	  remotes/tags/2.0
	  remotes/tags/2.0.5
	  remotes/tags/2.1.0
	  remotes/tags/2.1.0@12369
	  remotes/trunk

At this point, git-svn has passed the commit that created the stable/2.0.5 branch (8869).  Mind you, nothing was ever committed to that branch, so it's basically a tag.  However, remotes/tags/2.0.5 is at svn commit 9201, which is the correct for the releases/2.0.5 tag.  remotes/tags/2.1.0 is also correct for the tagging of the 2.1.0 release.

git-svn has also passed the commit that created the stable/2.1 branch (9211), as well as later commits that only apply to that branch.  AFAICT, remotes/tags/2.1.0@12369 (which is not an actual tag or branch in the svn repo) is the stable/2.1 branch up to commit 12369, but there have been later commits to stable/2.1 since then that git-svn has seen.  Those later commits don't seem to be in the git repository at all.

The releng/* branches look fine, though.

>> - The releng/X.Y branches are created from the stable/X  tree, where X
>> itself doesn't exist from the start.
> 
> Well, I assume X exists at the time of creation of X.Y. That's all that
> is needed.

Yes, that assumption is correct (it seems the 2.x releng branches were created off the trunk, not from a stable/ branch).

>> - FreeBSD likes to make single commits that spans multiple branches.
>> This is usually done as a security patch: One commit can, for example,
>> touch /head, /stable/X, /stable/W, and several branches under /releng.
> 
> I assume that git-svn converts such an svn commit into several git
> commits, one for each affected branch. Since you have a local mirror
> it's easy to try out.

Yep, git-svn does just that.  Nice!

		M.
