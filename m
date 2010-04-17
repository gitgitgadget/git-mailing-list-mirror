From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Makefile: Check for perl script errors with perl -c
Date: Sat, 17 Apr 2010 13:55:53 -0400
Message-ID: <20100417175553.GC23642@coredump.intra.peff.net>
References: <1271471380-17701-1-git-send-email-mmogilvi_git@miniinfo.net>
 <20100417072721.GD10365@coredump.intra.peff.net>
 <20100417170500.GA4587@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Sat Apr 17 19:56:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3CFu-0001R4-39
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 19:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874Ab0DQR41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 13:56:27 -0400
Received: from peff.net ([208.65.91.99]:44800 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766Ab0DQR4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 13:56:25 -0400
Received: (qmail 21205 invoked by uid 107); 17 Apr 2010 17:56:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 17 Apr 2010 13:56:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Apr 2010 13:55:53 -0400
Content-Disposition: inline
In-Reply-To: <20100417170500.GA4587@comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145164>

On Sat, Apr 17, 2010 at 11:05:00AM -0600, Matthew Ogilvie wrote:

> Yes, "perl -cw"'s exit code is always good, but the standard error is
> needlessly noisy in the success case:
> 
>   $ perl -cw -e 'print "hi\n"'
>   -e syntax OK
>   $ echo $?
>   0

Ah, OK. I misunderstood what you were trying to do before.

> 1. Accept the noise output from make and perl.  If we are willing to
>    accept this, then a simpler and/or uncoditional patch would be fine.

Though I would prefer it silenced, I don't personally have a big problem
with this. I guess others might.

> 2. Filter out the "{scriptName} syntax OK" noise with grep (or sed),
>    but then $? is grep's status (not perl's), and you have to go
>    through contortions to properly test perl's status:
> 
>     2a. Use PIPESTATUS, but this is a non-portable bashism.
>         My current version of the patch elects to do this, but
>         leaves the check disabled to (hopefully) avoid portability
>         issues.  (A second advantage of leaving it disabled [or at
>         least disablable] is if someone is in a cross-compile
>         environment and the target perl path is different 
>         from the build perl path.)

Hmm. The cross-compilation thing is interesting, but I'm not sure it
even works now. We already are relying on generating perl.mak and using
it as part of our build, I think. I haven't looked closely at the perl
build stuff in git, though, so maybe there is a way to make it work.

>     2b. Use a portable technique that involves echoing the status
>         redirected to file descriptor 3, then pulling the status out
>         of file descriptor 3 outside the pipeline.  This is frankly
>         kind of complicated and hard to read.

Yeah, I have used that technique before, and it is unreadable. Maybe
simpler is to cheat with a tempfile:

  if ! perl -wc $@+ 2>$@.stderr; \
    then cat >&2 $@.stderr; rm -f $@.stderr; exit 1; \
    else rm -f $@.stderr; fi && \

but that is getting a bit unreadable, too. I dunno.

-Peff
