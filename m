From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: pread() over NFS (again) [1.5.5.4]
Date: Thu, 26 Jun 2008 17:05:56 -0400
Message-ID: <20080626210556.GZ11793@spearce.org>
References: <6F25C1B4-85DE-4559-9471-BCD453FEB174@gmail.com> <20080626204606.GX11793@spearce.org> <7vskuzq5ix.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Holtje <docwhat@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 23:07:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBygI-0000YP-7n
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 23:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbYFZVGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 17:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755907AbYFZVGC
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 17:06:02 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42414 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbYFZVGA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 17:06:00 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KByf6-0006Ba-EB; Thu, 26 Jun 2008 17:05:48 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3A80F20FBAE; Thu, 26 Jun 2008 17:05:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vskuzq5ix.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86488>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > Christian Holtje <docwhat@gmail.com> wrote:
> >> I have read all the threads on git having trouble with pread() and I  
> >> didn't see anything to help.
> > ...
> >>   Receiving objects: 100% (253/253), 5.27 MiB | 9136 KiB/s, done.
> >>   fatal: cannot pread pack file: No such file or directory
> >>   fatal: index-pack failed
> >> 
> >> The end of the strace looks like so:
> >> pread(3, "", 205, 1373)                 = 0
> >> write(2, "fatal: cannot pread pack file: N"..., 57) = 57
> >
> > Hmmph.  So pread for a length of 205 can return 0 on NFS?  Is this
> > a transient error?  If so, perhaps a patch like this might help:
...
> > The file shouldn't be short unless someone truncated it, or there
> > is a bug in index-pack.  Neither is very likely, but I don't think
> > we would want to retry pread'ing the same block forever.
> 
> I don't think we would want to retry even once.  Return value of 0 from
> pread is defined to be an EOF, isn't it?

Indeed, it is defined to be EOF, but EOF here makes no sense.

We have a file position we saw once before as the start of a delta.
We wrote it down to disk.  We want to go back and open it up, as
we have the base decompressed and in memory and need to compute
the SHA-1 of the object that resides at this offset.

And *wham* we get an EOF.  Where there should be data.  Where we
know there is data.

I'm open to the idea that index-pack has a bug, but I doubt it.
We shovel hundreds of megabytes through that on a daily basis
across all of the git users, and nobody ever sees it crash out
with an EOF in the middle of an object it knows to be present.
Except poor Christian on NFS.

Actually, I think the last time someone reported something like this
in Git it turned out to be an NFS kernel bug.  I didn't quote it
in my reply to him, but I think he did say this was a linux client,
linux server.

-- 
Shawn.
