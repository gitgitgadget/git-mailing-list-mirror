From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: BUG ? git-log omits changesets if the file is identical between
 revs
Date: Fri, 02 Jul 2010 16:24:32 -0700
Message-ID: <4C2E7530.3080603@us.ibm.com>
References: <4C2E3511.902@us.ibm.com> <7vocepzga3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, u.kleine-koenig@pengutronix.de,
	"Hansen\, Dave" <haveblue@us.ibm.com>,
	Will Schmidt <willschm@us.ibm.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 03 01:24:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUpbI-0007lZ-Vs
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 01:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168Ab0GBXYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 19:24:37 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:36870 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473Ab0GBXYg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 19:24:36 -0400
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com [9.17.195.107])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o62NK8v1020270
	for <git@vger.kernel.org>; Fri, 2 Jul 2010 17:20:08 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o62NOZVT132246
	for <git@vger.kernel.org>; Fri, 2 Jul 2010 17:24:35 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o62NOZ2k006589
	for <git@vger.kernel.org>; Fri, 2 Jul 2010 17:24:35 -0600
Received: from [9.48.97.143] (sig-9-48-97-143.mts.ibm.com [9.48.97.143])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id o62NOYYX006571;
	Fri, 2 Jul 2010 17:24:34 -0600
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <7vocepzga3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150174>

Junio,

Thank you for the detailed explanation of what is apparently a common 
question - which I just didn't know how to phrase to find the previous 
discussions on simplified history.

Thanks,

Darren

On 07/02/2010 03:10 PM, Junio C Hamano wrote:
> Darren Hart<dvhltc@us.ibm.com>  writes:
>
>> $ git checkout -b 2.6.33.5-rt23 v2.6.33.5-rt23
>> $ git log --pretty=oneline v2.6.33.5.. arch/powerpc/kernel
>> ef4afcc4401e92982f4ffd3fae6a9a6745a98596 Merge stable/linux-2.6.33.y into rt/2.6.33
>> ...
>> 92bfe2d63ed46764b0b0a6e9b63bb9e81023ab80 powerpc: realtime support
>> ...
>> $ git whatchanged 92bfe2d6 -n1
>> commit 92bfe2d63ed46764b0b0a6e9b63bb9e81023ab80
>> ...
>> :100644 100644 43e0734... 4bb9ce4... M  arch/powerpc/kernel/entry_64.S
>> ...
>> $ git log --pretty=oneline v2.6.33.5.. arch/powerpc/kernel/entry_64.S
>> <null>
>
> This is expected, and it is by design.
>
> $ git log --oneline --simplify-merges --full-history --graph \
>    v2.6.33.5..v2.6.33.5-rt23 -- arch/powerpc/kernel/entry_64.S
>
> will give you a less simplified history.  The first commit we find in its
> output is:
>
> * ef4afcc Merge stable/linux-2.6.33.y into rt/2.6.33
>
> and if you look at that commit:
>
> $ git show --pretty=short --stat -m ef4afcc -- arch/powerpc/kernel/
>
> you will notice that:
>
>   - ef4afcc is a merge between ac43be5 and a00123d;
>
>   - arch/powerpc/kernel/entry_64.S has not changed between a00123d and this
>     merge result ef4afcc;
>
>   - There are many changes made to this path in the history leading to the
>     other parent of the merge, ac43be5.
>
>   - When Thomas created ef4afcc, after looking at ac43be5 and a00123d, he
>     took the version from a00123d.  Effectively, what happend on the side
>     branch that led to ac43be5 did _not_ contribute to the end result at
>     all.
>
>   - There was no change to the path between v2.6.33.5 and a00123d (as they
>     are the same commit ;-).
>
>   - Hence there is nothing noteworthy to report when explaining how the
>     path came about since v2.6.33.5 and v2.6.33.5-rt23.
>
> BTW, this has nothing to do with the path being the same between your HEAD
> and v2.6.33.5.  You can try:
>
>    $ git checkout v2.6.33.5-rt23
>    $ echo>>arch/powerpc/kernel/entry_64.S
>    $ git commit -m 'random change' arch/powerpc/kernel/entry_64.S
>    $ git log --oneline v2.6.33.5.. -- arch/powerpc/kernel/entry_64.S
>    b736245 random change
>
> and notice that the change you just made is the only one that is needed to
> explain how the file came into its current shape since the named bottom
> version (v2.6.33.5).
>
> If you look for "history simplification" in the list archive you will find
> Linus explaining why this simplification is the right thing to do number
> of times, but the short version is that "git log $path" by default gives
> you _one_ possible and simplest explanation of how the $path came about
> into its current shape, and "one possible and simplest" is what you want
> most of the time, because "all possible explanations" is very expensive to
> compute and often unreadable.
>
> But the "--simplify-merges --full-history" trick I showed above may also
> be another good thing to know.
>
>


-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
