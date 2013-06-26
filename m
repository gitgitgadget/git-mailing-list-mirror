From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 09/16] documentation: add documentation for the bitmap
 format
Date: Wed, 26 Jun 2013 01:11:17 -0400
Message-ID: <20130626051117.GB26755@sigill.intra.peff.net>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
 <1372116193-32762-10-git-send-email-tanoku@gmail.com>
 <CAJo=hJtcQwh-N-9_i84y1ZsL0mdREHcxhP2gepcrREiaxvxS6A@mail.gmail.com>
 <CAFFjANRwBBcORhu4mwjESBfr4GJ3zDrgYvUhY=VxK9abv7k2MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vicent =?utf-8?B?TWFydMOt?= <tanoku@gmail.com>,
	Colby Ranger <cranger@google.com>, git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 26 07:11:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uri0q-00080p-Fq
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 07:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059Ab3FZFLV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jun 2013 01:11:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:54360 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718Ab3FZFLU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 01:11:20 -0400
Received: (qmail 5625 invoked by uid 102); 26 Jun 2013 05:12:24 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Jun 2013 00:12:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Jun 2013 01:11:17 -0400
Content-Disposition: inline
In-Reply-To: <CAFFjANRwBBcORhu4mwjESBfr4GJ3zDrgYvUhY=VxK9abv7k2MA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229028>

On Tue, Jun 25, 2013 at 09:33:11PM +0200, Vicent Mart=C3=AD wrote:

> > One way we side-stepped the size inflation problem in JGit was to o=
nly
> > use the bitmap index information when sending data on the wire to a
> > client. Here delta reuse plays a significant factor in building the
> > pack, and we don't have to be as accurate on matching deltas. Durin=
g
> > the equivalent of `git repack` bitmaps are not used, allowing the
> > traditional graph enumeration algorithm to generate path hash
> > information.
>=20
> OH BOY HERE WE GO. This is worth its own thread, lots to discuss here=
=2E
> I think peff will have a patchset regarding this to upstream soon,
> we'll get back to it later.

We do the same thing (only use bitmaps during on-the-wire fetches).  Bu=
t
there a few problems with assuming delta reuse.

=46or us (GitHub), the foremost one is that we pack many "forks" of a
repository together into a single packfile. That means when you clone
torvalds/linux, an object you want may be stored in the on-disk pack
with a delta against an object that you are not going to get. So we hav=
e
to throw out that delta and find a new one.

I'm dealing with that by adding an option to respect "islands" during
packing, where an island is a set of common objects (we split it by
fork, since we expect those objects to be fetched together, but you
could use other criteria). The rule is that an object cannot delta
against another object that is not in all of its islands. So everybody
can delta against shared history, but objects in your fork can only
delta against other objects in the fork.  You are guaranteed to be able
to reuse such deltas during a full clone of a fork, and the on-disk pac=
k
size does not suffer all that much (because there is usually a good
alternate delta base within your reachable history).

So with that series, we can get good reuse for clones. But there are
still two cases worth considering:

  1. When you fetch a subset of the commits, git marks only the edges a=
s
     preferred bases, and does not walk the full object graph down to
     the roots. So any object you want that is delta'd against somethin=
g
     older will not get reused. If you have reachability bitmaps, I
     don't think there is any reason that we cannot use the entire
     object graph (starting at the "have" tips, of course) as preferred
     bases.

  2. The server is not necessarily fully packed. In an active repo, you
     may have a large "base" pack with bitmaps, with several recently
     pushed packs on top. You still need to delta the recently pushed
     objects against the base objects.

I don't have measurements on how much the deltas suffer in those two
cases. I know they suffered quite badly for clones without the name
hashes in our alternates repos, but that part should go away with my
patch series.

-Peff
