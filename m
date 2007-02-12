From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Efficiency of initial clone from server
Date: Mon, 12 Feb 2007 00:11:08 -0500
Message-ID: <20070212051108.GB699@spearce.org>
References: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com> <20070211225326.GC31488@spearce.org> <9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com> <Pine.LNX.4.64.0702112022430.1757@xanadu.home> <7vd54gau3r.fsf@assigned-by-dhcp.cox.net> <9e4733910702112029k6ef3fb7bl3bdb134a787512e8@mail.gmail.com> <7v4ppsatbr.fsf@assigned-by-dhcp.cox.net> <9e4733910702112053q2c196ddcr970a062281d332b7@mail.gmail.com> <9e4733910702112101h256b1468j5de65c6e89109a22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 06:11:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGTTD-0005RO-Aj
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 06:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932990AbXBLFLQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 00:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932991AbXBLFLQ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 00:11:16 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33474 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932990AbXBLFLP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 00:11:15 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGTSr-0005Nb-T9; Mon, 12 Feb 2007 00:10:57 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D5D2B20FBAE; Mon, 12 Feb 2007 00:11:08 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <9e4733910702112101h256b1468j5de65c6e89109a22@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39365>

Jon Smirl <jonsmirl@gmail.com> wrote:
> But pack to the original point, can't the server check and see if it
> has write access so that it can keep the fully packed tree? I've just
> caused kernel.org to needlessly repack the wireless-dev tree a dozen
> times playing with this clone command. If it didn't have to keep
> repacking for the clone, clone would be a lot faster.

We probably could.

I have actually been thinking about another problem that is
somewhat related.  We cannot put more than 4 GiB of data into a
single packfile, due to the current index size limitation, or more
than 2^32-1 objects into one packfile, due to the header nr_objects
field size.

Right now we are sending a single packfile down to the client,
even if the remote server end has the repository broken down into
a couple of packfiles (such as "really old historical stuff" and
"active stuff from this year").  If we could send more than one
packfile to the client in a single stream, we could still keep the
file size limitations.

We can also avoid this huge repack case on the server.  Because it
could just send all of the packfiles that it already has, followed
by whatever is loose which wasn't in a prior packfile.  And no
write access required.

Of course, we still could do the optimization of caching the
packfile, but I'm not sure how well that would work on kernel.org,
as I understand the trees are owned by the devs which created them
while the git daemon is probably not running as their UNIX user.

-- 
Shawn.
