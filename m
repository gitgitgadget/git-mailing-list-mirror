From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH v2] Custom compression levels for objects and packs
Date: Tue, 08 May 2007 21:23:25 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705082106590.24220@xanadu.home>
References: <4640FBDE.1000609@gmail.com>
 <7vk5vi27ko.fsf@assigned-by-dhcp.cox.net>
 <56b7f5510705081725v655d2ce1j28712507cfa7fa55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 03:23:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlauC-0006Uy-6i
	for gcvg-git@gmane.org; Wed, 09 May 2007 03:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968497AbXEIBXm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 21:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968535AbXEIBXm
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 21:23:42 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27473 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968497AbXEIBXm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 21:23:42 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHR005ER2J1BZ30@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 08 May 2007 21:23:29 -0400 (EDT)
In-reply-to: <56b7f5510705081725v655d2ce1j28712507cfa7fa55@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46650>

On Tue, 8 May 2007, Dana How wrote:

> Since max-pack-size has been out there since April 4 and
> the first acceptable version was May 1 (suggested by 0 comments),
> I didn't realize it was a "questionable series".
> 
> I think it should be straightforward for me to re-submit this
> based on current master.

Since this patch is simpler it could be merged much faster, before the 
pack limit series.

> > > +     /* differing core & pack compression when loose object -> must
> > recompress */
> > > +     if (!entry->in_pack && pack_compression_level !=
> > zlib_compression_level)
> > > +             to_reuse = 0;
> > > +     else
> > I am not sure if that is worth it, as you do not know if the
> > loose object you are looking at were compressed with the current
> > settings.
> You do not know for certain, that is correct.  However, config
> settings setting unequal compression levels signal that you
> care differently about the two cases. (For me,  I want the
> compression investment to correspond to the expected lifetime of the file.)
> Also,  *if* we have the knobs we want in the config file,
> I don't think we're going to be changing these settings all that often.
> 
> If I didn't have this check forcing recompression in the pack,
> then in the absence of deltification each object would enter the pack
> by being copied (in the preceding code block) and pack.compression
> would have little effect.  I actually experienced this the very first
> time I imported a large dataset into git (I was trying to achieve the
> effect of this patch by changing core.compression dynamically,  and
> was a bit mystified for a while by the result).
> 
> Thus,  if core.loosecompression is set to speed up git-add,  I should
> take the time to recompress the object when packing if pack.compression
> is different (of course the hit of not doing so will be lessened by
> deltification
> which forces a new compression).

Right.  And this also depends whether or not you have core.legacyheaders 
set to false or not.

And the whole purpose for setting core.legacyheaders is exactly to allow 
for loose objects to be copied straight into the pack.  This should have 
priority over mismatched compression levels IMHO.

Also, when repacking, delta reuse does not recompress objects for the 
same reason, regardless of the compression level used when they were 
compressed initially.  Same argument goes for delta depth.

So if you really want to ensure a compression level on the whole pack, 
you'll have to use -f with git-repack. Or leave core.legacyheaders 
unset.


Nicolas
