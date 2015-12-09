From: Jeff King <peff@peff.net>
Subject: Re: publish from certain commit onward, keeping earlier history
 private, but provable
Date: Wed, 9 Dec 2015 17:20:41 -0500
Message-ID: <20151209222041.GB21751@sigill.intra.peff.net>
References: <35583CFA-3BEE-4844-9F85-ED73A412A97F@joernhees.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?SsO2cm4=?= Hees <dev@joernhees.de>
X-From: git-owner@vger.kernel.org Wed Dec 09 23:20:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6n6Q-0006bj-35
	for gcvg-git-2@plane.gmane.org; Wed, 09 Dec 2015 23:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbbLIWUp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2015 17:20:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:39514 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753382AbbLIWUo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2015 17:20:44 -0500
Received: (qmail 2496 invoked by uid 102); 9 Dec 2015 22:20:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Dec 2015 16:20:44 -0600
Received: (qmail 14031 invoked by uid 107); 9 Dec 2015 22:20:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Dec 2015 17:20:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Dec 2015 17:20:41 -0500
Content-Disposition: inline
In-Reply-To: <35583CFA-3BEE-4844-9F85-ED73A412A97F@joernhees.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282200>

On Wed, Dec 09, 2015 at 02:45:44PM +0100, J=C3=B6rn Hees wrote:

> I've been hacking away on a library for quite some time and have a lo=
t of commits in my private repository:
>=20
> A -> B -> C -> D -> E
>=20
> Finally, I'm nearing completion of a first version, and want to
> publish it to a remote called public from D onward keeping A..C to
> myself, so public should afterwards look like this:
>=20
> D -> E

The short answer is that you cannot do this without changing the names
(i.e., sha1 commit ids) of D and E.

One of the fundamental assumptions git makes is that if a repository ha=
s
an object X, it also has all of the objects reachable from it (past
commits, their trees, subtrees, and blobs). This is what makes the
push/fetch object transfer efficient (one side says only "I have X" and
the other side knows "Ah, that is a whole chunk of objects I do not hav=
e
to bother sending", without the names of those objects going over the
wire).

The exception, of course, is shallow clones, where one side tells the
other "I am shallow at cutoff point Y; don't assume I have anything
below there". This does work, but there are some downsides (for
instance, we cannot apply some of the same reachability optimizations
for serving fetches).

>   I can verify that local_public only contains D -> E and that the
>   commit, tree and parent hashes are the same, which is exactly what =
i
>   want.
>  =20
>   The problem is that when i try to push to an added public remote
>   from local_public i get an error like this:
>  =20
>   ! [remote rejected] master -> master (shallow update not allowed)

Right. The receiver must be explicitly configured to accept a shallow
push (I do not recall offhand whether clients fetching from you would
also need an explicit config to accept a shallow history).

So the usual path here is to rewrite D and E (with the same trees, but
they will get new commit ids). If you want to retain the older history
(commits A-C), you can distribute it separately and use git-replace to
"graft" it onto the newer history at run-time.

You can do that with:

  # set up a run-time replacement view so that D appears to have
  # no parents; this doesn't impact the objects themselves, but
  # rather git will use our parent-less "replacement" D anytime
  # somebody mentions the original
  git replace --graft D

  # verify that the history is what you want; if you have a non-linear
  # history you may have to make several such "cuts" in the graph
  git log

  # now cement it into place by rewriting
  git filter-branch

Of course that is a bitter pill to swallow if you have reasons for
wanting to use the old sha1s. E.g., you have internal development
proceeding against the old tree and want to share a truncated version
with the public.  In that case I still think the least painful thing is
to rewrite the truncated history, have _everyone_, internal and public
work against that, and let internal folks graft the old history on for
their own use. They can do that with:

  git replace --graft the-rewritten-D the-original-C

-Peff
