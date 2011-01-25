From: Shuang He <shuang.he@intel.com>
Subject: Re: [RFC] Add bad-branch-first option for git-bisect
Date: Tue, 25 Jan 2011 11:27:39 +0800
Message-ID: <4D3E432B.70905@intel.com>
References: <4D3CDDF9.6080405@intel.com> <AANLkTimUkv9+g_+wFcyGhwMjE9zYAKjMn32GL-WOVmoe@mail.gmail.com> <4D3D54D3.7040801@intel.com> <4D3D5989.50903@viscovery.net> <4D3D5CE5.4050108@intel.com> <7v8vyam5la.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <christian.couder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"apenwarr@gmail.com" <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 25 04:27:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhZZL-0000bW-BJ
	for gcvg-git-2@lo.gmane.org; Tue, 25 Jan 2011 04:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692Ab1AYD1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jan 2011 22:27:42 -0500
Received: from mga11.intel.com ([192.55.52.93]:29916 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446Ab1AYD1l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jan 2011 22:27:41 -0500
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP; 24 Jan 2011 19:27:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.60,372,1291622400"; 
   d="scan'208";a="880615683"
Received: from she4-mobl3.ccr.corp.intel.com (HELO [10.239.13.5]) ([10.239.13.5])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jan 2011 19:27:40 -0800
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <7v8vyam5la.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165467>

On 2011/1/25 4:04, Junio C Hamano wrote:
> Shuang He<shuang.he@intel.com>  writes:
>
>> If A is bad commit, and C fixed it, and then F is bad again,
>>
>> A ->   B ->   C ->   D ->   E ->   F ->   G ->   H   (master)
>>    \                    \      /
>>      a  ->   b... c ->   d ->   e->f  (feature 1)
>>
>> Start with H as bad commit, and D as good commit, it's possible git-bisect would jump to c, and it will lead to wrong direction
>>
>> If bad-branch-first is used, it would be:
>> 1. first round found F
>> 2. end
> It is unclear from the way you drew the picture if "F" is supposed to be a
> merge of "E" and "f", but I'd assume that it is.

Oh, I lost this mail
That graph is different from what I meant, when shown in different email 
client.
It's G which is merged from e and F

> So what you are saying in 1. is "skip from H until you hit a first merge
> (without testing any intermediate commit), find F and stop to check it,
> and find that it is broken".
>
> What makes you decide "2. end"?  The fact that both of its parents "E" and
> "f" are Ok?  IOW, it won't be "2. end" if one of the parents of the merge
> is broken?

I think the correction above should have answer those two questions.

> What if there is _no_ merge from a side branch but there were breakages in
> A (fixed in C) and then F in your original picture, i.e.
>
>    A---B---C---D---E---F---G---H (broken)
>    x       o           x
>
> and you are hunting for the bug starting from H?  How does your algorithm
> help?  I grossed over the linear part by saying "skip from H until you hit
> a first merge", but in general, what is your plan to handle linear part of
> the history?

If the history is linear, the new algorithm won't help, it will just 
behavior like default git-bisect algorithm.

> A totally unacceptable answer is "It does not help linear case, but it
> helps when there are merges".  The a-thru-f side branch in your picture,
> or any "culprit side branch that was merged" your algorithm finds in
> general, would eventually have a linear segment, and having x-o-x in the
> history fundmentally breaks "bisect"---your band-aid will not help.
>
> The whole idea behind using "bisect" to gain efficiency in isolating the
> issue depends on "Once you see a Good commit, you do not have to search
> beyond its ancestors", as it is to look for a single breakage that
> persists to the "Bad" commit you give, and as far as "bisect" is
> concerned, the breakage at A in your example is an unrelated breakage that
> did not persist through the history to the "Bad" commit H.

In the example above (after we know G is merged from e and F),
Those commits are old bad commit: A, B, a, b, ..., c, d (but we don't 
care about those old bad commits, we cared about latest bad commit that 
we met which is F)
It's possible that default git-bisect would jump to these old bad 
commits, and will finally find an old first bad commit
With bad-branch-first, it could help us to get away from the trouble 
that old culprit commit exist on feature1 branch for a period of time 
not fixed

Thanks
     --Shuang
