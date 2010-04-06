From: Jeff King <peff@peff.net>
Subject: Re: Getting rid of a stale remote?
Date: Tue, 6 Apr 2010 14:42:56 -0400
Message-ID: <20100406184256.GA14281@coredump.intra.peff.net>
References: <x2jc115fd3c1004061103z3154b6b3ge34493260f12925e@mail.gmail.com>
 <w2if3271551004061107rb25b83b9p19a284f19e7d4f87@mail.gmail.com>
 <x2uc115fd3c1004061125i695f66bbi9f949ccc1958750@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 20:43:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzDkA-0000co-LI
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 20:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757164Ab0DFSnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 14:43:16 -0400
Received: from peff.net ([208.65.91.99]:49016 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756104Ab0DFSnO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 14:43:14 -0400
Received: (qmail 26400 invoked by uid 107); 6 Apr 2010 18:43:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 06 Apr 2010 14:43:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Apr 2010 14:42:56 -0400
Content-Disposition: inline
In-Reply-To: <x2uc115fd3c1004061125i695f66bbi9f949ccc1958750@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144165>

On Tue, Apr 06, 2010 at 02:25:07PM -0400, Tim Visher wrote:

> >   prune
> >       Deletes all stale tracking branches under <name>. These stale branches
> >       have already been removed from the remote repository referenced by
> >       <name>, but are still locally available in "remotes/<name>".
> 
> I'm unclear as to how this solves my problem.  Consider the following:

It doesn't. Prune is about removing stale branches of _existing_
remotes, but you want to remove the whole remote.

>     $ git remote
>     a
>     b
>     c

So you don't have a remote 'd' at this point.

>     $ git branch -a
>     a
>     b
>     c
>     remotes/a/branch
>     remotes/b/branch
>     remotes/c/branch
>     remotes/d/branch

But you do have a crufty tracking branch.

>     $ git remote prune d
>     fatal: 'd' does not appear to be a git repository
>     fatal: The remote end hung up unexpectedly

You don't have a remote 'd', so we try to a git repository in the
directory 'd'. Which obviously doesn't work.

>     $ git remote rm d
>     error: Could not remove config section 'remote.d'

And this fails because you have no configured remote 'd', just the
crufty branch. How you got into that state, I don't know, but I imagine
it was from deleting the config in .git/config manually instead of using
"git remote rm" in the first place.

It would be tempting to say that "git remote rm" should continue if the
config simply doesn't exist and remove the crufty branch, but that is
not quite right. We actually need the config to tell us "here is where
we store the tracking branches for remote d". Of course, unless you have
munged the config manually, it will always be "refs/remotes/d". So we
could perhaps guess that for the case of missing config (possibly with
"git remote rm -f" or something).

But if you just want to do things manually, try "git branch -d -r
d/branch".

-Peff
