From: Jeff King <peff@peff.net>
Subject: Re: How should git-config include.path option work in ~/.gitconfig
 file?
Date: Sat, 21 Jun 2014 06:08:03 -0400
Message-ID: <20140621100803.GB16599@sigill.intra.peff.net>
References: <CAK6hiNhumFhKd9tjr07SgtZe23LwW8RKSp3BbwVRh06-L0C8EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Cox, Michael" <mhcox@bluezoosoftware.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 12:08:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WyIDU-00088D-TU
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jun 2014 12:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934513AbaFUKII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2014 06:08:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:48705 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934497AbaFUKIG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2014 06:08:06 -0400
Received: (qmail 905 invoked by uid 102); 21 Jun 2014 10:08:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Jun 2014 05:08:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Jun 2014 06:08:03 -0400
Content-Disposition: inline
In-Reply-To: <CAK6hiNhumFhKd9tjr07SgtZe23LwW8RKSp3BbwVRh06-L0C8EA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252300>

[+cc mailing list]

On Sat, Jun 21, 2014 at 03:16:05AM -0600, Cox, Michael wrote:

> I discovered the new (to me, at least) git config include.path option
> recently and tried using it to include a file, .gitremotes in my git
> worktree.  The .gitremotes file contains a remote.upstream section
> containing information (url, fetch, etc.) for the upstream remote I'm using
> to fetch updates for the project I'm working on, e.g.
> 
> [remote "upstream"]
> url = http://github.com/diydrones/ardupilot
> fetch = +refs/heads/*:refs/remotes/upstream/*
> 
> When I add
> 
> [include]
> path = ../.gitremotes
> 
> to my .git/config file, everything works as expected.

So far so good, though note the potential security implications. If the
upstream you fetch from puts something malicious into .gitremotes, they
could execute arbitrary code (e.g., by setting up external diff config).

That may be a tradeoff you're OK with, but I wanted to point it out to
make sure you are aware.

> I then thought I'd like to make this work for all my repositories by
> default by adding the above include.path option to my global ~/.gitconfig
> file. This way I would not have to run "git config include.path
> ../.gitremotes" for each of my repositories and the .gitremotes file would
> server as documentation of the official remote repositories for the
> project. The documentation for the git config include.path option does
> state that relative paths are relative to the including config file. But
> the ~/.gitconfig file is supposed to contain common configuration options
> that appear in all your git repositories.

The including config file in that case would be ~/.gitconfig, and the
included path is relative to it.

Your final sentence seems to me to be the one that introduces the
confusion. Options in .gitconfig do not "appear in all your git
repositories". Rather, when a git command is run, it consults the
repo-local $GIT_DIR/config, the global ~/.gitconfig file, and the
system-level /etc/gitconfig.

> So is this a bug or a feature?

Feature. :)

> It seems like the currently documented behavior of include.path and
> .gitconfig are conflicting. I can see how having include.path
> statements in your .gitconfig file that are processed immediately
> would be useful for modularizing your .gitconfig file, but I think my
> use case is also a valuable use of the include.path functionality.
> Not sure how to syntactically express the deferral of the include file
> processing in the .gitconfig file, though.

Yes, the design of includes from ~/.gitconfig is very intentional, and
not going to change (and even if it weren't, we would have to deal with
backwards compatibility while changing it).  I agree what you are trying
to do is a sane thing (the security implications of pointing straight
into the work-tree aside, you could easily be doing the same thing with
another file in $GIT_DIR, or any number of similar schemes).

There isn't currently a way to do what you want. I think we would need a
new syntax for it. Recently we discussed supporting environment
variables in expansions of path-oriented config variables. So something
like:

  [include]
  path = $GIT_DIR/../.gitremotes

would do what you want. We'd have to give some thought on what that
should do when $GIT_DIR is not set (e.g., when you run a git command
outside of a repository). I'd be inclined to say that such an include
should be ignored (the naive shell interpretation would be to look for
"/../.gitremotes", which is almost certainly not what the user wants).

> P.S.  I searched the archive and found your patch submittal.  I wasn't sure
> if I should post this to git@vger.kernel.org, so I decided it would be
> better to check with the original feature developer first.  Sorry if that
> was a violation of this mailing list's etiquette.

This is definitely the sort of thing that should be discussed on the
mailing list. I've added it to the cc so we can continue the discussion
there.

-Peff
