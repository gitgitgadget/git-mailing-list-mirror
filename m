From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Teach checkout the -n|--dry-run option
Date: Sun, 08 May 2011 13:22:28 +0200
Message-ID: <4DC67CF4.80901@web.de>
References: <4DC47242.6060205@web.de> <7vhb97xx5g.fsf@alter.siamese.dyndns.org> <7vfwoqwby5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 08 13:22:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ24M-0006yE-Ob
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 13:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508Ab1EHLWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 07:22:33 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:42588 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373Ab1EHLWc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 07:22:32 -0400
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate02.web.de (Postfix) with ESMTP id A22AD19EE5671;
	Sun,  8 May 2011 13:22:30 +0200 (CEST)
Received: from [93.246.38.165] (helo=[192.168.178.43])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QJ24E-0006q7-00; Sun, 08 May 2011 13:22:30 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <7vfwoqwby5.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18p6ggjou0LdvRubcAKM4i6S/3OFWmHgFN6bUs9
	w3rxgdZy4+QCRL1zHt2Wo4JLHreyLc0SSlJtZcd+e7o0vXoXpu
	BdUBWluuJzU1eYfSC9TQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173093>

Am 07.05.2011 21:24, schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> In other words, can't the check you need in submodule be scripted around
>> the specific plumbing responsible for the branch switching, which is:
>>
>>     $ git read-tree -m HEAD $other_branch
>>
>>> @@ -397,7 +400,7 @@ static int merge_working_tree(struct checkout_opts *opts,
>>>
>>>  		/* 2-way merge to the new branch */
>>>  		topts.initial_checkout = is_cache_unborn();
>>> -		topts.update = 1;
>>> +		topts.update = !opts->dry_run;
>>>  		topts.merge = 1;
>>>  		topts.gently = opts->merge && old->commit;
>>>  		topts.verbose_update = !opts->quiet;
>>
>> What you are doing in this part of your patch is exactly that two-tree
>> form of the "read-tree -m", no?
> 
> That is, this would succeed:
> 
> 	$ git reset --hard master
>         $ git read-tree --index-output=rubbish -m master next
>         
> and these would fail:
> 
> 	$ git reset --hard master
> 	$ echo >>Makefile
>         $ git read-tree --index-output=rubbish -m master next
>         error: Entry 'Makefile' not uptodate. Cannot merge.
> 
> 	$ git reset --hard master
> 	$ echo >>Makefile
> 	$ git add Makefile
>         $ git read-tree --index-output=rubbish -m master next
>         error: Entry 'Makefile' would be overwritten by merge. Cannot merge.

Thanks for pointing me to "git read-tree -m". When I saw that a "git
checkout -n" would do exactly what I needed, I stopped looking for
alternatives (especially as I saw that adding -n there would help
other non-submodule use cases as well).

> Having said that, please do not discard your patch.  After sleeping on
> this, I started to think that "checkout -n" might be a better interface
> than using the plumbing read-tree in the longer term, especially if you
> can enhance it to handle "checkout -m -n" to check if the local change can
> be merged without conflicts.

I'll see if I can come up with a solution for the "-m -n" case (I stopped
after implementing the checkout branch case I needed to get some feedback
if this thing went into the right direction). And I assume the "git
checkout <pathspec>" case should learn -n too?

> But if the only question you are interested in is "can I switch to that
> branch from the current state of the index and the working tree?", I would
> prefer to see if the script can use "read-tree -m" approach first.

Yup, I will try that.

> We may also want to add "read-tree -n" so that you do not have to specify
> a dummy index output only to prevent from writing the real index over,
> though.

Hmm, wouldn't using "read-tree --index-output=/dev/null" be equivalent to
"read-tree -n"? But nonetheless it might make sense to add the -n option.
