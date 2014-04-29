From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Sleep 1 millisecond in poll() to avoid busy wait
Date: Tue, 29 Apr 2014 09:51:26 -0700
Message-ID: <xmqq7g68m641.fsf@gitster.dls.corp.google.com>
References: <20140428083931.GA10257@camelia.ucw.cz>
	<CABPQNSaC30p7TEOvc85u=+skjrFj17182vWWSL=QNVuvzVFE=w@mail.gmail.com>
	<20140428113815.GA10559@camelia.ucw.cz>
	<20140428114224.GA11186@camelia.ucw.cz>
	<CABPQNSbDkE+Vff=4MmPO9oMfjRay6Oin51zZRoZ8mOEhGoaD3Q@mail.gmail.com>
	<535E6E4B.6070308@viscovery.net>
	<20140428153527.GB12357@camelia.ucw.cz>
	<CABPQNSbpyFzg8A8gLp2nJZeTRSLSb0Qs8ytZDsJLmi6VyER71Q@mail.gmail.com>
	<xmqqfvkxqo0l.fsf@gitster.dls.corp.google.com>
	<20140429034727.GB15181@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>,
	Theodore Leblond <theodore.leblond@gmail.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Apr 29 18:51:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfBFu-0008BI-O7
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 18:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758168AbaD2Qve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 12:51:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44526 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778AbaD2Qvb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 12:51:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 201BC7FF16;
	Tue, 29 Apr 2014 12:51:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cp5h5d8IUVOKkPngk621q9jTYr8=; b=NCRums
	qd+l/zdo2kF+YOR1RObSDdumJLsRLwZCapY+4nwiyHEMwTRWRuXjA0KlKnv+RvPZ
	WTRRd+mZBUyfEqjB6eYM8hEUOM6HiEhQHU56nXWGRtz+UdTINQPIIy4TINqjzmhg
	X3cAc2pwNO8GGSYFpMROXWxPxeQw4nqaGXc4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QU5UouJFvS5V/5UOg89q3L4jRpAkR9hV
	tAL1pdOxyjBUgOa79caL5RTiNq7/wH7fs62xZDeBKLRxAwOn35Owp75jw3K/Q6sF
	5J/pQmR1yJAr7+rr4wnPDmoSKvsmWL2P74Gmv6+udQldUtFTdGtPdSqusArRw2qs
	mX2rH6vHQmY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E83D57FF15;
	Tue, 29 Apr 2014 12:51:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BCD897FF12;
	Tue, 29 Apr 2014 12:51:28 -0400 (EDT)
In-Reply-To: <20140429034727.GB15181@camelia.ucw.cz> (Stepan Kasal's message
	of "Tue, 29 Apr 2014 05:47:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8251D5C4-CFBE-11E3-8539-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247589>

Stepan Kasal <kasal@ucw.cz> writes:

> Hello Junio,
>
> thank you for pointing out the problems.
>
> Let me explain the background:
>
> After some discussion a one line fix to win32/poll.c was accepted to msysgit/git
> at 2012-05-16 https://github.com/msysgit/git/pull/7
>
> The description of the commit looked like this:
>> I played around with this [...]
>> [...]
>> I also tested the very fast local case, and didn't see any measurable
>> difference. On a big repo with 4500 files, the upload-pack took about 2
>> seconds with and without the fix.
> ... but there was no sign-off by Theodore.
>
> Because poll.c comes from Gnulib, it was reported there as well.
> Paolo Bonzini accepted the fix for poll.c and added a fix for select.
> The combined commit got this changelog entry:
>
>> 2012-05-21  Paolo Bonzini  <bonzini@gnu.org>
>> 
>>         poll/select: prevent busy-waiting.  SwitchToThread() only gives away
>>         the rest of the current time slice to another thread in the current
>>         process. So if the thread that feeds the file decscriptor we're
>>         polling is not in the current process, we get busy-waiting.
>>         * lib/poll.c: Use SleepEx(1, TRUE) instead of SwitchToThread().
>>         Patch from Theodore Leblond.
>>         * lib/select.c: Split polling out of the loop that sets the output
>>         fd_sets.  Check for zero result and loop if the wait timeout is
>>         infinite.
>
> The patch that I (Stepan) submitted as "v2" combines things like this:
> - subject by Theodore
> - first paragraph by Paolo, concise problem description
> - rest from Theodore's original commit ("I" = Theodore, I suppose)
> - diff exctly as in gnulib commit
>
> On Mon, Apr 28, 2014 at 11:58:50AM -0700, Junio C Hamano wrote:
>>     Subject: compat/poll: sleep 1 millisecond to avoid busy wait
>
> Thanks for improving it.
>
>>     Signed-off-by: Theodore Leblond <theodore.leblond@gmail.com>
>>     Signed-off-by: Stepan Kasal <kasal@ucw.cz>
>>     Acked-by: Johannes Sixt <j6t@kdbg.org>
>>     Acked-by: Erik Faye-Lund <kusmabite@gmail.com>
>
> Sorry that I forgot to add my sign-off (Stepan).
> But I'm afraid I cannot add Theodore's, it was not in the original
> commit.  But it is one line change; the real work was the analysis.

Well, the original git/pull/7 in msysgit repository says that is a
patch by Theodore, so the kosher thing to do is to ask him (and I
see he is on the Cc list), and also ask msysgit folks (and I see
they are on the Cc list as well) to be a bit more careful when
responding to pull requests, especially given that it is our mutual
benefit to make sure we keep the changes between our two trees to
the minimum by upstreaming.

I'll queue without the forged sign-off by Theodore, as I think DCO
(1.1) (c) read loosely would let me do so ;-)

Thanks.
