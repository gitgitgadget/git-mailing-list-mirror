From: Jeff King <peff@peff.net>
Subject: Re: Problem with large files on different OSes
Date: Wed, 27 May 2009 17:53:14 -0400
Message-ID: <20090527215314.GA10362@coredump.intra.peff.net>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk> <m3y6siboij.fsf@localhost.localdomain> <alpine.LFD.2.01.0905270922250.3435@localhost.localdomain> <alpine.LFD.2.01.0905270942580.3435@localhost.localdomain> <alpine.LFD.2.00.0905271312220.3906@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christopher Jefferson <caj@cs.st-andrews.ac.uk>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 27 23:53:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9R3w-0007zx-EO
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 23:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758252AbZE0VxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 17:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757852AbZE0VxU
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 17:53:20 -0400
Received: from peff.net ([208.65.91.99]:59744 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469AbZE0VxT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 17:53:19 -0400
Received: (qmail 17412 invoked by uid 107); 27 May 2009 21:53:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 27 May 2009 17:53:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2009 17:53:14 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0905271312220.3906@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120110>

On Wed, May 27, 2009 at 01:37:26PM -0400, Nicolas Pitre wrote:

> My idea for handling big files is simply to:
> 
>  1) Define a new parameter to determine what is considered a big file.
> 
>  2) Store any file larger than the treshold defined in (1) directly into 
>     a pack of their own at "git add" time.
> 
>  3) Never attempt to diff nor delta large objects, again according to 
>     (1) above.  It is typical for large files not to be deltifiable, and 
>     a diff for files in the thousands of megabytes cannot possibly be 
>     sane.

What about large files that have a short metadata section that may
change? Versions with only the metadata changed delta well, and with a
custom diff driver, can produce useful diffs. And I don't think that is
an impractical or unlikely example; large files can often be tagged
media.

Linus' "split into multiple objects" approach means you could perhaps
split intelligently into metadata and "uninteresting data" sections
based on the file type.  That would make things like rename detection
very fast. Of course it has the downside that you are cementing whatever
split you made into history for all time. And it means that two people
adding the same content might end up with different trees. Both things
that git tries to avoid.

I wonder if it would be useful to make such a split at _read_ time. That
is, still refer to the sha-1 of the whole content in the tree objects,
but have a separate cache that says "hash X splits to the concatenation
of Y,Z". Thus you can always refer to the "pure" object, both as a user,
and in the code. So we could avoid retrofitting all of the code -- just
some parts like diff might want to handle an object in multiple
segments.

-Peff
