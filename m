From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFH] gcc constant expression warning...
Date: Sun, 28 Oct 2007 12:28:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710281204350.7345@iabervon.org>
References: <7vy7dnvd6w.fsf@gitster.siamese.dyndns.org> <87ir4rletv.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 17:29:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImB0t-0004PB-5T
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 17:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbXJ1Q3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 12:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbXJ1Q3C
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 12:29:02 -0400
Received: from iabervon.org ([66.92.72.58]:60780 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097AbXJ1Q3B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 12:29:01 -0400
Received: (qmail 12744 invoked by uid 1000); 28 Oct 2007 16:28:59 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Oct 2007 16:28:59 -0000
In-Reply-To: <87ir4rletv.fsf@mid.deneb.enyo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62569>

On Sun, 28 Oct 2007, Florian Weimer wrote:

> * Junio C. Hamano:
> 
> > The offending lines are:
> >
> >         if (idx_size != min_size) {
> >                 /* make sure we can deal with large pack offsets */
> >                 off_t x = 0x7fffffffUL, y = 0xffffffffUL;
> >                 if (x > (x + 1) || y > (y + 1)) {
> >                         munmap(idx_map, idx_size);
> 
> x and y must be unsigned for this test to work (signed overflow is
> undefined).

I believe the test is trying to determine if signed addition on numbers of 
a certain size is safe in this environment. Doing the test with unsigned 
variables would cause the test to give a predictable but irrelevant 
result. I think gcc is being annoying in assuming that signed overflow 
doesn't occur (even when it must), rather than assuming that the result of 
signed overflow is some arbitrary and likely not useful value. If we have 
an overflow possible with off_t in the way we'd use it, then one of those 
tests should be automatically true due to the limited size of the type 
(except that I think the test should be >= instead of >). I think we 
should be able to assume that the result of a signed overflow, whatever 
undefined value it is, is a possible value of its type and therefore not 
more than the maximum value of its type, but gcc may be screwing this up.

It's probably best just to test the size of off_t.

	-Daniel
*This .sig left intentionally blank*
