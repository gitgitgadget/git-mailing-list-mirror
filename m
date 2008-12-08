From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] diff: allow turning on textconv explicitly for
	plumbing
Date: Sun, 7 Dec 2008 23:59:24 -0500
Message-ID: <20081208045924.GA22780@coredump.intra.peff.net>
References: <20081208025700.GB22072@coredump.intra.peff.net> <7vfxkz9v8f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 06:00:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9YEe-00014o-Kd
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 06:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754704AbYLHE71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 23:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754741AbYLHE71
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 23:59:27 -0500
Received: from peff.net ([208.65.91.99]:4102 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754260AbYLHE70 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 23:59:26 -0500
Received: (qmail 21970 invoked by uid 111); 8 Dec 2008 04:59:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 07 Dec 2008 23:59:25 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Dec 2008 23:59:24 -0500
Content-Disposition: inline
In-Reply-To: <7vfxkz9v8f.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102528>

On Sun, Dec 07, 2008 at 07:55:12PM -0800, Junio C Hamano wrote:

> But I am not 100% sure if the scripting part is "the right way".
> 
> If a script wants to take whatever Porcelain users are happy as the
> "presentation for human consumption" and pass that through as its own
> output to the end user, maybe it is better off reading from Porcelain,
> instead of reading from the plumbing (the latter of which requires making
> the plumbing output less reliable)?

But I don't think having gitk call the porcelain makes sense, either.
That would enable, for example, external diff drivers which might
actually spawn an entirely new window. And I don't think most people
would want that from gitk.

Now, obviously it could call "git diff --no-ext-diff" to opt out of
that. But I think it is backwards to call porcelain but opt out of
features that you don't want. It makes more sense to start with the bare
minimum (i.e., plumbing) and opt in to features that you are OK with.

And yes, you increase the risk that a script which blindly passes
options to plumbing may now be asked to generate a textconv'd diff which
will be useless to the user. But:

  1. that is already a risk with --ext-diff

  2. it is actually a _feature_. It is asking the user to say "is this
     a sane option to pass for my situation or not" instead of forcing
     the script to make that decision.

> When we later enhance textconv output from the "diff" Porcelain to
> benefit interactive users, it will automatically help the script that
> passes through the "diff" output to the end users.

I'm not sure what enhancement you mean. But it is possible that gitk
would not _want_ such an enhancement, and it would then have to opt out
of it.

> You can certainly argue that this "textconv" feature that is grafted from
> Porcelain into plumbing is a special case in that its output is subject to
> change any time to help human consumption and we never strive for its
> stability as we do for other features in the plumbing to support machine
> readability by scripts.  You can propagate the later enhancement of
> textconv diff output we'd make for Porcelain to the scripted users that
> reads from the plumbing that way.

Right. _If_ it's a change that won't upset any plumbing consumers. If it
is, then it needs to be a separate option so that the plumbing consumers
who don't mind the change can start using it.

> But then wouldn't it be the same for these scripts that do value the
> "presentation meant for human consumption" over "machine readability" to
> read from Porcelain?  That would not have to blur the distinction between
> the Porcelain and plumbing like the approach you are suggesting here.

I don't agree that this is blurring the distinction. I don't see
textconv diffs as a "porcelain feature" that has been grafted on to
plumbing. I see it as a core diff feature which can be turned off or on.
Porcelain has it on by default, and plumbing has it off by default. But
you can ask either to change their default settings[1].

-Peff

[1]: You can argue that the current implementation is buggy in this
sense, though, since some porcelains will accept "--textconv" but not
change their behavior. I think blame, for example, will have that
problem, because it accepts diff options but does not necessarily use
them to create diffs. But I think that just means we have a bug and
eventually should handle the case of "git blame --textconv" correctly.
