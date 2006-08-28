From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Packfile can't be mapped
Date: Sun, 27 Aug 2006 22:47:20 -0400
Message-ID: <20060828024720.GD24204@spearce.org>
References: <9e4733910608271804j762960a8ud83654c78ebe009a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 28 05:21:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHXgV-0007sf-VX
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 05:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWH1DU6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 23:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWH1DU6
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 23:20:58 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:23178 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932306AbWH1DU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 23:20:57 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GHXg1-0004qh-Ii; Sun, 27 Aug 2006 23:20:42 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 39B6820FB7F; Sun, 27 Aug 2006 22:47:21 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <9e4733910608271804j762960a8ud83654c78ebe009a@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26135>

Jon Smirl <jonsmirl@gmail.com> wrote:
> git-repack can't handle my 1.75GB pack file. I am running x86 with 3GB
> address space.
> 
> -rw-rw-r-- 1 jonsmirl jonsmirl    47221712 Aug 27 20:29 testme.idx
> -rw-rw-r-- 1 jonsmirl jonsmirl  1754317619 Aug 27 20:29 testme.pack
> 
> [jonsmirl@jonsmirl t1]$ git-repack -a -f --window=50 --depth=5000
> Generating pack...
> Done counting 1963325 objects.
> fatal: packfile .git/objects/pack/testme.pack cannot be mapped.
> [jonsmirl@jonsmirl t1]$
> 
> It is built from Mozilla CVS but it is an intermediate stage of our
> work. The fast-import tool isn't diffing directory tree which makes
> the pack much bigger than it needs to be. Shawn is working on the
> packing code.

I'm going to try to get tree deltas written to the pack sometime this
week. That should compact this intermediate pack down to something
that git-pack-objects would be able to successfully mmap into a
32 bit address space.  A complete repack with no delta reuse will
hopefully generate a pack closer to 400 MB in size.  But I know
Jon would like to get that pack even smaller.  :)

I should point out that the input stream to fast-import was 20 GB
(completely decompressed revisions from RCS) plus all commit data.
The original CVS ,v files are around 3 GB.  An archive .tar.gz'ing
the ,v files is around 550 MB.  Going to only 1.7 GB without tree
or commit deltas is certainly pretty good.  :)

> ---------------------------------------------------
> Alloc'd objects:    1968000 (   1892000 overflow  )
> Total objects:      1967527 (     41856 duplicates)
>       blobs  :       633842 (         0 duplicates)
>       trees  :      1131208 (     41856 duplicates)
>       commits:       200921 (         0 duplicates)
>       tags   :         1556 (         0 duplicates)
> Total branches:        1600 (      7985 loads     )
>       marks:        1048576 (    200921 unique    )
>       atoms:          56803
> Memory total:         66908 KiB
>        pools:          5408 KiB
>      objects:         61500 KiB
> Pack remaps:           9501
> ---------------------------------------------------
> Pack size:          1713200 KiB
> Index size:           46114 KiB

All of that says that aside from the 1.7 GB output file fast-import
ran extremely well.  About 1.9 million objects were written into
the output pack file, with 41k duplicate trees (duplicate blobs
were removed by cvs2svn prior to fast-import so they don't appear).
200k commits were created across 1600 branches.  And we did it in
only 67 MB of memory.

We also had ~8000 LRU cache misses related to our branch data;
this just means that cvs2svn likes to frequently jump around
between branches rather than import an entire branch at a time.
Boosting the size of the LRU cache (at the expense of needing more
memory) should reduce those cache misses as well as 'Pack remaps'.

I'd also like to clean up that pack remapping code and move it
into sha1_file.c.  Its an implementation of partial pack mapping
and it is apparently working quite well for us in fast-import.
It may help GIT deal with very large packs (e.g. 1.7 GB) on smaller
address space systems (e.g. 32 bit).


We're not confident that this import is completely valid yet.
We have a few translation issues we're still working on.  But now
that we have a complete pack going from start to finish we can start
to focus on those issues.  Especially since this entire process
(,v to .pack) is less than half a day to run.

-- 
Shawn.
