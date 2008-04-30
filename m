From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Wed, 30 Apr 2008 09:47:02 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804300938190.17469@eeepc-johanness>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de> <7vabjm78v2.fsf@gitster.siamese.dyndns.org> <20080422095549.GB3752@alea.gnuu.de>
 <alpine.DEB.1.00.0804221127360.4460@eeepc-johanness> <7vy775ygjm.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804221810180.4460@eeepc-johanness> <7v3ap5a4ny.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804290138170.27457@eeepc-johanness>
 <7vk5ih8ckp.fsf@gitster.siamese.dyndns.org> <4816CA72.8070405@viscovery.net> <alpine.DEB.1.00.0804291147450.27457@eeepc-johanness> <7vk5ig745b.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804292220120.13650@eeepc-johanness> <7viqy05mhp.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804292355060.17469@eeepc-johanness> <7v63u05khw.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804300016130.17469@eeepc-johanness> <7v1w4o3zle.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 10:47:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr7yV-0002Kc-Uc
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 10:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506AbYD3Iqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 04:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754098AbYD3Iqu
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 04:46:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:45911 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752948AbYD3Iqt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 04:46:49 -0400
Received: (qmail invoked by alias); 30 Apr 2008 08:46:47 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp014) with SMTP; 30 Apr 2008 10:46:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/pHnt1N5zpyiUR0YWi06SB3FVDNEnU1QMtJMOy+J
	th1RREqUfFfQVt
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7v1w4o3zle.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80811>

Hi,

On Tue, 29 Apr 2008, Junio C Hamano wrote:

> 
>                  A
>                 / \
>                /   X
>               /   / \
>              O---B   Z
>               \   \ /
>                \   Y
>                 \ /
>                  C
> 
>             X = checkout A, merge B
>             Y = checkout C, merge B
>             Z = checkout X, merge Y
> 
> I start from Q, create A', B' and C' with:
> 
> 	reset Q
> 	pick A
>         reset Q
>         pick B
>         reset Q
>         pick C
> 
> Then I can recreate X by doing
> 
> 	reset A
>         merge B
> 
> The problem I had was to figure out the way to go back to "rewritten X". 
> I assumed you would say "B" because that is the last insn in the 
> sequence that used that name.
> 
> But instead you are thinking of letting me just say "X", and somehow 
> make the machinery guess by noticing "Ah, original X is a merge between 
> original A and B, and we have a merge between rewritten A and rewritten 
> B, so we will treat that merge as rewritten "X"?
> 
> I actually was hoping we could avoid that, which feels messy.

I cannot bring myself to feel that this is messy.  The more I think about 
it, the clearer it becomes for me that the pick call should use the 
original commit, whereas the merge call should use the rewritten commit 
(and should therefore only be called when all ancestors of that merge 
which need rebasing were rebased already).

BTW I think that I made a stupid mistake in one of my previous mails: when 
I wrote an example for the "merge" command (as I would like it), I did 
_not_ list the original commit name of that merge.  I.e.

	merge <parent2> <parent3>... <message>

I completely forgot that for the $DOTEST/rewritten/ to work, the original 
commit name of that merge has to be listed.

But this got me thinking, and I think that to leave out the first parent 
was another mistake I made, so I really would like to have this syntax:

	merge <orig-commit> <parent1> <parent2>... <message>

This would allow to change the parents in the interactive rebase, and if 
<parent1> is not the current commit at that point, it would implicitly 
call "reset".

What appeals to me is the simplicity of this approach: you refer to the 
commits by calling them by their (original) name.

In the (probably really rare) occasion that you really need to refer to an 
original _and_ a rewritten commit, you can always use _any_ commit-ish as 
argument to the command.

Ciao,
Dscho
