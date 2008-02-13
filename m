From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] pack-objects: only throw away data during memory pressure
Date: Tue, 12 Feb 2008 20:48:06 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802122025490.2732@xanadu.home>
References: <120271478556-git-send-email-mkoegler@auto.tuwien.ac.at>
 <alpine.LFD.1.00.0802110942310.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Brian Downing <bdowning@lavos.net>
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 02:48:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP6jt-0003qS-FZ
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 02:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbYBMBsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 20:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753341AbYBMBsJ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 20:48:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:19436 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbYBMBsI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 20:48:08 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW500FADMC6BIF0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 12 Feb 2008 20:48:07 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.1.00.0802110942310.2732@xanadu.home>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73734>

On Mon, 11 Feb 2008, Nicolas Pitre wrote:

> On Mon, 11 Feb 2008, Martin Koegler wrote:
> 
> > If pack-objects hit the memory limit, it deletes objects from the delta
> > window.
> > 
> > This patch make it only delete the data, which is recomputed, if needed again.
> > 
> > Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> 
> Looks fine.
> 
> Acked-by: Nicolas Pitre <nico@cam.org>

Well, I take that back.

Some testing on the OOO repository with this turns out to be 
completely unusable.

By the time this gets into action and data is actively thrown away, 
performance simply goes down the drain due to the data constantly being
reloaded over and over and over and over and over and over again, to the 
point of virtually making no relative progress at all.

So this change is not actually helping anything.  The previous behavior 
of enforcing the memory limit by dynamically shrinking the window size 
at least had the effect of allowing some kind of progress, even if the 
end result wouldn't be optimal.

And that's the whole point behind this memory limiting feature: allowing 
some progress to be made when resources are too limited to let the 
repack go unbounded.

Therefore I think commit 9c2174350cc0ae0f6bad126e15fe1f9f044117ab should 
be reverted.


Nicolas
