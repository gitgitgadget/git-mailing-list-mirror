From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Tue, 14 Feb 2006 01:14:06 -0500
Message-ID: <20060214061406.GA13238@spearce.org>
References: <20060210195914.GA1350@spearce.org> <tnxy80fe2zo.fsf@arm.com> <20060214045618.GA12844@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 07:14:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8tS5-00019Q-UN
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 07:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030486AbWBNGOL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 01:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030485AbWBNGOL
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 01:14:11 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:1497 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1030482AbWBNGOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 01:14:09 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1F8tRw-00072N-Gs; Tue, 14 Feb 2006 01:14:08 -0500
Received: by asimov.spearce.org (Postfix, from userid 1000)
	id 78D3120FBA0; Tue, 14 Feb 2006 01:14:06 -0500 (EST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org,
	Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060214045618.GA12844@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16118>

Shawn Pearce <spearce@spearce.org> wrote:
> > >     pg operations generally perform faster than StGIT operations,
> > >     at least on my large (~7000 file) repositories.
> > 
> > Might be possible but I haven't done any tests. There are some
> > optimisations in StGIT that make it pretty fast: (1) if the base of
> > the patch has not changed, it can fast-forward the pushed patches
> > which is O(1) and (2) StGIT first tries to use git-apply when pushing
> > a patch and use a three-way merge only if this fails (the operation
> > usually succeeds for most of the patches). There are some speed
> > problems with three-way merging if there are many file
> > removals/additions because the external merge tool is called for each
> > of them but the same problem exists for any other tool.

I did a quick benchmark of the latest StGIT and pg versions available
by cloning a linux repository twice (pg and stg) and constructing
an identical patch in in each which modified the same set of files
(3 files in 3 different subdirectories).

Popping and pushing this patch of 3 files is a fast forward/rewind
case to both implementations, but pg was faster for me:

stg pop; stg push (fast-forward)
  pop  real 0m13.824s user 0m1.904s sys 0m3.934s
  pop  real 0m13.670s user 0m1.882s sys 0m3.973s
  pop  real 0m21.070s user 0m2.005s sys 0m4.069s
  pop  real 0m15.346s user 0m1.757s sys 0m3.846s
  pop  real 0m16.960s user 0m1.888s sys 0m3.866s
          
  push real 0m20.650s user 0m2.027s sys 0m4.015s
  push real 0m15.624s user 0m1.958s sys 0m3.966s
  push real 0m13.277s user 0m1.746s sys 0m3.796s
  push real 0m12.739s user 0m1.764s sys 0m3.822s
  push real 0m15.161s user 0m1.973s sys 0m3.939s
        
pg-pop; pg-push (fast-forward)
  pop  real 0m10.009s user 0m1.919s sys 0m2.265s
  pop  real 0m 4.710s user 0m1.692s sys 0m1.560s
  pop  real 0m 4.333s user 0m1.664s sys 0m1.554s
  pop  real 0m 5.480s user 0m1.848s sys 0m1.638s
  pop  real 0m 4.412s user 0m1.680s sys 0m1.604s
          
  push real 0m5.813s user 0m1.750s sys 0m1.733s
  push real 0m4.345s user 0m1.686s sys 0m1.632s
  push real 0m5.326s user 0m1.721s sys 0m1.658s
  push real 0m4.740s user 0m1.691s sys 0m1.647s
  push real 0m4.487s user 0m1.702s sys 0m1.637s


I tried to do the merge case which requires reconstructing the
patch onto a new base revision.  This was easy to test over and over
again on pg (pg-rebase; pg-rebase --undo) but I don't know how I can
safely undo the stg pull so I can repeat it on the stg repository.
Instead I tested git-diff-tree|git-apply as that's what StGIT uses
internally.  StGIT does a check for a clean tree before starting
its merge so I cheated here and used the pg version of that check
as part of the diff/apply cost to try and make it slightly more
fair to pg-rebase.

git-diff-tree -p %s %s | git-apply --index
  diff/apply real 0m6.246s user 0m1.377s sys 0m1.634s
  diff/apply real 0m5.293s user 0m1.342s sys 0m1.591s
  diff/apply real 0m5.929s user 0m1.445s sys 0m1.614s
  diff/apply real 0m5.258s user 0m1.333s sys 0m1.567s
  diff/apply real 0m5.255s user 0m1.339s sys 0m1.581s

pg-rebase; pg-rebase --undo (merge)
  rebase real 0m9.505s user 0m4.028s sys 0m3.366s
  rebase real 0m9.415s user 0m4.020s sys 0m3.334s
  rebase real 0m9.387s user 0m4.028s sys 0m3.364s
  rebase real 0m9.159s user 0m4.024s sys 0m3.353s
  rebase real 0m9.008s user 0m4.025s sys 0m3.326s

  undo   real 0m6.531s user 0m1.852s sys 0m2.403s
  undo   real 0m6.383s user 0m1.815s sys 0m2.405s
  undo   real 0m6.510s user 0m1.849s sys 0m2.406s
  undo   real 0m6.519s user 0m1.846s sys 0m2.408s
  undo   real 0m6.496s user 0m1.878s sys 0m2.413s

I guess you could say I didn't entirely expect this result.
The diff-tree/apply approach is faster for a single commit then
read-tree -u -m is; even if totally different files are being
impacted and thus all stages collapse neatly to stage 0 in the index.
No wonder StGIT uses diff/apply!

-- 
Shawn.
