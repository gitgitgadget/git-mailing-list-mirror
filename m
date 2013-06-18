From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 00/12] Fix some reference-related races
Date: Tue, 18 Jun 2013 19:13:14 +0100
Message-ID: <51C0A33A.7060802@ramsay1.demon.co.uk>
References: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu> <51BCCAD2.9070106@ramsay1.demon.co.uk> <51BD5232.20205@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 18 20:40:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up0pC-0008UH-5i
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 20:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932911Ab3FRSkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 14:40:07 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:35288 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932419Ab3FRSkG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 14:40:06 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 470866F89CB;
	Tue, 18 Jun 2013 19:40:04 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 468946F82CD;
	Tue, 18 Jun 2013 19:40:03 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Tue, 18 Jun 2013 19:40:01 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <51BD5232.20205@alum.mit.edu>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228293>

Michael Haggerty wrote:
> Thanks for all of the information.
> 
> On 06/15/2013 10:13 PM, Ramsay Jones wrote:
>> Michael Haggerty wrote:
>>> *This patch series must be built on top of mh/reflife.*

[ ... ]

>> You may be wondering why clear_packed_ref_cache() is called? Well, that
>> is because stat_validity_check() *incorrectly* indicates that the
>> packed-refs file has changed. Why does it do that? Well, this is one
>> more example of the problems caused by the cygwin schizophrenic stat()
>> functions. :( [ARGHHHHHHHHH]
>>

[ ... ]

> So if I understand correctly, all of the above is *without* the
> refcounting changes introduced in mh/ref-races?  Is so, then it is not
> surprising, as this is exactly the sort of problem that the reference
> counting is meant to solve.

Yes, as I said, this describes the old (non refcounted) series.
This particular problem (the segmentation fault) is fixed by the new
series (as noted below). [Note, however, that the packed-refs file
will still be re-read more often than needed.]

>> Now, turning to the new code, t3211-peel-ref.sh test #7 now works, but
>> test #8 still fails...

[ ... ]

> These "internal error: packed-ref cache cleared while locked" failures
> result from an internal consistency check that clear_packed_ref_cache()
> is not called while the write lock is held on the packed-refs file.  A
> call to c_p_r_c() could result from
> 
> * a programming error
> 
> * a determination based on the packed-refs file stat that the file needs
> to be re-read
> 
> Judging from what you said about cygwin, I assume that the latter is
> happening.

Indeed.

>             It should be impossible, because the current process is
> holding packed-refs.lock, and therefore other git processes should
> refuse to change the packed-refs file.

:-P You are assuming that a single process can't lie to itself ...

[ ... ]

> Yikes!  ECYGWINFAIL.

Ah, NO, this should read ECYGWINGITFAIL.
This is a self-inflicted wound; it has nothing much to do with cygwin.

I should not have assumed that you knew what I meant by "schizophrenic
stat() functions" above; sorry about that! If you are interested, then
the following commits may be useful reading: adbc0b6, 7faee6b, 7974843,
05bab3ea, 924aaf3e and b8a97333.

[ ... ]

>> I haven't checked the remaining test failures to see if they are
>> caused by this code (I don't think so, but ...), but this failure
>> is clearly a cygwin specific issue.
> 
> Thanks again for the testing and analysis,

So, unless you feel the need to fix this yourself, you can probably
ignore this issue for now. I will hopefully find time to fix it up
before this topic progresses to next. (Although I don't have any
feeling for the time-frame of this topic).

HTH

ATB,
Ramsay Jones
