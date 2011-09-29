From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Wed, 28 Sep 2011 19:37:18 -0600
Message-ID: <960aacbf-8d4d-4b2a-8902-f6380ff9febd@email.android.com>
References: <4DF6A8B6.9030301@op5.se> <CAP8UFD3TWQHU0wLPuxMDnc3bRSz90Yd+yDMBe03kofeo-nr7yA@mail.gmail.com> <201109281338.04378.mfick@codeaurora.org> <201109281610.49322.mfick@codeaurora.org> <c76d7f65203c0fc2c6e4e14fe2f33274@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Thu Sep 29 03:38:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R95a4-0004aD-N1
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 03:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754790Ab1I2Bi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 21:38:28 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:24179 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706Ab1I2Bi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 21:38:27 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6483"; a="123131477"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 28 Sep 2011 18:38:27 -0700
Received: from [192.168.1.190] (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id E45B210004BE;
	Wed, 28 Sep 2011 18:38:26 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <c76d7f65203c0fc2c6e4e14fe2f33274@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182380>

On Wednesday 28 September 2011 18:59:09 Martin Fick wrote: 
> Julian Phillips <julian@quantumfyre.co.uk> wrote: 
> > On Wed, 28 Sep 2011 16:10:48 -0600, Martin Fick wrote: 
> >> So with that bug fixed, the thing taking the most time 
> >> now for a git checkout with ~100K refs seems to be the 
> >> orphan check as Thomas predicted. The strange part with 
> >> this, is that the orphan check seems to take only about 
> >> ~20s in the repo where the refs aren't packed. However, 
> >> in the repo where they are packed, this check takes at 
> >> least 5min! This seems a bit unusual, doesn't it? Is 
> >> the filesystem that much better at indexing refs than 
> >> git's pack mechanism? Seems unlikely, the unpacked refs 
> >> take 312M in the FS, the packed ones only take about 
> >> 4.3M. I suspect their is something else unexpected 
> >> going on here in the packed ref case. 
> >> 
> >> Any thoughts? I will dig deeper... 
> > 
> > I think the problem is that resolve_ref() walks a linked 
> > list of searching for the packed ref. Does this mean that 
> > packed refs are not indexed at all? 
> > Are you sure that it is walking the linked list that is the problem?

It sure seems like it.

> I've created a test repo with ~100k refs/changes/... style refs, and 
> ~40000 refs/heads/... style refs, and checkout can walk the list of 
> ~140k refs seven times in 85ms user time including doing whatever other 
> processing is needed for checkout. The real time is only 114ms - but 
> then my test repo has no real data in.

If I understand what you are saying, it sounds like you do not have a very good test case. The amount of time it takes for checkout depends on how long it takes to find a ref with the sha1 that you are on. If that sha1 is so early in the list of refs that it only took you 7 traversals to find it, then that is not a very good testcase. I think that you should probably try making an orphaned ref (checkout a detached head, commit to it), that is probably the worst testcase since it should then have to search all 140K refs to eventually give up.

Again, if I understand what you are saying, if it took 85ms for 7 traversals, then it takes approximately 10ms per traversal, that's only 100/s! If you have to traverse it 140K times, that should work out to 1400s ~ 23mins.

> If resolve_ref() walking the linked list of refs was the problem, then > I would expect my test repo to show the same problem. It doesn't, a pre 
> ref-packing checkout took minutes (~0.5s user time), whereas a 
> ref-packed checkout takes ~0.1s. So, I would suggest that the problem > lies elsewhere. 
> 
> Have you tried running a checkout whilst profiling?

No, to be honest, I am not familiar with any profilling tools.

-Martin

Employee of Qualcomm Innovation Center,Inc. which is a member of Code Aurora Forum
