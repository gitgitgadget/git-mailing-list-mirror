From: Jeff King <peff@peff.net>
Subject: Re: 'git clone' doesn't use alternates automatically?
Date: Tue, 3 Feb 2009 01:06:08 -0500
Message-ID: <20090203060608.GA21367@sigill.intra.peff.net>
References: <885649360901301412jd5c6b0dne1eff1ff00dd043e@mail.gmail.com> <20090131071238.GC3033@coredump.intra.peff.net> <885649360901311208s4bc17ae3me2062b07b302291e@mail.gmail.com> <20090131215514.GB9415@coredump.intra.peff.net> <7v7i4b2bto.fsf@gitster.siamese.dyndns.org> <20090202130755.GA8487@sigio.peff.net> <7v7i48f8gj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James Pickens <jepicken@gmail.com>, Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 07:07:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUERf-0007Ys-HF
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 07:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbZBCGGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 01:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbZBCGGN
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 01:06:13 -0500
Received: from peff.net ([208.65.91.99]:37023 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917AbZBCGGN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 01:06:13 -0500
Received: (qmail 14856 invoked by uid 107); 3 Feb 2009 06:06:24 -0000
Received: from c-75-75-4-229.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (75.75.4.229)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 03 Feb 2009 01:06:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Feb 2009 01:06:08 -0500
Content-Disposition: inline
In-Reply-To: <7v7i48f8gj.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 02, 2009 at 08:30:36PM -0800, Junio C Hamano wrote:

> To be fair, I think it was proposed/implemented by somebody who almost
> never uses alternates himself, and certainly never a relative alternates.
> The intention of hardlinking was while saving tons of disk space, still be
> independent from the original repository.
> 
> Back when e95ab1e ([PATCH] Short-circuit git-clone-pack while cloning
> locally (take 2)., 2005-07-06) was done, the packfile implementation was

Well, in your defense, relative alternates didn't come about until two
months later, in ccfd3e9. So you can blame the author of that patch for
screwing up your existing work. :)

> still only a week old, and hardlinking made a lot of sense from space
> saving's point of view.  These days, if you make a local hardlinked clone,
> work a little there and then repack it, most of the space saving will be
> gone; there isn't much point in the hardlink optimization anymore from
> that angle, even though it still is a good compromise between the clone
> speed and safety, especially when no alternates are involved.

True. But I still think the hardlinks are nice for one-off repositories.
Every once in a while I want to start a new topic or experiment while my
repository is a mess; it's nice to just "git clone git foo", hack around
in the work directory, and blow it away. And the hardlinks make that
first step a _lot_ faster.

But I also don't mind having to add a command-line option to get the
speed. And for my use case, there really isn't a benefit to hardlinks
over alternates.

> I think a possible fix would be not to copy alternates file literally, but
> install an alternates file to directly borrow from the same repositories
> the clone-source repository borrows from ourselves, taking relative paths
> into account.  Another would be to look at the alternates and hardlink the
> objects and packs while cloning, and if the repositories involved reside
> across filesystem boundaries, we need to fall back to copying.

Yes, either of those would work. But I wonder if it is really worth the
complexity. When I suggested just ditching hardlinks if the remote uses
alternates, my thought was that most people won't really care. Either
they use alternates, in which case they should be providing "-s" and
not doing hardlinks, or they don't, in which case things will happen as
usual.

But reading your response, I wonder if it is worth keeping the hardlink
optimization around at all; getting rid of it would simplify the code
and the explanation of why "git clone foo" is different from "git clone
file://$PWD/foo".  If people want a fast, dependent clone, they can use
"-s". I guess hardlinks are also useful for a fast "git clone foo bar;
rm -rf foo". But I'm not sure how common that is.

-Peff
