From: Jeff King <peff@peff.net>
Subject: Re: How to handle terminal detection in a daemon calling git?
Date: Wed, 30 May 2012 21:29:09 -0400
Message-ID: <20120531012908.GD5488@sigill.intra.peff.net>
References: <1338412607.9452.140661082904349.02F677C3@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Travis P <git@castle.fastmail.fm>
X-From: git-owner@vger.kernel.org Thu May 31 03:29:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZuCS-0002Rd-Pp
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 03:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757592Ab2EaB3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 21:29:12 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:36704
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754614Ab2EaB3L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 21:29:11 -0400
Received: (qmail 12946 invoked by uid 107); 31 May 2012 01:29:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 May 2012 21:29:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 May 2012 21:29:09 -0400
Content-Disposition: inline
In-Reply-To: <1338412607.9452.140661082904349.02F677C3@webmail.messagingengine.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198856>

On Wed, May 30, 2012 at 04:16:47PM -0500, Travis P wrote:

> I've got a script that runs in the background without a terminal.
> It actually does have STDOUT and STDERR set to a rotating log file.
> 
> When it runs:
>   /bin/sh -c 'cd /to/my/wc; git pull --ff-only'
> the git command fails (rc 32768).
> 
> When it runs
>  /bin/sh -c 'cd /to/my/wc; git pull --ff-only > /to/a/file 2>&1'
> 
> or even
>  /bin/sh -c 'cd /to/my/wc; git pull --ff-only | cat'
> 
> then all is well.  The command succeeds (rc 0, and I see the expected
> results).

If your stdout and stderr are not a terminal in the first place (you say
they go to a rotating log file), then that should not be making a
difference. Are they connected by a pty or something odd?

Can you describe the failure in the first case more? Does git produce
any output?

> Piping through 'cat' is okay, but I'd rather avoid the 'trick'.  Is
> there some way to communicate to git that it should operate just as if
> output were redirected?

Git cares about terminals in only a few cases:

  1. We check isatty(2) to enable progress reporting by default. You can
     use --no-progress to disable this. However, in your final example
     you only redirect stdout, which makes me think that stderr is not
     relevant.

  2. We check isatty(1) for starting a pager, auto-selecting color, and
     in recent versions of git, for column support. But none of those
     things should be in use by git-pull anyway.

  3. Merge was changed recently to open an editor when we have a
     terminal. That can be changed by setting GIT_MERGE_AUTOEDIT=no in
     the environment. However, since you pass --ff-only, we shouldn't be
     running merge at all.

So I'm confused. Could it be not related to a terminal at all, but that
there is a problem writing to the original stdout? Something that might
give git a SIGPIPE? Can you describe the original stdout destination
more?

-Peff
