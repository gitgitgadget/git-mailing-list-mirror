From: Nicolas Pitre <nico@cam.org>
Subject: Re: performance on repack
Date: Thu, 16 Aug 2007 11:34:19 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0708161103080.16727@xanadu.home>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
 <20070812103338.GA7763@auto.tuwien.ac.at>
 <9e4733910708120649g5a5e0f48pa71bd983f2bc2945@mail.gmail.com>
 <20070814031236.GC27913@spearce.org>
 <alpine.LFD.0.999.0708141634160.5415@xanadu.home>
 <20070815053231.GJ27913@spearce.org>
 <9e4733910708150808x39241071j1a4012f16cd26ef8@mail.gmail.com>
 <20070815171152.GA15155@auto.tuwien.ac.at>
 <9e4733910708151138x2b267dc6w27c1bc8d948e5633@mail.gmail.com>
 <alpine.LFD.0.999.0708151453390.5415@xanadu.home>
 <86d4xn5287.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 16 17:34:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILhMe-000220-Ll
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 17:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760066AbXHPPeX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 11:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760174AbXHPPeW
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 11:34:22 -0400
Received: from relais.videotron.ca ([24.201.245.36]:38524 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760066AbXHPPeV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 11:34:21 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JMV00DYCHX7GH50@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 16 Aug 2007 11:34:20 -0400 (EDT)
In-reply-to: <86d4xn5287.fsf@lola.quinscape.zz>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56019>

On Thu, 16 Aug 2007, David Kastrup wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Wed, 15 Aug 2007, Jon Smirl wrote:
> >
> >> On 8/15/07, Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> >> > git-pack-objects knows the order, in which it will use the objects.  A
> >> > seperate thread could pre-read the next object and wait until the main
> >> > thread starts processing it. After the read is complete, another
> >> > thread could start computing the delta index.
> >> 
> >> The hope is that the new adaptive read ahead code in the kernel will
> >> get this right and you won't need the second thread. Letting the
> >> kernel handle the read ahead will dynamically scale as other demands
> >> are made on the host. There's effectively only one read ahead cache in
> >> the system, only the kernel really knows how to divide it up between
> >> competing apps.
> >
> > No read ahead will ever help the delta search phase.
> 
> Well, the delta search phase consists of computing a delta index and
> then matching against it.

No, what I mean is what happens at a higher level where one object is 
deltified against several base object candidates to find the best match.  
Those several objects are presorted according to a combination of 
heuristics that makes their actual access completely random, hence no 
kernel read ahead might help here.

> If I understand correctly, delta indices
> for the search window are kept, and the current file is compared
> against them.  Locality might be better if just one delta index gets
> calculated and then compared with all _upcoming_ delta candidates in
> one go.

This appears so obvious that I attempted that a while ago already.

The idea turned up to be so complex to implement correctly and produced 
suboptimal results in practice that I abandoned it.

See http://marc.info/?l=git&m=114610715706599&w=2 for the details if 
you're interested.

PS: please at least CC me when replying to my mails


Nicolas
