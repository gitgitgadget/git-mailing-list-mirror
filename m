From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Thu, 17 Aug 2006 00:07:19 -0400
Message-ID: <20060817040719.GC18500@spearce.org>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 17 06:07:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDZAE-0006IN-O5
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 06:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWHQEHY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 00:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWHQEHY
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 00:07:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:3465 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932389AbWHQEHX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 00:07:23 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GDZ9x-00080Z-Jh; Thu, 17 Aug 2006 00:07:09 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D865A20FB77; Thu, 17 Aug 2006 00:07:19 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25547>

Jon Smirl <jonsmirl@gmail.com> wrote:
> Shawn put together a new version of his import utility that packs all
> of the deltas from a run into a single blob instead of one blob per
> delta. The idea is to put 10 or more deltas into each delta entry
> instead of one. The index format would map the 10 sha1's to a single
> packed delta entry which would be expanded when needed. Note that you
> probably needed multiple entries out of the delta pack to generate the
> revision you were looking for so this is no real loss on extraction.
> 
> I ran it overnight on mozcvs. If his delta pack code is correct this
> is a huge win.
> 
> One entry per delta -  845,42,0150
> Packed deltas - 295,018,474
> 65% smaller
> 
> The effect of packing the deltas is to totally eliminate many of the
> redundant zlib dictionaries.

I'm going to try to integrate this into core GIT this weekend.
My current idea is to make use of the OBJ_EXT type flag to add
an extended header field behind the length which describes the
"chunk" as being a delta chain compressed in one zlib stream.
I'm not overly concerned about saving lots of space in the header
here as it looks like we're winning a huge amount of pack space,
so the extended header will probably itself be a couple of bytes.
This keeps the shorter reserved types free for other great ideas.  :)

My primary goal of integrating it into core GIT is to take
advantage of verify-pack to check the file fast-import is producing.
Plus having support for it in sha1_file.c will make it easier to
performance test the common access routines that need to be fast,
like commit and tree walking.

My secondary goal is to get a patchset which other folks can try
on their own workloads to see if its as effective as what Jon is
seeing on the Mozilla archive.


Unfortunately I can't think of a way to make this type of pack
readable by older software.  So this could be creating a pretty
big change in the pack format, relatively speaking.  :)

-- 
Shawn.
