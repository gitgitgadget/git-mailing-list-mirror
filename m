From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Support multiple virtual repositories with a single
 object store and refs
Date: Tue, 24 May 2011 15:59:37 -0400
Message-ID: <20110524195937.GE584@sigill.intra.peff.net>
References: <20110524010252.GA5368@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jamey Sharp <jamey@minilop.net>
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Tue May 24 22:00:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOxlf-00064O-Uy
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 21:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201Ab1EXT7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 15:59:41 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57238
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753245Ab1EXT7k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 15:59:40 -0400
Received: (qmail 21209 invoked by uid 107); 24 May 2011 19:59:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 May 2011 15:59:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 May 2011 15:59:37 -0400
Content-Disposition: inline
In-Reply-To: <20110524010252.GA5368@leaf>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174338>

On Mon, May 23, 2011 at 06:02:52PM -0700, Josh Triplett wrote:

> Given many repositories with copies of the same objects (such as
> branches of the same source), sharing a common object store will avoid
> duplication.  Alternates provide a single baseline, but don't handle
> ongoing activity in the various repositories.  Git safely handles
> concurrent accesses to the same object store across repositories, but
> operations such as gc need to know about all of the refs.
> 
> This change adds support in upload-pack and receive-pack to simulate
> multiple virtual repositories within the object store and references of
> a single underlying repository.

Neat idea. It is important to note, though, that it is possible to leak
information between virtual repos that share the same object store. You
can't directly say "give me object ABCD" if you don't have a ref to it,
but you can do some other sneaky things like:

  1. Claiming to push ABCD, at which point the server will optimize out
     the need for you to actually send it. Now you have a ref to ABCD
     and can fetch it (claiming not to have it, of course).

  2. Requesting other refs, claiming that you have ABCD, at which point
     the server may generates deltas against ABCD.

Both are problems with alternates, too, of course. But in the case of
alternates, you can share only a subset of the objects. So every day or
so, you could pack all of the objects that _all_ repos can see into one
big alternates repo, and then each "leaf" repo contains any objects
private to itself.

Of course none of this is a concern if you are just hosting public
repositories, or everyone who gets to see one virtual repo can see
what's in other ones (e.g., everybody is sharing objects within one
organization).

But it may make sense to touch on these issues in the documentation
(which also needs to be written at all :) ).

> The refs and heads of the virtual repositories get stored in the
> underlying repository using prefixed names specified by the
> --ref-prefix and --head options; for instance, --ref-prefix=repo1/
> will use refs/repo1/heads/* and refs/repo1/tags/*.  upload-pack and
> receive-pack will not expose any references that do not match the
> specified prefix.

You have a namespace clash if a repo is named "heads" or "tags" or
"remotes". Should we give it its own namespace, like:

  refs/virtual/repo1/heads/*

?

Also, it seems conceptually simpler to me if it's a straight prefix.
IOW, "refs/heads/foo" in repo1 becomes:

  refs/virtual/repo1/refs/heads/foo

Then if we are operating in the virtual repo1 space, then:

  1. It is an easy test to know whether we are allowed to see a ref:
     "does it start with refs/virtual/$repo/ ?"

  2. Converting back and forth is simple. You just prepend or strip the
     refs/virtual/$repo prefix.

-Peff
