From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/3] Lazily open pack index files on demand
Date: Mon, 28 May 2007 13:13:19 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705281242210.11491@xanadu.home>
References: <20070526052419.GA11957@spearce.org>
 <7vabvsm1h8.fsf@assigned-by-dhcp.cox.net>
 <56b7f5510705261031o311b89bapd730374cbc063931@mail.gmail.com>
 <20070527033429.GY28023@spearce.org>
 <alpine.LFD.0.99.0705271110550.3366@xanadu.home>
 <20070527215245.GD28023@spearce.org>
 <alpine.LFD.0.99.0705271929480.3366@xanadu.home>
 <alpine.LFD.0.98.0705280907290.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Dana How <danahow@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon May 28 19:13:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hsimg-0006aw-Kx
	for gcvg-git@gmane.org; Mon, 28 May 2007 19:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbXE1RNX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 13:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbXE1RNX
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 13:13:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:54682 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbXE1RNW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 13:13:22 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIR00AE1H67F8C0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 28 May 2007 13:13:20 -0400 (EDT)
In-reply-to: <alpine.LFD.0.98.0705280907290.26602@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48627>

On Mon, 28 May 2007, Linus Torvalds wrote:

> On Sun, 27 May 2007, Nicolas Pitre wrote:
> > 
> > It helps irrespective of the number of pack files.  With the current 
> > binary search the lookup cost is O(log n).  With a Newton method this 
> > cost is almost O(1).
> 
> This is not true.
> 
> First off, when comparing O(logn) to O(1), with "n" being less than a 
> billion, they are pretty much exactly the same. Think of it this way: 
> O(logn) == O(9) == O(1), if you know that n < 10**9.

Agreed.

> Secondly, the cost of Newton isn't "almost O(1)". I don't know _what_ it 
> is (the rule of thumb with Newton-Raphson should be that the number of 
> significant correct digits in the answer doubles with each iteration: I 
> think that probably means that it should approximate O(loglog(n)), but I 
> haven't thought deeply about it.

Sure.  But given the reasoning you gave above for O(log N) being about 
the same as O(1) for a small enough N, I think that O(log log N) is even 
closer to O(1) in that regard.

> And the thing is, Newton-Raphson didn't actually speed anything up in my 
> tests. Sometimes it was better, sometimes it was worse, most of the time 
> it was in the noise.

OK I didn't remember the difference was so unconclusive.
The constant cost is certainly a big factor in the equation.

Maybe we didn't test with a big enough repo yet (big in the sense of 
number of objects) to see the variable cost actually dominate.

Did you try with the KDE repo at the time?  It has over 4M objects.
The binary search would require 14 itterations while the Newton search 
should take around 3 or 4 itterations if the log O(log N) esttimate is 
right.  Of course the evaluation of the next mid point is more costly 
with the Newton method.


Nicolas
