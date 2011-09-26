From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 26 Sep 2011 14:01:38 -0600
Organization: CAF
Message-ID: <201109261401.38624.mfick@codeaurora.org>
References: <4DF6A8B6.9030301@op5.se> <201109261207.52736.mfick@codeaurora.org> <88a00eadcbb4a7946dbe8d70dd0e933d@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Sep 26 22:01:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8HN8-0002LE-C1
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 22:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002Ab1IZUBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 16:01:45 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:13174 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855Ab1IZUBo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 16:01:44 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6481"; a="121557656"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 26 Sep 2011 13:01:39 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id C0EDA10004BE;
	Mon, 26 Sep 2011 13:01:39 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <88a00eadcbb4a7946dbe8d70dd0e933d@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182158>

On Monday, September 26, 2011 12:37:10 pm Julian Phillips 
wrote:
> On Mon, 26 Sep 2011 12:07:52 -0600, Martin Fick wrote:
> -- snip --
> 
> > Ahh, I think I have some more clues.  So while this
> > change does not speed things up for me normally, I
> > found a case where it does!  I  set my .git/config to
> > have
> > 
> >   [core]
> >   
> >         compression = 0
> > 
> > and ran git-gc on my repo.  Now, with a modern git with
> > this optimization in it (1.7.6, 1.7.7.rc0...), 'git
> > branch' is almost instantaneous (.05s)!  But, if I
> > revert c774aa it takes > ~15s.
> 
> I don't understand this.  I don't see why
> core.compression should have anything to do with refs
> ...
> 
> > So, it appears that this optimization is foiled by
> > compression?  In the case when this optimization helps,
> > it save about 15s, when it hurts (with compression),
> > it seems to cost > 3mins.  I am not sure this
> > optimization is worth it?  Would there be someway for
> > it to adjust to the repo conditions?
> 
> Well, in the case I tried it was 1.2s vs 40s.  It would
> seem that you have managed to find some corner case.  It
> doesn't seem right to punish everyone who has large
> numbers of refs by making their commands take orders of
> magnitude longer to save one person 3m.  Much better to
> find, understand and fix the actual cause.

I am not sure mine is the corner case, it is a real repo 
(albeit a Gerrit repo with strange refs/changes), while it 
sounds like yours is a test repo.  It seems likely that 
whatever you did to create the test repo makes it perform 
well?  I am also guessing that it is not the refs which are 
the problem but the objects since the refs don't get 
compressed do they?  Does your repo have real data in it 
(not just 100K refs)?  

My repo compressed is about ~2G and uncompressed is ~1.1G
Yes, the compressed one is larger than the uncompressed one.
Since the compressed repo above was larger, I thought that I 
should at lest gc it.  After git gc, it is ~1.1G, so it 
looks like the size difference was really because of not 
having gced it at first after fetching the 100K refs.

After a gc, the repo does perform the similar to the 
uncompressed one (which was achieved via gc).  After gc, it 
takes ~.05s do to a 'git branch' with 1.7.6 and 
git.1.7.7.rc0.72.g4b5ea.  It also takes a bit more than 15s 
with the patch reverted.  So it appears that compression is 
not likely the culprit, but rather the need to be gced.

So, maybe you are correct, maybe my repo is the corner case?  
Is a repo which needs to be gced considered a corner case?  
Should git be able to detect that the repo is so in 
desperate need of gcing?  Is it normal for git to need to gc 
right after a clone and then fetching ~100K refs?

I am not sure what is right here, if this patch makes a repo 
which needs gcing degrade 5 to 10 times worse than the 
benefit of this patch, it still seems questionable to me.


 
> I really can't see what effect core.compression can have
> on loading the ref_list.  Certainly the sort doesn't
> load anything from the object database.  It would be
> really good to profile and find out what is taking all
> the time - I am assuming that the CPU is at 100% for the
> 3+ minutes?

Yes, 100% CPU (I mostly run the tests at least twice and 
have 8G of RAM, so I think the entire repo gets cached).


> Random thought.  What happens to the with compression
> case if you leave the commit in, but add a sleep(15) to
> the end of sort_refs_list?

Why, what are you thinking?  Hmm, I am trying this on the 
non gced repo and it doesn't seem to be completing (no cpu 
usage)!  It appears that perhaps it is being called many 
times (the sleeping would explain no cpu usage)?!?  This
could be a real problem, this should only get called once 
right?

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
