From: Brandon Casey <bcasey@nvidia.com>
Subject: Re: [PATCH] remote.c: avoid O(n^2) behavior in match_push_refs by
 using string_list
Date: Wed, 3 Jul 2013 13:05:09 -0700
Message-ID: <51D483F5.6020702@nvidia.com>
References: <1372809228-2963-1-git-send-email-bcasey@nvidia.com> <20130703062332.GA16090@sigill.intra.peff.net> <CA+sFfMeDC=hc7QZhfSuQYsdBPzig5WANeTBhMxFZk=Pusq0QpA@mail.gmail.com> <7vhagbfpwz.fsf@alter.siamese.dyndns.org> <20130703190047.GA349@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Martin Fick <mfick@codeaurora.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 03 22:05:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuTIk-0001SJ-3A
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 22:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933089Ab3GCUFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 16:05:11 -0400
Received: from hqemgate04.nvidia.com ([216.228.121.35]:5043 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932690Ab3GCUFK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 16:05:10 -0400
Received: from hqnvupgp07.nvidia.com (Not Verified[216.228.121.13]) by hqemgate04.nvidia.com
	id <B51d484070000>; Wed, 03 Jul 2013 13:05:27 -0700
Received: from hqemhub01.nvidia.com ([172.20.12.94])
  by hqnvupgp07.nvidia.com (PGP Universal service);
  Wed, 03 Jul 2013 13:06:17 -0700
X-PGP-Universal: processed;
	by hqnvupgp07.nvidia.com on Wed, 03 Jul 2013 13:06:17 -0700
Received: from [172.17.130.228] (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.298.1; Wed, 3 Jul 2013
 13:05:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <20130703190047.GA349@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229519>

On 7/3/2013 12:00 PM, Jeff King wrote:
> On Wed, Jul 03, 2013 at 11:40:12AM -0700, Junio C Hamano wrote:
> 
>> Brandon Casey <drafnel@gmail.com> writes:
>>
>>> Right.  For repos with few refs on either side, I don't think there
>>> will be any measurable difference.  When pushing a single ref to a
>>> repo with a very large number of refs, we will see a very small net
>>> loss for the time required to prepare the string list (which grows
>>> linearly with the number of remote refs).  After 2 or 3 refs, we
>>> should see a net gain.
>>>
>>> So we're really just improving our worst case performance here.
>>
>> ... by penalizing the common case by how much?  If it is not too
>> much, then this obviously would be a good change.
> 
> I don't think by much. If we have "m" local refs to push and "n" remote
> refs, right now we do O(m*n) work ("m" linear searches of the remote
> namespace). With Brandon's patch, we do O(n log n) to build the index,

Whoops, yes, n log n, not linear as I misspoke.

> plus O(m log n) for lookups.
> 
> So our break-even point is basically m = log n, and for m smaller than
> that, we do more work building the index. Your absolute biggest
> difference would be pushing a single ref to a repository with a very
> large number of refs.
> 
> Here are the timings before and after Brandon's patch for pushing a
> no-op single ref from a normal repo to one with 370K refs (the same
> pathological repo from the upload-pack tests). Times are
> best-of-five.
> 
>              before     after
>      real    0m1.087s   0m1.156s
>      user    0m1.344s   0m1.412s
>      sys     0m0.288s   0m0.284s
> 
> So it's measurable, but even on a pathological worst-case, we're talking
> about 6% slowdown.

That agrees with what I've observed.

> You could try to guess about when to build the index based on the size
> of "m" and "n", but I suspect you'd waste more time calculating whether
> to build the index than you would simply building it in most cases.

I agree, I don't think it's worth trying to guess when to build an index
and when to just perform linear searches.  If building the payload for
each element in the index was more expensive than just assigning to a
pointer, than it could be worth it, but we're not, so I don't think it
is worth it.

-Brandon
