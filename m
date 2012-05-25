From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Add possibility to store configuration in
 ~/.config/git/config file
Date: Fri, 25 May 2012 17:44:07 -0400
Message-ID: <20120525214406.GA10064@sigill.intra.peff.net>
References: <1337975239-17169-1-git-send-email-nguyenhu@ensibm.imag.fr>
 <20120525203056.GC4364@sigill.intra.peff.net>
 <7vd35sq7fx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: NGUYEN Huynh Khoi Nguyen <nguyenhu@ensimag.imag.fr>,
	git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 25 23:44:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY2J0-0003IN-C9
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 23:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683Ab2EYVoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 17:44:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56192
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754657Ab2EYVoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 17:44:09 -0400
Received: (qmail 14080 invoked by uid 107); 25 May 2012 21:44:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 May 2012 17:44:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 May 2012 17:44:07 -0400
Content-Disposition: inline
In-Reply-To: <7vd35sq7fx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198529>

On Fri, May 25, 2012 at 02:25:38PM -0700, Junio C Hamano wrote:

> > At first people will have only one or the other, but people using
> > multiple versions of git, or people following already-written
> > instructions on the web about modifying ~/.gitconfig could end up with
> > both.
> 
> Isn't it actually much worse than that?
> 
> If you read from .gitconfig and also from the new location, but update
> only the new location, people who use two versions of git will be in a
> very confusing situation.  Randomly, some of their updates are always in
> effect, and others only appear sometimes, and after wasting a lot of time
> and hair scratching their heads, they will realize that writing with old
> versions of Git will store values to a place visible to both versions,
> while writing with new versions will store values to a place visible only
> to new versions.

That's true, but...

> I'd rather see it ignore the new location as long as ~/.gitconfig exists
> (and if only the new location exists, read from and write to it), and have
> users make a conscious decision to transition.  That is:
> 
>  - If ~/.gitconfig exists, do not do anything new.  Just exercise the
>    original code.  For these users, ~/.config/ does _not_ exist as far as
>    Git is concerned.
> 
>  - (optional) If ~/.gitconfig exists, offer _moving_ it to the new
>    location after telling the user to make sure that the user will never
>    use older version of git again, and move it if the user agrees.
> 
>  - Otherwise, read from and write to the new location.

That doesn't solve all problems with multiple versions, though. For
example, this sequence:

  1. User consciously moves to new location, moving ~/.gitconfig to
     ~/.config/git/config (or perhaps they do not do so consciously, but
     do not have a ~/.gitconfig at all, and run "git config --global"
     with the new version.

  2. User runs "git config --global" with an old version of git, which
     writes to ~/.gitconfig.

After step 1, old versions of git will not respect the user's config at
all. This is unavoidable; the old version does not know about the new
location.

But after step 2, _all_ versions of git have stopped respecting the new
location (because ~/.gitconfig takes precedence). Whereas if we read
from everywhere, then it is broken only in older versions (which are
broken anyway).

So I consider it the lesser of two evils. The rule is much simpler: "old
versions of git do not know about this new location". Which is
unavoidable, and easier to explain than "Old versions of git do not know
about this location. New versions do, but will sometimes ignore
depending on whether this other file exists, which might have been
created by an old version".

However, let's take a step back for a minute. I think the real issue is
writing to the XDG location without the user knowing about it. So a
better transition plan would be:

  1. Start reading from the XDG location in addition to the old
     location. Always write to the old location.

  2. Wait N time units until everybody reasonable has a version that
     does (1).

  3. Start writing to the XDG location by default. Keep reading from the
     old version for compatibility.

People who want to start using the new location after step 1 are free to
do so; they just shouldn't expect git to write to it, and they should
accept the obvious caveat that older versions of git will not understand
it. An optional addendum is that we could start writing to the XDG
location after step 1 only if it exists, which implies that the user has
decided it's OK to do so (which is still a guess; they might have wanted
to split their config intentionally).

-Peff
