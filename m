From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] builtin-pack-objects: don't fail, if delta is not possible
Date: Mon, 28 May 2007 22:53:49 -0400
Message-ID: <20070529025349.GD7044@spearce.org>
References: <11803872591522-git-send-email-mkoegler@auto.tuwien.ac.at> <alpine.LFD.0.99.0705282243280.11491@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue May 29 04:54:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hsrqk-0001wY-ED
	for gcvg-git@gmane.org; Tue, 29 May 2007 04:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbXE2CyK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 22:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbXE2CyK
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 22:54:10 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36347 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbXE2CyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 22:54:09 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hsrq7-0007St-LQ; Mon, 28 May 2007 22:53:39 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1896F20FBAE; Mon, 28 May 2007 22:53:50 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99.0705282243280.11491@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48660>

Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 28 May 2007, Martin Koegler wrote:
> 
> > If builtin-pack-objects runs out of memory while finding
> > the best deltas, it bails out with an error.
> > 
> > If the delta index creation fails (because there is not enough memory),
> > we can downgrade the error message to a warning and continue with the
> > next object.
> 
> In the same vain, there is one realloc() that was turned into a 
> xrealloc() in diff-delta.c.  I think this was a mistake and should 
> probably be a non fatal realloc again to let the caller go on.

And if those two calls fail to alloc their memory, they might want
to try calling the pack window gc thingy (release_pack_memory(need,
-1)) and then retry the alloc before they fail the delta generation.
Its possible that we are better off releasing the LRU pack window
and produce the delta, then to fail because we're hanging onto some
mmap we don't need...

And actaully release_pack_memory could get more aggressive now that
the index_data can be lazily loaded.  We could actually unload LRU
indexes too.

-- 
Shawn.
