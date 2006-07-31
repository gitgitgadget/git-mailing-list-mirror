From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Diff format in packs
Date: Mon, 31 Jul 2006 18:32:21 -0400
Message-ID: <20060731223221.GB24888@spearce.org>
References: <9e4733910607311408i10e17dse776920de7c5076a@mail.gmail.com> <ealruh$sq9$1@sea.gmane.org> <9e4733910607311420n8537b76lbde4d60062195403@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 00:32:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7gJJ-0000tA-Bp
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 00:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030490AbWGaWc0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 18:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030491AbWGaWc0
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 18:32:26 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39830 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1030490AbWGaWcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 18:32:25 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G7gJ3-0001oV-KW; Mon, 31 Jul 2006 18:32:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E556C20E456; Mon, 31 Jul 2006 18:32:21 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910607311420n8537b76lbde4d60062195403@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24552>

Jon Smirl <jonsmirl@gmail.com> wrote:
> On 7/31/06, Jakub Narebski <jnareb@gmail.com> wrote:
> >Jon Smirl wrote:
> >
> >> I'm trying to build a small app that takes a CVS ,v and writes out a
> >> pack corresponding to the versions. Suggestions on the most efficient
> >> strategy for doing this by calling straight into the git C code?
> >> Forking off git commands is not very efficient when done a million
> >> times.
> >
> >Something akin to parsecvs by Keith Packard?
> 
> I see the error in my thoughts now, I need the fully expanded delta to
> compute the sha-1 so I might as well use the parsecvs code.
> 
> I am working on combining cvs2svn, parsecvs and cvsps into something
> that can handle Mozilla CVS.

I think you sort of have the right idea.  Creating a pack file
from scratch without deltas is a very trivial operation.  The pack
format is documented in Documentation/technical/pack-format.txt.
The actual delta format isn't documented here and generating a delta
would be somewhat difficult, but creating a pack with no deltas
and only zlib compression is pretty simple.  And no, GIT doesn't
use the same (horrible) delta format as RCS so you definately are
right, you have to expand it before you can compress it.

Creating trees and commits from scratch is also really easy.  Calling
zlib and a SHA1 routine to create the checksum is the hard part.
I think I wrote the tree and commit construction part of jgit in
a few hours, and that was while I was also being distracted by
someone speaking in the front of the room.  :-)


It should be reasonably simple to extract each revision from a
single ,v file into its full undeltafied form, compute its SHA1,
compress it with zlib, and append it into a pack file.  Do that
for every file and toss the SHA1 values, file names and revision
numbers off into a table somewhere.

Then loop back through and generate trees while playing around only
with the RCS file paths, timestamps and SHA1 pointers.  Again tree
generation is extremely simple; it would be trivial to generate
tree objects and append them into the same (or another) pack.

Finally writing commit objects pointing at the trees is also easy,
without calling git-commit.

When you are all done run a `git-repack -a -d -f` and let the delta
code compress everything down.  That first compression might take
a little while but it should do a reasonably good job despite the
input pack(s) being highly unorganized.

So I think I'm suggesting you find a way to generate the base objects
yourself right into a pack file, rather than using the higher level
GIT executables to do it.  You may be able to reuse some of the
code in GIT but I know its writer code is organized for writing
loose objects, not for appending new objects into a new pack file,
so some surgery would probably be required.

-- 
Shawn.
