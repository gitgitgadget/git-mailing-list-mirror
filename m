From: Nicolas Pitre <nico@cam.org>
Subject: Re: block-sha1: improve code on large-register-set machines
Date: Tue, 11 Aug 2009 17:36:58 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908111735010.10633@xanadu.home>
References: <alpine.LFD.2.01.0908101637440.3417@localhost.localdomain>
 <alpine.LFD.2.00.0908102246210.10633@xanadu.home>
 <alpine.LFD.2.01.0908110758160.3417@localhost.localdomain>
 <alpine.LFD.2.00.0908111254290.10633@xanadu.home>
 <alpine.LFD.2.00.0908111517390.10633@xanadu.home>
 <fLYKSyures_wcvAvAV9-MgKQlhk959HJpx-pKz7T1n-Mel7f2RBkMw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Aug 11 23:37:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Maz2C-0007m4-Rd
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 23:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515AbZHKVhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 17:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753915AbZHKVhX
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 17:37:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:42597 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbZHKVhW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 17:37:22 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KO800JVMEPMMIK1@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 11 Aug 2009 17:36:58 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <fLYKSyures_wcvAvAV9-MgKQlhk959HJpx-pKz7T1n-Mel7f2RBkMw@cipher.nrlssc.navy.mil>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125604>

On Tue, 11 Aug 2009, Brandon Casey wrote:

> Nicolas Pitre wrote:
> > On Tue, 11 Aug 2009, Nicolas Pitre wrote:
> > 
> >> On Tue, 11 Aug 2009, Linus Torvalds wrote:
> >>
> >>> On Tue, 11 Aug 2009, Nicolas Pitre wrote:
> >>>> #define SHA_SRC(t) \
> >>>>   ({ unsigned char *__d = (unsigned char *)&data[t]; \
> >>>>      (__d[0] << 24) | (__d[1] << 16) | (__d[2] << 8) | (__d[3] << 0); })
> >>>>
> >>>> And this provides the exact same performance as the ntohl() based 
> >>>> version (4.980s) except that this now cope with unaligned buffers too.
> >>> The actual object SHA1 calculations are likely not aligned (we do that 
> >>> object header thing), and if you can't do the htonl() any better way I 
> >>> guess the byte-based thing is the way to go..
> > 
> > OK, even better: 4.400s.
> > 
> > This is with this instead of the above:
> > 
> > #define SHA_SRC(t) \
> >    ({   unsigned char *__d = (unsigned char *)data; \
> >         (__d[(t)*4 + 0] << 24) | (__d[(t)*4 + 1] << 16) | \
> >         (__d[(t)*4 + 2] <<  8) | (__d[(t)*4 + 3] <<  0); })
> > 
> > The previous version would allocate a new register for __d and then 
> > index it with an offset of 0, 1, 2 or 3.  This version always uses the 
> > register containing the data pointer with absolute offsets.  The binary 
> > is a bit smaller too.
> 
> In that case, why not change the interface of blk_SHA1Block() so that its
> second argument is const unsigned char* and get rid of __d and the { } ?

Because not all architectures care to access the data bytewise.  Please 
see the original SHA_SRC definition.


Nicolas
