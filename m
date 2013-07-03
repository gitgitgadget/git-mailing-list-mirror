From: Brandon Casey <bcasey@nvidia.com>
Subject: Re: [PATCH] remote.c: avoid O(n^2) behavior in match_push_refs by
 using string_list
Date: Wed, 3 Jul 2013 12:21:30 -0700
Message-ID: <51D479BA.1070207@nvidia.com>
References: <1372809228-2963-1-git-send-email-bcasey@nvidia.com> <20130703062332.GA16090@sigill.intra.peff.net> <CA+sFfMeDC=hc7QZhfSuQYsdBPzig5WANeTBhMxFZk=Pusq0QpA@mail.gmail.com> <7vhagbfpwz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Martin Fick <mfick@codeaurora.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 21:21:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuScX-00064L-AH
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 21:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965403Ab3GCTVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 15:21:35 -0400
Received: from hqemgate04.nvidia.com ([216.228.121.35]:3944 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965381Ab3GCTVc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 15:21:32 -0400
Received: from hqnvupgp07.nvidia.com (Not Verified[216.228.121.13]) by hqemgate04.nvidia.com
	id <B51d479cc0000>; Wed, 03 Jul 2013 12:21:48 -0700
Received: from hqemhub01.nvidia.com ([172.20.12.94])
  by hqnvupgp07.nvidia.com (PGP Universal service);
  Wed, 03 Jul 2013 12:22:38 -0700
X-PGP-Universal: processed;
	by hqnvupgp07.nvidia.com on Wed, 03 Jul 2013 12:22:38 -0700
Received: from [172.17.130.228] (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.298.1; Wed, 3 Jul 2013
 12:21:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <7vhagbfpwz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229513>

On 7/3/2013 11:40 AM, Junio C Hamano wrote:
> Brandon Casey <drafnel@gmail.com> writes:
> 
>> Right.  For repos with few refs on either side, I don't think there
>> will be any measurable difference.  When pushing a single ref to a
>> repo with a very large number of refs, we will see a very small net
>> loss for the time required to prepare the string list (which grows
>> linearly with the number of remote refs).  After 2 or 3 refs, we
>> should see a net gain.
>>
>> So we're really just improving our worst case performance here.
> 
> ... by penalizing the common case by how much?  If it is not too
> much, then this obviously would be a good change.

For something the size of the git repo, 5 branches, and pushing with
matching refspecs, I can't measure any difference.  The fastest time I
record with or without this patch is the same:

   $ time git push -n
   real    0m0.178s
   user    0m0.020s
   sys     0m0.008s

Ditto, when only pushing a single branch.  Preparing the string list for
a repo with a "normal" number of refs has very little overhead.

When the remote side has very many refs, then there is a small penalty
when the local side is pushing very few refs.  But still, the penalty is
small.

My measurements for pushing from a repo with a single local branch into
my 100000+ ref repo showed <10% hit and the numbers were in the tens of
milliseconds.

        before    after
real    0m0.525s  0m0.566s
user    0m0.243s  0m0.279s
sys     0m0.075s  0m0.099s

>> ...  But, I don't see a down side to doing the lazy prepare in
>> the other loop too, and in fact, it looks like we may be able to avoid
>> building the string list when only explicit refspecs are used.  So,
>> yeah, we should lazy build in both loops.
> 
> OK, so will see a reroll sometime?

Yeah, I'll reroll.

-Brandon
