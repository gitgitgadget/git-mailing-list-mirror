From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] Lazily open pack index files on demand
Date: Sat, 26 May 2007 23:34:29 -0400
Message-ID: <20070527033429.GY28023@spearce.org>
References: <20070526052419.GA11957@spearce.org> <7vabvsm1h8.fsf@assigned-by-dhcp.cox.net> <56b7f5510705261031o311b89bapd730374cbc063931@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 27 05:34:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs9Ww-0005jH-Lj
	for gcvg-git@gmane.org; Sun, 27 May 2007 05:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbXE0Dee (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 23:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbXE0Dee
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 23:34:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36926 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbXE0Dee (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 23:34:34 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hs9WM-0007I1-RJ; Sat, 26 May 2007 23:34:18 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D087720FBAE; Sat, 26 May 2007 23:34:29 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <56b7f5510705261031o311b89bapd730374cbc063931@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48515>

Dana How <danahow@gmail.com> wrote:
> Shawn:  When I first saw the index-loading code,  my first
> thought was that all the index tables should be
> merged (easy since sorted) so callers only need to do one search.

Yes; in fact this has been raised on the list before.  The general
idea was to create some sort of "super index" that had a list of
all objects and which packfile they could be found in.  This way the
running process doesn't have to search multiple indexes, and the
process doesn't have to be responsible for the merging itself.

See the thing is, if you read all of every .idx file on a simple
`git-log` operation you've already lost.  The number of trees and
blobs tends to far outweigh the number of commits and they really
outweigh the number of commits the average user looks at in a
`git-log` session before they abort their pager.  So sorting all
of the available .idx files before we produce even the first commit
is a horrible thing to do.

But the problem with a super index is repacking.  Every time the user
repacks their recent loose objects (or recently fetched packs) we are
folding some packfiles together, but may be leaving others alone.
The super index would need to account for the packfiles we aren't
looking at or repacking.  It gets complicated fast.

There's also the problem of alternate ODBs; do we fold the indexes
of our alternates into our own super index?  Or does each ODB get
its own super index and we still have to load multiple super index
files?

In pack v4 we're likely to move the SHA-1 table from the .idx file
into the front of the .pack file.  This makes the .idx file hold
only the offsets and the CRC checkums of each object.  If we start
making a super index, we have to duplicate the SHA-1 table twice
(once in the .pack, again in the super index).

-- 
Shawn.
