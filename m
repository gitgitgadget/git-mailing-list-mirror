From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] basic threaded delta search
Date: Thu, 06 Sep 2007 10:48:06 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0709061014280.21186@xanadu.home>
References: <11890591912193-git-send-email-nico@cam.org>
 <11890591923123-git-send-email-nico@cam.org>
 <11890591923270-git-send-email-nico@cam.org>
 <1189059193250-git-send-email-nico@cam.org>
 <7vwsv4cm6b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 16:48:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITIel-0002UA-Q8
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 16:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbXIFOs1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 10:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753043AbXIFOs1
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 10:48:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46930 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbXIFOs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 10:48:26 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JNY00G5RBS8NR30@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 06 Sep 2007 10:48:09 -0400 (EDT)
In-reply-to: <7vwsv4cm6b.fsf@gitster.siamese.dyndns.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57886>

On Thu, 6 Sep 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > this is still rough, hence it is disabled by default.  You need to compile
> > with "make THREADED_DELTA_SEARCH=1 ..." at the moment.
> >
> > Threading is done on different portions of the object list to be
> > deltified. This is currently done by spliting the list into n parts and
> > then a thread is spawned for each of them.  A better method would consist
> > of spliting the list into more smaller parts and have the n threads
> > pick the next part available.
> 
> Hmmm.  I wonder how the result is affected by such a partition;
> aren't you going to have many objects that could have used
> somebody else as a delta but gets stored as base because they
> happen to be a very early part of their partition (and lacking
> delta base candidates in the window)?  

Yes.  On a largish repo that shouldn't be significant though, not worse 
than repacking multiple packs into one without -f.

> You cannot solve it with
> overlapping partitions without busting the depth limit easily
> either, I suspect.

My plan is to call find_deltas() again over partition boundaries after 
adjacent partitions have been processed.  If delta_child is properly 
maintained in all cases (trivial) then this should just work.

> Also how would this interact with the LRU
> delta base window we discussed a week or two ago?

This is completely orthogonal.

> Separating the list into different object types would not have
> any adverse impact coming from the "horizon" of delta base
> candidates window (because we do not deltify across types), but
> that is not very useful because we cannot gain much parallerism
> from such a partition.

Indeed.  Even with a straight split with equal number of objects, some 
threads currently complete much faster than others.  This is why a more 
sophisticated distribution of work is still needed to keep the desired 
amount of threads busy all the time.


Nicolas
