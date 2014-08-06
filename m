From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 07/19] rebase -i: log the replay of root commits
Date: Wed, 6 Aug 2014 18:01:25 -0400
Message-ID: <20140806220125.GB23878@peff.net>
References: <53A258D2.7080806@gmail.com>
 <cover.1406589435.git.bafain@gmail.com>
 <7389745946359e0d9d8c6f1e8f2ebc78033132e6.1406589435.git.bafain@gmail.com>
 <20140802000405.GB20040@peff.net>
 <53DFF965.8020808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 00:01:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF9H3-0008LB-Ub
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 00:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821AbaHFWBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 18:01:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:47280 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753869AbaHFWB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 18:01:28 -0400
Received: (qmail 18091 invoked by uid 102); 6 Aug 2014 22:01:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Aug 2014 17:01:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Aug 2014 18:01:25 -0400
Content-Disposition: inline
In-Reply-To: <53DFF965.8020808@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254907>

On Mon, Aug 04, 2014 at 11:21:41PM +0200, Fabian Ruch wrote:

> Thanks for laying out the differences in the user visible output. With
> stock git we are seeing summaries for other commits, but not root
> commits, _with the --verbose option_. It's the fault of my patch to show
> the summary even in non-verbose mode. This is now fixed by wrapping the
> relevant command in 'output', a shell function defined in git-rebase.sh
> as follows:

Ah, OK. That makes a lot more sense, then.

> > output=$("$@" 2>&1 )
> > status=$?
> > test $status != 0 && printf "%s\n" "$output"
> > return $status
> 
> The problem that git-rebase--interactive has is that the redirection of
> stdin to a variable (or a file) does not work reliably with commands
> that invoke the log message editor, that is 'reword' and 'squash'
> produce their output both in verbose and non-verbose mode. I wouldn't
> know how to fix this but
> 
> 1) invoking $GIT_EDITOR from git-rebase--interactive.sh, but to make
> this right there should be a built-in command for shell scripts and an
> interface for git-commit that prepare the editor contents like
> git-commit does now, or
> 
> 2) forcing $GIT_EDITOR and git-commit to print on distinct file
> descriptors, which would involve temporarily wrapping the $GIT_EDITOR
> call in a shell script that redirects stdin to some other file
> descriptor similar to what t/test-lib.sh does, or

Hmm. In the test scripts, we send stdout and stderr for sub-commands to
fds 3 and 4 respectively. And then we either point those at /dev/null or
to >&1 and >&2, depending on whether $verbose mode was specified.

I don't think that will work here, though. You literally have one "git
commit" command to run, and you want its stderr/stdout to go somewhere
different than the $GIT_EDITOR it will invoke. Your (2) makes some sense
to me. Something like:

  GIT_EDITOR="$(shellquote "$(git var GIT_EDITOR)") >&3 2>&4" \
    git commit ... 3>&1 4>&2 >wherever 2>&1

Or we could just point it at /dev/tty, though I guess that may open
another can of worms (systems without /dev/tty, what happens when you do
not have a terminal, etc).

> 3) passing the --quiet option in non-verbose mode and omitting it in
> verbose mode, which would cover the '$status != 0' above for if a
> command fails, it should indicate its error status despite being asked
> to be silent.

Yeah, that is probably the cleanest option if it works. I would just
worry that it is not as complete. It works for "git commit", but are
there are other commands wrapped in the verbose output that would want
the same treatment (that might not know about --quiet)? Your paragraph
below says it would not be that big a deal, so as long as we don't plan
to add anything in the future that could not handle the requirement,
that may be enough.

-Peff
