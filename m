From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] run-command: optimize out useless shell calls
Date: Thu, 31 Dec 2009 16:41:35 -0500
Message-ID: <20091231214134.GA31399@coredump.intra.peff.net>
References: <20091230095634.GA16349@coredump.intra.peff.net>
 <20091230105536.GC22959@coredump.intra.peff.net>
 <4B3CD74D.7020605@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Dec 31 22:42:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQSmX-0001p5-Dy
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 22:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbZLaVlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 16:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbZLaVlj
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 16:41:39 -0500
Received: from peff.net ([208.65.91.99]:53008 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751594AbZLaVli (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 16:41:38 -0500
Received: (qmail 29941 invoked by uid 107); 31 Dec 2009 21:46:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 31 Dec 2009 16:46:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Dec 2009 16:41:35 -0500
Content-Disposition: inline
In-Reply-To: <4B3CD74D.7020605@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135977>

On Thu, Dec 31, 2009 at 05:54:37PM +0100, Johannes Sixt wrote:

> The git version that msysgit ships (and the one that I use on
> Windows) has this sequence in pager.c:
> 
> static const char *pager_argv[] = { "sh", "-c", NULL, NULL };
> ...
> 	pager_process.argv = &pager_argv[2];
> 	pager_process.in = -1;
> 	if (start_command(&pager_process)) {
> 		pager_process.argv = pager_argv;
> 		pager_process.in = -1;
> 		if (start_command(&pager_process))
> 			return;
> 	}

As a side note to what you are saying, my patch 2/6 will break this. The
"new" way to do it would be:

  /* do not set pager_argv[2] specially */
  pager_process.in = -1;
  if (start_command(&pager_process)) {
          pager_process.use_shell = 1;
          pager_process.in = -1;
          if (start_command(&pager_process))
                  return;
  }

though I am happy to also just revert the pager.c changes and leave it
to handle the shell itself.

But of course if we use your trick internally in run-command, then your
pager-specific change can just go away.

> to help people set
> 
>  PAGER=C:\Program Files\cygwin\bin\less
> 
> That is, we first try to run the program without the shell, then
> retry wrapped in sh -c.
> 
> Wouldn't it be possible to do the same here, assuming that we don't
> have programs such as "editor -f" in the path?

Hmm. That is somewhat clever. And it would actually solve the
backward-compatibility problem for helpers moving to shell execution. If
you have a textconv of "/path with space/foo", it will continue to
work transparently, but now "/path_without_space/foo --option" will also
Just Work.

The two downsides I see are:

  1. You want to run "foo" with "-bar" in your path but you have "foo
     -bar" in your path (your "editor -f" example). This just seems
     insane to me.

  2. There is a little bit of an interface inconsistency. You can do
     PAGER="/path with space/foo", but once you want to add an option,
     PAGER="/path with space/foo -bar" does not do what you mean. You
     have to understand the magic that is going on, and that you now
     need to quote the first part.

     I'm not sure that is not a feature, though. You are paying that
     cost in the transition, but getting the DWYM magic for the common
     case.

> It does assume that we are able to detect execvp failure due to
> ENOENT which is currently proposed elsewhere by Ilari Liusvaara (and
> which is already possible on Windows).

We could also simply do the path lookup ourselves, decide whether to use
the shell, and then exec. Path lookup is not that hard, and I think we
already have mingw compat routines for it anyway.

-Peff
