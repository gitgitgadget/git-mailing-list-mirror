From: Jeff King <peff@peff.net>
Subject: Re: Using bitmaps to accelerate fetch and clone
Date: Thu, 27 Sep 2012 13:20:37 -0400
Message-ID: <20120927172037.GB1547@sigill.intra.peff.net>
References: <CAJo=hJstK1tGrWhtBt3s+R1a6C0ge3wMtJnoo43Fjfg5A57eVw@mail.gmail.com>
 <CACsJy8D0vkyEArNChXE0igUkanH6PwjmPitq22a9sudfmWF4kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>,
	Colby Ranger <cranger@google.com>, David Barr <barr@github.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 19:20:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THHla-0001TB-1Y
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 19:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677Ab2I0RUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 13:20:40 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:32901 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376Ab2I0RUj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 13:20:39 -0400
Received: (qmail 3288 invoked by uid 107); 27 Sep 2012 17:21:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Sep 2012 13:21:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2012 13:20:37 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8D0vkyEArNChXE0igUkanH6PwjmPitq22a9sudfmWF4kA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206491>

On Thu, Sep 27, 2012 at 07:17:42PM +0700, Nguyen Thai Ngoc Duy wrote:

> > Operation                   Index V2               Index VE003
> > Clone                       37530ms (524.06 MiB)     82ms (524.06 MiB)
> > Fetch (1 commit back)          75ms                 107ms
> > Fetch (10 commits back)       456ms (269.51 KiB)    341ms (265.19 KiB)
> > Fetch (100 commits back)      449ms (269.91 KiB)    337ms (267.28 KiB)
> > Fetch (1000 commits back)    2229ms ( 14.75 MiB)    189ms ( 14.42 MiB)
> > Fetch (10000 commits back)   2177ms ( 16.30 MiB)    254ms ( 15.88 MiB)
> > Fetch (100000 commits back) 14340ms (185.83 MiB)   1655ms (189.39 MiB)
> 
> Beautiful. And curious, why do 100->1000 and 10000->10000 have such
> big leaps in time (V2)?

Agreed. I'm very excited about these numbers.

> >   Defines the new E003 index format and the bit set
> >   implementation logic.
> [...]
> It seems the bitmap data follows directly after regular index content.
> I'd like to see some sort of extension mechanism like in
> $GIT_DIR/index, so that we don't have to increase pack index version
> often. What I have in mind is optional commit cache to speed up
> rev-list and merge, which could be stored in pack index too.

As I understand it, both the bitmaps and a commit cache are
theoretically optional. That is, git can do the job without them, but
they speed things up. If that is the case, do we need to bump the index
version at all? Why not store a plain v2 index, and then store an
additional file "pack-XXX.reachable" that contains the bitmaps and an
independent version number.

The sha1 in the filename makes sure that the reachability file is always
in sync with the actual pack data and index.  Old readers won't know
about the new file, and will ignore it. For new readers, if the file is
there they can use it; if it's missing (or its version is not
understood), they can fall back to the regular index.

I haven't looked at the details of the format change yet. If it is
purely an extra chunk of data at the end, this Just Works. If there are
changes to the earlier parts of the pack (e.g., I seem to recall the
commit cache idea wanted separate indices for each object type), we may
still need a v3. But it would be nice if we could make those changes
generic (e.g., just the separate indices, which might support many
different enhancements), and then let the actual feature work happen in
the separate files.

> Definitely :-). I have shown my interest in this topic before. So I
> should probably say that I'm going to work on this on C Git, but
> sllloooowwwly. As this benefits the server side greatly, perhaps a
> GitHubber ;-) might want to work on this on C Git, for GitHub itself
> of course, and, as a side effect, make the rest of us happy?

Yeah, GitHub is definitely interested in this. I may take a shot at it,
but I know David Barr (cc'd) is also interested in such things.

-Peff
