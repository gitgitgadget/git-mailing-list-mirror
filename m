From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Fri, 30 Sep 2011 10:41:13 -0600
Organization: CAF
Message-ID: <201109301041.13848.mfick@codeaurora.org>
References: <4DF6A8B6.9030301@op5.se> <201109261147.56607.mfick@codeaurora.org> <201109262056.04279.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Fri Sep 30 18:42:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from [209.132.180.67] (helo=vger.kernel.org)
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9gAE-0002lu-Ie
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 18:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475Ab1I3QlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 12:41:17 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:21544 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab1I3QlR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 12:41:17 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6485"; a="123672298"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 30 Sep 2011 09:41:14 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id C602A10004BE;
	Fri, 30 Sep 2011 09:41:14 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <201109262056.04279.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182492>

> On Monday, September 26, 2011 12:56:04 pm Christian Couder 
wrote:
> After "git pack-refs --all" I get:

OK.   So many great improvements in ref scalability, thanks 
everyone!

It is getting so good, that I had to take a step back and 
re-evaluate what we consider good/bad.  On doing so, I can't 
help but think that fetches still need some improvement.

Fetches had the worst regression of all > 8days, so the 
massive fix to bring it down to 7.5mins was awesome.  
7-8mins sounded pretty good 2 weeks ago, especially when a 
checkout took 5+ mins!  but now that almost every other 
operation has been sped up, that is starting to feel a bit 
on the slow side still.  My spidey sense tells me something 
is still not quite right in the fetch path.

Here is some more data to backup my spidey sense: after all 
the improvements, a noop fetch of all the changes (noop 
meaning they are all already uptodate) takes around 
3mins with a non gced (non packed refs) case.  That same 
noop only takes ~12s in the gced (packed ref case)!

I dug into this a bit further.  I took a non gced and non 
packed refs repo and this time instead of gcing it to get 
packedrefs, I only ran the above git pack-refs --all so that
objects did not get gced.  With this, the noop fetch was 
also only around 12s.  This confirmed that the non gced 
objects are not interfering with the noop fetch, the problem 
really is just the unpacked refs.  Just to confirm that the 
FS is not horribly slow, I did a "find .git/refs" and it 
only takes about .4s for about 80Kresults!

So, while I understand that a full fetch will actually have 
to transfer quite a bit of data, the noop fetch seems like 
it is still suffering in the non gced (non packed ref case).  
If that time were improved, I suspect that the full fetch 
will improve at least by an equivalent amount, if not more.

Any thoughts?

-Martin


-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
