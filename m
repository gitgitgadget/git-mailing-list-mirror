From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Fri, 30 Sep 2011 15:02:30 -0600
Organization: CAF
Message-ID: <201109301502.30617.mfick@codeaurora.org>
References: <4DF6A8B6.9030301@op5.se> <201109262056.04279.chriscool@tuxfamily.org> <201109301041.13848.mfick@codeaurora.org>
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
X-From: git-owner@vger.kernel.org Fri Sep 30 23:02:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9kEH-0002A6-5X
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 23:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027Ab1I3VCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 17:02:40 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:16108 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152Ab1I3VCj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 17:02:39 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6485"; a="123936488"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 30 Sep 2011 14:02:31 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 2284510004BE;
	Fri, 30 Sep 2011 14:02:31 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <201109301041.13848.mfick@codeaurora.org>
X-Length: 3440
X-UID: 21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182508>

On Friday, September 30, 2011 10:41:13 am Martin Fick wrote:
> massive fix to bring it down to 7.5mins was awesome.
> 7-8mins sounded pretty good 2 weeks ago, especially when
> a checkout took 5+ mins!  but now that almost every
> other operation has been sped up, that is starting to
> feel a bit on the slow side still.  My spidey sense
> tells me something is still not quite right in the fetch
> path.

I guess I overlooked that there were 2 sides to this 
equation.  Even though I have been doing my fetches locally, 
I was using the file:// protocol and it appears that the 
remote was running git 1.7.6 which was in my path the whole 
time.  So eliminating that from my path and pointing to the 
the "best" binary with all the fixes for both remote and 
local, the full fetch does indeed speed up quite a bit, it 
goes from about 7.5mins down to ~5m!  Previously the remote 
seemed to primarily spend the extra time after:

 remote: Counting objects: 316961

yet before:

 remote: Compressing objects


> Here is some more data to backup my spidey sense: after
> all the improvements, a noop fetch of all the changes
> (noop meaning they are all already uptodate) takes
> around 3mins with a non gced (non packed refs) case. 
> That same noop only takes ~12s in the gced (packed ref
> case)!

I believe (it is hard to be go back and be sure) that this 
means that the timings above which gave me 3mins were 
because the remote was using git 1.7.6.  Now, with the good 
binary, in both repos (packed and unpacked), I get great 
warm cache times of about 11-13s for a noop fetch.  It is 
interesting to note that cold cache times are 20s for packed 
refs and 1m30s for unpacked refs.  I guess that makes some 
sense.  

But, this does leave me thinking that packed refs should 
become the default and that there should be a config option 
to disable it?  This still might help a fetch?

Since a full sync is now done to about 5mins, I broke down 
the output a bit.  It appears that the longest part (2:45m) 
is now the time spent scrolling though each change still.  
Each one of these takes about 2ms:
 * [new branch]      refs/changes/99/71199/1 -> 
refs/changes/99/71199/1

Seems fast, but at about 80K... So, are there any obvious N 
loops over the refs happening inside each of of the [new 
branch] iterations?


-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
