From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2] rev-list docs: clarify --topo-order description
Date: Fri, 17 Aug 2012 19:37:36 +0200
Message-ID: <87obm9a07z.fsf@thomas.inf.ethz.ch>
References: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
	<877gt16ewe.fsf@thomas.inf.ethz.ch>
	<7vzk5x8s1q.fsf@alter.siamese.dyndns.org>
	<87sjbpa5m8.fsf@thomas.inf.ethz.ch>
	<7vmx1v53fb.fsf_-_@alter.siamese.dyndns.org>
	<CAOeW2eFZNuM_8bFB2cXGVRT0FpDC86fH=XMj9kviXs-UCo1fAA@mail.gmail.com>
	<7vipcj2w9f.fsf@alter.siamese.dyndns.org>
	<7vehn72vyl.fsf@alter.siamese.dyndns.org>
	<87pq6rw77l.fsf@thomas.inf.ethz.ch> <502CC4E7.5060508@alum.mit.edu>
	<87k3wzujuy.fsf@thomas.inf.ethz.ch>
	<7v628i3jiu.fsf@alter.siamese.dyndns.org>
	<874no1hnfg.fsf@thomas.inf.ethz.ch>
	<7v1uj5wi72.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 19:37:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2QUV-0003OS-Pw
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 19:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992Ab2HQRhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 13:37:42 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:38378 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752864Ab2HQRhk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 13:37:40 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 17 Aug
 2012 19:37:33 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 17 Aug
 2012 19:37:36 +0200
In-Reply-To: <7v1uj5wi72.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 17 Aug 2012 10:18:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203630>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> However, suppose we knew generation numbers.  I haven't actually looked
>> into the old threads again, but my understanding was that they are
>> numbers g(C) attached to each commit C such that
>>
>>   g(C) = 1 + max(g(P) for P a parent of C)   for non-root commits
>>
>>   g(C) = 0                                   for root commits
>>
>> They are invariant given the commit, so they can be cached.
>> ...
>> I hope I got that right.  The order of commits is still entirely
>> determined by the choice of "any tentative source", but the algorithm
>> should now stream nicely once the generation numbers are known.
>
> That matches the definition of generation number I remember from the
> old discussion.  Now look at the illustration in this discussion
> again:
>
>       ---A---B---C---D
>                       \
>     ---1---2---3---4---* = HEAD
[...]
> The numbered commits 1 2 3 4 are building on top of recent "master",
> while alphabetized A B C D are building on aged maintenance track.
> The difference in generation numbers between 1 and 2, 2 and 3,... A
> and B, B and C, C and D are all one, and HEAD (the tip of 'pu') would
> have generation number of commit 4 plus 1, as commit 4's generation
> number would be a thousand or more ahead of that of commit D.  And
> there are a thousand ancestors of '1' with larger generation numbers
> than 'D'.
>
> When the user runs "git log" (i.e. the casual "the last few commit"
> macthes), the expectation of the user is "I want to see what I did
> recently".  If you substituted the commit timestamp with such a
> generation number, how would that expectation satisified?

Umm, have you looked at the algorithm I proposed?

It does not substitute the generation numbers for anything, let alone
the date.  It merely uses them to determine a point where it knows
"enough" of the history to be able to emit the next commit; that is,
where it can use the generation numbers to prove that no unknown commit
can be a descendant of what it wants to emit next.

It does *not* have to use the generation numbers in the final ordering
of the commits.  That final order is determined by how the algorithm
chooses the next candidate commit.  If you use a stack, it winds up
being --topo-order.  If you use a date-ordered priority queue, it
becomes --date-order.

So really, this is only about modifying the algorithm that generates the
existing order to allow for streaming output as it reads through
history.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
