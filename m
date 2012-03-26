From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Make run-command.c honour SHELL_PATH
Date: Mon, 26 Mar 2012 13:58:43 -0400
Message-ID: <20120326175843.GF7942@sigill.intra.peff.net>
References: <1332678696-4001-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Mon Mar 26 19:58:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCEBv-000073-Pr
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 19:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933209Ab2CZR6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 13:58:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60036
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933196Ab2CZR6p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 13:58:45 -0400
Received: (qmail 14759 invoked by uid 107); 26 Mar 2012 17:59:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Mar 2012 13:59:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2012 13:58:43 -0400
Content-Disposition: inline
In-Reply-To: <1332678696-4001-1-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193941>

On Sun, Mar 25, 2012 at 08:31:34AM -0400, Ben Walton wrote:

> [Others touched this file too, but it appears Jeff wrote the affected
> functionality.]

Sort of. I was just refactoring what was happening elsewhere in the
code, where individual callsites were sitting "sh -c" manually into the
argv list. So I didn't actually give any thought to whether SHELL_PATH
should be used. :)

> I hit a glitch with t7006-pager while testing the 1.7.10 rc1/rc2
> builds for OpenCSW/Solaris that turned out to be a problem with the
> way run-command.c:prepare_shell_cmd was setting up external
> utilities.  It was hard coded to fork 'sh -c' instead of honouring the
> SHELL_PATH as set at build time.
> 
> In this case, the failing test was t7006-pager:command-specific
> pager.  That test (and some subsequent ones) were setting the pager
> command used by git log to "sed s/^/foo:/ >actual" which is fine in a
> POSIX-compliant sh, but not in Solaris' sh.  If the user PATH at
> runtime happened to allow the broken system sh used instead of a sane
> sh, the ^ is interpreted the same as[1] | and this caused sed to fail
> with incomplete s/ command and a "command not found: /foo:" from the
> other forked process.

The original intent of SHELL_PATH is to give the full path, so it could
be used in places where PATH lookup is not an option (i.e., on
#!-lines). Whereas the run-command use_shell option looks up "sh" in the
PATH, so the "right" thing is to have your PATH set up to put a sane
"sh" near the front.

So in that sense, your patch is unnecessary. On the other hand, it is
very unlikely to harm anyone[1], and it reduces the number of things the
user has to make sure are set up properly, so I think overall it's an
improvement, even if there is already another way to fix the problem.

-Peff

[1] I can't imagine anybody will be upset that we would use SHELL_PATH
    instead of "sh". It could produce a difference of behavior if you
    had a sane "sh" in your PATH, but SHELL_PATH points to the absolute
    path of some other shell. But if your SHELL_PATH and the "sh" in
    your PATH are so wildly divergent that you notice the difference, I
    think you may have bigger problems.
