From: Nicolas Pitre <nico@cam.org>
Subject: Re: Something is broken in repack
Date: Sun, 09 Dec 2007 20:07:49 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712092002170.555@xanadu.home>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
 <alpine.LFD.0.99999.0712072032410.555@xanadu.home>
 <7vodd0vnhv.fsf@gitster.siamese.dyndns.org>
 <7vprxgs36w.fsf@gitster.siamese.dyndns.org>
 <9e4733910712091025s27c3d698yba78eed4306cd3ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 02:08:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1X8O-0007k2-1U
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 02:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbXLJBIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 20:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbXLJBIL
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 20:08:11 -0500
Received: from relais.videotron.ca ([24.201.245.36]:48421 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbXLJBIK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 20:08:10 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JST00B9M751O7X0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 09 Dec 2007 20:07:49 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910712091025s27c3d698yba78eed4306cd3ec@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67667>

On Sun, 9 Dec 2007, Jon Smirl wrote:

> On 12/9/07, Junio C Hamano <gitster@pobox.com> wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > > Nicolas Pitre <nico@cam.org> writes:
> > >
> > >> On Fri, 7 Dec 2007, Jon Smirl wrote:
> > >>
> > >>> Starting with a 2GB pack of the same data my process size only grew to
> > >>> 3GB with 2GB of mmaps.
> > >>
> > >> Which is quite reasonable, even if the same issue might still be there.
> > >>
> > >> So the problem seems to be related to the pack access code and not the
> > >> repack code.  And it must have something to do with the number of deltas
> > >> being replayed.  And because the repack is attempting delta compression
> > >> roughly from newest to oldest, and because old objects are typically in
> > >> a deeper delta chain, then this might explain the logarithmic slowdown.
> > >>
> > >> So something must be wrong with the delta cache in sha1_file.c somehow.
> > >
> > > I was reaching the same conclusion but haven't managed to spot anything
> > > blatantly wrong in that area.  Will need to dig more.
> >
> > Does this problem have correlation with the use of threads?  Do you see
> > the same bloat with or without THREADED_DELTA_SEARCH defined?
> >
> 
> Something else seems to be wrong.
> 
> With threading turned off,  5000 CPU seconds and 13% done.
> With threading turned on, threads = 1, 5000 CPU seconds, 13%
> With threading turned on, threads = 2, 180 CPU seconds, 13%
> With threading turned on, threads = 4, 150 CPU seconds, 13%
> 
> This can't be right, four cores are not 40x one core.

It may be right.  The object list to apply delta compression on doesn't 
necessarily require a uniform amount of cycles throughout.  When using 
multiple threads, the list is broken in parts for each thread, and later 
parts might end up being simply much easier to process, therefore 
changing the percentage figure.

> So maybe the observed logarithmic slow down is because the percent 
> complete is being reported wrong in the threaded case. If that's the 
> case we may be looking in the wrong place for problems.

I really doubt it.


Nicolas
