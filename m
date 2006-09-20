From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Added --mirror-all to git-fetch.
Date: Wed, 20 Sep 2006 13:31:26 -0400
Message-ID: <20060920173126.GG23260@spearce.org>
References: <20060919232851.GA12195@spearce.org> <7vac4ujzf0.fsf@assigned-by-dhcp.cox.net> <20060920161407.GQ8259@pasky.or.cz> <20060920162145.GA23260@spearce.org> <7v1wq6jy3q.fsf@assigned-by-dhcp.cox.net> <20060920164912.GD23260@spearce.org> <7vac4uihr3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Sep 20 19:32:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ5w4-0006Ez-75
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 19:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWITRbe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 13:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWITRbe
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 13:31:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41637 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932114AbWITRbc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 13:31:32 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GQ5ur-0001ro-Lh; Wed, 20 Sep 2006 13:31:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 81CB020E48E; Wed, 20 Sep 2006 13:31:26 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vac4uihr3.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27385>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> > Originally I gave Pasky a one-liner on #git:
> >
> >   git fetch --force origin $(git ls-remote origin \
> >       | awk '{if(!/\^{}$/){print $2":"$2}}')
> 
> Which sounds a very sane thing to do, especially given git is
> designed to be scripted this way.

Exactly.  So I'm not sure why he was against it.  After all he must
have some script that's looping over all mirrored repositories and
invoking git fetch in them.  :-)
 
> > 	- it has a single remote named origin;
> 
> Do you mean ".git/remotes must have only one file 'origin' and
> nothing else", or do you mean "There must be .git/remotes/foobla
> for 'git-mirror foobla' to work"?

I meant ".git/remotes must have only one file 'origin' and
nothing else".  Because what does it mean to mirror two different
repositories at the same time into the same ref namespace?  The most
recently fetched would always win.

But now that I'm writing this I can see someone wanting multiple
remotes so they could store different URLs for the same repository
and call fetch on another if the first isn't responding.  So I
retract this entirely.  So there doesn't even need to be remotes
file; the URL could just be passed on the command line.  A remotes
file (like the default "origin" one) is just a handy place to store
the URL.
 
> > 	- HEAD isn't a symlink or a symref (its a normal ref in its
> > 	  own right);
> 
> Why?  Usually HEAD is a pointer to the active branch.  I
> consider it is a bug in the upload-pack protocol not to convey
> that information (but that is a separate topic).

Because we don't want to update HEAD with the SHA1 that's on the
remote if that's actually going to update some other ref which
doesn't have the same value.  :-)

I think its simple enough to verify HEAD isn't a symlink or symref
(or just doesn't exist) early in the mirror script.  If the user
really wants to do a mirror and they just did a `git init-db --bare`
they could also do a `rm HEAD` before starting `git-mirror`.

But I agree with you entirely about HEAD being a SHA1 and not its
actual link target in the network protocol.  An annoying bug.

-- 
Shawn.
