From: Jeff King <peff@peff.net>
Subject: Re: [Q] Encrypted GIT?
Date: Thu, 13 Mar 2008 11:53:22 -0400
Message-ID: <20080313155322.GA30847@coredump.intra.peff.net>
References: <c6c947f60803130148w7981a3f0r718c0801343c7b78@mail.gmail.com> <20080313114738.GC2414@genesis.frugalware.org> <alpine.LSU.1.00.0803131254580.1656@racer.site> <20080313121644.GD2414@genesis.frugalware.org> <20080313125853.GA12927@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 13 16:54:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZpkx-0005gg-4q
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 16:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbYCMPx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 11:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753321AbYCMPx1
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 11:53:27 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1657 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753290AbYCMPx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 11:53:26 -0400
Received: (qmail 9513 invoked by uid 111); 13 Mar 2008 15:53:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 13 Mar 2008 11:53:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2008 11:53:22 -0400
Content-Disposition: inline
In-Reply-To: <20080313125853.GA12927@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77097>

On Thu, Mar 13, 2008 at 08:58:54AM -0400, Theodore Tso wrote:

> No, and you wouldn't want to use gpg because of the overhead it adds
> around an encrypted message.  You would need to use a raw encryption
> algorithm, or one with very minimal wrapping.  It's normally at this

Well, "raw encryption algorithm" is a bit vague here. :)

I thought about this a while ago and come to a few conclusions:

  - encrypting before git sees content sucks, because you are either
    sacrificing security (content X always encrypts to Y) or system
    stability (git doesn't know that Y and Y' are really the same thing)

  - encrypting at the object level (when we do zlib) sucks, because we
    still want to name contents by their hash, which means the object
    database index contains information about what's in your content.
    There's also some per-object overhead. Plus any system without the
    key can't do deltas.

  - encrypting whole packfiles sucks for local storage, since you lose
    the random access property (unless you go with something static like
    an ECB mode, but then you are sacrificing security).

  - encrypting whole packfiles is a bit better for transport. The
    key-holding repo does the deltas and just treats the remote repo as
    dumb storage (it can't be smart, since that would involve looking at
    the data). Storage overhead is minimal if packfiles are a reasonable
    size.

So I think the last makes the most sense, where your local repo is
totally unprotected, but you efficiently push git objects to a remote
untrusted repo.

You could probably do something totally external to git using bundles as
the primitive. Store an encrypted index on the remote that says "here
are the packs I have, and the objects they contain." Whenever you push,
pull the index (which is of course more network-intensive than regular
git protocol, but not as bad as pulling all the data) and calculate a
thin-pack bundle yourself. Encrypt the bundle and store remotely.

> point that that you'd need to bring in a security expert to ask a
> whole lot of questions about your exact use scenario, do a formal
> threat analysis, since there are all sorts of unanswered questions
> about what kind of key management solution you really need for your
> situation.

I don't know if a formal thread analysis is necessary. I think most
people are interested in "if the contents of remote storage X are
known, how much do people know about the _contents_ of my repo stored on
X?" and they don't care about masking the size, time of updates, etc.

That's a fairly straightforward application of cryptography. The tricky
part is doing it in a way that can still leverage some of git's
efficiencies.

> It's usually not as simple as "just encrypt it".  How many people need
> to have access to the to the repository?  Do you need to revoke access
> to the repository later?  Who is allowed to give a new person access
> to the repository?  etc., etc., etc.

Sure, those are all interesting questions for a complete system. But I
think it makes sense to incrementally try the basics first.

-Peff
