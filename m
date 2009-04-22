From: Jeff King <peff@peff.net>
Subject: Re: Removing duplicated code between builtin-send-pack.c and
	transport.c
Date: Wed, 22 Apr 2009 15:03:37 -0400
Message-ID: <20090422190337.GA13424@coredump.intra.peff.net>
References: <09511913-0ED3-41C0-A4F0-9F2D452C00D7@petdance.com> <alpine.LNX.1.00.0904221407160.10753@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andy Lester <andy@petdance.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:05:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwhkx-0006X1-TF
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 21:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbZDVTDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 15:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbZDVTDl
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 15:03:41 -0400
Received: from peff.net ([208.65.91.99]:55324 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790AbZDVTDl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 15:03:41 -0400
Received: (qmail 17250 invoked by uid 107); 22 Apr 2009 19:03:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 22 Apr 2009 15:03:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2009 15:03:37 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0904221407160.10753@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117229>

On Wed, Apr 22, 2009 at 02:24:07PM -0400, Daniel Barkalow wrote:

> On Wed, 22 Apr 2009, Andy Lester wrote:
> 
> > There's a ton of code duplicated between transport.c and builtin-send-pack.c,
> > from print_push_status() and its static helpers.
> > 
> > Is there a reason NOT to refactor it out of the builtin and use the 
> > transport? 
> 
> I think the builtin should actually just be deprecated and eventually 
> removed. As far as I know, nothing actually runs "git send-pack" rather 
> than calling send_pack(), but I left the builtin entry point, along with 
> its helpers, just in case.
> 
> If you're interested in reorganizing things there, I think it would be 
> best to move send_pack() to a new send-pack.c, such that 
> builtin-send-pack.c can go away entirely.

I think there are actually three issues here:

  1. send_pack() is a library-ish function used by transport.c (which in
     turn is called by push), and it is in builtin-send-pack.c. This is
     generally against git policy.

  2. There are several static functions duplicated in transport.c and
     builtin-send-pack.c, which can be refactored to exist only once.
     In fact, I really don't see why your 64fcef2 didn't do that in the
     first place. It looks like they were cut and paste into
     transport.c; I don't see why you didn't just make them non-static
     and delete the original versions.

  3. Nobody really uses "git send-pack" anymore, so it can perhaps be
     deprecated and eventually dropped.

I think Andy was referring to (2), and I think that should be cleaned
up, as the different versions have a tendency to diverge. Probably
addressing (1) by moving send_pack() to transport.c makes sense as part
of the same cleanup.

I don't know that (3) really buys us much. Sure, it is probably useless,
but we would need to keep it for historical compatibility for quite some
time, anyway.

-Peff
