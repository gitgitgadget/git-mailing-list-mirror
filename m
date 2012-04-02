From: Jeff King <peff@peff.net>
Subject: Re: GSoC - Some questions on the idea of
Date: Mon, 2 Apr 2012 17:40:49 -0400
Message-ID: <20120402214049.GB28926@sigill.intra.peff.net>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com>
 <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com>
 <loom.20120328T131530-717@post.gmane.org>
 <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com>
 <20120330203430.GB20376@sigill.intra.peff.net>
 <4F77209A.8050607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bo Chen <chen@chenirvine.org>, Sergio <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 23:41:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEozf-0000I6-FF
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 23:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933Ab2DBVkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 17:40:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43593
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751916Ab2DBVkv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 17:40:51 -0400
Received: (qmail 22110 invoked by uid 107); 2 Apr 2012 21:40:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Apr 2012 17:40:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Apr 2012 17:40:49 -0400
Content-Disposition: inline
In-Reply-To: <4F77209A.8050607@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194566>

On Sat, Mar 31, 2012 at 10:19:54AM -0500, Neal Kreitzinger wrote:

> >Note that there are other problem areas with big files that can be
> >worked on, too. For example, some people want to store 100 gigabytes
> >in a repository.
> 
> I take it that you have in mind a 100G set of files comprised entirely
> of big-files that cannot be logically separated into smaller submodules?

Not exactly. Two scenarios I'm thinking of are:

  1. You really have 100G of data in the current version that doesn't
     compress well (e.g., you are storing your music collection). You
     can't afford to store two copies on your laptop (because you have a
     fancy SSD, and 100G is expensive again).  You need the working tree
     version, but it's OK to stream the repo version of a blob from the
     network when you actually need it (mostly "checkout", assuming you
     have marked the file as "-diff").

  2. You have a 100G repository, but only 10G in the most recent
     version (e.g., because you are doing game development and storing
     the media assets). You want your clones to be faster and take less
     space. You can do a shallow clone, but then you're never allowed to
     look at old history. Instead, it would be nice to clone all of the
     commits, trees, and small blobs, and then stream large blobs from
     the network as-needed (again, mostly "checkout").

> My understanding is that a main strategy for "big files" is to separate
> your big-files logically into their own submodule(s) to keep them from
> bogging down the not-big-file repo(s).

That helps people who want to work on the not-big parts by not forcing
them into the big parts (another solution would be partial clone, but
more on that in a minute). But it doesn't help people who actually want
to work on the big parts; they would still have to fetch the whole
big-parts repository.

For splitting the big-parts people from the non-big-parts people, there
have been two suggestions: partial checkout (you have all the objects in
the repo, but only checkout some of them) and partial clone (you don't
have some of the objects in the repo). Partial checkout is a much easier
problem, as it is mostly about marking index entries as "do not bother
to check this out, and pretend that it is simply unmodified". Partial
clone is much harder, because it violates git's usual reachability
rules. During a fetch, a client will say "I have commit X", which the
server can then assume means they have all of the ancestors of X, and
all of the tree and blobs referenced by X and its ancestors.

But if a client can say "yes, I have these objects, but I just don't
want to get them because it's expensive", then partial checkout is
sufficient. The non-big-parts people will clone, omitting the big
objects, and then do a partial checkout (to avoid fetching the objects
even once).

Note that some protocol extension is still needed for the client to tell
the server "don't bother including objects X, Y, and Z in the packfile;
I'll get them from my alternate big-object repo". That can either be a
list of objects, or it can simply be "don't bother with objects bigger
than N".

> >Because git is distributed, that means 100G in the repo database,
> >and 100G in the working directory, for a total of 200G.
> 
> I take it that you are implying that the 100G object-store size is due
> to the notion that binary files cannot-be/are-not compressed well?

In this case, yes. But you could easily tweak the numbers to be 100G and
150G. The point is that the data is stored twice, and even the
compressed version may be big.

> >People in this situation may want to be able to store part of the
> >repository database in a network-accessible location, trading some
> >of the convenience of being fully distributed for the space savings.
> >So another project could be designing a network-based alternate
> >object storage system.
> >
> I take it you are implying a local area network with users git repos
> on workstations?

Not necessarily. Obviously if you are doing a lot of active work on the
big files, the faster your network, the better. But it could work at the
internet scale, too, if you don't actually fetch the big files
frequently (so part of a scheme like this would be making sure we avoid
accessing big objects whenever we can; in practice, this is pretty easy,
as git already tries to avoid accessing objects unnecessarily, because
it's expensive even on the local end).

You can also cache a certain number of fetched objects locally. Assuming
there is some locality of the objects you ask about (e.g., because you
are doing "git checkout" back and forth between two branches), this can
help.

> Some setups login to a linux server and have all their repos there.
> The "alternate objects" does not need to network-based in that case.
> It is "local", but local does not mean 20 people cloning the
> alternate objects to their workstations.  It means one copy of
> alternate objects, and twenty repos referencing that one copy.

Right. This is the same concept, except over the network. So people's
working repositories are on their own workstations instead of a central
server. You could even do it today by network-mounting a filesystem and
pointing your alternates file at it. However, I think it's worth making
git aware that the objects are on the network for a few reasons:

  1. Git can be more careful about how it handles the objects, including
     when to fetch, when to stream, and when to cache. For example,
     you'd want to fetch the manifest of objects and cache it in your
     local repository, because you want fast lookups of "do I have this
     object".

  2. Providing remote filesystems on an Internet scale is a management
     pain (and it's a pain for the user, too). My thought was that this
     would be implemented on top of http (the connection setup cost is
     negligible, since these objects would generally be large).

  3. Usually alternate repositories are full repositories that meet the
     connectivity requirements (so you could run "git fsck" in them).
     But this is explicitly about taking just a few disconnected large
     blobs out of the repository and putting them elsewhere. So it needs
     a new set of tools for managing the upstream repository.

-Peff
