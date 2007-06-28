From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-rev-list: give better diagnostic for failed write
Date: Thu, 28 Jun 2007 17:34:51 -0400
Message-ID: <20070628213451.GB22455@coredump.intra.peff.net>
References: <87r6nzu666.fsf@rho.meyering.net> <alpine.LFD.0.98.0706251349540.8675@woody.linux-foundation.org> <878xa7u2gh.fsf@rho.meyering.net> <alpine.LFD.0.98.0706251505570.8675@woody.linux-foundation.org> <alpine.LFD.0.98.0706251536240.8675@woody.linux-foundation.org> <alpine.LFD.0.98.0706251607000.8675@woody.linux-foundation.org> <20070626171127.GA28810@thunk.org> <alpine.LFD.0.98.0706261024210.8675@woody.linux-foundation.org> <20070628190406.GC29279@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 28 23:34:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I41dh-0000ph-9c
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 23:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763953AbXF1Vez (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 17:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763375AbXF1Vez
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 17:34:55 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1765 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762796AbXF1Vey (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 17:34:54 -0400
Received: (qmail 17211 invoked from network); 28 Jun 2007 21:35:13 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 28 Jun 2007 21:35:13 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jun 2007 17:34:51 -0400
Content-Disposition: inline
In-Reply-To: <20070628190406.GC29279@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51129>

On Thu, Jun 28, 2007 at 03:04:06PM -0400, Theodore Tso wrote:

>     This patch skips the fflush() calls when stdout is a regular file, or
>     if the environment variable GIT_NEVER_FLUSH_STDOUT is set.  This
>     latter can speed up a command such as:
>     
>     	(export GIT_NEVER_FLUSH_STDOUT=t; git-rev-list HEAD | wc -l)

I wonder if this would be more natural in the opposite form:

  GIT_FLUSH_STDOUT=1 git-rev-list HEAD

In general, you don't want to do the flushing unless:
  - it's going to the pager
  - some program is reading incrementally

In the first case, we can just turn on GIT_FLUSH_STDOUT when we kick off
the pager. In the second case, that program can just add the variable to
its invocation.

On top of which, in your patch the type of output trumps the environment
variable, which seems backwards. In other words, I can't do this:

GIT_FLUSH_EVEN_THOUGH_ITS_A_FILE=1 git-rev-list HEAD >file
[in another window] tail -f file

I would think an explicit preference from a variable should override any
guesses.

-Peff
