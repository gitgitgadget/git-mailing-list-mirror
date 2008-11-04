From: Jeff King <peff@peff.net>
Subject: Re: CRLF support bugs (was: Re: .gitattributes glob matching
	broken)
Date: Tue, 4 Nov 2008 00:14:32 -0500
Message-ID: <20081104051432.GD31276@coredump.intra.peff.net>
References: <83od0yaxzk.fsf@kalahari.s2.org> <20081103090932.GA18424@coredump.intra.peff.net> <83y700alzf.fsf_-_@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Hannu Koivisto <azure@iki.fi>
X-From: git-owner@vger.kernel.org Tue Nov 04 06:15:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxEGd-0001ak-0B
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 06:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbYKDFOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 00:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbYKDFOf
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 00:14:35 -0500
Received: from peff.net ([208.65.91.99]:1308 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132AbYKDFOe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 00:14:34 -0500
Received: (qmail 5187 invoked by uid 111); 4 Nov 2008 05:14:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 04 Nov 2008 00:14:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Nov 2008 00:14:32 -0500
Content-Disposition: inline
In-Reply-To: <83y700alzf.fsf_-_@kalahari.s2.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100037>

On Mon, Nov 03, 2008 at 05:05:24PM +0200, Hannu Koivisto wrote:

> I suspect one part of that "oddness" was caused by git applying its
> heuristics in checkout as it doesn't use .gitattributes at that
> time.

It _does_ apply them in checkout, you just didn't have a .gitattributes
file yet. So it is part of the same problem.

> For example, it seems that it recognized some of my .sh
> files as text files and the rest as binary files.  I suppose I was
> correct to assume that it would be stupid to rely on git guessing
> file type and the only sensible way is to use .gitattributes.  If

I think it depends on what's in your scripts, since many people have not
had trouble with the auto-detection. Perhaps some are UTF-16 which
contain NULs?

If the auto-detection is not working, I am sure people would love to see
samples of what fooled it (since it is, after all, just a guess, and we
would like to make the guess more accurate).

> > To "fix" this, you can then do a "git reset --hard" which will respect
> > your .gitattributes (since it is now checked out). And further file
> > creation and checkout should work OK.
> 
> Since I'm trying to launch git in a company environment, I think I
> can't rely on people remembering to do that.

Oh, absolutely. I think this is a shortcoming in git. The reset is
simply a workaround until it is actually fixed.

> Actually, even if .gitattributes were applied in checkout, I think
> the whole CRLF support is broken by design because people will have
> to remember to use -n in clone, then enable core.autocrlf support
> and then checkout.  This makes it unneccessarily complicated to

Yes, that is a little bit annoying. I think there are four options:

  - people set core.autocrlf in their global ~/.gitconfig. The downside,
    as you mentioned, is that you might not want it for all projects

  - clone should take an extra "options" parameter which can set this up
    after doing the 'init'. Like:

      git clone -O core.autocrlf=true /path/to/repo

  - after setting autocrlf, people need to tell git to re-checkout with
    the updated settings. I don't know of a straightforward way to tell
    git everything needs to be updated. So I would do:

      git ls-files | xargs touch
      git reset --hard

    which is not ideal. Probably some sort of "re-checkout" option to
    git-checkout would be better.

  - you could do this "re-checkout" automagically when core.autocrlf is
    set via "git config". There are two obvious problems with this
    magic, though:

      - that may not be what the user wants, if they have work in
        progress in the directory. And normally calling "git config"
        has no such side effects, so it is certainly unexpected.

      - we don't even know when the config is updated, since the user
        may simply edit the file behind git's back

    So that is a little too magic for my taste.

> I think CRLF conversion support should have some attribute (be it
> .gitattributes attribute or something else) that is somehow
> inherited from the parent repository.  It would basically say that
> "you should use platform's native line end type for text files with
> this repository and its children".  To go with that, one would
> maybe have a configuration option to tell what that platform
> default line end type is (just in case someone wants to pretend
> Cygwin is Unix or something like that).

I think others have complained before about something like this, in that
it really is a _local_ decision and not a _project_ decision to make. I
am fortunate enough to work exclusively on platforms with sane line
endings, so I don't know what is normal.

But if you really wanted to do such a thing for some set of corporate
users, maybe it would make sense to have a "clone" hook that runs after
init and can set up any relevant config (e.g., by copying certain config
values from the parent repo).

-Peff
