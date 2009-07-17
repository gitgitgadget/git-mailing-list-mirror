From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix rebase -p --onto
Date: Fri, 17 Jul 2009 10:40:08 +0200
Message-ID: <4A6038E8.1090402@viscovery.net>
References: <20090716230031.GM7503@vinegar-pot.mit.edu> <4A601C59.8040108@viscovery.net> <7vk52767el.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Greg Price <price@ksplice.com>, git@vger.kernel.org,
	Stephen Haberman <stephen@exigencecorp.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 10:40:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRizQ-0006OM-Ei
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 10:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934219AbZGQIkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 04:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934203AbZGQIkQ
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 04:40:16 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:62192 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934181AbZGQIkO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 04:40:14 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MRizB-0008C1-BU; Fri, 17 Jul 2009 10:40:09 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1FB2D6D9; Fri, 17 Jul 2009 10:40:09 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <7vk52767el.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123450>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> Greg Price schrieb:
>>> In a rebase with --onto, the correct test for whether we can skip
>>> rewriting a commit is if it is already on top of $ONTO, not $UPSTREAM.
>>> Without --onto, this distinction does not exist and the behavior does
>>> not change.
>>>
>>>
>>> In the situation
>>>
>>>  X---o---o---o---M
>>>   \             /
>>>    x---x---x---x
>>>
>>>  Y
>>> ...
>>> The command `git rebase -p --onto Y X M` moves only the
>>> first-parent chain, like so:
>>>
>>>  X
>>>   \
>>>    x---x---x---x
>>>                 \
>>>  Y---o'--o'--o'--M'
>>>
>>> because it mistakenly drops the other branch(es) x---x---x---x from
>>> the TODO file.  This tests and fixes this behavior.
>> I think the current behavior is by design. There is nothing to fix.
>>
>> The purpose of rebase -p is to leave non-first children alone and rebase
>> only the first child parenthood chain. It is not the purpose to reseat an
>> entire history DAG.
> 
> Hmm, if the original history were
> 
>  .---X---o---o---o---M
>   \                 /
>    x---x---x---x---x
> 
>      Y
> 
> and the rebase is about moving history leading to M since X on top of Y,
> I would actually have agreed that this
> 
>  .---X---o---o---o---M
>   \                 /
>    x---x---x---x---x
>                     \
>      Y---o'--o'--o'--M'
> 
> would be the right thing to do (IOW, I would agree with you).
> 
> Can the current code distinguish the two cases?  More generally, can we
> always tell these two cases apart, or is it fundamentally not possible to
> differentiate the two cases and we should simplify the problem space by
> limiting ourselves by treating the first parent in a special way?

I have used rebase -i -p in the past to rewrite history that involves
merges of topic branches like this:

  ---------Y--M--M--F     <-- master
             /  /
  ----a--a--a  /
              /
  --b--b--b--b

where F is a fixup that I want to insert between Y and M, and I thought
rebase -i -p was intended for this use-case.

With this in mind, I do not see why should we distinguish the cases. I
would even go so far to say that this is OK:

  X---a---o---o---M            X---a
       \         /    ===>          \
        x---x---x                    x---x---x
                                              \
  Y                            Y---a'--o'--o'--M'
