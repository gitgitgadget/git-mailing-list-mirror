From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Current Issues #3
Date: Mon, 22 May 2006 19:12:57 -0400
Message-ID: <20060522231257.GA21124@spearce.org>
References: <7v8xoue9eo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605221738090.6713@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 01:13:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiJaH-0001vy-6Q
	for gcvg-git@gmane.org; Tue, 23 May 2006 01:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWEVXNF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 19:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWEVXNF
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 19:13:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40333 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751292AbWEVXNE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 19:13:04 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FiJZy-0002dE-SL; Mon, 22 May 2006 19:12:51 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 89A9620FB0C; Mon, 22 May 2006 19:12:58 -0400 (EDT)
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605221738090.6713@iabervon.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20547>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Mon, 22 May 2006, Junio C Hamano wrote:
> 
> > * reflog
> > 
> >   I still haven't merged this series to "next" -- I do not have
> >   much against what the code does, but I am unconvinced if it is
> >   useful.  Also objections raised on the list that this can be
> >   replaced by making sure that a repository that has hundreds of
> >   tags usable certainly have a point.
> 
> I think it would make gitweb's summary view clearer, and Linus seemed 
> interested in being able to look up what happened in the fast forward 
> which was the first of several merges in a day.
> 
> It could be replaced by a repository with hundreds of machine-readable 
> tags with code to parse dates into queries for suitable tags. But I don't 
> think there's an advantage to using the tag mechanism here, because you 
> never want to look the history up by exactly which history it is (the 
> thing that a tag ref is good for); you'll be looking for whatever reflog 
> item is the newest not after a specified time, where the specified time is 
> almost never a time that a reflog item was created.

The thing is this might also be easily represented as a structure
of tags; for example:

	refs/logs/heads/<ref>/<year>/<month>/<day> <hour>:<min>:<sec>:<seq>

where the tag is a tag of the commit which was valid in that ref
at that time.  Searching for an entry "around a particular time"
isn't that much more difficult than parsing a file, you just have
to walk backwards through the sorted directory listings then read
the tag object which matches; that tag object will point at the
tree/commit/tag which is was in that ref..

What's ugly about this is simply the disk storage: a ref file is an
expensive thing (relatively speaking) on most UNIX file systems due
to the inode overhead.  If this was stored in a more compact format
(such as a GIT tree) then this would cost very little.

So the alternative that I have been mentaly kicking around for
the past two days is storing the GIT_DIR/refs directory within a
standard GIT tree.  This of course would need to be an option that
gets enabled by the user as currently most tools expect the refs
directory to actually be a directory, not a tree.  The advantage here
is that unlike proposed reflog it is a compact ref representation
which could be used by other features, such as tagging a GIT
commit with the unique name of the same change from another SCM.
Or tagging your repository on every automated build, which runs
once every 5 minutes.

-- 
Shawn.
