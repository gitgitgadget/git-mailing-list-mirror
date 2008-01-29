From: Jeff King <peff@peff.net>
Subject: Re: git-revert is a memory hog
Date: Tue, 29 Jan 2008 17:20:07 -0500
Message-ID: <20080129222007.GA3985@coredump.intra.peff.net>
References: <20080127172748.GD2558@does.not.exist> <20080128055933.GA13521@coredump.intra.peff.net> <alpine.LFD.1.00.0801300844170.28476@www.l.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adrian Bunk <bunk@kernel.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 29 23:20:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJyov-0001oo-MX
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 23:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770AbYA2WUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 17:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753669AbYA2WUM
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 17:20:12 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4149 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbYA2WUL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 17:20:11 -0500
Received: (qmail 11368 invoked by uid 111); 29 Jan 2008 22:20:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 29 Jan 2008 17:20:09 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2008 17:20:07 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801300844170.28476@www.l.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72004>

On Wed, Jan 30, 2008 at 08:51:09AM +1100, Linus Torvalds wrote:

> I definitely can reproduce it, it's horrid.
> 
> This is from "top" fairly late in the game, but with the thing not even 
> done yet. Current git, pretty much fully (and fairly aggressively) packed 
> current kernel repo, and using "diff.renamelmit=0".

Hrm, setting diff.renamelimit to 0 lets me reproduce (I thought I tried
it before, but clearly not...).

The culprit seems to be diffcore-rename.c:476:

  mx = xmalloc(sizeof(*mx) * num_create * num_src);

Where that ends up allocating about 450M. I think this is exactly the
sort of case that renamelimit was introduced to address.

-Peff
