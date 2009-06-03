From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Am able to delete a file with no trace in the log
Date: Wed, 3 Jun 2009 15:56:01 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906031547480.4880@localhost.localdomain>
References: <EB2D87B9-3B03-431A-B204-C7799F9BA291@ausperks.net> <20090602213439.GA7584@coredump.intra.peff.net> <alpine.LFD.2.01.0906021439030.4880@localhost.localdomain> <7vfxeidqoz.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0906022000040.4880@localhost.localdomain>
 <7vtz2x6mor.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0906031431100.4880@localhost.localdomain> <7v8wk96knh.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0906031504080.4880@localhost.localdomain> <7vmy8p54fr.fsf@alter.siamese.dyndns.org>
 <20090603224413.GA2902@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Graham Perks <gperks@ausperks.net>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 04 00:56:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBzNZ-0000S2-LO
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 00:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbZFCW4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 18:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753781AbZFCW4I
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 18:56:08 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39470 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753669AbZFCW4H (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2009 18:56:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n53Mu20i006854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Jun 2009 15:56:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n53Mu1ud007342;
	Wed, 3 Jun 2009 15:56:02 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090603224413.GA2902@coredump.intra.peff.net>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.467 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120660>



On Wed, 3 Jun 2009, Jeff King wrote:
> 
> Is there a way to say "show me everything that touched x, _including_
> merges"?

Well, that's the "--simplify-merges" part. 

It's just that our diff generation isn't very smart. We do show the 
commit, we just don't show a meaningful diff in that case.

And doing good diffs for a merge is _hard_. The "--cc" thing is supremely 
useful - it's just that it's useful for data conflicts, not for metadata 
issues.

It's in fact somewhat dubious if you actually want to see the file removal 
as a _diff_ in a merge, exactly because it's so verbose and yet often so 
uninteresting (ie the removal may well be intentional). 

It might be that the right thing to do is to expand on "-c" and '--cc" to 
just give a summary of metadata changes.

Right now, "-c" and "--cc" ignore files that didn't change from one of the 
parents.

But maybe the right thing to do is to entirely ignore files only if they 
exist in all parents, but didn't change in one - and for things that have 
actual metadata changes, just say

 - exists in merge result, but not in parent 2:

   File 'x' was created in parent 1

 - does not exist in merge result, but exists in parent 1:

   File 'y' was deleted by parent 2

or similar (with perhaps even rename detection some day if -M is 
specified, although n-way rename detection is likely pretty painful).

IOW, do the whole "extended diff", but not actually show any diffs, just 
summary information, for new/deleted files in merges.

That would be enough of a hint to then use other tools to see the exact 
details of what happened..

			Linus
