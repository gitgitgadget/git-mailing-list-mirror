From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push: Add '--current', which pushes only the current branch
Date: Mon, 19 Nov 2007 14:15:19 -0800
Message-ID: <7vfxz1naq0.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711121501500.4362@racer.site>
	<fhrrbt$lvk$1@ger.gmane.org>
	<7vy7cum2k1.fsf@gitster.siamese.dyndns.org>
	<200711192204.26772.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 23:16:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuEuV-0003gh-WD
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 23:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676AbXKSWP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 17:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752251AbXKSWP1
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 17:15:27 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:34958 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbXKSWP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 17:15:26 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id EC3882F2;
	Mon, 19 Nov 2007 17:15:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 43BD697960;
	Mon, 19 Nov 2007 17:15:43 -0500 (EST)
In-Reply-To: <200711192204.26772.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 19 Nov 2007 22:04:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65507>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>>> Brief recap, to check if I understand things correctly:
>>>
>>> 1. If you use "matching" more often, then it should be enough
>>>    to provide remote.<remotename>.push with refspec or wildcard
>>>    refspec. 
>> 
>> Eh, excuse me, what refspec would you write there?  "matching"
>> is defined to push the intersection of what we have and what
>> they have when "git-push" is run.  I do not think there is any
>> way to write that in remote.$there.push and cast in stone.
> [...]
>>>    Question: what to do if there is no remote.<remotename>.push?
>>>    Assume 1-1 matching?
>> 
>> One-to-one is what 'matching' does, and the way to trigger it is
>> not to have a remote.$there.push.
>
> I'm sorry, I had to have "stupid" moment. Thanks a lot for complete 
> explanation of git-push, anyway.
>
>
>>>    ... If one wants to push only current branch, one
>>>    would use "git push --current" or "git push <remotename> HEAD".
>> 
>> I think that is the proposal by Steffen (added back CC).
>> 
>> I am wondering if an alternative approach could be simpler.  If
>> we teach "git-push" to notice when only the refspecs are given
>> without remotename, and default to branch.$current.remote in
>> such a case, 
>
> Including default remote when branch.<branchname>.remote is not set?
>
>> IOW, make these: 
>> 
>> 	$ git push HEAD
>>       $ git push next
>> 
>> push the obvious thing to the default remote, I _think_ we can
>> achieve the same effect as --current and a bit more.
>
> The only problem would be when there is conflict between remote name and 
> branch name...

Yes.  *If* we were to do that fallback it has to be something
like this:

 (1) does $0 look like remote and $1..$n look like a refspec?  If
     so do not fallback;

 (2) Do we have branch.$current.remote?  If not, we cannot
     fallback so error out.

 (3) otherwise, does $0 look like a refspec?  If so, try insert
     it before the params, treating $0..$n all refspecs.

> So for scripts it would be "git push -- HEAD"; still shorter than
> "git push --current".

scripts should be as explicit as they need to be.

What matters is the case when the command cannot be explicit,
just like you cannot write --matching with explicit refspecs.

> BTW. what would happen for "git push branch1 branch2" if branch1 has 
> different remote than branch2?

Read my example more carefully.  It says "push HEAD" and "push
next" while on 'pu' and it takes branch.pu.remote.
