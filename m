From: Nicolas Pitre <nico@cam.org>
Subject: Re: Continue git clone after interruption
Date: Fri, 21 Aug 2009 23:37:31 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908212324130.6044@xanadu.home>
References: <1250509342.2885.13.camel@cf-48>
 <200908200937.05412.jnareb@gmail.com>
 <alpine.LFD.2.00.0908201358010.6044@xanadu.home>
 <200908211207.38555.jnareb@gmail.com>
 <alpine.LFD.2.00.0908211614220.6044@xanadu.home>
 <1250896025.19039.7.camel@maia.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	Tomasz Kontusz <roverorna@gmail.com>,
	git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sat Aug 22 05:37:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MehQG-00087h-OZ
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 05:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933221AbZHVDhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 23:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933219AbZHVDhg
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 23:37:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:59660 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933218AbZHVDhf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 23:37:35 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOR009XJE2JFF20@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 21 Aug 2009 23:37:32 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1250896025.19039.7.camel@maia.lan>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126781>

On Sat, 22 Aug 2009, Sam Vilain wrote:

> On Fri, 2009-08-21 at 17:07 -0400, Nicolas Pitre wrote:
> > > 2. There is support in git pack format to do 'deepening' of shallow
> > >    clone, which means that git can generate incrementals in top-down
> > >    order, _similar to how objects are ordered in packfile_.
> > 
> > Well... the pack format was not meant for that "support".  The fact
> > that 
> > the typical object order used by pack-objects when serving fetch
> > request 
> > is amenable to incremental top-down updates is rather coincidental
> > and 
> > not really planned.
> 
> Mmm.  And the problem with 'thin' packs is that they normally allow
> deltas the other way.

Sure.  The pack format is flexible.

> I think the first step here would be to allow thin pack generation to
> accept a bounded range of commits, any of the objects within which may
> be used as delta base candidates.  That way, these "top down" thin packs
> can be generated.  Currently of course it just uses the --not and makes
> "bottom up" thin packs.

The pack is still almost top-down.  It's only the missing delta base 
that are in the other direction, refering to objects you have locally 
and therefore older.

> > > Another solution would be to try to come up with some sort of stable
> > > sorting of objects so that packfile generated for the same
> > > parameters (endpoints) would be always byte-for-byte the same.  But
> > > that might be difficult, or even impossible.
> >
> > And I don't want to commit to that either.  Having some flexibility
> > in object ordering makes it possible to improve on the packing
> > heuristics.
> 
> You don't have to lose that for storage.  It's only for generating the
> thin packs that it matters;

What matters?

> also, the restriction is relaxed when it
> comes to objects which are all being sent in the same pack, which can
> freely delta amongst themselves in any direction.

That's always the case within a pack, but only for REF_DELTA objects.  
The OFS_DELTA objects have to be ordered. And yes, having deltas across 
packs is disallowed to avoid cycles and to keep the database robust.  
The only exception is for thin packs, but those are never created on 
disk. Thin packs are only used for transport and quickly "fixed" upon 
reception by appending the missing objects to them so they are not 
"thin" anymore.

> What did you think about the bundle slicing stuff?

If I didn't comment on it already, then I probably missed it and have no 
idea.


Nicolas
