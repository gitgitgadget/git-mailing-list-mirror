From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitk: disable checkout of remote branch
Date: Thu, 5 Nov 2009 02:48:08 -0500
Message-ID: <20091105074808.GA12114@coredump.intra.peff.net>
References: <2e24e5b90911030800j22b00372r99a56c3f847a3644@mail.gmail.com>
 <fabb9a1e0911030807h6b76b661pef75628a1255356@mail.gmail.com>
 <1257295737457-3942366.post@n2.nabble.com>
 <2e24e5b90911031758t651735f9xe9d078079112cfa6@mail.gmail.com>
 <1257315478920-3943388.post@n2.nabble.com>
 <fabb9a1e0911032241u3735fa30heaa195d959879f5a@mail.gmail.com>
 <20091104072709.GC24263@coredump.intra.peff.net>
 <7vhbtai2uy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Tim Mazid <timmazid@hotmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 08:48:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5x4v-0004v9-Vt
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 08:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685AbZKEHsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 02:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754610AbZKEHsJ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 02:48:09 -0500
Received: from peff.net ([208.65.91.99]:51521 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787AbZKEHsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 02:48:09 -0500
Received: (qmail 20737 invoked by uid 107); 5 Nov 2009 07:51:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 05 Nov 2009 02:51:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Nov 2009 02:48:08 -0500
Content-Disposition: inline
In-Reply-To: <7vhbtai2uy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132207>

On Wed, Nov 04, 2009 at 10:03:49AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Nov 04, 2009 at 07:41:28AM +0100, Sverre Rabbelier wrote:
> >
> >> On Wed, Nov 4, 2009 at 07:17, Tim Mazid <timmazid@hotmail.com> wrote:
> >> > So instead of invoking 'git checkout REMOTE/BRANCH', do 'git checkout -b
> >> > BRANCH REMOTE/BRANCH'.
> >> 
> >> Automagically doing 'git checkout -t remote/branch' when asked to do
> >> 'git checkout remote/branch' was suggested earlier on the list and I
> >> think there was even a patch that implemented it, not sure what the
> >> outcome of the series was. I do remember that Peff was annoyed by it
> >> at the GitTogether though so it might be a bad idea.
> >
> > It's in 'next' now.
> 
> Isn't it quite different?  What's in 'next' for 1.7.0 is to guess the
> user's intention when:

Sorry, yes, I just saw Sverre's comment and misread the original
proposal.  Checking out "$remote/$branch" will still detach the HEAD,
and I don't think anybody has a previous proposal to change that.

> I think this is primarily because the way this DWIM is totally silent in
> the transcript is misleading.  If you explain it the way I outlined above,
> I do not think there is any confusion.  That is, there is no way for the
> user to get confused if the command sequence were like so:
> 
>    $ git branch -t foo origin/foo
>    Branch foo set up to track remote branch foo from origin.
>    $ git checkout foo
>    Switched to a new branch 'foo'
> 
>    ... time passes ...
> 
>    $ git checkout foo
>    Switched to branch 'foo'
>    Your branch is behind 'origin/foo' by 1 commit, and can be fast-forwarded.
> 
> It could just be a matter of telling what we are doing a bit more
> explicitly when this DWIM kicks in.  How about this?
>
>    $ git checkout foo
>    (first forking your own 'foo' from 'origin/foo')
>    Branch foo set up to track remote branch foo from origin.
>    Switched to a new branch 'foo'

This is much better than the current behavior, IMHO. It at least says
what is going on, so a user who actually reads the message will have a
chance of knowing what happened.

The devil's advocate argument is that the difference between the "branch
-t" and the DWIM is that in the former, the user intentionally asks for
a new branch, whereas in the latter, they must realize (by reading and
understanding) that a new branch has been created.

Maybe that difference isn't relevant, and people actually read and
understand everything git says. Maybe not. I dunno. I don't think we
have any real data yet on how people will perceive the feature over
time, and I suspect the only way to get it is to release with it and see
what happens.

> In any case, I do not think the DWIM would kick in when you try to detach
> at remote branch head.  I did not check gitk code to find out the exact
> command line it uses, but I do not think it runs "checkout BRANCH".  The
> command needs to be at least "checkout REMOTE/BRANCH" to work the way it
> does now with any released version of git, and I would not be surprised if
> paulus was cautious enough to have spelled it as "refs/REMOTE/BRANCH" to
> avoid any potential ambiguity issues.

Yes, I was confused when I wrote the original. I agree that "checkout
REMOTE/BRANCH" from the command line should still detach. If gitk wants
to prevent people accidentally detaching HEAD, the context menu for
remote branch boxes should probably detect remote branches and say
something like "Create local branch 'foo' from 'origin/foo'".

-Peff
