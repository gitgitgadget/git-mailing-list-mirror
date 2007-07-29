From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation/git-diff: remove -r from --name-status
	example
Date: Sun, 29 Jul 2007 00:52:17 -0400
Message-ID: <20070729045217.GA6858@coredump.intra.peff.net>
References: <20070729002427.GA1566@coredump.intra.peff.net> <alpine.LFD.0.999.0707281905050.3442@woody.linux-foundation.org> <20070729041159.GA5544@coredump.intra.peff.net> <alpine.LFD.0.999.0707282119010.3442@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 29 06:52:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF0lT-0003YN-Ek
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 06:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbXG2EwV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 00:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbXG2EwU
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 00:52:20 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3467 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496AbXG2EwU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 00:52:20 -0400
Received: (qmail 23799 invoked from network); 29 Jul 2007 04:52:20 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 29 Jul 2007 04:52:20 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Jul 2007 00:52:17 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707282119010.3442@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54081>

On Sat, Jul 28, 2007 at 09:27:18PM -0700, Linus Torvalds wrote:

> The fact that "--name-status" is not considered a "patch" is an 
> implementation detail, and I would _almost_ suggest that we just make it 
> always recurse, and leave thenon-recursing case for _just_ "--raw". But 
> that is a separate decision.

I think it makes some sense, but I'm not sure it is worth it for two
reasons:
  1. --raw and --name-status are very linked in the diff code. Turning
     on recursion for --name-status without --raw will be somewhat
     hairy.
  2. If all of the porcelain tools turn on recursion anyway, that
     implementation detail just goes away anyway.

On the other hand, it looks like we just set options->recursive = 1 for
most formats anyway. So doing "git-log --raw" will not recurse, but
"git-log --raw -p" will recurse for _both_ the raw and the log formats.
Which I think is a bit non-intuitive, but it certainly makes the patch
much simpler:

diff --git a/diff.c b/diff.c
index a5fc56b..3137cac 100644
--- a/diff.c
+++ b/diff.c
@@ -2151,6 +2151,7 @@ int diff_setup_done(struct diff_options *options)
 				      DIFF_FORMAT_DIFFSTAT |
 				      DIFF_FORMAT_SHORTSTAT |
 				      DIFF_FORMAT_SUMMARY |
+				      DIFF_FORMAT_NAME_STATUS |
 				      DIFF_FORMAT_CHECKDIFF))
 		options->recursive = 1;
 	/*

> It *is* a change in behaviour, though, so I can understand if Junio 
> doesn't think it's appropriate this late in the 1.5.3 series.

Agreed.

> "git log", of course, defaults to no output at all, so the only way to get 
> non-recursive behaviour is to ask for "--raw", and then having to specify 
> explicitly whether to get recursion or not make sense. Once you want raw 
> output, it really _is_ your choice.

I wonder if git-log should match the behavior of the other commands. I
have often see git-whatchanged explained as the equivalent of "git-log
-p" but that's not exactly true. Similarly, git-show has been explained
as "git-log -p for the first commit." And using "-p" they are basically
the same. But it means I can't just replace all use of "git-whatchanged"
with "git-log" and get the exact same behavior.  I think it makes to
harmonize these little "gotchas".

-Peff
