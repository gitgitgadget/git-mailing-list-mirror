From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: 'upstream' branches.
Date: Sun, 6 May 2007 11:21:29 +0200
Message-ID: <20070506092129.GA2434@steel.home>
References: <1178368166.11851.60.camel@pmac.infradead.org> <20070505174416.GA2898@steel.home> <1178387429.17680.35.camel@shinybook.infradead.org> <20070505225249.GE2898@steel.home> <7v3b2ah30f.fsf@assigned-by-dhcp.cox.net> <1178436926.17680.74.camel@shinybook.infradead.org> <7vy7k2e606.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 06 11:21:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkcvz-0005Ew-8i
	for gcvg-git@gmane.org; Sun, 06 May 2007 11:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932819AbXEFJVc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 05:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933413AbXEFJVc
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 05:21:32 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:39199 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932819AbXEFJVb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 05:21:31 -0400
Received: from tigra.home (195.4.200.47)
	by post.webmailer.de (mrclete mo13) (RZmta 5.9)
	with ESMTP id A00542j467v8kL ; Sun, 6 May 2007 11:21:30 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id BD642277BD;
	Sun,  6 May 2007 11:21:29 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 4CD88D171; Sun,  6 May 2007 11:21:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vy7k2e606.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWopCbQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46322>

Junio C Hamano, Sun, May 06, 2007 10:00:25 +0200:
> 
> > Is that possible? I'm fairly sure it used to be.
> 
> I doubt we had that bug.  If you allowed overwriting with +, it
> would not have prevented a rewind (i.e. pull from Linus and then
> pull from somebody who pulled from Linus earlier than you did).
> If you didn't, then it would have failed the fetch.
> 

Maybe we should not fail in the case the remote repo is older then
local, but just to try to fast-forward local reference after a fetch
and fail only if the fast-forward fails?
Or introduce a new syntax for the strict reference succession and make
fetch+fast-forward the default?
Or the other way around, use something like "-from:to" to ignore
fast-forwards failed because the "from" already has all the "to" has,
which has precedents: make and its "-include", which ignores errors
from non-existing files.

Let us the local repo being in history younger then the remote:

Whole history (anywhere)		       : A--B--C--D
Local has (branch Tracking)		       : A--B
Remote1 (where the Local is doing a fetch from): A--B--C

Normal case, fetch will just update its reference in Local. It is now
at C.

Now suppose we have another remote Remote2, which is on B still. If
Local does a fetch from that, usually the operation will fail. But if
we do, for example, a fetch from Remote2 and store its reference
locally somewhere and then try to merge Local with the stored
reference, it shall result in nothing: everything's already merged:

$ git branch
* master
  Tracking
$ git fetch Remote1 master:Tracking
...reference Tracking updated
$ git fetch Remote2 master:tmp
$ git checkout Tracking
$ git merge tmp
Already up-to-date.
$ git branch -d tmp
$ git checkout master
