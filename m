From: Jeff King <peff@peff.net>
Subject: Re: t7006 sometimes hangs in cronjobs on OS X
Date: Wed, 9 Feb 2011 14:09:00 -0500
Message-ID: <20110209190900.GA8314@sigill.intra.peff.net>
References: <201102091538.46594.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 09 20:09:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnFPe-0000Gb-EX
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 20:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455Ab1BITJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 14:09:08 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:40840 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976Ab1BITJH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 14:09:07 -0500
Received: (qmail 11431 invoked by uid 111); 9 Feb 2011 19:09:03 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 09 Feb 2011 19:09:03 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Feb 2011 14:09:00 -0500
Content-Disposition: inline
In-Reply-To: <201102091538.46594.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166435>

On Wed, Feb 09, 2011 at 03:38:46PM +0100, Thomas Rast wrote:

> I have been running a nightly next&pu smoke tester each on RHEL5 and
> OS X.  For quite some time (at least a month), t7006 gets stuck
> randomly (i.e., not every night).  [This has been a bit of a problem
> because it keeps a lot of processes stuck on the machine and eats into
> my ulimit, but that's the case with any stuck process; I'll have to
> think about a good solution to that.]
> 
> The relevant part of 'ps xwww' is
> 
>   65211   ??  SN     0:00.03 /bin/sh t7006-pager.sh
>   65798   ??  SN     0:00.04 /usr/bin/perl /Users/trast/git-smoke/t/test-terminal.perl git --no-pager log
>   65846   ??  ZN     0:00.00 (git)
>   65847   ??  ZN     0:00.00 (perl5.10.0)

Hmm. The zombie git process implies to me that git has exited, but for
some reason we are still stuck in the copy-to-terminal loop and haven't
reaped it. But the zombie perl process confuses me.  We fork a second
time so that one process copies stderr and the other one copies stdout.
Is the second perl process the stderr copier, and we are still blocking
on copying stdout for some reason? But then why is the command name
different? Is /usr/bin/perl a wrapper script on your platform?

Have you tried running strace on the surviving perl process to see what
it's doing? Presumably it's just hung on a read() syscall.

Or maybe try stracing the whole thing from the start, which may be more
informative, like:

diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
index c383b57..f7e6b7f 100644
--- a/t/lib-terminal.sh
+++ b/t/lib-terminal.sh
@@ -13,7 +13,7 @@ test_expect_success 'set up terminal for tests' '
 				echo >&4 "test_terminal: need to declare TTY prerequisite"
 				return 127
 			fi
-			"$PERL_PATH" "$TEST_DIRECTORY"/test-terminal.perl "$@"
+			strace -f "$PERL_PATH" "$TEST_DIRECTORY"/test-terminal.perl "$@"
 		}
 	fi
 '

and giving us the stderr dump (or perhaps redirecting strace output to a
file and saving it)?

>     TEST_JOBS=6 nice make smoke

If you use TEST_JOBS=1, does it still happen? I can't imagine what race
condition would cause this, but there are other tests use
lib-terminal.sh, so perhaps there is some interference there.

-Peff
