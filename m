From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 15:52:01 -0400
Message-ID: <20060629195201.GA10786@coredump.intra.peff.net>
References: <20060628223744.GA24421@coredump.intra.peff.net> <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606291053280.1213@localhost.localdomain> <20060629180011.GA4392@coredump.intra.peff.net> <Pine.LNX.4.64.0606291410420.1213@localhost.localdomain> <20060629185335.GA6704@coredump.intra.peff.net> <Pine.LNX.4.64.0606291458110.1213@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 21:52:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw2Yc-0006H0-Qo
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 21:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWF2TwG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 15:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWF2TwF
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 15:52:05 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:27794 "HELO
	peff.net") by vger.kernel.org with SMTP id S932355AbWF2TwD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 15:52:03 -0400
Received: (qmail 6867 invoked from network); 29 Jun 2006 15:51:41 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 29 Jun 2006 15:51:41 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jun 2006 15:52:01 -0400
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606291458110.1213@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22895>

On Thu, Jun 29, 2006 at 03:04:15PM -0400, Nicolas Pitre wrote:

> Right.  Your use pattern is a special case that doesn't work well with 
> the whole window hash approach.  I'd expect it to work beautifully with 
> the kernel repository though.

I don't necessarily care about the kernel repository. It packs fine as
it is, and you only waste 30 seconds on a repack checking deltas that
could be avoided. I do care on my special repository where packing is
virtually unusable and I can achieve a 45x speedup. Maybe my original
caching is not worth it for the kernel and should be configurable,
but obviously this window caching cannot REPLACE mine since it fails
utterly for the one thing I wanted it for.

That being said, I'm not sure that window caching is all that great for
"normal" repos.

Same test as before, but instead of simulating the commits, I merely
looked at the window hashes produced by 
  git-rev-list --objects master~$x

For the git repo:
x=0 tries 6698 windows
x=0 and x=50 contain 5197 identical windows
x=0 and x=100 contain 2484 identical windows
x=0 and x=500 contain 455 identical windows

For linux-2.6 repo:
x=0 tries 57208 windows
x=0 and x=50 contain 53677 identical windows
x=0 and x=100 contain 52886 identical windows
x=0 and x=500 contain 41196 identical windows

Obviously the kernel repo is doing better, but x=500 is only 4 days ago.
Trying with --before=2.weeks.ago yields only 31505 matches.

So the windows do clearly experience a fair bit of churn, but whether or
not this is worth it depends on how long you think is reasonable before
something gets "churned out" .

-Peff
