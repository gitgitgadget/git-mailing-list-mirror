From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFH] git cherry vs. git rev-list --cherry, or: Why does "..."
 suck?
Date: Thu, 24 Mar 2011 08:38:48 +0100
Message-ID: <4D8AF508.7070709@drmicha.warpmail.net>
References: <4D889119.3020009@drmicha.warpmail.net> <4D8A23CD.9030203@drmicha.warpmail.net> <7vfwqdem0p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 08:42:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2fBk-0006pk-C9
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 08:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933550Ab1CXHmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 03:42:31 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:42013 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933451Ab1CXHma (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2011 03:42:30 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B2FC9207BC;
	Thu, 24 Mar 2011 03:42:29 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 24 Mar 2011 03:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=ws0tX8ZDU+WQs7VOCZJfiMz5iSI=; b=S2wbpvzI44brdGPXrVX+rg79HpDy8FZeT+C+szkZtg8aD6pTmAgPQLPwbH7/Od/MlNGuK/lo1ZF7nCVcSpw2OlNaHD33OIZUsRG6SpjB2wkdA03L9YdorjGJdEkR/a453awRZ66WsU7hIq9BMMxTkuyn8Mp1KNUED1gLBEPO8UA=
X-Sasl-enc: K0sgI7OUej7a/BMgPWiMPsppGC0ZDKIQp9o8C9XGv8LS 1300952549
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3A6FD40862D;
	Thu, 24 Mar 2011 03:42:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7vfwqdem0p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169901>

Junio C Hamano venit, vidit, dixit 23.03.2011 19:20:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Adding some recent insight:
>>
>> Michael J Gruber venit, vidit, dixit 22.03.2011 13:07:
>>> Performance
>>> ===========
>>>
>>> I don't get this:
>>>
>>> git cherry A B: 0.4s
>>> git rev-list --cherry A...B: 1.7s
>>> (more details below)
>>
>> I can get the latter down to 0.95s and this
>>
>>> merge-base A B: 0.95s
>>> merge-base --all A B: 0.95s
>>> rev-parse A...B: 0.95s
>>
>> to 0.16s each. The downside is that merge-base may give a few
>> unneccessary candidates (commits which are ancestors of other commits it
>> returns), but this does not change the results for rev-list, of course.
>>
>> I get this dramatic speedup by removing the check for duplicates from
>> get_merge_bases_many() in commit.c. After a first merge_bases_many()
>> run, returning N commits, that check calls merge_bases_many() again for
>> each pair (N choose 2) to check whether one is contained in the other.
>> Quite a bottleneck. Removing it works great. But can we live with a few
>> additional merge bases?
> 
> When we run merge-base as the top-level command (this includes
> reduce_heads() that is used by "git merge"), we have to cull unnecessary
> phantom bases that can be reached by other bases, so you are not allowed
> to make such a change unconditionally.
> 
> Passing down a parameter from a caller that is prepared to handle phantom
> merge bases correctly is probably the right approach.  Existing callers
> can make "safer" calls for now; you can later examine them and turn them
> into "faster" calls if they operate correctly given a result that contain
> phantom bases.

Yes, I was thinking of having thorough vs. fast mode, but I'll dig more
into merge_bases_many().

My current impression is that those phantom merge bases appear only
(mainly?) when there are severe date ordering problems in the dag.
merge_bases_many() uses commit_list_insert_by_date(), and given the way
it walks, later merge bases which are ancestors of another one get
marked STALE automatically.

For callers which are interested in one base only, the check makes a
difference only if there are date ordering problems.

In my A B example, merge_bases_many() comes up with the correct 25 ones
during its first run, and then gets called 300 times again (25*24/2) to
check each pair of them, without any reduction. (Clearly, it's a non
issue in the case of unique merge base.)

What I'm mainly interested in is the A...B case. And for a revision walk
with one A...B range and revs->limited, one could even embed the whole
mb-logic into the walk! But I don't see how to do this for multiple
symmetric ranges.

Michael
