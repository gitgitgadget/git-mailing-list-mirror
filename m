From: Jeff King <peff@peff.net>
Subject: Re: How to resume broke clone ?
Date: Wed, 4 Dec 2013 15:08:50 -0500
Message-ID: <20131204200850.GB16603@sigill.intra.peff.net>
References: <AAA12788-A242-41B8-B47D-1A0A52F33FC1@ancientrocklab.com>
 <5296F343.6050506@gmail.com>
 <560807D9-CE82-4CF6-A1CC-54E7CCA624F9@ancientrocklab.com>
 <CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com>
 <5297004F.4090003@gmail.com>
 <CACsJy8AdOAPT-RfD0NfZj_cQPBSUrVKn8yS7JRe=-4k8C8TvQg@mail.gmail.com>
 <211D44CB-64A2-4FCA-B4A7-40845B97E9A1@ancientrocklab.com>
 <CACsJy8AOVWF2HssWNeYkVvYdmAXJOQ8HOehxJ0wpBFchA87ZWw@mail.gmail.com>
 <20131128092935.GC11444@sigill.intra.peff.net>
 <CAJo=hJuBTjGfF2PvaCn_v4hy4qDfFyB=FXbY0=Oz3hcE0L=L4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, zhifeng hu <zf@ancientrocklab.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 04 21:09:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoIl1-0000bk-2m
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 21:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933506Ab3LDUIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 15:08:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:50453 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933316Ab3LDUIw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 15:08:52 -0500
Received: (qmail 24652 invoked by uid 102); 4 Dec 2013 20:08:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Dec 2013 14:08:52 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Dec 2013 15:08:50 -0500
Content-Disposition: inline
In-Reply-To: <CAJo=hJuBTjGfF2PvaCn_v4hy4qDfFyB=FXbY0=Oz3hcE0L=L4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238806>

On Thu, Nov 28, 2013 at 11:15:27AM -0800, Shawn Pearce wrote:

> >>  - better integration with git bundles, provide a way to seamlessly
> >> create/fetch/resume the bundles with "git clone" and "git fetch"
> 
> We have been thinking about formalizing the /clone.bundle hack used by
> repo on Android. If the server has the bundle, add a capability in the
> refs advertisement saying its available, and the clone client can
> first fetch $URL/clone.bundle.

Yes, that was going to be my next step after getting the bundle fetch
support in. If we are going to do this, though, I'd really love for it
to not be "hey, fetch .../clone.bundle from me", but a full-fledged
"here are full URLs of my mirrors".

Then you can redirect a non-http cloner to http to grab the bundle. Or
redirect them to a CDN. Or even somebody else's server entirely (e.g.,
"go fetch from Linus first, my piddly server cannot feed you the whole
kernel"). Some of the redirects you can do by issuing an http redirect
to "/clone.bundle", but the cross-protocol ones are tricky.

If we advertise it as a blob in a specialized ref (e.g., "refs/mirrors")
it does not add much overhead over a simple capability. There are a few
extra round trips to actually fetch the blob (client sends a want and no
haves, then server sends the pack), but I think that's negligible when
we are talking about redirecting a full clone. In either case, we have
to hang up the original connection, fetch the mirror, and then come
back.

> For most Git repositories the bundle can be constructed by saving the
> bundle reference header into a file, e.g.
> $GIT_DIR/objects/pack/pack-$NAME.bh at the same time the pack is
> created. The bundle can be served by combining the .bh and .pack
> streams onto the network. It is very little additional disk overhead
> for the origin server,

That's clever. It does not work out of the box if you are using
alternates, but I think it could be adapted in certain situations. E.g.,
if you layer the pack so that one "base" repo always has its full pack
at the start, which is something we're already doing at GitHub.

> but allows resumable clone, provided the server has not done a GC.

As an aside, the current transfer-resuming code in http.c is
questionable.  It does not use etags or any sort of invalidation
mechanism, but just assumes hitting the same URL will give the same
bytes. That _usually_ works for dumb fetching of objects and packfiles,
though it is possible for a pack to change representation without
changing name.

My bundle patches inherited the same flaw, but it is much worse there,
because your URL may very well just be "clone.bundle" that gets updated
periodically.

> > I posted patches for this last year. One of the things that I got hung
> > up on was that I spooled the bundle to disk, and then cloned from it.
> > Which meant that you needed twice the disk space for a moment.
> 
> I don't think this is a huge concern. In many cases the checked out
> copy of the repository approaches a sizable fraction of the .pack
> itself. If you don't have 2x .pack disk available at clone time you
> may be in trouble anyway as you try to work with the repository post
> clone.

Yeah, in retrospect I was being stupid to let that hold it up. I'll
revisit the patches (I've rebased them forward over the past year, so it
shouldn't be too bad).

> > I wanted
> > to teach index-pack to "--fix-thin" a pack that was already on disk, so
> > that we could spool to disk, and then finalize it without making another
> > copy.
> 
> Don't you need to separate the bundle header from the pack data before
> you do this?

Yes, though it isn't hard. We have to fetch part of the bundle header
into memory during discover_refs(), since that is when we realize we are
getting a bundle and not just the refs. From there you can spool the
bundle header to disk, and then the packfile separately.

My original implementation did that, though I don't remember if that one
got posted to the list (after realizing that I couldn't just
"--fix-thin" directly, I simplified it to just spool the whole thing to
a single file).

> If the bundle is only used at clone time there is no
> --fix-thin step.

Yes, for the particular use case of a clone-mirror, you wouldn't need to
--fix-thin. But I think "git fetch https://example.com/foo.bundle"
should work in the general case (and it does with my patches).

> See above, I think you can reasonably do the /clone.bundle
> automatically on any HTTP server.

Yeah, the ".bh" trick you mentioned is low enough impact to the server
that we could just unconditionally make it part of the repack.

> > What would need to go into such a hash? It would need to represent the
> > exact bytes that will go into the pack, but without actually generating
> > those bytes. Perhaps a sha1 over the sequence of <object sha1, type,
> > base (if applicable), length> for each object would be enough. We should
> > know that after calling compute_write_order. If the client has a match,
> > we should be able to skip ahead to the correct byte.
> 
> I don't think Length is sufficient.
> 
> The repository could have recompressed an object with the same length
> but different libz encoding. I wonder if loose object recompression is
> reliable enough about libz encoding to resume in the middle of an
> object? Is it just based on libz version?
> 
> You may need to do include information about the source of the object,
> e.g. the trailing 20 byte hash in the source pack file.

Yeah, I think you're right that it's too flaky without recording the
source. At any rate, I think I prefer the bundle approach you mentioned
above. It solves the same problem, and is a lot more flexible (e.g., for
offloading to other servers).

-Peff
