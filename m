From: Jeff King <peff@peff.net>
Subject: Re: Memory corruption when rebasing with git version 1.8.1.5 on arch
Date: Sun, 10 Mar 2013 03:05:05 -0400
Message-ID: <20130310070505.GA15324@sigill.intra.peff.net>
References: <5139D76D.80703@bernhard-posselt.com>
 <20130308212831.GA9217@sigill.intra.peff.net>
 <513A7D80.5000501@bernhard-posselt.com>
 <20130309044850.GB12167@sigill.intra.peff.net>
 <513B14EC.4040504@bernhard-posselt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Bernhard Posselt <mail@bernhard-posselt.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 08:05:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEaKA-0004hI-Mr
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 08:05:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453Ab3CJHFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 03:05:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42764 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365Ab3CJHFI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 03:05:08 -0400
Received: (qmail 32627 invoked by uid 107); 10 Mar 2013 07:06:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 10 Mar 2013 03:06:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Mar 2013 03:05:05 -0400
Content-Disposition: inline
In-Reply-To: <513B14EC.4040504@bernhard-posselt.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217788>

On Sat, Mar 09, 2013 at 11:54:36AM +0100, Bernhard Posselt wrote:

> >Also, I can almost reproduce here, as PatrickHeller/core.git is public.
> >However, I suspect the problem is particular to your work built on top,
> >which looks like it is at commit 0525bbd73c9015499ba92d1ac654b980aaca35b2.
> >Is it possible for you to make that commit available on a temporary
> >branch?

> What do you mean exactly by that?

I just meant to push the work from your local repository somewhere where
I could access it to try to replicate the issue. What you did here:

> git clone https://github.com/Raydiation/memorycorruption
> cd memorycorruption
> git pull --rebase https://github.com/Raydiation/core

...should be plenty. Unfortunately, I'm not able to reproduce the
segfault.  All of the patches apply fine, both normally and when run
under valgrind.

> Heres the output of the GIT_TRACE file
> [...]
> trace: built-in: git 'apply' '--index' '/srv/http/owncloud/.git/rebase-apply/patch'

This confirms my suspicion that the problem is in "git apply".

You had mentioned before that the valgrind log was very long.  If you're
still able to reproduce, could you try running it with valgrind like
this:

  valgrind -q --trace-children=yes --log-file=/tmp/valgrind.out \
    git pull --rebase https://github.com/Raydiation/core

Logging to a file instead of stderr should mean we still get output for
commands that are invoked with their stderr redirected (which is the
case for the "git apply" in question), and using "-q" should eliminate
the uninteresting cruft from the log.

-Peff
