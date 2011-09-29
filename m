From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git is not scalable with too many refs/*
Date: Thu, 29 Sep 2011 01:54:00 +0100
Message-ID: <c76d7f65203c0fc2c6e4e14fe2f33274@quantumfyre.co.uk>
References: <4DF6A8B6.9030301@op5.se>
 <CAP8UFD3TWQHU0wLPuxMDnc3bRSz90Yd+yDMBe03kofeo-nr7yA@mail.gmail.com>
 <201109281338.04378.mfick@codeaurora.org>
 <201109281610.49322.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	<git@vger.kernel.org>, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Sep 29 02:54:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R94t8-000752-9M
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 02:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755383Ab1I2AyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 20:54:05 -0400
Received: from neutrino.quantumfyre.co.uk ([93.93.128.23]:54175 "EHLO
	neutrino.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755336Ab1I2AyE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2011 20:54:04 -0400
Received: from reaper.quantumfyre.co.uk (quantumfyre-1-pt.tunnel.tserv5.lon1.ipv6.he.net [IPv6:2001:470:1f08:1724::2])
	by neutrino.quantumfyre.co.uk (Postfix) with ESMTP id 04022C0626;
	Thu, 29 Sep 2011 01:54:02 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id B4D3436A856;
	Thu, 29 Sep 2011 01:54:01 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 31Z2wy9l6jRn; Thu, 29 Sep 2011 01:54:01 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id C3F7F36A4BE;
	Thu, 29 Sep 2011 01:54:00 +0100 (BST)
In-Reply-To: <201109281610.49322.mfick@codeaurora.org>
X-Sender: julian@quantumfyre.co.uk
User-Agent: Roundcube Webmail/0.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182377>

On Wed, 28 Sep 2011 16:10:48 -0600, Martin Fick wrote:
> On Wednesday, September 28, 2011 01:38:04 pm Martin Fick
> wrote:
-- snip --
>> So with that bug fixed, the thing taking the most time
>> now for a git checkout with ~100K refs seems to be the
>> orphan check as Thomas predicted.  The strange part with
>> this, is that the orphan check seems to take only about
>> ~20s in the repo where the refs aren't packed.  However,
>> in the repo where they are packed, this check takes at
>> least 5min!  This seems a bit unusual, doesn't it?  Is
>> the filesystem that much better at indexing refs than
>> git's pack mechanism? Seems unlikely, the unpacked refs
>> take 312M in the FS, the packed ones only take about
>> 4.3M.  I suspect their is something else unexpected
>> going on here in the packed ref case.
>>
>> Any thoughts?  I will dig deeper...
>
> I think the problem is that resolve_ref() walks a linked
> list of searching for the packed ref.  Does this mean that
> packed refs are not indexed at all?

Are you sure that it is walking the linked list that is the problem?  
I've created a test repo with ~100k refs/changes/... style refs, and 
~40000 refs/heads/... style refs, and checkout can walk the list of 
~140k refs seven times in 85ms user time including doing whatever other 
processing is needed for checkout.  The real time is only 114ms - but 
then my test repo has no real data in.

If resolve_ref() walking the linked list of refs was the problem, then 
I would expect my test repo to show the same problem.  It doesn't, a pre 
ref-packing checkout took minutes (~0.5s user time), whereas a 
ref-packed checkout takes ~0.1s.  So, I would suggest that the problem 
lies elsewhere.

Have you tried running a checkout whilst profiling?

-- 
Julian
