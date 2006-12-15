X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Avoiding uninteresting merges in Cairo
Date: Fri, 15 Dec 2006 02:53:57 -0500
Message-ID: <20061215075357.GA27964@spearce.org>
References: <20061215020629.GK26202@spearce.org> <87tzzx4zm7.wl%cworth@cworth.org> <20061215032530.GM26202@spearce.org> <87slfh4xkm.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 07:54:12 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <87slfh4xkm.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34475>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv7tT-00042A-8p for gcvg-git@gmane.org; Fri, 15 Dec
 2006 08:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751265AbWLOHyG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 02:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWLOHyG
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 02:54:06 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60183 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751265AbWLOHyE (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 02:54:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gv7tI-0000FS-7z; Fri, 15 Dec 2006 02:54:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 ECDB920FB65; Fri, 15 Dec 2006 02:53:57 -0500 (EST)
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> wrote:
> On Thu, 14 Dec 2006 22:25:30 -0500, Shawn Pearce wrote:
> > I saw three things happen to poor jwatt that really threw him for
> > a loop, and I think they are all more likely related to Git than
> > to the Cairo project specifically:
> 
> Yes. Also a fourth one was a filesystem case-insensitivity issue. We
> recently imported an external library into cairo that had some
> filenames with capital letters. We then renamed them to the
> all-lowercase filenames we like. Poor jwatt was unlucky enough to have
> cloned with a capitalized filename, and then was trying to pull the
> latest with the lowercase filename and he got:
> 
> 	fatal: Untracked working tree file 'test/pdiff/lpyramid.h'
> 	would be overwritten by merge
> 
> This was in some sense worse than the other problems since it stopped
> him cold and gave him no idea what was wrong nor how to fix it.

This is a huge problem on filesystems where case does not matter
(FAT, Mac OS X's HFS+, NTFS).  We really should put something into
git to detect this when it happens and help the user get out of
the box they have worked themselves into.
 
> >  * His user.name/user.email is probably not what he wanted;
> >
> >  * His Cygwin/Windows system made some *.c/*.c files 0755 without
> >    him realizing it;
> 
> Those two issues did silently put garbage in the commits. I don't know
> how to best fix the name/email thing. Maybe on the first commit with
> no user.name and user.email configuration git could create them,
> announce them to the user, and instruct them on how to change them:
> 
> 	No name or email configuration exists. Using:
> 
> 		U-JONATHAN-X60S\jonathan <jonathan@Jonathan-X60s.(none)>
> 
> 	You can change these with the following commands:
> 
> 		git repo-config user.name Your Name
> 		git repo-config user.email user@example.com
> 
> And maybe mention --global as well.

I've been thinking that is the right thing to do, somewhere
in git-commit, but I can't decide if its best to save that
per-repository or per user, or be interactive and get confirmation
from the user, or just display it and hope the user noticed.
 
> As for the filemode setting, shouldn't that be configured by default
> the right way for Windows git?

No.  The problem is Git tries to be smart and see if filemode works
by chmodding the config file and then looking to see if that worked
the way we expected it to.  It usually does on Cygwin when using
NTFS.  But then if you edit a file non-executable file with a native
Windows application Cygwin may suddenly think its executable again,
and now our core.filemode=true guess isn't actually right anymore.

We probably should just hardcode core.filemode to false on Cygwin.
If the user actually wants core.filemode to be true on Cygwin then
he/she will probably also know enough about this issue with native
Windows applications that the additional hurdle of turning on the
option by hand won't be a big one for them.

> >  * gitweb made it appear as though a whole lot of Carl's recent
> >    work was somehow undone in the merge.
> 
> That looks like a simple gitweb bug. None of the other tools, (gitk,
> git log -p), consider a trivial merge commit like this as having
> anything interesting in it worth displaying.

Right.  gitweb is doing `diff HEAD^1 HEAD` which is quite wrong on
a merge commit.  Especially here where the trunk was pulled into
the topic branch, rather than the topic branch being pulled into
the trunk.

-- 
