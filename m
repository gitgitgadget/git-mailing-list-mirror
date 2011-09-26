From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 26 Sep 2011 09:15:29 -0600
Organization: CAF
Message-ID: <201109260915.29285.mfick@codeaurora.org>
References: <4DF6A8B6.9030301@op5.se> <1315529522448-6774328.post@n2.nabble.com> <201109251443.28243.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Sep 26 17:15:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8Cu8-0002Q0-UK
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 17:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347Ab1IZPPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 11:15:32 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:20431 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab1IZPPb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 11:15:31 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6480"; a="121450257"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 26 Sep 2011 08:15:31 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 6ECB310004BE;
	Mon, 26 Sep 2011 08:15:31 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <201109251443.28243.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182121>

OK, I have found what I believe is another performance 
regression for large ref counts (~100K).  

When I run git br on my repo which only has one branch, but 
has ~100K refs under ref/changes (a gerrit repo), it takes 
normally 3-6mins depending on whether my caches are fresh or 
not.  After bisecting some older changes, I noticed that 
this ref seems to be where things start to get slow: 
c774aab98ce6c5ef7aaacbef38da0a501eb671d4


commit c774aab98ce6c5ef7aaacbef38da0a501eb671d4
Author: Julian Phillips <julian@quantumfyre.co.uk>
Date:   Tue Apr 17 02:42:50 2007 +0100

    refs.c: add a function to sort a ref list, rather then 
sorting on add

    Rather than sorting the refs list while building it, 
sort in one
    go after it is built using a merge sort.  This has a 
large
    performance boost with large numbers of refs.

    It shouldn't happen that we read duplicate entries into 
the same
    list, but just in case sort_ref_list drops them if the 
SHA1s are
    the same, or dies, as we have no way of knowing which 
one is the
    correct one.

    Signed-off-by: Julian Phillips 
<julian@quantumfyre.co.uk>
    Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
    Signed-off-by: Junio C Hamano <junkio@cox.net>



which is a bit strange since that commit's purpose was to 
actually speed things up in the case of many refs.  Just to 
verify, I reverted the commit on 1.7.7.rc0.73 and sure 
enough, things speed up down to the 14-20s range depending 
on caching.

If this change does not actually speed things up, should it 
be reverted?  Or was there a bug in the change that makes it 
not do what it was supposed to do?

Thanks,

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
