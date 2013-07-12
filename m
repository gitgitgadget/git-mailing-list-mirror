From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Fri, 12 Jul 2013 22:00:30 +0200
Message-ID: <51E0605E.9020902@kdbg.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org> <1373399610-8588-1-git-send-email-gitster@pobox.com> <1373399610-8588-8-git-send-email-gitster@pobox.com> <51DC7199.2050302@kdbg.org> <7vhag3v59o.fsf@alter.siamese.dyndns.org> <51DC78C0.9030202@kdbg.org> <7v38rnv0zt.fsf@alter.siamese.dyndns.org> <7vvc4jtjqa.fsf@alter.siamese.dyndns.org> <51DF1F56.9000705@kdbg.org> <7vzjtspwvo.fsf@alter.siamese.dyndns.org> <51E03B18.5040502@kdbg.org> <7vli5bllsd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 22:00:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxjW9-0002jn-Mh
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 22:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757808Ab3GLUAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 16:00:34 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:19170 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757638Ab3GLUAd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 16:00:33 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 41856130050;
	Fri, 12 Jul 2013 22:00:31 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 9F94D19F616;
	Fri, 12 Jul 2013 22:00:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vli5bllsd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230246>

Am 12.07.2013 19:40, schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Am 12.07.2013 00:14, schrieb Junio C Hamano:
>>> Johannes Sixt <j6t@kdbg.org> writes:
>>>
>>>> Again: Why not just define +refspec as the way to achieve this check?
>>>
>>> What justification do we have to break existing people's
>>> configuration that says something like:
>>>
>>> 	[remote "ko"]
>>> 		url = kernel.org:/pub/scm/git/git.git
>>>                 push = master
>>>                 push = next
>>>                 push = +pu
>>>                 push = maint
>>>
>>> by adding a _new_ requirement they may not be able to satisify?
>>> Notice that the above is a typical "push only" publishing point,
>>> where you do not need any remote tracking branches.
>>
>> Why would it break? When you do not specify --lockref, there is no
>> change whatsoever.
> 
> I thought your suggestion "Why not just define +pu as the way to
> achieve _THIS_ check?" was to make +pu to mean
> 
> 	git push ko --lockref pu
> 
> which would mean "check refs/remotes/ko/pu and make sure the remote
> side still is at that commit".
> 
> If that is not what you meant, please clarify what _THIS_ is.

We have three independent options that the user can choose in any
combination:

 o --force given or not;

 o --lockref semantics enabled or not;

 o refspec with or without +;

and these two orthogonal preconditions of the push

 o push is fast-forward or it is not ("ff", "noff");

 o the branch at the remote is at the expected rev or it is not
   ("match", "mismatch").

Here is a table with the expected outcome. "ok" means that the push is
allowed(*), "fail" means that the push is denied. (Four more lines with
--force are omitted because they have "ok" in all spots.)

                       ff   noff     ff      noff
                      match match mismatch mismatch

--lockref +refspec     ok    ok    denied   denied
--lockref  refspec     ok  denied  denied   denied
          +refspec     ok    ok      ok       ok
           refspec     ok  denied    ok     denied

Notice that without --lockref semantics enabled, +refspec and refspec
keep the current behavior.

(*) As we are talking only about the client-side of the push here, I'm
saying "allowed" instead of "succeeds" because the server can have
additional restrictions that can make the push fail.

-- Hannes
