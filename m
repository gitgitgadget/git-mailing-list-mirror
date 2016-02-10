From: Jeff King <peff@peff.net>
Subject: Re: RFC: Resumable clone based on hybrid "smart" and "dumb" HTTP
Date: Wed, 10 Feb 2016 16:49:46 -0500
Message-ID: <20160210214945.GA5853@sigill.intra.peff.net>
References: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
 <CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 10 22:49:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTce2-0003FT-At
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 22:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbcBJVtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 16:49:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:40032 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751935AbcBJVts (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 16:49:48 -0500
Received: (qmail 18101 invoked by uid 102); 10 Feb 2016 21:49:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Feb 2016 16:49:48 -0500
Received: (qmail 32102 invoked by uid 107); 10 Feb 2016 21:49:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Feb 2016 16:49:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Feb 2016 16:49:46 -0500
Content-Disposition: inline
In-Reply-To: <CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285934>

On Wed, Feb 10, 2016 at 12:11:46PM -0800, Shawn Pearce wrote:

> On Wed, Feb 10, 2016 at 10:59 AM, Shawn Pearce <spearce@spearce.org> wrote:
> >
> > ... Thoughts?
> 
> Several of us at $DAY_JOB talked about this more today and thought a
> variation makes more sense:
> 
> 1. Clients attempting clone ask for /info/refs?service=git-upload-pack
> like they do today.
> 
> 2. Servers that support resumable clone include a "resumable"
> capability in the advertisement.

Because the magic happens in the git protocol, that would mean this does
not have to be limited to git-over-http. It could be "resumable=<url>"
to point the client anywhere (the same server over a different protocol,
another server, etc).

> 3. Updated clients on clone request GET /info/refs?service=git-resumable-clone.
> 
> 4. The server may return a 302 Redirect to its current "mostly whole"
> pack file. This can be more flexible than "refs/heads/*", it just
> needs to be a mostly complete pack file that contains a complete graph
> from any arbitrary roots.

And with "resumable=<url>", the client does not have to hit the server
to do a redirect; it can go straight to the final URL, saving a
round-trip.

> 5. Clients fetch the file using standard HTTP GET, possibly with
> byte-ranges to resume.
> 
> 6. Once stored and indexed with .idx, clients run `git fsck
> --lost-found` to discover the roots of the pack it downloaded. These
> are saved as temporary references.

Clients do not have to _just_ fetch a packfile. They could get a bundle
file that contains the roots along with the packfile. I know that one of
your goals is not duplicating the storage of the packfile on the server,
but it would not be hard for the server to store the packfile and the
bundle header separately, and concatenate them on the fly.

Right now the clients can't clone from bundles directly via HTTP. I
wrote patches for that ages ago, but got stuck on this very issue
(basically that I had to spool the bundle and then clone from it, which
temporarily doubled the client's disk space requirements). One
alternative would be to amend the bundle format so that rather than a
single file, you get a bundle header whose end says "...and my matching
packfile is 1234-abcd". And then the client knows that they can fetch
that separately from the same source.

It's an extra HTTP request, but it makes the code for client _and_
server way simpler. So the whole thing is basically then:

  0. During gc, server generates pack-1234abcd.pack. It writes matching
     tips into pack-1234abcd.info, which is essentially a bundle file
     whose final line says "pack-1234abcd.pack".

  1. Client contacts server via any git protocol. Server says
     "resumable=<url>". Let's says that <url> is
     https://example.com/repo/clones/1234abcd.bundle.

  2. Client goes to <url>. They see that they are fetching a bundle,
     and know not to do the usual smart-http or dumb-http protocols.
     They can fetch the bundle header resumably (though it's tiny, so it
     doesn't really matter).

  3. After finishing the bundle header, they see they need to grab the
     packfile. Based on the bundle header's URL and the filename
     contained within it, they know to get
     https://example.com/repo/clones/pack-1234abcd.pack". This is
     resumable, too.

  4. Client clones from bundled pack as normal; no root-finding magic
     required.

  5. Client runs incremental fetch against original repo from step 1.

And you'll notice, too, that all of the bundle-http magic kicks in
during step 2 because the client sees they're grabbing a bundle. Which
means that the <url> in step 1 doesn't _have_ to be a bundle. It can be
"go fetch from kernel.org, then come back to me".

> An advantage to this process is its much more flexible for the server.
> There is no additional pack-*.info file required. GC can organize
> packs anyway it wants, etc.

Yes, it's much better than your original email, at least for GitHub
servers. We're not very flexible with GC tricks, because we need bitmaps
to work, and because we get a lot of benefit from sharing the object
storage for forks of a single repository.

> To make step 4 really resume well, clients may need to save the first
> Location header it gets back from
> /info/refs?service=git-resumable-clone and use that on resume. Servers
> are likely to embed the pack SHA-1 in the Location header, and the
> client wants to use this on subsequent GET attempts to abort early if
> the server has deleted the pack the client is trying to obtain.

You could possibly do away with this trick if the server hands out a
unique URL in its "resumable" header. Though I imagine it might be
convenient for server admins to always point to a generic url, and
put the logic in the HTTP layer.

OTOH, if you do the "split bundle" thing I mentioned above, then this
happens for free. The client caches the bundle header it grabs in my
step 2, and then that contains the unique pack name to fetch in step 3.

-Peff
