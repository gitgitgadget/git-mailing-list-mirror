From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn's performance issue and strange pauses, and other thing
Date: Fri, 19 Sep 2014 08:25:29 +0000
Message-ID: <20140919082529.GA32459@dcvr.yhbt.net>
References: <1411025993.80693.YahooMailBasic@web172304.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakob Stoklund Olesen <stoklund@2pi.dk>,
	Sam Vilain <sam@vilain.net>,
	Steven Walter <stevenrwalter@gmail.com>,
	Peter Baumann <waste.manager@gmx.de>,
	Andrew Myrick <amyrick@apple.com>
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Sep 19 10:25:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUtVb-0003Pm-Gd
	for gcvg-git-2@plane.gmane.org; Fri, 19 Sep 2014 10:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbaISIZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2014 04:25:34 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55066 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbaISIZc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2014 04:25:32 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD4AF1F7C9;
	Fri, 19 Sep 2014 08:25:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1411025993.80693.YahooMailBasic@web172304.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257282>

Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> (I am not on the list - please CC)

Done, it is standard practice for git :)

> Thanks for git-svn - I use it instead of subversion itself for many years now.
> 
> Just thought I'd ask/report a few issues I noticed for some time
> now, of tracking development of a particular subversion-based
> development project. Broadly speaking, I think there are 3 problems,
> especially noticeable against a particular repository, but 
> to a lesser extent with some others too.
> 
> - just doing "git svn fetch --all" seems to consume a lot of memory,
> for very little actual fetched changes. (in the 2GB+ region, sometimes).
> 
> - "git svn fetch --all" also seems to take a long time too, for certain
> fetched changes. (in the minutes region).

Jakob sent some patches a few months ago which seem to address the
issue.  Unfortunately we forgot about them :x

Can you take a look at the following two "mergeinfo-speedups"
in my repo?  (git://bogomips.org/git-svn)

Jakob Stoklund Olesen (2):
      git-svn: only look at the new parts of svn:mergeinfo
      git-svn: only look at the root path for svn:mergeinfo

Also downloadable here:

http://bogomips.org/git-svn.git/patch?id=9b258e721b30785357535
http://bogomips.org/git-svn.git/patch?id=73409a2145e93b436d74a

Can you please give them a try?

> -  I know I can probably just "read the source", but I'd like to know
> why .git/svn/.caches is even larger than .git/objects (which supposedly
> contains everything that's of interest)? I hope this can be documented
> towards the end of the man-page, for example, of important parts
> of .git/svn (and what not to do with them...), without needing to
> 'read the source'. Here is part of "du" from a couple of days ago:
> 
> 254816	.git/objects
> 307056	.git/svn/.caches
> 332452	.git/svn
> 588064	.git
> 
> The actual .git/config is here - this should be sufficient info for
> somebody looking into experiencing the issues I mentioned above.

IIRC, the caching is unique to mergeinfo, so perhaps Jakob's patches
help, there, too.

Sorry I don't understand the mergeinfo stuff more, I've never worked on
a project which uses it.

> --------
> $ more .git/config 
> [core]
> 	repositoryformatversion = 0
> 	filemode = true
> 	bare = false
> 	logallrefupdates = true
> [svn-remote "svn"]
> 	url = https://svn.r-project.org/R
> 	fetch = trunk:refs/remotes/trunk
> 	branches = branches/*:refs/remotes/*
> 	tags = tags/*:refs/remotes/tags/*
> [pack]
> 	threads = 1
> ------------
