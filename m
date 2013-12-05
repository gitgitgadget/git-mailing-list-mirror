From: Jeff King <peff@peff.net>
Subject: Re: How to resume broke clone ?
Date: Thu, 5 Dec 2013 11:04:18 -0500
Message-ID: <20131205160418.GA27869@sigill.intra.peff.net>
References: <560807D9-CE82-4CF6-A1CC-54E7CCA624F9@ancientrocklab.com>
 <CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com>
 <5297004F.4090003@gmail.com>
 <CACsJy8AdOAPT-RfD0NfZj_cQPBSUrVKn8yS7JRe=-4k8C8TvQg@mail.gmail.com>
 <211D44CB-64A2-4FCA-B4A7-40845B97E9A1@ancientrocklab.com>
 <CACsJy8AOVWF2HssWNeYkVvYdmAXJOQ8HOehxJ0wpBFchA87ZWw@mail.gmail.com>
 <20131128092935.GC11444@sigill.intra.peff.net>
 <CAJo=hJuBTjGfF2PvaCn_v4hy4qDfFyB=FXbY0=Oz3hcE0L=L4Q@mail.gmail.com>
 <20131204200850.GB16603@sigill.intra.peff.net>
 <CAJo=hJuRz9Qc8ztQATkEs8huDfiANMA6gZEOapoofVdoY82k4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, zhifeng hu <zf@ancientrocklab.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 05 17:04:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VobPd-00053f-JL
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 17:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590Ab3LEQEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 11:04:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:50989 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932336Ab3LEQEU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 11:04:20 -0500
Received: (qmail 17852 invoked by uid 102); 5 Dec 2013 16:04:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Dec 2013 10:04:20 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Dec 2013 11:04:18 -0500
Content-Disposition: inline
In-Reply-To: <CAJo=hJuRz9Qc8ztQATkEs8huDfiANMA6gZEOapoofVdoY82k4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238889>

On Wed, Dec 04, 2013 at 10:50:27PM -0800, Shawn Pearce wrote:

> I wasn't thinking about using a "well known blob" for this.
> 
> Jonathan, Dave, Colby and I were kicking this idea around on Monday
> during lunch. If the initial ref advertisement included a "mirrors"
> capability the client could respond with "want mirrors" instead of the
> usual want/have negotiation. The server could then return the mirror
> URLs as pkt-lines, one per pkt. Its one extra RTT, but this is trivial
> compared to the cost to really clone the repository.

I don't think this is any more or less efficient than the blob scheme.
In both cases, the client sends a single "want" line and no "have"
lines, and then the server responds with the output (either pkt-lines,
or a single-blob pack).

What I like about the blob approach is:

  1. It requires zero extra code on the server. This makes
     implementation simple, but also means you can deploy it
     on existing servers (or even on non-pkt-line servers like
     dumb http).

  2. It's very debuggable from the client side. You can fetch the blob,
     look at it, and decide which mirror you want outside of git if you
     want to (true, you can teach the git client to dump the pkt-line
     URLs, too, but that's extra code). You could even do this with an
     existing git client that has not yet learned about the mirror
     redirect.

  3. It removes any size or structure limits that the protocol imposes
     (I was planning to use git-config format for the blob itself). The
     URLs themselves aren't big, but we may want to annotate them with
     metadata.

     You mentioned "this is a bundle" versus "this is a regular http
     server" below. You might also want to provide network location
     information (e.g., "this is a good mirror if you are in Asia"),
     though for the most part I'd expect that to happen magically via
     CDN.

     When we discussed this before, the concept came up of offering not
     just a clone bundle, but "slices" of history (as thin-pack
     bundles), so that a fetch could grab a sequence of resumable
     slices, starting with what they have, and then topping off with a
     true fetch. You would want to provide the start and end points of
     each slice.

  4. You can manage it remotely via the git protocol (more discussion
     below).

  5. A clone done with "--mirror" will actually propagate the mirror
     file automatically.

What are the advantages of the pkt-line approach? The biggest one I can
think of is that it does not pollute the refs namespace. While (5) is
convenient in some cases, it would make it more of a pain if you are
trying to keep a clone mirror up to date, but do _not_ want to pass
along upstream's mirror file.

You may want to have a server implementation that offers a dynamic
mirror, rather than a true object we have in the ODB. That is possible
with a mirror blob, but is slightly harder (you have to fake the object
rather than just dumping a line).

> These pkt-lines need to be a bit more than just URL. Or we need a new
> URL like "bundle:http://...." to denote a resumable bundle over HTTP
> vs. a normal HTTP URL that might not be a bundle file, and is just a
> better connected server.

Right, I think that's the most critical one (though you could also just
use the convention of ".bundle" in the URL). I think we may want to
leave room for more metadata, though.

