From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/4] External 'filter' attributes and drivers
Date: Sun, 22 Apr 2007 01:20:08 -0400
Message-ID: <20070422052008.GH17480@spearce.org>
References: <11771520591529-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 07:20:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfUV3-0007Ii-PT
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 07:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbXDVFUO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 01:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbXDVFUO
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 01:20:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40686 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808AbXDVFUN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 01:20:13 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HfUUc-0007Io-SJ; Sun, 22 Apr 2007 01:20:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7E9D720FBAE; Sun, 22 Apr 2007 01:20:09 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <11771520591529-git-send-email-junkio@cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45213>

Junio C Hamano <junkio@cox.net> wrote:
> I know this is controversial, but here is a small four patch
> series to let you insert arbitrary external filter in checkin
> and checkout codepath.

This series is some pretty nice work.

But I really don't think we want filters.  Actually, I'm very
against them, and I'm actually very against the CRLF work that
has already been added.  Since the CRLF ship has sailed I won't
try to call it back to port.  But I don't want to see the filter
stuff raise anchor...

I've only really seen a few arguments for the filters:

1) Better compress structured content (e.g. ODF) by storing the
   ZIP as a tree, allowing normal deltification within packfiles
   to apply to the contained files.

2) Use a custom diff function on special files (e.g. ODF) as they
   are otherwise unreadable with the internal xdiff based engine.

3) Mutate content prior to extracting from the tree, e.g. printing.


Let me try to address these points.

#1: There are a limited number of content formats that we could
reasonably filter into the repository such that the standard
deltification routines will have good space/performance benefits.
Most of them today are ZIP archives (e.g. ODF, JAR).

Why don't we just teach the packfile format how to better compress
these types of streams?  Let read_sha1_file() and pack-objects do all
of the heavy translation work, just as they do today for text files.
Explode them into a "tree-like" thing that allows deltification
against any other content (even cross ZIP streams) just like we
do with trees, but always expose them to the working directory
level of the system as blobs.

This way we never get into the mess that David Lang pointed out
where we have many optimizations that reuse working tree files when
stat data matches; nor do we have to worry about major structural
differences between the working tree (1 file) and the repository
format (exploded ZIP as 10,000 files).


#2: We already support using any diff tool you want: set the
GIT_EXTERNAL_DIFF environment variable before running a program that
generates a diff.  As Junio pointed out on #git tonight, that could
be any shell script that decides how to produce the diff based on
its own logic.  Though we could also use the new attribute stuff
to select diff programs, much like we do now for merge conflict
resolution in merge-recursive.


#3: This has already been discussed at length on the list.
Letting the build system perform this sort of work is better than
making the VCS do it; especially when you want the VCS to do its
sole job well (track the state of the working directory) and the
build system do its sole job well (produce files suitable for use
outside of the repository).


So despite the fact that I tried to make 4/4 shorter, I really
don't think we should be doing this...

-- 
Shawn.
