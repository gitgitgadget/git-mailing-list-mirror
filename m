From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] git-remote-mediawiki: new tool to preview local
 changes without pushing
Date: Sun, 9 Jun 2013 02:08:07 -0400
Message-ID: <20130609060807.GA8906@sigill.intra.peff.net>
References: <1370641831-9115-1-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, celestin.matte@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Sun Jun 09 08:08:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlYnk-0007oY-JU
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132Ab3FIGIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 02:08:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:60510 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750931Ab3FIGIK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:08:10 -0400
Received: (qmail 15336 invoked by uid 102); 9 Jun 2013 06:08:59 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 09 Jun 2013 01:08:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jun 2013 02:08:07 -0400
Content-Disposition: inline
In-Reply-To: <1370641831-9115-1-git-send-email-benoit.person@ensimag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226890>

On Fri, Jun 07, 2013 at 11:50:31PM +0200, benoit.person@ensimag.fr wrote:

> The #7 issue on git-mediawiki's issue tracker [1] states that the ability to
> preview content without pushing would be a nice thing to have.

Sounds like a useful goal.

> The default behaviour for the `preview` subcommand is:
> 1- Find the remote name of the current branch's upstream and check if it's a
> wiki one with its url (ie: mediawiki://)
> 2- Parse the content of the local file (given as argument) using the distant
> wiki's API.

Makes sense.

> 3- Retrieve the current page on the distant mediawiki.
> 4- Merge those those contents.

I'm not sure what these steps are for. You are trying to preview not
just your local version, but pulling in any changes that have happened
upstream since the work you built on top of?

It seems like that is a separate, orthogonal issue, and git would be the
right place to do that merge. IOW, as a user, your workflow would be
something like:

  1. git fetch, pulling down the latest copy from the server

  2. make your changes on top

  3. use this command to preview your changes

  4. use git fetch to check whether anything else happened on the
     server.

       a. If not, go ahead and push.

       b. If upstream changed, use "git diff" to inspect the changes to
          the wiki source. Merge or rebase your changes with respect to
          what's on the server. Goto step 3 to make sure they look good.

I also wonder if it would be useful to be able to specify not only files
in the filesystem, but also arbitrary blobs. So in 4b above, you could
"git mw preview origin:page.mw" to see the rendered version of what
upstream has done.

> It works but a couple of points trouble me: 
> 1-  I had to copy two functions from `git-remote-mediawiki.perl`, I don't 
>     really know how we could "factorize" those things ? I don't think it makes 
>     much sense to create a package just for them ?

You could make a Git::MediaWiki.pm module, but installing that would
significantly complicate the build procedure, and potentially be
annoying for users. One trick I have done in the past is to concatenate
bits of perl script together in the Makefile, like this:

  foo: common.pl foo.pl
          { \
            echo '$(PERL_PATH_SQ)' && \
            for i in $^; do \
              echo "#line 1 $src" && \
                cat $src \
            done \
          } >$@+
          mv $@+ $@

That would conflict a bit with the way we chain to git's Makefile,
though. I suspect you could do something complicated like build "foo.pl"
from "common.pl" and "foo-main.pl", then chain to git's Makefile to
build "foo" from "foo.pl".

> 2-  The current behavior is to crash if the current branch do not have an
>     upstream branch on a valid mediawiki remote. To find that specific remote, 
>     it runs `git rev-parse --symbolic-full-name @{upstream}` which will return 
>     something like `/refs/remotes/$remote_name/master`.
>   2a-  maybe there is a better way to find that remote name ?

If you just care about the remote name and not the name of the local
branch, you can just ask for

  my $curr_branch = `git symbolic-ref HEAD`;
  my $remote = `git config "branch.$curr_branch.remote"`;
  my $url = `git config "remote.$remote.url"`;

Of course you would want some error checks and probably some chomp()s in
there, too.

>   2b-  would it be useful to add a fallback if that search fails ? searching 
>        for a valid mediawiki remote url in all the remotes returned by 
>        `git remote` for instance ?

That is probably OK as long as there is only one such remote, and it
would help the case where you have branched off of a local branch (so
your upstream remote is ".").  If there are two mediawiki remotes,
though, it would make sense to simply fail, as you don't know which to
use. But I'd expect the common case by far to be that you simply have
one such remote.

-Peff
