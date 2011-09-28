From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Wed, 28 Sep 2011 13:38:04 -0600
Organization: CAF
Message-ID: <201109281338.04378.mfick@codeaurora.org>
References: <4DF6A8B6.9030301@op5.se> <201109251443.28243.mfick@codeaurora.org> <CAP8UFD3TWQHU0wLPuxMDnc3bRSz90Yd+yDMBe03kofeo-nr7yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 21:38:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8zxN-0001zC-MG
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 21:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374Ab1I1TiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 15:38:09 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:39602 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab1I1TiH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 15:38:07 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6483"; a="123223697"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 28 Sep 2011 12:38:07 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 8CFA710004BE;
	Wed, 28 Sep 2011 12:38:06 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <CAP8UFD3TWQHU0wLPuxMDnc3bRSz90Yd+yDMBe03kofeo-nr7yA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182362>

On Monday, September 26, 2011 06:41:04 am Christian Couder 
wrote:
> On Sun, Sep 25, 2011 at 10:43 PM, Martin Fick 
<mfick@codeaurora.org> wrote:
...
> >  git checkout
> > 
> > can also take rather long periods of time > 3 mins when
> > run on a repo with ~100K refs.
...
> >  So, I bisected this issue also, and it seems that the
> > "offending" commit is
...
> > commit 680955702990c1d4bfb3c6feed6ae9c6cb5c3c07
> > Author: Christian Couder <chriscool@tuxfamily.org>
> > 
> >    replace_object: add mechanism to replace objects
> > found in "refs/replace/"
...

> I don't think there is an obvious problem with it, but it
> would be nice if you could dig a bit deeper.
> 
> The first thing that could take a lot of time is the call
> to for_each_replace_ref() in this function:
> 
> +static void prepare_replace_object(void)
> +{
> +       static int replace_object_prepared;
> +
> +       if (replace_object_prepared)
> +               return;
> +
> +       for_each_replace_ref(register_replace_ref, NULL);
> +       replace_object_prepared = 1;
> +}

The time was actually spent in for_each_replace_ref()
which calls get_loose_refs() which has the recursive bug 
that Julian Phillips fixed 2 days ago.  Good to see that 
this fix helps other use cases too.

So with that bug fixed, the thing taking the most time now 
for a git checkout with ~100K refs seems to be the orphan 
check as Thomas predicted.  The strange part with this, is 
that the orphan check seems to take only about ~20s in the 
repo where the refs aren't packed.  However, in the repo 
where they are packed, this check takes at least 5min!  This 
seems a bit unusual, doesn't it?  Is the filesystem that 
much better at indexing refs than git's pack mechanism?  
Seems unlikely, the unpacked refs take 312M in the FS, the 
packed ones only take about 4.3M.  I suspect their is 
something else unexpected going on here in the packed ref 
case.  

Any thoughts?  I will dig deeper...

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
