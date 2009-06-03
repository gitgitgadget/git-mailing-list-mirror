From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Am able to delete a file with no trace in the log
Date: Wed, 3 Jun 2009 15:17:49 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906031504080.4880@localhost.localdomain>
References: <EB2D87B9-3B03-431A-B204-C7799F9BA291@ausperks.net> <20090602213439.GA7584@coredump.intra.peff.net> <alpine.LFD.2.01.0906021439030.4880@localhost.localdomain> <7vfxeidqoz.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0906022000040.4880@localhost.localdomain>
 <7vtz2x6mor.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0906031431100.4880@localhost.localdomain> <7v8wk96knh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Graham Perks <gperks@ausperks.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 00:19:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBync-0001j4-Os
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 00:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451AbZFCWSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 18:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753880AbZFCWSp
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 18:18:45 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47938 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751237AbZFCWSo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2009 18:18:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n53MHolw003119
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Jun 2009 15:17:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n53MHnnu009937;
	Wed, 3 Jun 2009 15:17:50 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7v8wk96knh.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.467 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120655>



On Wed, 3 Jun 2009, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > The original problem was:
> >
> >  - create new file 'x' in branch 'a'
> >
> >  - merge branch 'a' into branch 'b', but because of a merge conflict and 
> >    confurion in the merge, the merge result doesn't contain 'x' any more.
> >
> >  - try to find out what happened to 'x' after-the-fact.
> >
> > Try it. Git really doesn't make it very easy, because git will notice that 
> > 'x' didn't exist before the branch either (in branch 'b'), so there will 
> > be _no_ sign of 'x' actually going away.
> 
> That is true.  The "crude attempt" patch I just sent actually catches
> this, but it does not show the lossage of "new" in the "diff/diffstat"
> part of the merge, when run with "git log --stat -- x".  Besides, it shows
> too many other uninteresting "merged two branches, resolving to lossage of
> the path the same way as all the previous merges" to be really useful.

Yes.

Thinking more about it, we always did have fairly good workarounds for the 
"we optimized away the history too aggressively" (ie the original 
--full-history, and then the newer and nicer --simplify-merges).

So I'm starting to suspect that I was just wrong in looking at the 
revision history simplification. Yes, that can cause simplification that 
we don't want, but on the other hand, it's reasonably easy to work around.

Maybe what we want is a better model for showing diffs from merges.

For example, right now there is _no_ way to get even a "show diff relative 
to first parent". You can do "-m", which will show it relative to _both_ 
parents, but nobody ever wants that. And you can do "-c" or "--cc", but 
that simplifies away all the paths that match in one. 

So here's a challenge: in the git repository, get a nice view of what your 
merges looked like. The closest I can get is

	git log -c --stat --grep="Merge branch '"

which is actually very non-intuitive ("-c" on its own gives no useful 
output, but "-c --stat" gives nice diffstat against the first parent, 
which in this case is what we want).

But I can't actually get git to generate the _patch_ that the --stat 
describes. You'd have to do something like

	git rev-list --parents --grep="Merge branch '" HEAD |
		while read a b c; do git show -s $a ; git diff $b..$a; done | less -S

which is pretty ugly.

			Linus
