From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH/RFC] rebase -p: do not redo the merge, but cherry-pick
 first-parent changes
Date: Fri, 25 May 2012 17:58:17 +0200
Message-ID: <4FBFAC19.8030108@kdbg.org>
References: <4FBAA33D.1080703@kdbg.org> <CAOeW2eE9EW3gER7ZDThGABtZ0doNuUb70DnKrnzD+OeWYLO7cQ@mail.gmail.com> <7vzk8yzq35.fsf@alter.siamese.dyndns.org> <CAOeW2eGvEaQYk9KODmLzZuEBu-KhKcQeL4PE-4YHwSgtP0dJfA@mail.gmail.com> <7vehq9xz7a.fsf@alter.siamese.dyndns.org> <CAOeW2eH85+qa2PXS55_xGwH+tpMDMEK76HywfpLTYrv_Dtg49Q@mail.gmail.com> <4FBE9AC7.3010506@kdbg.org> <7vaa0xw9dy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stephen Haberman <stephen@exigencecorp.com>,
	Andrew Wong <andrew.kw.w@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 25 17:58:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXwum-0003oc-1c
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 17:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908Ab2EYP6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 11:58:22 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:41573 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750864Ab2EYP6V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 11:58:21 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3EB78130060;
	Fri, 25 May 2012 17:54:05 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D63D319F6BF;
	Fri, 25 May 2012 17:58:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <7vaa0xw9dy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198479>

Am 24.05.2012 23:34, schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Today I was able to use rebase -i -p in the field. I used it to rebuild
>> an integration branch (akin to git's pu branch). Guess what? It did not
>> work as expected:
>>
>> Two of the topic branches' early parts were already merged in the
>> upstream. The instruction sheet had only 'pick' of merge commits for the
>> topics. Except for these two; there, all commits (that were not yet in
>> upstream) were offered to pick, including the merge commit.
>>
>> I started with this:
>>
>>     A--M--o--o   <- master
>>    /  /
>> --o--X--Y        <- side branch (partially merged in master)
>>    \     \
>>     R--S--N--T   <- integration (to be rebuilt on master)
>>
>> I wanted this:
>>
>>      A--M--o--o
>>     /  /       \
>>    /  /          R'--S'--N'--T'
>> --o--X--Y---------------´
> 
> It is unclear what exact revisions you gave to rebase, but I am assuming
> that you asked "rebase --onto master X^ T" (you can use R^ instead of X^;
> they refer to the same commit).

Sorry, I should have been more precise. The command was

  git rebase -i -p master T

An important detail is that the order of parents of N is S, Y. (I
assumed that this was somewhat clear from the context of my message.)

> It is straightforward to see what should happen to R and S; they should be
> a straight replay of single parent commit on top of 'master'.  
> 
> But it is unclear what should happen to X and Y.

Nothing. Relabel "integration" to "topic" in my artwork above. Then X
and Y are on an "unrelated side branch" that is merged into the topic
whose tip is at T. The early part of this side branch is already in
master.  In fact, if X were not merged into master, yet, then 'rebase -i
-p' already works as (I) intended: it leaves X and Y alone.

> When you are rebasing the X^..T sub-DAG, can you say what makes S more
> special than Y by looking at the original topology?  Your "I wanted this"
> picture depicts S' to be rewritten but Y stays the same.  Why?  

It is "not on topic" (pun intended). It is the second parent of N. Think
of X and Y as an independent bug fix sub-topic. It is merged into topic
only because T depends on the fix.

> They are both in the X^..T DAG, and neither of them is merged to 'master'.
> I can sort of see why X and R would be treated differently (X is part of
> master, R is not), but I cannot justify why your "I wanted this" picture
> replays S' without replaying Y'.
> 
> What am I missing?

First-parentship. When a topic or an integration branch is rebased (with
--preserve-merges), only the first-parent chain should be rewritten.

>> But I got this:
>>
>>     A--M--o--o-------Y'
>>    /  /       \       \
>> --o--X--Y      R'--S'--N'--T'
> 
> Which is what I would expect, from the "Y and S play a similar role in the
> sub-DAG X^..T in the original DAG, with respect to master" point of view.

-- Hannes
