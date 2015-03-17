From: Jeff King <peff@peff.net>
Subject: Re: git submodule: update=!command
Date: Tue, 17 Mar 2015 15:50:31 -0400
Message-ID: <20150317195030.GA18725@peff.net>
References: <1426620537.1785877.241673949.72FB3B40@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Chris Packham <judge.packham@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ryan Lortie <desrt@desrt.ca>
X-From: git-owner@vger.kernel.org Tue Mar 17 20:50:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXxVd-0005nP-Uv
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 20:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411AbbCQTue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 15:50:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:34197 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752814AbbCQTud (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 15:50:33 -0400
Received: (qmail 26847 invoked by uid 102); 17 Mar 2015 19:50:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Mar 2015 14:50:33 -0500
Received: (qmail 27729 invoked by uid 107); 17 Mar 2015 19:50:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Mar 2015 15:50:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Mar 2015 15:50:31 -0400
Content-Disposition: inline
In-Reply-To: <1426620537.1785877.241673949.72FB3B40@webmail.messagingengine.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265658>

On Tue, Mar 17, 2015 at 03:28:57PM -0400, Ryan Lortie wrote:

> The first is a question about git's basic policy with respect to things
> like this.  I hope that it's safe to assume that running 'git' commands
> on repositories downloaded from potentially-hostile places will never
> result in the authors of those repositories being able to run code on my
> machine.

Definitely, our policy is that downloading a git repository should not
result in arbitrary code being run. If there is a case of that, it would
be a serious security bug.

I am not an expert on submodules, but I think the security module there
is:

  1. You can do whatever you like in submodule.*.update entries in
     .git/config, including arbitrary code. Nobody but the user can
     write to it.

  2. The submodule code may migrate entries from .gitmodules into
     .git/config, but does so with an allow-known-good whitelist (see
     git-submodule.sh lines 622-637).

So AFAICT there's no bug here, and the system is working as designed.
It might be worth mentioning that restriction in the submodule
documentation, if only to prevent non-malicious people from wondering
why adding "!foo" does not work in .gitmodules.

> If that is true then, the second request would be to spell this out more
> explicitly in the relevant documentation.  I'm happy to write a patch to
> do that, if it is deemed appropriate.

Yeah, spelling out the security model more explicitly would be good.
There is also some subtlety around hooks. Doing:

  git clone user@host:/path/to/repo.git local

should never run code controlled by "repo.git" as "user@host". But
doing:

  ssh user@host 'cd /path/to/repo.git && git log'

will respect the .git/config in repo.git, which may include arbitrary
commands.

-Peff
