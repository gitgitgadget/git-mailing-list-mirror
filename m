From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: pread() over NFS (again) [1.5.5.4]
Date: Thu, 26 Jun 2008 18:07:55 -0400
Message-ID: <20080626220755.GB11793@spearce.org>
References: <6F25C1B4-85DE-4559-9471-BCD453FEB174@gmail.com> <20080626204606.GX11793@spearce.org> <7vskuzq5ix.fsf@gitster.siamese.dyndns.org> <20080626210556.GZ11793@spearce.org> <7vod5nq2dy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Holtje <docwhat@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 00:08:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBzeB-0002ej-5W
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 00:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbYFZWIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 18:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbYFZWH7
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 18:07:59 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46477 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbYFZWH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 18:07:59 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KBzd5-0000UK-2T; Thu, 26 Jun 2008 18:07:47 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6A2B520FBAE; Thu, 26 Jun 2008 18:07:55 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vod5nq2dy.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86492>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > We have a file position we saw once before as the start of a delta.
> > We wrote it down to disk.  We want to go back and open it up, as
> > we have the base decompressed and in memory and need to compute
> > the SHA-1 of the object that resides at this offset.
> >
> > And *wham* we get an EOF.  Where there should be data.  Where we
> > know there is data.
> 
> We have written that earlier in the same process?  Are we playing games
> with mixed mmap() and pread()?  Is fsync() or msync() or unmap/remap
> needed?

Yes, we wrote the very same file earlier in the process.

index-pack _used_ to use a mixed write/mmap game.  Today it uses
write, followed by later pread.  No mmap.  We had major performance
issues on Mac OS X with mmap, not to mention the coherency issues
that can arise from using it.  So index-pack is mmap free[*1*].
 
> > Actually, I think the last time someone reported something like this
> > in Git it turned out to be an NFS kernel bug.  I didn't quote it
> > in my reply to him, but I think he did say this was a linux client,
> > linux server.
> 
> This is getting into the area Linus would immediately know the answer to,
> but he is away for this week.

Yea, I was expecting a reply from him, but that explains it.

*1* There is usage of mmap in index-pack, but only to access
    _existing_ objects and packs from the object store.

-- 
Shawn.
