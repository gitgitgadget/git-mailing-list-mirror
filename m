From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Could this be done simpler?
Date: Thu, 25 Jun 2009 15:50:19 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906251544030.3605@localhost.localdomain>
References: <alpine.LFD.2.01.0906241426120.3154@localhost.localdomain> <7veit9m8cs.fsf@alter.siamese.dyndns.org> <200906260002.40531.chriscool@tuxfamily.org> <200906260023.03169.chriscool@tuxfamily.org> <7vprcsymjd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 00:51:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJxma-0004mg-Ma
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 00:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755665AbZFYWu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 18:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753768AbZFYWu2
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 18:50:28 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59659 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751893AbZFYWu0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2009 18:50:26 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5PMoKKD016494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Jun 2009 15:50:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5PMoJ6v017559;
	Thu, 25 Jun 2009 15:50:20 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vprcsymjd.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.47 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122253>



On Thu, 25 Jun 2009, Junio C Hamano wrote:
> 
> Such a decomposed octopus would _only_ be necessary during bisection, only
> when the user chooses to test two tips at once (instead of testing one by
> one), _and_ only its tree is needed for that purpose.  In other words, we
> should be able to do this _without_ creating an extra commit, let alone
> replace mechanism.

Keep in mind, though, that realistically, I don't think we've ever seen 
any bisection attempts that end at an octopus.

Sure, I suspect that being really clever about decomposing an octopus 
merge might allow us to bisect things _faster_ to one of the branches 
involved in the merge, but the amount of smarts to do that just for that 
reason seems pretty outlandish.

And if we ever do end up with an actual bug being bisected to the octopus 
merge itself, at that point I don't think it's unreasonable to take the 
same approach we do with any normal merge: just try to figure out what the 
conflict is all about (clearly it's not a data conflict, since the 
octopus wouldn't have succeeded in that case, but subtle merge errors can 
be due to two branches each introducing their own assumptions without 
actually ever clashing on a source file level).

With regular merges, if you really don't see what the conceptual conflict 
is, you could try to do a temporary rebase to try to figure it out, and I 
suspect that that is what you'd want to do with an octopus merge too - 
rather than try to decompose the octopus merge into multiple simpler 
merges, you'd like to try to linearize history and then re-do the 
bisection attempt on that totally modified/simplified history.

			Linus
