From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] config: allow including config from repository blobs
Date: Thu, 26 Jan 2012 19:49:02 -0500
Message-ID: <20120127004902.GA15257@sigill.intra.peff.net>
References: <20120126073547.GA28689@sigill.intra.peff.net>
 <20120126074208.GD30474@sigill.intra.peff.net>
 <7vbopq2mk9.fsf@alter.siamese.dyndns.org>
 <20120126230054.GC12855@sigill.intra.peff.net>
 <7vsjj20yog.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 01:49:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rqa08-0000Mo-2G
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 01:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518Ab2A0AtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 19:49:07 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46113
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754507Ab2A0AtG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 19:49:06 -0500
Received: (qmail 32124 invoked by uid 107); 27 Jan 2012 00:56:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jan 2012 19:56:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2012 19:49:02 -0500
Content-Disposition: inline
In-Reply-To: <7vsjj20yog.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189181>

On Thu, Jan 26, 2012 at 04:35:59PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So yeah, if you are just going to copy it once, or even periodically, it
> > is not that big an advantage. And the example I gave using "git tag" did
> > just that. But I also wanted to allow more complex things, like this:
> >
> >   # clone and inspect
> >   git clone git://example.com/project.git
> >   cd project
> >   git show origin:devtools/std_gitconfig
> >
> >   # well, that looks pretty good. But I'd like to tweak something.
> >   git checkout -b config origin
> >   $EDITOR devtools/std_gitconfig
> >   git commit -a -m "drop the foo option, which I hate"
> >
> >   # OK, let's use it now.
> >   git config include.ref config:devtools/std_gitconfig
> >
> >   # Weeks pass. Somebody else updates the std_gitconfig.
> >   git fetch
> >   # let's inspect the changes
> >   git checkout config
> >   git diff @{u} -- devtools/std_gitconfig
> >   # looks good, let's merge (not copy!) them in
> >   git merge @{u}
> >
> > This is obviously an advanced thing to be doing.
> 
> The "which *I* hate" in the log message makes it sound as if it is a
> personal preference, but in fact this is more about maintaining the
> recommended configuration among participants, no?

No, I meant it explicitly to be about this single user hating it. Note
how the resulting commits are never pushed. It is purely a local
override, but with the added bonus that history is tracked so you can
merge in further changes from upstream.

Of course, you could also share it with others, or do whatever. Once
it's tracked by git, you can be as flexible as you like.

> And if you have the source of the configuration on a branch so that
> people can work on it among themselves, then "config.path =
> ../devtools/std_gitconfig" should be sufficient, no?

Yes, you _could_ just keep it in a branch, merge upstream's changes into
the branch, and then periodically copy it out to your .git directory.
But this removes that final step.

It also does allow "[include]ref = origin/meta:gitconfig" if you want to
live dangerously. I consider that a feature, because it lets the user
make the security tradeoff they deem appropriate. Yes, I want to have
git be secure by default, and yes I want to encourage awareness of the
issues in the documentation for the feature. But I suspect in practice
that many people fetch changes and run "make" without looking at them,
which is basically the exact same hole. If a user has already accepted
that risk, why deny them the convenience of accepting it somewhere else?

> The pros-and-cons between the volume of the change to read include from
> blobs and the benefit illustrated in the use case did not look too good to
> me, at least from the messages in this thread so far.

I didn't think the read-from-blob code was very big or complex (most of
the refactoring was to support parsing an arbitrary buffer, but I think
that may be a good thing to have in the long run, anyway).

But I guess that is all a matter of opinion.

-Peff
