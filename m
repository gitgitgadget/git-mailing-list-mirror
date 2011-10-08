From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Sat, 8 Oct 2011 14:59:51 -0600
Organization: CAF
Message-ID: <201110081459.52174.mfick@codeaurora.org>
References: <4DF6A8B6.9030301@op5.se> <201109301502.30617.mfick@codeaurora.org> <201109301606.31748.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	=?iso-8859-1?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 22:59:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCdzy-0001Ia-Kb
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 22:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494Ab1JHU7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 16:59:54 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:48874 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab1JHU7x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 16:59:53 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6493"; a="125836260"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 08 Oct 2011 13:59:53 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 326C210004C2;
	Sat,  8 Oct 2011 13:59:53 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <201109301606.31748.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183175>

On Friday, September 30, 2011 04:06:31 pm Martin Fick wrote:
> On Friday, September 30, 2011 03:02:30 pm Martin Fick 
wrote:
> > On Friday, September 30, 2011 10:41:13 am Martin Fick
> 
> wrote:
> > Since a full sync is now done to about 5mins, I broke
> > down the output a bit.  It appears that the longest
> > part (2:45m) is now the time spent scrolling though
> > each
> > 
> > change still. Each one of these takes about 2ms:
> >  * [new branch]      refs/changes/99/71199/1 ->
> > 
> > refs/changes/99/71199/1
> > 
> > Seems fast, but at about 80K... So, are there any
> > obvious N loops over the refs happening inside each of
> > of the [new branch] iterations?
> 
> OK, I narrowed it down I believe.  If I comment out the
> invalidate_cached_refs() line in write_ref_sha1(), it
> speeds through this section.
> 
> I guess this makes sense, we invalidate the cache and
> have to rebuild it after every new ref is added? 
> Perhaps a simple fix would be to move the invalidation
> right after all the refs are updated?  Maybe
> write_ref_sha1 could take in a flag to tell it to not
> invalidate the cache so that during iterative updates it
> could be disabled and then run manually after the
> update?

OK, this thing has been bugging me...

I found some more surprising results, I hope you can follow 
because there are corner cases here which have surprising 
impacts.


** Important fact: 
** ---------------
** When I clone my repo, it has about 4K tags which
** come in packed to the clone.
**

This fact has a heavy impact on how I test things. If I 
choose to delete these packed-refs from the cloned repo and 
then do a fetch of the changes, all of the tags are also 
fetched along with these changes.  This means that if I want 
to test the impact of having packed-refs vs no packed refs, 
on my change fetches, I need to first delete the packed-refs 
file, and second fetch all the tags again, so that when I 
fetch the changes, the repo only actually fetches changes, 
not all the tags!

So, with this in mind, I have discovered, that the fetch 
performance degradation by invalidating the caches in 
write_ref_sha1() is actually due to the packed-refs being 
reloaded and resorted again on each ref insertion (not the 
loose refs)!!!

Remember the important fact above?  Yeah, those silly 4K 
refs (not a huge number, not 61K!) take a while to reread 
from the file and sort.  When this is done for 61K changes, 
it adds a lot of time to a fetch.  The sad part is that, of 
course, the packed-refs don't really need to be invalidated 
since we never add new refs as packed refs during a fetch 
(but apparently we do during a clone)!  Also noteworthy is 
that invalidating the loose refs, does not cause a big 
delay.


Some data:

1) A fetch of the changes in my series with all good 
external patches applied takes about 7:30min.


2) A fetch of the changes with #1 invalidate_cache_refs() 
commented out in write_ref_sha1() takes about 1:50min.


3) A fetch of the changes with #1 with 
invalidate_cache_refs() in write_ref_sha1() replaced with a 
call to my custom invalidate_loose_cache_refs() takes about 
1:50min.


4) A fetch with #1 on a repo with packed-refs deleted after 
the clone, takes about ~5min.  

** This is a strange regression which threw me off.  In this 
case, all the tags are refetched in addition to the changes, 
this seems to cause some weird interaction that makes things 
take longer than they should (#5 + #6 = 2:10m  <<  #4 5min).


5) A fetch with #1 on a repo with packed-refs deleted after 
the clone, and then a fetch done to get all the tags (see 
#6), takes only 1:30m!!!!


6) A fetch to get all the **TAGS** with packed-refs deleted 
after the clone, takes about 40s.



---Additional side data/tests:

7) A fetch of the changes with #1 and a special flag causing 
the packed-refs to be read from the file, but not parsed or 
sorted, takes 2:34min.  So just the repeated reads add at 
least 40s.


8) A fetch of the changes with #1 and a special flag causing 
the packed-refs to be read from the file, parsed, but NOT 
sorted, takes 3:40min.  So the parsing appears to take an 
additional minute at least.




I think that all of this might explain why no matter how 
good Michael's intentions are with his patch series, his 
series isn't likely to fix this problem unless he does not 
invalidate the packed-refs after each insertion.  I tried 
preventing this invalidation in his series to prove this, 
but unfortunately, it appears that in his series it is no 
longer possible to only invalidate just the packed-refs? :(
Michael, I hope I am completely wrong about that...


Are there any good consistency reasons to invalidate the 
packed refs in write_ref_sha1()?  If not, would you accept a 
patch to simply skip this invalidation (to only invalidate 
the loose refs)?

Thanks,
 
-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
