From: Jeff King <peff@peff.net>
Subject: Re: diffcore-rename performance mode
Date: Tue, 25 Sep 2007 15:52:20 -0400
Message-ID: <20070925195220.GA19549@segfault.peff.net>
References: <20070918082321.GA9883@coredump.intra.peff.net> <7vsl5cwe6p.fsf@gitster.siamese.dyndns.org> <20070918085413.GA11751@coredump.intra.peff.net> <20070925163843.GA22987@coredump.intra.peff.net> <20070925190640.GA4613@coredump.intra.peff.net> <86641y4k34.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Sep 25 21:52:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaGSb-0005Ak-J9
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 21:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463AbXIYTwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 15:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753777AbXIYTwZ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 15:52:25 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2534 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408AbXIYTwY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 15:52:24 -0400
Received: (qmail 19663 invoked by uid 1000); 25 Sep 2007 19:52:21 -0000
Content-Disposition: inline
In-Reply-To: <86641y4k34.fsf@lola.quinscape.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59164>

On Tue, Sep 25, 2007 at 09:32:31PM +0200, David Kastrup wrote:

> >                  | stock | nofree | old somefree | fixed somefree
> > -----------------|-----------------------------------------------
> > user time (s)    | 76.78 | 16.96  | 46.26        | 16.99
> > peak memory (Kb) | 52300 | 66796  | 59156        | 57328
> >
> > So now we're at a 4.5x speedup for about 10% extra memory usage. Patch
> > will follow.
> 
> Sounds good except when we happen to just hit the "memory working set
> exceeds physical memory" sweet spot.  But the odds are much better
> than for "nofree".

Of course, there is the possibility that it is the 10% that pushes you
into swap (or kills your ability to cache the entire pack in RAM).
However, this is probably not a big deal for two reasons:
  1. this is a 50M process handling the linux-2.6 repository. Other
     operations such as repacking already consume significantly more
     memory (git-repack -a allocates 290M on the same repo).
  2. I specifically turned off rename limiting (-l0) to do rename
     detection on these large-ish diffs.  If you have a machine which is
     on the cusp of swapping, then don't do that. Jumping from -l100
     (the default) to -l0 in my tests is _already_ moving you from 28M
     to 52M, a much larger jump.

-Peff
