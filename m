From: Jeff King <peff@peff.net>
Subject: Re: RefTree: Alternate ref backend
Date: Thu, 17 Dec 2015 17:10:45 -0500
Message-ID: <20151217221045.GA8150@sigill.intra.peff.net>
References: <CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>, David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 17 23:11:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9glk-0006eV-OO
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 23:11:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933408AbbLQWKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 17:10:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:43948 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932226AbbLQWKs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 17:10:48 -0500
Received: (qmail 17531 invoked by uid 102); 17 Dec 2015 22:10:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Dec 2015 16:10:47 -0600
Received: (qmail 18436 invoked by uid 107); 17 Dec 2015 22:10:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Dec 2015 17:10:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Dec 2015 17:10:45 -0500
Content-Disposition: inline
In-Reply-To: <CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282680>

On Thu, Dec 17, 2015 at 01:02:50PM -0800, Shawn Pearce wrote:

> I started playing around with the idea of storing references directly
> in Git. Exploiting the GITLINK tree entry, we can associate a name to
> any SHA-1.

Gitlink entries don't imply reachability, though. I guess that doesn't
matter if your ref backend says "no, really, these are the ref tips, and
they are reachable".  But you could not push the whole thing up to
another server and expect it to hold the whole graph.

Which is not strictly necessary, but to me seems like the real advantage
of using git objects versus some other system.

Of course, the lack of reachability has advantages, too. You can
drop commits pointed to by old reflogs without rewriting the ref
history. Unfortunately you cannot expunge the reflogs at all. That's
good if you like audit trails. Bad if you are worried that your reflogs
will grow large. :)

> By storing all references in a single tree, atomic transactions are
> possible. Its a simple compare-and-swap of a single 40 byte SHA-1.
> This of course leads to a bootstrapping problem, where do we store the
> 40 byte SHA-1? For this example its just $GIT_DIR/refs/txn/committed
> as a classical loose reference.

Somehow putting it inside `refs/` seems weird to me, in an infinite
recursion kind of way.  I would have picked $GIT_DIR/REFSTREE or
something. But that is a minor point.

> Configuration:
> 
>   [core]
>     repositoryformatversion = 1
>   [extensions]
>     refsBackendType = RefTree

The semantics of extensions config keys are open-ended. The
formatVersion=1 spec only says "if there is a key you don't know about,
then you may not proceed". Now we're defining a refsBackendType
extension. It probably makes sense to write up a few rules (e.g., is
RefTree case-sensitive?).

-Peff
