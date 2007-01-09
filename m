From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Replacing the system call pread() with lseek()/xread()/lseek() sequence.
Date: Tue, 9 Jan 2007 18:25:41 -0500
Message-ID: <20070109232540.GA30023@spearce.org>
References: <45A40C15.1070200@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 00:25:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4QLo-0001Cy-7C
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 00:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbXAIXZt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 18:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbXAIXZt
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 18:25:49 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34220 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932515AbXAIXZt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 18:25:49 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4QLV-0004u8-Ft; Tue, 09 Jan 2007 18:25:33 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4174720FBAE; Tue,  9 Jan 2007 18:25:41 -0500 (EST)
To: Andy Whitcroft <apw@shadowen.org>
Content-Disposition: inline
In-Reply-To: <45A40C15.1070200@shadowen.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36421>

Andy Whitcroft <apw@shadowen.org> wrote:
> Stefan-W. Hahn wrote:
> > Using cygwin with cygwin.dll before 1.5.22 the system call pread() is buggy.
> > This patch introduces NO_PREAD. If NO_PREAD is set git uses a sequence of
> > lseek()/xread()/lseek() to emulate pread.
> > +
> > +        rc=read_in_full(fd, buf, count);
> 
> Seems to be style inconsistancy between current_offset = and rc= I
> believe the former is preferred.

With the exception of this style difference, the patch looked
pretty good.  Nice work Stefan.  Andy's right, we do tend to prefer
"rc = read_in_full" over "rc=read_in_full".  Quite a bit actually,
though Junio is the final decider on all such matters as he gets
to choose to accept or reject the patch.  ;-)

> > +
> > +        if (current_offset != lseek(fd, current_offset, SEEK_SET))
> > +                return -1;
> 
> How likely are we ever to be in the right place here?  Seems vanishingly
> small putting us firmly in the four syscalls per call space.  I wonder
> if git ever actually cares about the seek location.  ie if we could stop
> reading and resetting it.  Probabally not worth working it out I guess
> as any _sane_ system has one.

Andy's right actually.  If we are using pread() we aren't relying
on the current file pointer.  Which means its unnecessary to get
the current pointer before seeking to the requested offset, and its
unnecessary to restore it before the git_pread() function returns.

Though its a possibly unnecessary optimization as like Andy points
out, most sane systems already have a working pread() implementation.
And those that don't, well, probably should be made to be sane.
But we don't need to make Git suffer there if we don't have to.

-- 
Shawn.
