From: Nicolas Pitre <nico@cam.org>
Subject: Re: index-pack died on pread
Date: Mon, 23 Jul 2007 14:03:45 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707231349160.6355@xanadu.home>
References: <333e1ca10707230552i34c2a1cfq9fae94f20023e9d7@mail.gmail.com>
 <alpine.LFD.0.999.0707230956390.3607@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Michal Rokos <michal.rokos@gmail.com>, GIT <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 20:04:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID2GR-0005Qn-OF
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 20:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763811AbXGWSDr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 14:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764200AbXGWSDr
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 14:03:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18327 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763531AbXGWSDq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 14:03:46 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JLN004IZ8U9KUP0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 23 Jul 2007 14:03:46 -0400 (EDT)
In-reply-to: <alpine.LFD.0.999.0707230956390.3607@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53454>

On Mon, 23 Jul 2007, Linus Torvalds wrote:

> 
> 
> On Mon, 23 Jul 2007, Michal Rokos wrote:
> >
> > fatal: cannot pread pack file: No such file or directory (n=0,
> > errno=2, fd=3, ptr=40452958, len=428, rdy=0, off=123601)
> 
> Ok, that's bogus. When "n" is zero, the errno (and thus the error string) 
> is not changed by pread, so that's a very misleading error report.
> 
> So what seems to have happened is that the pack-file is too short, so we 
> got a return value of 0, and then reported it as if it had an errno.
> 
> The reason for returning zero from pread would be:
> 
>  - broken pread. I don't think HPUX should be a problem, so that's 
>    probably not it.
> 
>  - the pack-file got truncated
> 
>  - the offset is corrupt, and points to beyond the size of the packfile.
> 
> In this case, since the offset is just 123601, I suspect it's a truncation 
> issue, and your pack-file is simply corrupt. Either because of some 
> problem with receiving it, or because of problems on the remote side.

I doubt it can be that.  pread() is always used on pack data that we 
already received and validated, and part of the validation is the final 
pack SHA1.  No code path leads to pread() before the final pack SHA1 is 
tested OK.

The only way for the received pack to be truncated and pread() to fail 
is if write_or_die() somehow failed to write the pack data without Git 
noticing.


Nicolas
