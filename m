From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: Re: [PATCH] Makefile: Check for perl script errors with perl -c
Date: Sat, 17 Apr 2010 11:05:00 -0600
Message-ID: <20100417170500.GA4587@comcast.net>
References: <1271471380-17701-1-git-send-email-mmogilvi_git@miniinfo.net>
 <20100417072721.GD10365@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 17 19:05:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3BSB-00018l-3R
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 19:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676Ab0DQRFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 13:05:05 -0400
Received: from qmta03.emeryville.ca.mail.comcast.net ([76.96.30.32]:52183 "EHLO
	qmta03.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752260Ab0DQRFD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Apr 2010 13:05:03 -0400
Received: from omta14.emeryville.ca.mail.comcast.net ([76.96.30.60])
	by qmta03.emeryville.ca.mail.comcast.net with comcast
	id 6eXY1e0021HpZEsA3h53Jx; Sat, 17 Apr 2010 17:05:03 +0000
Received: from mmogilvi.homeip.net ([67.190.99.184])
	by omta14.emeryville.ca.mail.comcast.net with comcast
	id 6h511e0093yhxvF8ah52p2; Sat, 17 Apr 2010 17:05:02 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 47DEE1E9625D; Sat, 17 Apr 2010 11:05:00 -0600 (MDT)
Content-Disposition: inline
In-Reply-To: <20100417072721.GD10365@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145159>

On Sat, Apr 17, 2010 at 03:27:21AM -0400, Jeff King wrote:
> On Fri, Apr 16, 2010 at 08:29:40PM -0600, Matthew Ogilvie wrote:
> > The whole tradeoff between noise ("{script} syntax OK"), portability
> > (PIPESTATUS is a bashism), or really ugly contortions with redirecting
> > extra file descriptors (to avoid PIPESTATUS) seems to be the biggest
> > downside of the idea behind this patch.
> 
> Why do you need to run it through grep? Doesn't:
> 
>   echo 'use strict; bogosity' >foo.pl
>   perl -wc foo.pl
> 
> properly set the exit code? I get:
> 
>   $ perl -wc foo.pl
>   Bareword "bogosity" not allowed while "strict subs" in use at foo.pl line 1.
>   foo.pl had compilation errors.
>   $ echo $?
>   255

Yes, "perl -cw"'s exit code is always good, but the standard error is
needlessly noisy in the success case:

  $ perl -cw -e 'print "hi\n"'
  -e syntax OK
  $ echo $?
  0

Which then leaves a choice among not-great options:

1. Accept the noise output from make and perl.  If we are willing to
   accept this, then a simpler and/or uncoditional patch would be fine.

2. Filter out the "{scriptName} syntax OK" noise with grep (or sed),
   but then $? is grep's status (not perl's), and you have to go
   through contortions to properly test perl's status:

    2a. Use PIPESTATUS, but this is a non-portable bashism.
        My current version of the patch elects to do this, but
        leaves the check disabled to (hopefully) avoid portability
        issues.  (A second advantage of leaving it disabled [or at
        least disablable] is if someone is in a cross-compile
        environment and the target perl path is different 
        from the build perl path.)

    2b. Use a portable technique that involves echoing the status
        redirected to file descriptor 3, then pulling the status out
        of file descriptor 3 outside the pipeline.  This is frankly
        kind of complicated and hard to read.

So, I take it you would be happy with the noisy output?
Anyone else have an opinion?  If someone knows a cleaner
way to resolve this, or if the group consensus is that we like the
patch's concept but would rather resolve the noisy output some
other way (perhaps just accept it), I could change the patch.

--
Matthew Ogilvie   [mmogilvi_git@miniinfo.net]
