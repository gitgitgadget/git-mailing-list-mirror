From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] pack-objects: fix threaded load balancing
Date: Mon, 10 Dec 2007 11:14:44 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712101104320.555@xanadu.home>
References: <alpine.LFD.0.99999.0712080000120.555@xanadu.home>
 <9e4733910712092030j5cf7dfdcrb3a003fbce391422@mail.gmail.com>
 <9e4733910712092123r6987c3edua74a15890ae45a3d@mail.gmail.com>
 <9e4733910712092159s24cf5a7cx4610f797f61b1de5@mail.gmail.com>
 <9e4733910712092206o40e0c748s3796b95f637bf2b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 17:15:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1lHf-0005Bj-DS
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 17:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbXLJQOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 11:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbXLJQOp
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 11:14:45 -0500
Received: from relais.videotron.ca ([24.201.245.36]:63344 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbXLJQOp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 11:14:45 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSU00JOTD4JSTF0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 10 Dec 2007 11:14:43 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910712092206o40e0c748s3796b95f637bf2b3@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67727>

On Mon, 10 Dec 2007, Jon Smirl wrote:

> On 12/10/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > I just deleted the section looking for identical hashes.
> >
> > +                       while (sub_size && list[0]->hash &&
> > +                              list[0]->hash == list[-1]->hash) {
> > +                               list++;
> > +                               sub_size--;
> > +                       }
> >
> > Doing that allows the long chains to be split over the cores.
> >
> > My last 5% of objects is taking over 50% of the total CPU time in the
> > repack. I think these objects are the ones from that 103,817 entry
> > chain. It is also causing the explosion in RAM consumption.
> >
> > At the end I can only do 20 objects per clock second on four cores. It
> > takes 30 clock minutes (120 CPU minutes) to do the last 3% of objects.
> 
> It's all in create_delta...

Here you're mixing two different hashes with no relation what so ever 
with each other.

The hash in create_delta corresponds to chunk of data in a reference 
buffer that we try to match in a source buffer.

The hash in the code above has to do with the file names the 
corresponding objects are coming from.

And again, both hash uses are deterministic i.e. they will be the same 
when repacking with -f regardless if the source pack is the 2.1GB or the 
300MB one, so they may not explain the huge performance and memory usage 
discrepency you see between those two packs.

The code that do get influenced by the source pack, though, is all 
concentrated in sha1_file.c.


Nicolas
