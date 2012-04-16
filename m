From: Jeff King <peff@peff.net>
Subject: Re: GSoC - Some questions on the idea of
Date: Mon, 16 Apr 2012 10:54:50 -0400
Message-ID: <20120416145450.GA14724@sigill.intra.peff.net>
References: <4F76E430.6020605@gmail.com>
 <4F772E48.3030708@gmail.com>
 <20120402210708.GA28926@sigill.intra.peff.net>
 <4F84DD60.20903@gmail.com>
 <20120411213522.GA28199@sigill.intra.peff.net>
 <4F872D24.8010609@gmail.com>
 <20120412210315.GC21018@sigill.intra.peff.net>
 <4F8A2EBD.1070407@gmail.com>
 <20120415021550.GA24102@sigill.intra.peff.net>
 <4F8A3381.803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 16:55:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJnKV-0000yn-86
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 16:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432Ab2DPOyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 10:54:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36231
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753431Ab2DPOyx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 10:54:53 -0400
Received: (qmail 23998 invoked by uid 107); 16 Apr 2012 14:55:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Apr 2012 10:55:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Apr 2012 10:54:50 -0400
Content-Disposition: inline
In-Reply-To: <4F8A3381.803@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195639>

On Sat, Apr 14, 2012 at 09:33:37PM -0500, Neal Kreitzinger wrote:

> We use git to transfer database files from the dev server to
> qa-servers.  Sometimes these barf for some reason and I get called to
> remediate.  I assumed the user closed their session prematurely
> because it was "taking too long".  However, now I'm wondering if the
> git-pull --ff-only is dying on its own due to the big-files.  It
> could be that on a qa-server that hasn't updated database files in
> awhile they are pulling way more than another qa-server that does
> their git-pull more requently.  How would I go about troubleshooting
> this?  Is there some log files I would look at?  (I'm using git 1.7.1
> compiled with git makefile on rhel6.)

No, git doesn't keep logfiles. Errors go to stderr. So look wherever the
stderr for your git sessions is going (if you are doing this via cron
job or something, then that is outside the scope of git).

> When I go to remediate do git-reset --hard to clear out the barfed
> worktree/index and then run git-pull --ff-only manually and it always
> works.  I'm not sure if that proves it wasn't git that barfed the
> first time.  Maybe the first time git brought some stuff over and
> barfed because it bit off more than it could chew, but the second time
> its really having to chew less food because it already chewed some of
> it the first time and therefore works the second time.

Try "git pull --no-progress" and see if it still works. If the server
has a very long delta-compression phase, there will be no output
generated for a while, which could cause intermediate servers to hang up
(git won't do this, but if, for example, you are pulling over
git-over-http and there is a reverse proxy in the middle, it may hit a
timeout). If the automated pulls are happening from a cron job, then
they won't have a terminal and progress-reporting will be off by
default.

-Peff
