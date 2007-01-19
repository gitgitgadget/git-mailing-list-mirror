From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] prune: --expire=seconds
Date: Thu, 18 Jan 2007 22:44:04 -0500
Message-ID: <20070119034404.GA17521@spearce.org>
References: <20070118171830.GA13521@moooo.ath.cx> <20070118172408.GG15428@spearce.org> <20070118174244.GA14287@moooo.ath.cx> <20070118175134.GH15428@spearce.org> <20070118222919.GA22060@moooo.ath.cx> <7vy7o0klt1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 04:44:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7kfs-00029J-2I
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 04:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbXASDoL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 22:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbXASDoL
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 22:44:11 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54036 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964813AbXASDoK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 22:44:10 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H7kfS-000394-My; Thu, 18 Jan 2007 22:43:54 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8772120FBAE; Thu, 18 Jan 2007 22:44:04 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy7o0klt1.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37151>

Junio C Hamano <junkio@cox.net> wrote:
> Matthias Lederhofer <matled@gmx.net> writes:
> 
> > This option specifies the minimum age of an object before it
> > may be removed by prune.  The default value is 2 hours and
> > may be changed using gc.pruneexpire.
> 
> I am not sure if this is needed, as Shawn explained earlier
> rounds of loose-objects safety work.

I think we need this fix.  We still have a race condition between
the loose object creation and the ref update.

We've closed this hole completely in the large push case (objects
>=receive.unpackLimit) and 'fetch -k' case by creating .keep files
before the .pack file, updating refs, then deleting the .keep file;
and by making sure git-repack leaves packs with .keeps alone.  So
we cannot lose an object here.

But update-index/add/merge-recursive/write-tree/commit-tree, etc.
as well as small pushes (objects <receive.unpackLimit) and fetch
without -k option still have a race condition.  The objects will
be created/unpacked into the loose objects directory with nothing
referencing them, and a prune which gets to run just before before
the ref update becomes visible would probably whack those objects.

Given that 'git gc' is the encouraged way to maintain a repository,
and that 'repack -a -d' is safe, and prune-packed is equally safe,
I think we should try to make prune safe too.  Matthias' patch
does this by giving the ref update process a fairly large window
to perform its action within.
 
> If this is something we would want, it might make sense if we
> allowed "prune --expire='1.day'" syntax ;-).

Yes, I agree.

Matthias you can take a look at builtin-reflog.c's argument handling
for an example.  I think you just need to use approxidate() in both
your config function and in your command line argument handling.
Then the default becomes '2.hours.ago' instead of just "2" (at
least from a documentation perspective).

Though the more I think about this perhaps the default should be
'1.day'.  24 hours is a hellva large window for any current ref
update to complete in, even if the ref update was some massive rsync
which is doing a such a large volume of data on a small bandwidth
link that it takes 20 hours to complete.  Besides, users could
always force it to be much lower with the command line option if
they really need to prune _right_now_.

-- 
Shawn.
