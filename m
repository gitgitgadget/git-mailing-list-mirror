From: Jeff King <peff@peff.net>
Subject: Re: Having an invalid HEAD file causes git not to recognize the
 repository
Date: Tue, 21 Aug 2012 03:24:03 -0400
Message-ID: <20120821072403.GD3238@sigill.intra.peff.net>
References: <CANtNKfp+9HpvWkAO0vrm84oMiJNvjFg9T-UtNQko+ABHhEWj6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Egon Elbre <egonelbre@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 09:24:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3iow-00024V-Ps
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 09:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497Ab2HUHYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 03:24:08 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43525 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107Ab2HUHYG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 03:24:06 -0400
Received: (qmail 29029 invoked by uid 107); 21 Aug 2012 07:24:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Aug 2012 03:24:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2012 03:24:03 -0400
Content-Disposition: inline
In-Reply-To: <CANtNKfp+9HpvWkAO0vrm84oMiJNvjFg9T-UtNQko+ABHhEWj6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203949>

On Fri, Aug 17, 2012 at 02:42:33PM +0300, Egon Elbre wrote:

> Having an invalid HEAD file causes git not to recognize the repository
> and will cause an invalid message "fatal: Not a git repository (or any
> of the parent directories): .git" although there is a .git folder and
> everything seems okay in it. Solution was just to change HEAD to a
> valid ref/hash.

Right. When we search for a .git directory, we do a few sanity checks on
each candidate, like whether it has a properly-formatted HEAD, and
whether it has "objects" and "refs" directories. We have to balance
these heuristics to avoid false negatives (like yours, when the
directory was meant to be a repository but looked bogus) with false
positives (when we accidentally treat some random directory like a git
repository).

Since you don't have a working repository, the best we could do is say
"well, this looks like a repository, but it's broken, so I kept
looking". I think the best approach would probably be to have a new
GIT_TRACE_GITDIR environment variable to help debug git-dir lookup
(i.e., to print out details of the search as it happens).

> I ran into this problem when I had a BSOD during a rebase (ignore that
> I'm having to use Windows). This meant that only half of the hash got
> written into HEAD and all git commands I tried failed.

That generally shouldn't happen, as we write new ref content to a
temporary file and then rename it into place atomically. I wonder if
there is a problem with the atomicity there (we do not fsync after
close, which some filesystems might want), or if it was simply
filesystem corruption related to your BSOD.

-Peff
