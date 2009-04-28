From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT RFC PATCH 2/2] Rewrite WindowCache to be easier to
	follow and maintain
Date: Tue, 28 Apr 2009 16:30:48 -0700
Message-ID: <20090428233048.GY23604@spearce.org>
References: <1240885572-1755-1-git-send-email-spearce@spearce.org> <1240885572-1755-2-git-send-email-spearce@spearce.org> <200904290120.00039.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 01:31:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LywlT-0007Ep-LG
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 01:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081AbZD1Xat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 19:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753915AbZD1Xat
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 19:30:49 -0400
Received: from george.spearce.org ([209.20.77.23]:38618 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596AbZD1Xas (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 19:30:48 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 482DC38221; Tue, 28 Apr 2009 23:30:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200904290120.00039.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117836>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> tisdag 28 april 2009 04:26:12 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> > To keep the code simple a WindowCache.reconfigure() now discards the
> > entire current cache, and creates a new one.  That invalidates every
> > open file, and every open ByteWindow, and forces them to load again.
> > 
> > reconfigure is no longer a thread safe operation, as there is no easy
> > way to lock out other threads while the cache change is taking place.
> > I don't think cache reconfigurations occur frequently enough in
> > application code that we can justify the additional overhead required
> > by a multi-reader/single-writer lock around every cache access.
> > Instead, the Javadoc is updated to warn application authors against
> > changing this on the fly.
> 
> As for non-thread-safe reconfigure, we have to solve it somehow since
> I'd expect to be able to reconfigure the cache in Eclipse. Forcing a restart might
> be an ok workaround for that particular case. Could one somehow, thread safely, 
> let the old cache live on until no-one uses it and the GC takes care of it, and 
> redirect new accesses to the new cache.

I think I've fixed it with a subsequent patch, see "Better handle
concurrent reads during a WindowCache reconfiguration" sent out a
few hours ago.
 
> > diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java
> > index 5dc3d28..6b96b10 100644
> > --- a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java
> > +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java
> ...
> > @@ -98,26 +87,4 @@ void inflateVerify(final byte[] array, final int pos, final Inflater inf)
> >  		while (!inf.finished() && !inf.needsInput())
> >  			inf.inflate(verifyGarbageBuffer, 0, verifyGarbageBuffer.length);
> >  	}
> 
> Not related to this patche really, but the static buffer makes a but nervous,
> I don't think your test massaged  that part since it did not enable memory mapping.

This is old code, and isn't changed either way.

It isn't just memory mapping vs. not memory mapping, this same sort
of code is in ByteBufferWindow too.

Though now that you mention it, I'm recalling something about how
libz might try to read the output buffer when producing more output,
in which case this code is not thread safe.  I wish I could remember.

We may want to just do a follow-up patch that creates a temporary
byte[] within the WindowCursor for this verifyGarbageBuffer and
pass that down through here instead.

I'll consider it.
 
> > diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java
> > +	OffsetCache(final int tSize, final int lockCount) {
> ...
> > +		int eb = (int) (tableSize * .1);
> > +		if (64 < eb)
> > +			eb = 64;
> > +		else if (eb < 4)
> > +			eb = 4;
> 			^no coverage in unit testt
> > +		if (tableSize < eb)
> > +			eb = tableSize;
> 			^no coverage in unit testt

Blargh.  My EclEmma installation is busted so I couldn't run it
through coverage.  I just beat the tar out of it for 12 hours.

I'll try to fix EclEmma tomorrow and increase coverage around the
new code.

-- 
Shawn.
