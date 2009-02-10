From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: fact-import: failed to apply delta
Date: Tue, 10 Feb 2009 13:25:39 -0800
Message-ID: <20090210212539.GV30949@spearce.org>
References: <alpine.LNX.1.00.0902092218050.19665@iabervon.org> <alpine.DEB.1.00.0902101126040.10279@pacific.mpi-cbg.de> <20090210155626.GM30949@spearce.org> <alpine.LNX.1.00.0902101118110.19665@iabervon.org> <20090210172212.GR30949@spearce.org> <alpine.LNX.1.00.0902101226580.19665@iabervon.org> <20090210191220.GT30949@spearce.org> <alpine.LNX.1.00.0902101427300.19665@iabervon.org> <20090210201203.GU30949@spearce.org> <alpine.LNX.1.00.0902101520240.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 22:27:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX08J-0003Yh-B1
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 22:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755342AbZBJVZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 16:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755287AbZBJVZk
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 16:25:40 -0500
Received: from george.spearce.org ([209.20.77.23]:47766 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585AbZBJVZj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 16:25:39 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2174438210; Tue, 10 Feb 2009 21:25:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0902101520240.19665@iabervon.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109316>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> 
> I think maybe there's aliasing in the delta base cache? If it recycled a 
> struct packed_git, the cache would come up with a cached tree at offset 12 
> of the packed_git at that address, but the pack used by that struct has 
> changed.

Yup, that must be it.
 
> I don't see any reason that the situation couldn't arise where you start a
> pack, look up an object in it while it's still open but the object isn't 
> in the window, cache the delta base, end that packfile, eventually start a 
> packfile that gets allocated in the space that was freed, produce a new 
> delta against the object at exactly the same offset of the new pack (with 
> the same address as the old pack), and go on happily until you try looking 
> up this last delta and pull the wrong base out of the cache.
> 
> I don't see any code to flush the delta cache ever, but it's hard to get a 
> new packed_git allocated at the address of a freed one, except by doing a 
> lot of checkpoints in fast-import...

*ouch*.  I think you found it.

We should dump the cached_objects table in sha1_file.c during
a checkpoint in fast-import.

-- 
Shawn.
