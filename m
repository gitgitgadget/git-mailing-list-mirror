From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Prevent megablobs from gunking up git packs
Date: Thu, 24 May 2007 20:55:07 -0400
Message-ID: <20070525005507.GR28023@spearce.org>
References: <46528A48.9050903@gmail.com> <7v7iqz19d2.fsf@assigned-by-dhcp.cox.net> <56b7f5510705231655o589de801w88adc1aa6c18162b@mail.gmail.com> <7vps4ryp02.fsf@assigned-by-dhcp.cox.net> <20070524071235.GL28023@spearce.org> <Pine.LNX.4.64.0705241020450.21766@asgard.lang.hm> <Pine.LNX.4.64.0705241828160.4648@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@lang.hm, Junio C Hamano <junkio@cox.net>,
	Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 25 02:55:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrO5O-0008Hn-Rb
	for gcvg-git@gmane.org; Fri, 25 May 2007 02:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbXEYAzP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 20:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752046AbXEYAzP
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 20:55:15 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57679 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbXEYAzO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 20:55:14 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HrO54-0004Py-NM; Thu, 24 May 2007 20:54:58 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B47CB20FBAE; Thu, 24 May 2007 20:55:07 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705241828160.4648@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48320>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 24 May 2007, david@lang.hm wrote:
> > On Thu, 24 May 2007, Shawn O. Pearce wrote:
> > 
> > > Now #3 is actually really important here.  Don't forget that we
> > > *just* disabled the fancy "new loose object format".  It doesn't
> > > exist.  We can read the packfile-like loose objects, but we cannot
> > > write them anymore.  So lets say we explode a megablob into a loose
> > > object, and its 800 MiB by itself.  Now we have to send that object
> > > to a client.  Yes, that's right, we must *RECOMPRESS* 800 MiB for
> > > no reason.  Not the best choice.  Maybe we shouldn't have deleted
> > > that packfile formatted loose object writer...
> > 
> > when did the object store get changed so that loose objects aren't
> > compressed?
> 
> That never happened. But we had a different file format for loose objects, 
> which was meant to make it easier to copy as-is into a pack. That file 
> format went away, since it was not as useful as we hoped.

That "different file format" thing was added exactly for this type
of problem.  Someone added a bunch of large blobs to their repository
and then spent a lot of time decompressing and recompressing them
during their next repack.

The reason that recompress must happen is the deflate stream in a
standard (aka legacy) loose object contains both the Git object
header and the raw data; in a packfile the Git object header is
stored external from the deflate stream.  The "different file format"
used the packfile format, allowing us to store the Git object header
external from the deflate stream.  That meant we could just copy
the raw bytes as-is from the loose object into the packfile.

So we still store loose objects compressed, its just that we can
no longer create loose objects that can be copied directly into
a packfile without recompression.  And that is sort of Dana's
problem here.  OK, not entirely, but whatever.

-- 
Shawn.
