From: Phil Hord <hordp@cisco.com>
Subject: Re: Git commit generation numbers
Date: Thu, 21 Jul 2011 12:24:01 -0400
Message-ID: <4E2852A1.30800@cisco.com>
References: <20110721125544.26006.qmail@science.horizon.com> <1311263869.9745.72.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: George Spelvin <linux@horizon.com>, david@lang.hm,
	anthonyvdgent@gmail.com, git@vger.kernel.org, nico@fluxnic.net,
	torvalds@linux-foundation.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Thu Jul 21 18:24:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjw2l-0005lG-7Z
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 18:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117Ab1GUQYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 12:24:06 -0400
Received: from rcdn-iport-9.cisco.com ([173.37.86.80]:55428 "EHLO
	rcdn-iport-9.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758Ab1GUQYD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 12:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=3022; q=dns/txt;
  s=iport; t=1311265443; x=1312475043;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=1F6cw14AlCRcT8ZpRFkQWWeq/yTuo2Dhl7KY4MUbZpA=;
  b=MfBQscc6varHnwzpn+won2SOPKKcrQ3qUaRnCCWA2CNkrf/TlUFScKls
   BvXIhol8hVU/i3gENzXK6UYj2iigyyMiwQqNsZfnkORUr0aqZd0OUZHsj
   Hj5mn+Z07o53hDcWYmfAPd1kRbl1mMbUv74PVe3M3u7n21x+Hmu3BNyNu
   0=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAEtRKE6tJXHB/2dsb2JhbABUEKcwd4h8nTeeKIY+BJJuhQeLH1M
X-IronPort-AV: E=Sophos;i="4.67,242,1309737600"; 
   d="scan'208";a="5167880"
Received: from rcdn-core2-6.cisco.com ([173.37.113.193])
  by rcdn-iport-9.cisco.com with ESMTP; 21 Jul 2011 16:24:02 +0000
Received: from [64.100.104.94] (dhcp-64-100-104-94.cisco.com [64.100.104.94])
	by rcdn-core2-6.cisco.com (8.14.3/8.14.3) with ESMTP id p6LGO1uM032271;
	Thu, 21 Jul 2011 16:24:01 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110627 Thunderbird/5.0
In-Reply-To: <1311263869.9745.72.camel@drew-northup.unet.maine.edu>
X-TagToolbar-Keys: D20110721122401407
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/21/2011 11:57 AM, Drew Northup wrote:
> On Thu, 2011-07-21 at 08:55 -0400, George Spelvin wrote:
>>> I have not read yet one discussion about how generation numbers [baked
>>> into a commit] deal with rebasing, for instance. Do we assign one more
>>> than the revision prior to the base of the rebase operation or do we
>>> start with the revision one after the highest of those original commits
>>> included in the rebase? Depending on how that is done
>>> _drastically_different_ numbers can come out of different repository
>>> instances for the same _final_ DAG. This is one major reason why, as I
>>> see it, local storage is good for generation numbers and putting them in
>>> the commit is bad.
>> Er, no.  Whenever a new commit object is generated (as the result
>> of a rebase or not), its commit number is computed based on its
>> parent commits.  It is NEVER copied.
> I don't see the word "copy" in my original.
>
> B-O1-O2-O3-O4-O5-O6
>   \
>    R1----R2-------R3
>
> What's the correct generation number for R3? I would say gen(B)+3.
And you would be correct if you follow the SoP algorithm.

> My
> reading of the posts made by some others was that they thought gen(O6)
> was the correct answer. Still others seemed to indicate gen(O6)+1 was
> the correct answer.
Maybe the confusion comes from the different storage mechanisms being 
discussed.  If the generation numbers are in a local cache and used by a 
single client, the determinism of the specific numbers doesn't much 
matter.  If they are part of the commit, it still doesn't need to be 
completely deterministic. However, interoperability requires standards, 
and standards favor determinism, so dogmatic determinism may triumph in 
that case.

1. gen(06) might make sense if you mean to implement --date-order using 
gen-numbers, for example.  But I don't think it's practical in any case.

2. gen(06)+1 might make sense if you mean to require that gen-numbers 
are unique per repo.  But this is both unsupportable and unnecessary, so 
it's a non-starter.

3. gen(B)+1 is what you'd get from the the algorithm I saw proposed.

All three of these are provably correct by my definition of "correct": 
"for each A in ancestors_of(B), gen(A) < gen(B)".

However, [1] and [2] have some extra features of dubious value.  Simpler 
is better for interoperability, so I like [3] for this purpose.

Even [3] has an extra feature I think is unnecessary: determinism.  If 
that "requirement" is dropped, I think all three of these algorithms are 
(functionally) roughly equivalent.

> I don't think everybody MEANT to be saying such
> different things--that's just how they appeared on this end.
>
> Now, did you mean something different by "commit number?"

I remain unconvinced that there is value in gen-number distribution, so 
to my mind, the specific algorithm and whether or not it is 
deterministic are unimportant.

Phil ~ who wasn't really being asked, but felt like answering
