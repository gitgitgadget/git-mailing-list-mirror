From: Jeff King <peff@peff.net>
Subject: Re: Git Garbage Collect Error.
Date: Thu, 12 Jul 2012 05:32:21 -0400
Message-ID: <20120712093221.GA4443@sigill.intra.peff.net>
References: <4FD86AF8.1050100@zuken.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Lucas <toml@zuken.co.uk>
X-From: git-owner@vger.kernel.org Thu Jul 12 11:32:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpFlH-0003mS-KR
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 11:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758295Ab2GLJcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 05:32:33 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:57872
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757206Ab2GLJcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 05:32:25 -0400
Received: (qmail 19529 invoked by uid 107); 12 Jul 2012 09:32:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Jul 2012 05:32:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jul 2012 05:32:21 -0400
Content-Disposition: inline
In-Reply-To: <4FD86AF8.1050100@zuken.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201353>

On Wed, Jun 13, 2012 at 11:27:04AM +0100, Thomas Lucas wrote:

> Hopefully this is the right place to send bug reports... The
> community page "http://git-scm.com/community" suggests that it is.

It is the right place. Sorry that you did not get any response before
now.

> During garbage collection (git gc) it encountered the following error:
> 
> git gc | git gc --prune :
> 
>    Counting objects: 856758, done.
>    Delta compression using up to 2 threads.
>    fatal: Out of memory, malloc failed (tried to allocate 303237121 bytes)
>    error: failed to run repack

Packing can be memory hungry if you have a lot of large objects (we may
hold several large objects in memory while comparing them for deltas).
It is also worse with 2 threads, as they will be working simultaneously,
but in the same memory space.

> The compression gets over 90% of the way through before this error
> occurs, but I don't think any compression results are kept, because
> when you repeat it has the same amount of work to do.

Right. Nothing is written during compression; we are just coming up with
a list of deltas to perform during the writing phase.

> My system is XP64 2 core with 4Gb of memory and plenty of virtual memory.

Unfortunately, I believe that the msysgit build is 32-bit, which means
you are probably not even getting to use all 4Gb of your address space
(my impression is that without special flags, 32-bit Windows processes
are limited to 2Gb of address space).

I'd first try doing the pack single-threaded by setting the pack.threads
config option to 1. If that doesn't work, you might try setting
pack.windowMemory to limit the delta search based on available memory
(usually it is limited by number of objects). If the large blobs are
ones that do not delta well anyway (e.g., compressed media files), you
might also consider setting the "-delta" attribute for them to skip
delta compression entirely.

-Peff
