From: Jeff King <peff@peff.net>
Subject: Re: New Feature wanted: Is it possible to let git clone continue
 last break point?
Date: Wed, 2 Nov 2011 22:42:48 -0400
Message-ID: <20111103024248.GA9492@sigill.intra.peff.net>
References: <CAEZo+gfKVY-YgMjd=bEYzRV4-460kqDik-yVcQ9Xs=DoCZOMDg@mail.gmail.com>
 <CAEZo+gcj5q2UYnak1+1UG7pPzoeaUr=QLsiCiNXbC_n+JQbKQQ@mail.gmail.com>
 <20111031090717.GA24978@elie.hsd1.il.comcast.net>
 <20111102220614.GB14108@sigill.intra.peff.net>
 <7vwrbigna7.fsf@alter.siamese.dyndns.org>
 <20111102232735.GA17466@sigill.intra.peff.net>
 <CAJo=hJtt8vjB5oU+tEabN2AS7c-24bMHNwQSoWtZYtjjrR3d7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	netroby <hufeng1987@gmail.com>,
	Git Mail List <git@vger.kernel.org>,
	Tomas Carnecky <tom@dbservice.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 03 03:42:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLnGb-0004lg-RZ
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 03:42:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754422Ab1KCCmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 22:42:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60613
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752893Ab1KCCmw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 22:42:52 -0400
Received: (qmail 19453 invoked by uid 107); 3 Nov 2011 02:48:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Nov 2011 22:48:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2011 22:42:48 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJtt8vjB5oU+tEabN2AS7c-24bMHNwQSoWtZYtjjrR3d7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184697>

On Wed, Nov 02, 2011 at 05:06:53PM -0700, Shawn O. Pearce wrote:

> Yup, I agree. The "repo" tool used by Android does this in Python
> right now[1].  Its a simple hack, if the protocol is HTTP or HTTPS the
> client first tries to download $URL/clone.bundle. My servers have
> rules that trap on */clone.bundle and issue an HTTP 302 Found response
> to direct the client to a CDN. Works. :-)

I thought of doing something like that, but I wanted to be able to make
cross-domain links. The "302 to a CDN" thing is a clever hack, but it
requires more control of the webserver than some users might have. And
of course it doesn't work for the "redirect to git:// on a different
server" trick. Or redirect from "git://".

My thought of having it in "refs/mirrors" is only slightly less hacky,
but I think covers all of those cases. :)

> > Even if the bundle thing ends up too wasteful, it may still be useful to
> > offer a "if you don't have X, go see Y" type of mirror when "Y" is
> > something efficient, like git:// at a faster host (i.e., the "I built 3
> > commits on top of Linus" case).
> 
> Actually, I really think the bundle thing is wasteful. Its a ton of
> additional disk. Hosts like kernel.org want to use sendfile() when
> possible to handle bulk transfers. git:// is not efficient for them
> because we don't have sendfile() capability.

I didn't quite parse this. You say it is wasteful, but then indicate
that it can use sendfile(), which is a good thing.

However, I do agree with this:

> Its also expensive for kernel.org to create each Git repository twice
> on disk. The disk is cheap. Its the kernel buffer cache that is damned
> expensive. Assume for a minute that Linus' kernel repository is a
> popular thing to access. If 400M of that history is available in a
> normal pack file on disk, and again 400M is available as a "clone
> bundle thingy", kernel.org now has to eat 800M of disk buffer cache
> for that one Git repository, because both of those files are going to
> be hot.

Doubling the disk cache required is evil and ugly. I was hoping it
wouldn't matter because the bundle would be hosted on some far-away CDN
server anyway, though. But that is highly dependent on your setup. And
it's really just glossing over the fact that you have twice as many
servers. ;)

> I think I messed up with "repo" using a Git bundle file as its data
> source. What we should have done was a bog standard pack file. Then
> the client can download the pack file into the .git/objects/pack
> directory and just generate the index, reusing the entire dumb
> protocol transport logic. It also allows the server to pass out the
> same file the server retains for the repository itself, and thus makes
> the disk buffer cache only 400M for Linus' repository.

That would be cool, but what about ref tips? The pack is just a big blob
of objects, but we need ref tips to advertise to the server when we come
back via the smart protocol. We can make a guess about them, obviously,
but it would be nice to communicate them. I guess the mirror data could
include the tips and a pointer to a pack file.

Another issue with packs is that they generally aren't supposed to be
--thin on disk, whereas bundles can be. So I could point you to a
succession of bundles. Which is maybe a feature, or maybe just makes
things insanely complex[1].

> One (maybe dumb idea I had) was making the $GIT_DIR/objects/info/packs
> file contain other lines to list reference tips at the time the pack
> was made.

So yeah, that's another solution to the ref tip thingy, and that would
work. I don't think it would make a big difference whether the tips were
in the "mirror" file, or alongside the packfile. The latter I guess
might make administration easier. The "real" repo points its mirror one
time to a static pack store, and then the client goes and grabs whatever
it can from that store.

> Then we wind up with a git:// or ssh:// protocol extension that
> enables sendfile() on an entire pack, and to provide the matching
> objects/info/packs data to help a client over git:// or ssh://
> initialize off the existing pack files.

I think we can get around this by pointing git:// clients, either via
protocol extension or via a magic ref, to an http pack store. Sure, it's
an extra TCP connection, but that's not a big deal compared to doing an
initial clone of most repos.

So the sendfile() stuff would always happen over http.

> But either way, I like the idea of coupling the "resumable pack
> download" to the *existing* pack files, because this is easy to deal
> with.

Yeah, I'm liking that idea. In reference to my [1] above, what I've
started with is making:

  git fetch http://host/foo.bundle

work automatically. And it does work. But it actually spools the bundle
to disk and then unpacks from it, rather than placing it right into the
objects/pack directory. I did this because:

  1. We have to feed it to "index-pack --fix-thin", because bundles can
     be thin. So they're not suitable for sticking right into the pack
     directory.

  2. We could feed it straight to an index-pack pipe, but then we don't
     have a byte-for-byte file on disk to resume an interrupted
     transfer.

But spooling sucks, of course. It means we use twice as much disk space
during the index-pack as we would otherwise need to, not to mention the
latency of not starting the index-pack until we get the whole file.

Pulling down a non-thin packfile makes the problem go away. We can spool
it right into objects/pack, index it on the fly, and if all is well,
move it into its final filename. If the transfer is interrupted, you
drop what's been indexed so far, finish the transfer, and then re-start
the indexing from scratch (actually, the "on the fly" would probably
involve teaching index-pack to be clever about incrementally reading a
partially written file, but it should be possible).

-Peff
