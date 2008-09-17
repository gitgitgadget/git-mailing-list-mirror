From: Andreas Ericsson <ae@op5.se>
Subject: Re: [IRC/patches] Failed octopus merge does not clean up
Date: Wed, 17 Sep 2008 18:40:55 +0200
Message-ID: <48D13317.3090301@op5.se>
References: <200809160048.31443.trast@student.ethz.ch> <200809170053.15341.jnareb@gmail.com> <48D0A776.1000009@op5.se> <200809171011.06714.jnareb@gmail.com> <20080917155933.GI4829@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Sep 17 18:42:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg06X-0004Ox-68
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 18:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337AbYIQQlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 12:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755324AbYIQQlG
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 12:41:06 -0400
Received: from mail.op5.se ([193.201.96.20]:47773 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755306AbYIQQlF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 12:41:05 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id D9FE524B0004;
	Wed, 17 Sep 2008 18:30:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7OWBlffP1mqo; Wed, 17 Sep 2008 18:30:54 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 9F11624B0005;
	Wed, 17 Sep 2008 18:30:51 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080917155933.GI4829@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96127>

Miklos Vajna wrote:
> On Wed, Sep 17, 2008 at 10:11:02AM +0200, Jakub Narebski <jnareb@gmail.com> wrote:
>>>> BTW. does it mean that "git merge a b" might be not the same as
>>>> "git merge b a"?
>>>>
>>> No. Git merges all the sub-things together and then merges the result
>>> of that jumble into the branch you're on.
>>>
>>> Someone might have to correct me on that, but that's as far as I've
>>> understood it.
>> From what I understand from above explanation, and from thread on git
>> mailing list about better implementation of and documenting finding
>> merge bases for multiple heads, I think octopus merge is done by merging
>> [reduced] heads one by one into given branch.
>>
>> This means that "git merge a b" does internally "git merge a; git merge b"
>> as I understand it.
> 
> Sure, but given that both 'a' and 'b' merged (so none of them is subset
> of the other, for example so that reduce_heads() would drop one of them)
> the order of the parents will be different so the resulting commit will
> differ. The resulting tree will no, I think.


I got it wrong (not wrt reduced heads, but still). My apologies.

If octopus (the program/strategy/whatever) continues to merge after a
branch conflicting against the currently checked out branch (let's call
it "master"), the resulting tree may not differ, but then again, it might.
OTOH, if octopus quits the merge after having encountered a conflict, the
order the branches to merge were passed will always have an impact.

Let's say you have two branches, "clean" and "conflict". Which one is
which should be obvious here.

	git merge clean conflict

will produce a tree with 'master', 'clean' and a conflicted merge of
'conflict', while

	git merge conflict clean

will produce a tree with 'master' and a conflicted merge of 'conflict'.

In short, backing out the entire merge in case of a conflict is almost
certainly the only sane thing to do. If one branch depends on another
to merge cleanly, a different approach should have been taken (depending
branch should have been rebased onto the dependent one prior to merging),
but the merge *might* succeed depending on in which order the other
branches are given as arguments. It's not a very clever idea to merge
something like that though, as bisection will invariably have to mark the
entire depending branch as BAD, although the merge itself could obviously
be a good one.

Clearly, an octopus merge should not be undertaken without knowing very
well what it is one is merging in.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
