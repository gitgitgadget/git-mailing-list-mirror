From: Jeff King <peff@peff.net>
Subject: Re: 'git clone' doesn't use alternates automatically?
Date: Mon, 2 Feb 2009 08:07:55 -0500
Message-ID: <20090202130755.GA8487@sigio.peff.net>
References: <885649360901301412jd5c6b0dne1eff1ff00dd043e@mail.gmail.com> <20090131071238.GC3033@coredump.intra.peff.net> <885649360901311208s4bc17ae3me2062b07b302291e@mail.gmail.com> <20090131215514.GB9415@coredump.intra.peff.net> <7v7i4b2bto.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James Pickens <jepicken@gmail.com>, Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 14:09:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTyYI-0000uq-Nm
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 14:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248AbZBBNHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 08:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754225AbZBBNHp
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 08:07:45 -0500
Received: from peff.net ([208.65.91.99]:52109 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753493AbZBBNHo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 08:07:44 -0500
Received: (qmail 8500 invoked by uid 1000); 2 Feb 2009 13:07:55 -0000
Content-Disposition: inline
In-Reply-To: <7v7i4b2bto.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108081>

On Sat, Jan 31, 2009 at 05:19:31PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   - without either, copy alternates from origin, but _don't_ use
> >     alternates while cloning
> 
> Are you talking about a local clone optimization that does hardlink from
> the source repository?

Sorry, I was wrong about what was happening. From reading James' posts
and not doing any experimenting or looking, I had the impression that
doing this:

  # plain repo
  mkdir repo1 &&
    (cd repo1 && git init &&
     echo content >file && git add . && git commit -m one)

  # repo with alternates, but extra content
  git clone -s repo1 repo2 &&
    (cd repo2 &&
     echo content >>file && git commit -a -m two)

  # clone of repo w/ alternates
  git clone repo2 repo3

would cause the final clone to set up the alternate to repo1, but still
pull in the objects. But that isn't the case, of course. Either:

  1. It is a local hardlink clone, in which case we just pull in the
     objects from repo2.

  2. It isn't, in which case we don't copy over the alternates.

> I am fairly certain that copying alternates from the source repository was
> not an intended behaviour but was a consequence of lazy coding of how we
> copy (or link) everything from it.  The original was literally the simple
> matter of:
> 
>     find objects ! -type d -print | cpio $cpio_quiet_flag -pumd$l "$GIT_DIR/"
> 
> whose intention was to copy objects/?? and objects/pack/. and it wasn't
> even part of the design consideration to worry about what would happen to
> the alternates the source repository might have in objects/info/.

Right, I think that is what is going on. And what I was suggesting in my
other email is that it is actively harmful to have this behavior,
because now repo3 depends on repo1, without the user having explicitly
asked for such a relationship (and they might not even be aware of
repo1).

I was tempted to suggest avoiding copying the alternates from repo2
to repo3. But you can't do that: repo2 is _missing_ objects that repo3
won't have. Without the alternates file pointing to repo1, repo3 is
corrupt. So simply avoiding copying the alternates file doesn't work;
one would have to actually pull the missing objects in from the
alternate before doing so.

But actually, I think there is even more breakage in hardlinking the
alternates file: alternates files can be relative paths. So if repo2
points to "../../../repo1/.git/objects" (which it doesn't in the example
above, as "clone -s" uses absolute paths -- but it is easy enough to
construct a broken case), then repo3 will gain that alternate pointer,
but may be in a totally different directory where that relative path is
broken. And then repo3 is corrupt. So the alternates must be copied and
any relative paths munged for it to work reliably.

The hardlink code operates by default because it was thought to be a
safe optimization that couldn't bite people. But it interacts badly with
the concept of alternates. So I think a sane fix would be to disable
hardlinking if the parent repo is using alternates at all. Then a
vanilla "git clone repo2 repo3" will do the safe but more costly
behavior of actually copying the objects. If the user wants to accept
the risks of alternates, then he can give "-s" explicitly, and git will
track the alternates recursively through repo2 to repo1 at runtime.

-Peff
