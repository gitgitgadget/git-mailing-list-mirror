From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 2/2] Allow core.packedGitLimit to exceed "2 g"
Date: Sat, 13 Jun 2009 12:19:43 -0700
Message-ID: <20090613191943.GS16497@spearce.org>
References: <1244848986-10526-1-git-send-email-spearce@spearce.org> <1244848986-10526-2-git-send-email-spearce@spearce.org> <4A335B9A.7080808@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Ferry Huberts <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Sat Jun 13 21:20:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFYll-0005t4-Lw
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 21:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755703AbZFMTTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 15:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754683AbZFMTTm
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 15:19:42 -0400
Received: from george.spearce.org ([209.20.77.23]:54554 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758179AbZFMTTk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 15:19:40 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 68398381FD; Sat, 13 Jun 2009 19:19:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4A335B9A.7080808@pelagic.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121516>

Ferry Huberts <ferry.huberts@pelagic.nl> wrote:
> Shawn O. Pearce wrote:
> > A 64 bit JVM might actually be able to dedicate more than 2 GiB of

Please don't quote everything if you are only replying to a tiny
part.

> >  	private static int tableSize(final WindowCacheConfig cfg) {
> >  		final int wsz = cfg.getPackedGitWindowSize();
> > -		final int limit = cfg.getPackedGitLimit();
> > +		final long limit = cfg.getPackedGitLimit();
> >  		if (wsz <= 0)
> >  			throw new IllegalArgumentException("Invalid window size");
> >  		if (limit < wsz)
> >  			throw new IllegalArgumentException("Window size must be < limit");
> > -		return 5 * (limit / wsz) / 2;
> > +		return (int) Math.min(5 * (limit / wsz) / 2, 2000000000);
> 
> Math.min returns a long because the prototype Math.min(long,long) will
> be chosen. The cast can then overflow and fail. Better change the return
> type to a long:
> + return Math.min(5 * (limit / wsz) / 2, 2000000000L);

If you looked at that, 2,000,000,000 is within the range of an int.
We select the smallest value.  The first argument expression is
computed as a long, so we shouldn't ever overflow and cause the
first argument to be negative.  If the first argument is larger
than 2 billion, then it does risk overflow, but the 2nd argument
is smaller, so it is returned.

The code is fine as is.
 
-- 
Shawn.
