From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] new test fails "add -p" for adds on the top line
Date: Sat, 16 May 2009 12:51:16 -0700
Message-ID: <7vab5cn7wr.fsf@alter.siamese.dyndns.org>
References: <1c5969370905152010m486a8b85s96334e99e6c54ad5@mail.gmail.com>
	<20090516192529.6117@nanako3.lavabit.com>
	<200905161612.30911.trast@student.ethz.ch>
	<7viqk1ndlk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Matt Graham <mdg149@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat May 16 21:54:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5Pxh-0001Uf-CH
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 21:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755130AbZEPTvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 15:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754409AbZEPTvQ
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 15:51:16 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:60627 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754386AbZEPTvP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 15:51:15 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090516195117.LAPV17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 16 May 2009 15:51:17 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id sKrG1b0044aMwMQ03KrGmm; Sat, 16 May 2009 15:51:16 -0400
X-Authority-Analysis: v=1.0 c=1 a=bKi9ceUIwy0A:10 a=8WvdOqfm3OgA:10
 a=ybZZDoGAAAAA:8 a=WVWtLNSG7iKV3QmHPEYA:9 a=AGsaeeJKSvTtSfDopYkA:7
 a=P6StOSDS8e9B1Ec9KMUT10hZ4nwA:4 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <7viqk1ndlk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sat\, 16 May 2009 10\:48\:23 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119378>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
> ...
>> The above commit still reverts cleanly, but AFAICS merge_hunk blindly
>> trusts the hunk headers, an assumption that is no longer valid due to
>> the 'edit' feature.
>
> Heh, here is my "I told you so" moment ;-).

It never blindly trusted before the edit 'feature'; it counted carefully
and it could do so because it had all the necessary information.

I told you that 'edit' could remember the line offset and line numbers
before giving the buffer to the end user, and then recount and adjust the
count after getting the edited results back, to update the offset and
count with the same carefulness.  You (and I think there was somebody else
who was helping) didn't listen.

Fundamentally, after you remove some hunks (and worse yet, you modify
some) from the patch and feed that to "git apply --recount", it can never
do as thorough a job as you could do inside "add -p" itself.  The latter
has more information (the omitted hunks, and the hunks before/after the
user edited) necessary to reconstruct the line numbers and hunk size.  To
keep the whole process more robust and trustworthy, you must do the
necessary computation while you still have all the information about the
hunks you are not feeding to the downstream.

That was what the "I told you so" was about in my message.

It is not too late to teach the 'edit hack' to do so.  That would allow us
to remove the "$_->{DIRTY}" bit my "how about this" patch adds, and I'll
stop calling it the 'edit hack' and start calling it the 'edit feature'
when that happens ;-).

But at least the "how about this" patch should restore the original
behaviour as long as the user does not use the 'edit hack' for now.
