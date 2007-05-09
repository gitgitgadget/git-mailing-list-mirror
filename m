From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add --no-reuse-delta option to git-gc
Date: Wed, 9 May 2007 15:10:52 -0400
Message-ID: <20070509191052.GD3141@spearce.org>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net> <11786309073709-git-send-email-tytso@mit.edu> <11786309072612-git-send-email-tytso@mit.edu> <11786309071033-git-send-email-tytso@mit.edu> <Pine.LNX.4.64.0705090056231.18541@iabervon.org> <7v3b26xvjo.fsf@assigned-by-dhcp.cox.net> <46418E24.9020309@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed May 09 21:11:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlrZ7-0006CK-O0
	for gcvg-git@gmane.org; Wed, 09 May 2007 21:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755114AbXEITLD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 15:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757414AbXEITLC
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 15:11:02 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59533 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755114AbXEITLA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 15:11:00 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HlrYk-0005NG-BI; Wed, 09 May 2007 15:10:46 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D5C3B20FBAE; Wed,  9 May 2007 15:10:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46418E24.9020309@midwinter.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46769>

Steven Grimm <koreth@midwinter.com> wrote:
> On that note, has any thought been given to looking at other compression 
> algorithms? Gzip is a great high-speed compressor, but there are others 
> out there (some a bit slower, some much slower at both compression and 
> decompression) that produce substantially smaller output.

Its been discussed once before on the list, in very recent history,
but not by a whole lot.  As Junio pointed out, I don't think there
ever really was any discussion of is gzip the best way to deflate the
objects.  I think gzip was just chosen simply because it was readily
available in libz, stable, and has a pretty decent speed/size ratio.
 
> I think it'd be kind of neat to have my .git directory shrink by another 
> 20+%. That's conservative; on maximumcompression.com's test of a mix of 
> different file types including images, gzip compresses 64% and the 
> best-scoring one does 80%. On English text gzip does 71% and the top 
> scorer does 89%. Most of the top-tier compressors are proprietary, but 

Yes.  But in many cases we might actually be able to do even better
by going with a pack-wide dictionary.  Why?

Think about source code structure.  E.g.

  $ git grep --cached 'struct object'| cut -d: -f1|wc -l
     402

So 402 files in git.git use the term 'struct object', and that's just
the current revision I had in my index.  With our current packfile
organization we are likely to store this string at least 402 times.
We'll store it once in each file's delta chain, assuming each
file's blobs largely fall into a single delta chain for that file
(reasonable assumption, but certainly not always true).

That's just one string that does appear somewhat frequently in any
file its used in.  Now try 'unsigned char' (its 944 files, but an
even higher frequency-per-file).

So anyway, for the past year I've been thinking about trying to
implement a blob-level dictionary prototype to see if it helps on a
project like linux-2.6.git, but I haven't gotten to it.  The pack v4
work was about applying that basic dicationary principal to trees
and commits, and I think it pays off nicely there.  Just need to
get it cleaned up, rebased onto current master, and submitted to
the list for wider testing.  ;-)

-- 
Shawn.
