From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Support 64-bit indexes for pack files.
Date: Mon, 26 Feb 2007 19:31:18 -0500
Message-ID: <20070227003118.GH1639@spearce.org>
References: <200702261540.27080.ttelford.groups@gmail.com> <20070226235510.GF1639@spearce.org> <alpine.LRH.0.82.0702261916560.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Troy Telford <ttelford.groups@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 01:31:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLqFc-00085A-SZ
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 01:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbXB0Ab0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 19:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbXB0Ab0
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 19:31:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37737 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbXB0AbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 19:31:25 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HLqFK-0008SA-Tl; Mon, 26 Feb 2007 19:31:11 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3327020FBAE; Mon, 26 Feb 2007 19:31:19 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LRH.0.82.0702261916560.29426@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40678>

Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 26 Feb 2007, Shawn O. Pearce wrote:
> > The latter field is to help pack-objects reuse existing packfile
> > data, as today it needs to sort everything on its own on the fly.
> > Having that last field of data will help avoid that, and will keep
> > the index nicely aligned for 64-bit accesses to the offset.
> 
> Wouldn't that later field help the sliding mmap code as well, knowing in 
> advance what storage size a given object has? (I didn't look at the 
> sliding mmap code so I don't know).

Yes, it probably would.
 
> Actually I've been thinking about another format already.
> 
> What about keeping the pack offset as 32 bits like it is today, but for 
> index v2 if the top bit is set then this become an index into another 
> table containing 64-bit offsets as needed.  This way there is no waste 
> of space for most projects where the pack has yet to reach the 2GB limit 
> for many years to come.

Actually Troy's patch tries to do this by using the current format
and only switching to the new one if the packfile exceeds 4 GiB.
Rather smart.

One thought I had here was to expand the fan-out table from 1<<8
entries to 1<<16 entries, then store only the low 18 bytes of
the SHA-1.  We would have another 2 bytes worth of space to store
the offset, pushing our total offset up to 48 bits.

-- 
Shawn.
