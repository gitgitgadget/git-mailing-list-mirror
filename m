From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Tue, 5 Feb 2008 15:59:43 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802051539570.2967@woody.linux-foundation.org>
References: <20080202122135.GA5783@code-monkey.de> <20080203030054.GA18654@coredump.intra.peff.net> <20080203043310.GA5984@coredump.intra.peff.net> <alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org> <7vr6fsk08w.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802041146060.3034@hp.linux-foundation.org> <alpine.LFD.1.00.0802041223080.3034@hp.linux-foundation.org> <7vir13g9hx.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802051300050.3110@woody.linux-foundation.org>
 <alpine.LSU.1.00.0802052228280.8543@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	Tilman Sauerbeck <tilman@code-monkey.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 06 01:00:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMXic-0008D1-NL
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 01:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757610AbYBFAAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 19:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758224AbYBFAAQ
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 19:00:16 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51916 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757088AbYBFAAP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Feb 2008 19:00:15 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m15NxmkX002061
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 5 Feb 2008 15:59:49 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m15Nxh04016351;
	Tue, 5 Feb 2008 15:59:43 -0800
In-Reply-To: <alpine.LSU.1.00.0802052228280.8543@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.214 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72726>



On Tue, 5 Feb 2008, Johannes Schindelin wrote:
> > 
> >  - make commit warn if any parent commit date is in the future from the 
> >    current commit date (allow a *small* fudge factor here, say 5 minutes).
> 
> 5 minutes seems a little narrow to me.  I think we can even go with 86400 
> seconds.

Well, notice how I said *warn*. Not abort the commit. Not stop. Just make 
people very aware of the fact that clocks are skewed.

In the case that actually triggered this whole discussion, the problem 
seems to sadly have been in the original CVS tree (or whatever it was 
imported from): the project started in 2006, had lots of regular commits 
up to October 2007, and then suddenly it had a commit that had a date in 
2002!

[ For those interested in looking at this, the broken commit in that 
  Tilman's repo was commit 3a7340af2bd57488f832d7070b0ce96c4baa6b54, which 
  is from October 2002, and which is surrounded by commits from October 
  2007, so somebody was literally off by five years ]

In other words, the repo really was pretty broken, and the git behaviour 
came from that breakage.

One way to work around this kind of thing is to flag broken dates, and 
yes, we can probably find most of these kinds of random breakages (in the 
case of the broken repo, we had the parent of the broken commit already 
parsed, we could have seen that the date was bogus).

But yeah, I have to also admit that exactly *because* the bug came from 
some import from somewhere else, the date requirement cannot work - I 
don't want to change even obviously bogus data from an external import.

I don't see a good way to find the breakage efficiently and generally, 
though. In the particular case that this hit us, it's visible because the 
breakage is entirely local (ie you can see the broken commit  by just 
looking directly at its parents), but even if you have just *two* commits 
that are broken in succession, the breakage is no longer locally obvious 
at the later one.

Nasty.

			Linus
