From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: pack v4 status
Date: Tue, 27 Feb 2007 10:50:42 -0500
Message-ID: <20070227155042.GB3230@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 21:44:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM9BD-0000mq-F9
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933100AbXB0Unj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933806AbXB0Uni
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:43:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45634 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933100AbXB0Unf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:43:35 -0500
X-Greylist: delayed 657 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Feb 2007 15:43:33 EST
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HM4b8-0001lF-Rw; Tue, 27 Feb 2007 10:50:39 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 389C720FBAE; Tue, 27 Feb 2007 10:50:42 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40799>

Nico's and my packv4 topic is available from my fastimport.git fork
on repo.or.cz:

  gitweb: http://repo.or.cz/w/git/fastimport.git
  git:    git://repo.or.cz/git/fastimport.git
  branch: sp/pack4

We have thus far reformatted OBJ_TREEs with a new dictionary based
compression scheme.  In this scheme we pool the filenames and modes
that appear within trees into a single table within the packfile.
All trees are then converted to use a 22 byte record format:

  - 2 byte network byte order index into the string pool
  - 20 byte SHA-1

These trees are then stored *uncompressed* within the packfile,
but are also still stored using our standard delta system (only the
deltas for these trees are also stored uncompressed).  The resulting
savings is pretty good; on linux-2.6.git we are saving ~3.8 MiB as
a result of this encoding alone:

	141649022 pack2-linuxA.git
	137625761 pack4-linuxB.git

read_sha1_file() has been modified to unpack this new tree format
back into the canonical format; something that I think is very
unncessary for runtime given how easy it is to iterate the encoded
tree, but is still critically important for tools like git-cat-file,
git-index-pack and git-verify-pack.  Future plans are to iterate
the encoded tree directly, but performance is already faster despite
needing to reconvert the tree:

  lh=825020c3866e7312947e17a0caa9dd1a5622bafc
  git --git-dir=pack2-linux.git rev-list $lh -- include/asm-m68k
        3.97 real         3.60 user         0.15 sys
        3.98 real         3.60 user         0.15 sys
        3.98 real         3.60 user         0.15 sys
        3.98 real         3.60 user         0.15 sys
        3.98 real         3.60 user         0.15 sys

  git --git-dir=pack4-linux.git rev-list $lh -- include/asm-m68k
        3.52 real         3.17 user         0.13 sys
        3.46 real         3.17 user         0.13 sys
        3.51 real         3.17 user         0.13 sys
        3.52 real         3.18 user         0.13 sys
        3.53 real         3.16 user         0.13 sys

I'll take 500 milliseconds savings anyday, thanks!  :-)


Nico and I have only started working on commits, so the above results
still utilize the packv2 format for OBJ_COMMIT and do not take into
account any of our proposed concepts there.


The impetus for packv4 is to format the packfile in such a way that
we can work with the data faster at runtime for common operations,
like rev-list and its builtin path limiter.  We also want to make
reachability analysis (critical for packing and fsck) faster.
Any reduction in storage size is considered a bonus here, though
obviously there is some correlation between size of input data and
the time required to process it.  ;-)

The patch series for this is getting large.  Right now we are up to
32 patches in the series.  Given where we are and where we want to
go I'm predicting this series will come out at close to 100 patches.
Of course that's partly because I'm working in fairly small units,
slowly iterating the code into the final version we want.

I am constantly rebasing the sp/pack4 topic noted above, so the
patch count is not really because I'm going back and fixing things
in later patches.  Its because I'm trying to slowly iterate the
runtime side of things in digestable changes, then the packing side,
so that the system still works at every single commit in the series.
Yes, its a *BIG* set of code changed.

Obviously this series has a heavy hand on sha1_file.c,
builtin-pack-objects.c, builtin-unpack-objects.c, index-pack.c.
But it will also start to hit less obvious places like commit.c
and tree-walk.c as we start to support walking the encoded objects
directly.

Given the huge size of the series, and the amount of effort we are
tossing into it, and the fact that I'm trying to make it pu-ready by
early next week, we would appreciate it if folks could keep changes
to the above mentioned files limited to critical bug fixes only.  :)

-- 
Shawn.
