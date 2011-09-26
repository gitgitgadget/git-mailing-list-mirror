From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 26 Sep 2011 12:07:52 -0600
Organization: CAF
Message-ID: <201109261207.52736.mfick@codeaurora.org>
References: <4DF6A8B6.9030301@op5.se> <201109251443.28243.mfick@codeaurora.org> <201109260915.29285.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Julian Phillips <julian@quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 20:08:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8Fax-0004fR-DI
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 20:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733Ab1IZSHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 14:07:55 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:61639 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab1IZSHy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 14:07:54 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6480"; a="121660726"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 26 Sep 2011 11:07:54 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id C7AEB10004BE;
	Mon, 26 Sep 2011 11:07:53 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <201109260915.29285.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182145>

On Monday, September 26, 2011 09:15:29 am Martin Fick wrote:
> OK, I have found what I believe is another performance
> regression for large ref counts (~100K).
> 
> When I run git br on my repo which only has one branch,
> but has ~100K refs under ref/changes (a gerrit repo), it
> takes normally 3-6mins depending on whether my caches
> are fresh or not.  After bisecting some older changes, I
> noticed that this ref seems to be where things start to
> get slow: c774aab98ce6c5ef7aaacbef38da0a501eb671d4
> 
> 
> commit c774aab98ce6c5ef7aaacbef38da0a501eb671d4
> Author: Julian Phillips <julian@quantumfyre.co.uk>
> Date:   Tue Apr 17 02:42:50 2007 +0100
> 
>     refs.c: add a function to sort a ref list, rather
> then sorting on add
> 
>     Rather than sorting the refs list while building it,
> sort in one
>     go after it is built using a merge sort.  This has a
> large
>     performance boost with large numbers of refs.
> 
>     It shouldn't happen that we read duplicate entries
> into the same
>     list, but just in case sort_ref_list drops them if
> the SHA1s are
>     the same, or dies, as we have no way of knowing which
> one is the
>     correct one.
> 
>     Signed-off-by: Julian Phillips
> <julian@quantumfyre.co.uk>
>     Acked-by: Linus Torvalds
> <torvalds@linux-foundation.org> Signed-off-by: Junio C
> Hamano <junkio@cox.net>
> 
> 
> 
> which is a bit strange since that commit's purpose was to
> actually speed things up in the case of many refs.  Just
> to verify, I reverted the commit on 1.7.7.rc0.73 and
> sure enough, things speed up down to the 14-20s range
> depending on caching.
> 
> If this change does not actually speed things up, should
> it be reverted?  Or was there a bug in the change that
> makes it not do what it was supposed to do?


Ahh, I think I have some more clues.  So while this change 
does not speed things up for me normally, I found a case 
where it does!  I  set my .git/config to have

  [core]
        compression = 0

and ran git-gc on my repo.  Now, with a modern git with this 
optimization in it (1.7.6, 1.7.7.rc0...), 'git branch' is 
almost instantaneous (.05s)!  But, if I revert c774aa it 
takes > ~15s.  

So, it appears that this optimization is foiled by 
compression?  In the case when this optimization helps, it 
save about 15s, when it hurts (with compression), it seems 
to cost > 3mins.  I am not sure this optimization is worth 
it?  Would there be someway for it to adjust to the repo 
conditions?

 
Thanks,

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
