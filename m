From: Jeff King <peff@peff.net>
Subject: Re: Using bitmaps to accelerate fetch and clone
Date: Thu, 27 Sep 2012 14:22:33 -0400
Message-ID: <20120927182233.GA2519@sigill.intra.peff.net>
References: <CAJo=hJstK1tGrWhtBt3s+R1a6C0ge3wMtJnoo43Fjfg5A57eVw@mail.gmail.com>
 <CACsJy8D0vkyEArNChXE0igUkanH6PwjmPitq22a9sudfmWF4kA@mail.gmail.com>
 <20120927172037.GB1547@sigill.intra.peff.net>
 <CAJo=hJuXCYa=MKSqCRsxmwFdFYZamK_94zc3fE0tmvwUAVA2Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>,
	David Barr <barr@github.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 27 20:23:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THIk0-0007pP-HB
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 20:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754704Ab2I0SWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 14:22:37 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:32975 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755242Ab2I0SWf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 14:22:35 -0400
Received: (qmail 4385 invoked by uid 107); 27 Sep 2012 18:23:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Sep 2012 14:23:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2012 14:22:33 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJuXCYa=MKSqCRsxmwFdFYZamK_94zc3fE0tmvwUAVA2Ow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206504>

On Thu, Sep 27, 2012 at 10:35:47AM -0700, Shawn O. Pearce wrote:

> > If that is the case, do we need to bump the index
> > version at all? Why not store a plain v2 index, and then store an
> > additional file "pack-XXX.reachable" that contains the bitmaps and an
> > independent version number.
> 
> This is the alternate version we considered internally. It was a bit
> more work to define a 3rd file stream per pack in our backend storage
> system, so we opted for a revision of an existing stream. We could
> spend a bit more time and add a 3rd stream, keeping the index format
> unmodified.

I'd rather make the choice that provides the best user experience, even
if it is a bit more code refactoring.

> But we could have also done this with the CRC-32 table in index v2. We
> didn't. If the data should almost always be there in order to provide
> good service then we should really be embedding into the files.

Yes, although there were other changes in v2, also (e.g., the fanout to
handle larger packfiles).  Bumping the version also made the transition
take a lot longer. We introduced the reading and writing code, but then
couldn't flip the default for quite a while. For big server providers
this is not as big a deal (we know which versions of git we will use,
and are OK with flipping a config bit). But it's one more tuning thing
to deal with for small or single-person servers.

I think clients will also want it. If we can make "git rev-list
--objects --all" faster (which this should be able to do), we can speed
up "git prune", which in turn is by far the slowest part of "git gc
--auto", since in the typical case we are only incrementally packing.

I also like that the general technique can be reused easily. We've
talked about a generation-number cache in the past. That would fit this
model as well. Removing a backwards-compatibility barrier makes it a lot
easier to experiment with these sorts of things.

> > The sha1 in the filename makes sure that the reachability file is always
> > in sync with the actual pack data and index.
> 
> Depending on the extension dependencies, you may need to also use the
> trailer SHA-1 from the pack file itself, like the index does. E.g. the
> bitmap data depends heavily on object order in the pack and is invalid
> if you repack with a different ordering algorithm, or a different
> delta set of results from delta compression.

Interesting. I would have assumed it depended on order in the index. But
like I said, I haven't looked. I think you are still OK, though, because
the filename comes from the sha1 over the index file, which in turn
includes the sha1 over the packfile. Thus any change in the packfile
would give you a new pack and index name.

> Yes. One downside is these separate streams aren't removed when you
> run git repack. But this could be fixed by  a modification to git
> repack to clean up additional extensions with the same pack base name.

I don't think that's a big deal. We already do it with ".keep" files. If
you repack with an older version of git, you may have a stale
supplementary file wasting space. But that's OK. The next time you gc
with a newer version of git, we could detect and clean up such stale
files (we already do so for tmp_pack_* files).

-Peff