> The mirror URLs could be stored in $GIT_DIR/config as a simple
> multi-value variable. Unfortunately that isn't easily remotely
> editable. But I am not sure I care?

For big sites that manage the bundles on behalf of the user, I don't
think it is an issue. For somebody running their own small site, I think
it is a useful way of moving the data to the server.

> For the average home user sharing their working repository over git://
> from their home ADSL or cable connection, editing .git/config is
> easier than a blob in refs/mirrors. They already know how to edit
> .git/config to manage remotes.

Yes, but it's editing .git/config on the server, not on the client,
which may be slightly harder for some people. I do think we'd want
some tool support on the client side. git-config recently learned to
read from a blob. The next step is:

  git config --blob=refs/mirrors --edit

or

  git config --blob=refs/mirrors mirror.ko.url git://git.kernel.org/...
  git config --blob=refs/mirrors mirror.ko.bundle true

We can't add tool support for editing .git/config on the server side,
because the method for doing so isn't standard.

> Heck, remote.origin.url might already
> be a good mirror address to advertise, especially if the client isn't
> on the same /24 as the server and the remote.origin.url is something
> like "git.kernel.org". :-)

You could have a "git-advertise-upstream" that generates a mirror blob
from your remotes config and pushes it to your publishing point. That
may be overkill, but I don't think it's possible with a
.git/config-based solution.

> > That's clever. It does not work out of the box if you are using
> > alternates, but I think it could be adapted in certain situations. E.g.,
> > if you layer the pack so that one "base" repo always has its full pack
> > at the start, which is something we're already doing at GitHub.
> 
> Yes, well, I was assuming the pack was a fully connected repack.
> Alternates always creates a partial pack. But if you have an
> alternate, that alternate maybe should be given as a mirror URL? And
> allow the client to recurse the alternate mirror URL list too?

The problem for us is not that we have a partial pack, but that the
alternates pack has a lot of other junk in it. A linux.git clone is
650MB or so. The packfile for all of the linux.git forks together on
GitHub is several gigabytes.

> What really got us worried was the bundle header has no checksums, and
> a resume in the bundle header from the wrong version could be
> interesting.

The bundle header is small enough that you should just throw it away if
you didn't get the whole thing (IIRC, that is what my patches do,
because it does not do _anything_ until we receive the whole ref
advertisement, at which point we decide if it is smart, dumb, or a
bundle).

> Yes. And this is why the packfile name algorithm is horribly flawed. I
> keep saying we should change it to name the pack using the last 20
> bytes of the file but ... nobody has written the patch for that?  :-)

Totally agree. I think we could also get rid of the horrible hacks in
repack where we pack to a tempfile, then have to do another tempfile
dance (which is not atomic!) to move the same-named packfile out of the
way. If the name were based on the content, we could just throw away our
new pack if one of the same name is already there (just like we do for
loose objects).

I haven't looked at making such a patch, but I think it shouldn't be too
complicated. My big worry would be weird fallouts from some hidden part
of the code that we don't realize is depending on the current naming
scheme. :)

-Peff
