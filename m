From: Jeff King <peff@peff.net>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 18:10:07 -0400
Message-ID: <20070403221006.GA17948@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org> <alpine.LFD.0.98.0704031625050.28181@xanadu.home> <Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org> <20070403210319.GH27706@spearce.org> <Pine.LNX.4.64.0704031411320.6730@woody.linux-foundation.org> <20070403211709.GJ27706@spearce.org> <alpine.LFD.0.98.0704031730300.28181@xanadu.home> <20070403213710.GK27706@spearce.org> <7vvegduo9e.fsf@assigned-by-dhcp.cox.net> <20070403215342.GL27706@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Lee <clee@kde.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 00:10:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYrCh-0007bk-Qn
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 00:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753694AbXDCWKM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 18:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753696AbXDCWKM
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 18:10:12 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1341 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753694AbXDCWKK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 18:10:10 -0400
Received: (qmail 5114 invoked from network); 3 Apr 2007 22:10:43 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 3 Apr 2007 22:10:43 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Apr 2007 18:10:07 -0400
Content-Disposition: inline
In-Reply-To: <20070403215342.GL27706@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43679>

On Tue, Apr 03, 2007 at 05:53:42PM -0400, Shawn O. Pearce wrote:

> > If that is the only reason we have these reprepare_packed_git()
> > sprinkled all over in sha1_file.c (by 637cdd9d), perhaps we
> > should rethink that.  Is there a cheap way to trigger these
> > rescanning only when a prune-packed is in progress, I wonder...
> 
> Yea, it is the only reason.  So... if we could have some
> magic to trigger that, it would be good.  I just don't
> know what magic that would be.

It doesn't have to be in progress; it might have started and completed
between pack-scanning and object lookup. Something like:

  1. start git-repack -a -d
  2. start git-rev-list, scan for packs
  3. repack moves finished pack into place, starts git-prune-packed
  4. git-prune-pack completes
  5. git-rev-list looks up object

So you would need to have some sort of incremented counter that says
"there's a new pack available."

Perhaps instead of rescanning unconditionally, it should simply stat()
the pack directory and look for a change? That should be much cheaper.

-Jeff
