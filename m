From: Jeff King <peff@peff.net>
Subject: Re: log --pretty/--oneline: ignore log.decorate
Date: Thu, 8 Apr 2010 03:30:14 -0400
Message-ID: <20100408073014.GA15474@coredump.intra.peff.net>
References: <7vtyrr6nes.fsf@alter.siamese.dyndns.org>
 <7vmxxggsl4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Steven Drake <sdrake@xnet.co.nz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 09:30:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzmCL-0006Ur-3H
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 09:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758400Ab0DHHag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 03:30:36 -0400
Received: from peff.net ([208.65.91.99]:57631 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758276Ab0DHHaf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 03:30:35 -0400
Received: (qmail 18409 invoked by uid 107); 8 Apr 2010 07:30:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 08 Apr 2010 03:30:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Apr 2010 03:30:14 -0400
Content-Disposition: inline
In-Reply-To: <7vmxxggsl4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144341>

On Tue, Apr 06, 2010 at 02:48:55PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > [Stalled]
> >
> > * sd/log-decorate (2010-02-17) 3 commits
> >   (merged to 'next' on 2010-03-08 at 58a6fba)
> >  + log.decorate: usability fixes
> >  + Add `log.decorate' configuration variable.
> >  + git_config_maybe_bool()
> >
> > Needs squelching the configuration setting when "--pretty=raw" is given,
> > at least, or possibly when any "--pretty" is explicitly given.
> 
> This is necessary if we want to let users specify log.decorate and still
> use gitk.  A patch should look like this (of course untested).

Hmm. You took the "any --pretty" option with this patch.

And given the markups to the test suite:

> -	git log --oneline >expect.none &&
> -	git log --oneline --decorate >expect.short &&
> -	git log --oneline --decorate=full >expect.full &&
> +	git log >expect.none &&
> +	git log --decorate >expect.short &&
> +	git log --decorate=full >expect.full &&
> +	git log --oneline >expect.oneline &&

I suspect that will annoy users who have set log.decorate. Wouldn't they
expect to see it with "--oneline" if they have it configured (I would
guess that "git log" and "git log --oneline" are the most commonly
viewed forms by humans).

It seems reasonable to say "git log --pretty=raw should be consumable by
scripts", but I don't know that we need to do so for every pretty
format.

However:

  $ git grep oneline *.sh
  git-rebase--interactive.sh:             git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
  git-stash.sh:           head=$(git log --no-color --abbrev-commit --pretty=oneline -n 1 HEAD --)
  git-submodule.sh:                       git log --pretty=oneline --first-parent $range | wc -l

rebase--interactive properly uses rev-list. The submodule invocation
would uselessly look up the decoration, and the stash one would add it
to the stash commit message. But I am inclined to say that both of those
scripts are at fault, and should be converted to rev-list.

-Peff
