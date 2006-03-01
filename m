From: Shawn Pearce <spearce@spearce.org>
Subject: Re: bug?: stgit creates (unneccessary?) conflicts when pulling
Date: Wed, 1 Mar 2006 09:51:05 -0500
Message-ID: <20060301145105.GB3313@spearce.org>
References: <20060227204252.GA31836@diana.vm.bytemark.co.uk> <20060227222600.GA11797@spearce.org> <tnx1wxmig75.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 15:52:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FESfe-0000aM-9H
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 15:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWCAOvP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 09:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWCAOvO
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 09:51:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58847 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932274AbWCAOvO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 09:51:14 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FESfO-0006gE-LK; Wed, 01 Mar 2006 09:51:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 31C0B20FBBF; Wed,  1 Mar 2006 09:51:05 -0500 (EST)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <tnx1wxmig75.fsf@arm.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16976>

[Side Note: I've suddenly stopped receiving mail from vger.
 Even majordomo isn't replying to my pleas for help.  Arggh!
 Yet all other incoming email seems to be fine.]

Catalin Marinas <catalin.marinas@arm.com> wrote:
> Shawn Pearce <spearce@spearce.org> wrote:
> > Karl Hasselstr?m <kha@treskal.com> wrote:
> >> If I make a patch series where more than one patch touches the same
> >> line, I get a lot of merge errors when upstream has accepted them and
> >> I try to merge them back.
> >
> > When pg grabs its (possibly remote) parent ("stg pull" aka pg-rebase)
> > we try to push down PatchA.  If PatchA fails to push cleanly we'll
> > pop it off and try to push PatchA + PatchB.  If that pushes cleanly
> > then we fold the content of PatchA into PatchB, effectively making
> > PatchA part of PatchB.  If PatchA + PatchB failed to push down
> > cleanly then we pop both and retry pushing PatchA + PatchB + PatchC.
> 
> How do you solve the situation where only PatchA, PatchC and PatchE
> were merged, B and D still pending? Trying combinations of patches is
> not a good idea.

Yea, ouch.  pg would fold everything into E, destroying the B
and D boundary.  A (not so good) workaround right now would be to
undo the rebase, pop all patches, rebase, then push one by one.
I didn't even consider this case as its not my workflow style:
at least not right now.

> As I said, if you have a big number of patches this might be pretty
> slow. Have a look at my patch for trying the reversed patches in
> reverse order. It seems to solve this problem for most of the
> cases. There are cases when this method would fail like adjacent
> changes made by third-party patches that break the context of the git
> patches and git-apply would fail. An addition to this would be to try
> a diff3 merge with the reversed patch but I don't think it's worth
> since it would become much slower.

True.  The constant reapplication does really slow it down.  So does
grabbing the reverse patch and seeing if it applies backwards
cleanly.  Neither operation is fast, and neither is really going
to be fast.

BTW - I did read through your patch when it was posted: the reverse
apply idea is pretty slick and should work a large part of the time,
as you said.  Nice addition to StGIT.
 
> > If that pushes down cleanly then we make PatchA and PatchB officially
> > part of PatchC.
> 
> I don't agree with this. For example, patches A, B and C change the
> same line in file1 but patch A also changes file2 and patch B changed
> file3. With your approach, merging A+B+C succeeds and you make A and B
> part of C and hence move the changed to file2 and file3 in patch C.
> 
> The above can happen when the maintainer only merges part of the patch
> or simply decides to merge patch C only and manually solve the
> conflict in file1 (since patch C is based on the context from patches
> A+B).

Ah, yes.  The upstream maintainer who doesn't take everything.
Shame on them.  :-) Shame on me for also not dealing with this
case in pg, you are completely correct that folding these patches
together in this scenario is a really bad idea.

In the one environment where I really use pg the upstream is forced
to take the entire patch: I have my own foreign SCM interface to PVCS
VM (its heavily customized crap, so I'm not going to contribute it)
and in this interface the upstream is forced to take the entire patch
every time.  So right now its not a huge concern to me personally,
but if anyone else is trying to use pg it might be.

-- 
Shawn.
