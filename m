From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-fast-import
Date: Sat, 5 Aug 2006 23:40:09 -0400
Message-ID: <20060806034009.GE20565@spearce.org>
References: <9e4733910608051951g42bc4a5dv560c12e0a9add163@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 06 05:40:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9ZV6-0006AM-M2
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 05:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWHFDkS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 23:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWHFDkR
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 23:40:17 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:23947 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751510AbWHFDkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 23:40:16 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G9ZUg-0008OL-Dm; Sat, 05 Aug 2006 23:40:02 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BC3F120FB77; Sat,  5 Aug 2006 23:40:09 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910608051951g42bc4a5dv560c12e0a9add163@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24958>

Jon Smirl <jonsmirl@gmail.com> wrote:
> git-fast-import works great. I parsed and built my pack file in
> 1:45hr. That's way better than 24hr. I am still IO bound but that
> seems to be an issue with not being able to read ahead 150K small
> files. CPU utilization averages about 50%.

Excellent.  Now if only the damn RCS files were in a more suitable
format.  :-)
 
> I didn't bother reading the sha ids back from fast-import, instead I
> computed them in the python code. Python has a C library function for
> sha1. That decouple the processes from each other. They would run in
> parallel on SMP.

At least you are IO bound and not CPU bound.  But it is silly for the
importer in Python to be computing the SHA1 IDs and for fast-import
to also be computing them.  Would it help if fast-import allowed
you to feed in a tag string which it dumps to an output file listing
SHA1 and the tag?  Then you can feed that data file back into your
tree/commit processing for revision handling.

> My pack file is 980MB compared to 680MB from other attempts. I am
> still missing entries for the trees and commits.

The delta selection ain't the best.  It may be the case that prior
attempts were combining files to get better delta chains vs. staying
all in one file.  It may be the case that the branches are causing
the delta chains to not be ideal.  I guess I expected slightly
better but not that much; earlier attempts were around 700 MB so
I thought maybe you'd be in the 800 MB ballpark.  Under 1 GB is
still good though as it means its feasible to fit the damn thing
into memory on almost any system, which makes it pretty repackable
with the standard packing code.

Its possible that you are also seeing duplicates in the pack;
I actually wouldn't be surprised if at least 100 MB of that was
duplicates where the author(s) reverted a file revision to an exact
prior revision, such that the SHA1 IDs were the same.  fast-import
(as I have previously said) is stupid and will write the content
out twice rather than "reuse" the existing entry.


Tonight I'll try to improve fast-import.c to include index
generation, and at the same time perform duplicate removal.
That should get you over the GPF in index-pack.c, may reduce disk
usage a little for the new pack, and save you from having to perform
a third pass on the new pack.

-- 
Shawn.
