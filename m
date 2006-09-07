From: Nicolas Pitre <nico@cam.org>
Subject: Re: A look at some alternative PACK file encodings
Date: Wed, 06 Sep 2006 22:30:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609062221490.18635@xanadu.home>
References: <44FF41F4.1090906@gmail.com>
 <9e4733910609061623k73086dbey4a600ecf2852c024@mail.gmail.com>
 <Pine.LNX.4.64.0609062037560.18635@xanadu.home>
 <9e4733910609061759m2aae9e31ja146e309dc449628@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: gitzilla@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 04:31:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL9fj-0001ES-4V
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 04:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422665AbWIGCbP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 22:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422668AbWIGCbP
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 22:31:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34124 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1422665AbWIGCbO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 22:31:14 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J57002NLAZNTKQ3@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 06 Sep 2006 22:30:59 -0400 (EDT)
In-reply-to: <9e4733910609061759m2aae9e31ja146e309dc449628@mail.gmail.com>
X-X-Sender: nico@xanadu.home
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26586>

On Wed, 6 Sep 2006, Jon Smirl wrote:

> On 9/6/06, Nicolas Pitre <nico@cam.org> wrote:
> > On Wed, 6 Sep 2006, Jon Smirl wrote:
> >
> > > Shawn is doing some prototype work on true dictionary based
> > > compression. I don't know how far along he is but it has potential for
> > > taking 30% off the Mozilla pack.
> >
> > BTW I'm half-way done with support for deltas which base object is
> > referenced with an offset in the pack instead of a hash.  It is quite
> > messy though since it touches pretty core code all over the place when
> > it comes to fetching objects out of a pack.
> 
> Would it help to change all of the references in the pack from sha1 to
> encoded relative offsets? Then collect all of the object fetch code
> into a single subroutine which would change it algorithm depending on
> which type of pack it is operating on. Now the pack wouldn't mix
> reference types, they would all be encoded relative or sha1.

No.  The problem is more about sha1_file.c using a mix of sha1 refs 
and/or pack,offset tuples to reference deltas.  I converted most of them 
to pack,offset tuples.  This also has a mnice side effect of having less 
stack usage when recursing down a delta chain.

When a delta with sha1 reference is encountered the code turns that 
reference into the appropriate offset with a binary search in the pack 
index.  When a delta with offset reference is encountered then no search 
in the index is needed.

This is not really complicated but only spread all over so that the 
diffstat is a bit scary.


Nicolas
