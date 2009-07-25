From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue of 'git branch'
Date: Fri, 24 Jul 2009 19:39:27 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907241934260.3960@localhost.localdomain>
References: <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain> <7vtz146mgr.fsf@alter.siamese.dyndns.org> <20090723160740.GA5736@Pilar.aei.mpg.de>
 <alpine.LFD.2.01.0907230913230.21520@localhost.localdomain> <20090723165335.GA15598@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907231158280.21520@localhost.localdomain> <alpine.LFD.2.01.0907231212180.21520@localhost.localdomain> <20090723195548.GA28494@Pilar.aei.mpg.de>
 <alpine.LFD.2.01.0907241327410.3960@localhost.localdomain> <alpine.LFD.2.01.0907241346450.3960@localhost.localdomain> <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain> <alpine.LFD.2.01.0907241505400.3960@localhost.localdomain>
 <alpine.DEB.1.10.0907241518120.28013@asgard.lang.hm> <alpine.LFD.2.01.0907241529420.3960@localhost.localdomain> <alpine.DEB.1.10.0907241545340.28013@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Carlos R. Mafra" <crmafra2@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sat Jul 25 04:39:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUXAx-0004DI-0t
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 04:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754963AbZGYCjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 22:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752377AbZGYCjq
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 22:39:46 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49153 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751089AbZGYCjp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jul 2009 22:39:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6P2dSna026713
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 24 Jul 2009 19:39:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6P2dRhO000606;
	Fri, 24 Jul 2009 19:39:27 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.DEB.1.10.0907241545340.28013@asgard.lang.hm>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.459 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123989>



On Fri, 24 Jul 2009, david@lang.hm wrote:

> On Fri, 24 Jul 2009, Linus Torvalds wrote:
> 
> > On Fri, 24 Jul 2009, david@lang.hm wrote:
> > > 
> > > what does the performance look like if you just do a static compile
> > > instead?
> > 
> > I don't even know - I don't have a static version of curl. I could install
> > one, of course, but since I don't think that's the solution anyway, I'm
> > not going to bother.
> 
> I wasn't thinking a static version of curl, I was thinking a static version of
> the git binaries. see how fast things could be if no startup linking was
> nessasary.

Well, that's what I meant. If I add '-static' to the link flags, I get

	/usr/bin/ld: cannot find -lcurl
	collect2: ld returned 1 exit status

because I simply don't have a static library version of curl (and if I do 
NO_CURL, I fail the link due to not having a static version of zlib).

That's what I meant by "I could install a static version of curl" - I 
could install the debug libraries, but it just isn't a normal thing to do 
on any modern distribution. The right thing to do really would be to not 
have -lcurl for the main git binary at all.

Preferably done by having http walking handled by an external process (the 
way we already do rsync), but it's probably easier to just make all the 
clone/fetch/ls-remote things be a separate binary.

Of course, I'd personally solve the problem with NO_CURL=1, but that's 
probably not acceptable in general.

			Linus
