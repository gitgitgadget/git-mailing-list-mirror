From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-rev-list: give better diagnostic for failed write
Date: Tue, 26 Jun 2007 10:32:23 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706261024210.8675@woody.linux-foundation.org>
References: <87r6nzu666.fsf@rho.meyering.net>
 <alpine.LFD.0.98.0706251349540.8675@woody.linux-foundation.org>
 <878xa7u2gh.fsf@rho.meyering.net> <alpine.LFD.0.98.0706251505570.8675@woody.linux-foundation.org>
 <alpine.LFD.0.98.0706251536240.8675@woody.linux-foundation.org>
 <alpine.LFD.0.98.0706251607000.8675@woody.linux-foundation.org>
 <20070626171127.GA28810@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 26 19:33:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3EuW-0000lO-2G
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 19:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756678AbXFZRci (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 13:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757323AbXFZRci
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 13:32:38 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38442 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756622AbXFZRch (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jun 2007 13:32:37 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5QHWSrA020890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Jun 2007 10:32:30 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5QHWNWU030801;
	Tue, 26 Jun 2007 10:32:23 -0700
In-Reply-To: <20070626171127.GA28810@thunk.org>
X-Spam-Status: No, hits=-4.61 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50968>



On Tue, 26 Jun 2007, Theodore Tso wrote:
> 
> Is there something obviously wrong with doing something like this?
> 
> 	if ((fstat(fileno(stdout), &st) < 0) &&
> 	    !S_ISREG(st.st_mode))
> 		setbuf(stdout, NULL);
> 
> This would change stdout to use completely unbuffered I/O we're not
> sending the output to a file.

Well, we might as well keep it line-buffered, so I'd use setvbuf(_IOLBF) 
instead. Totally unbuffered is bad, since we often do printf's in smaller 
chunks.

But we actually _do_ want fully buffered from a performance angle. 
Especially for the big stuff, which is usually the *diffs*, not the commit 
messages. Not so much an issue with git-rev-list, but with "git log -p" 
you would normally not want it line-buffered, and it's actually much nicer 
to let it be fully buffered and then do a flush at the end.

Even pipes are often used for "throughput" stuff if you end up doing some 
post-processing (ie "git log -p | gather-statistics"), and yes, I actually 
do things like that - it's nice for things like looking at how many lines 
have been added during the last release cycle:

	git log -p v2.6.21.. | grep '^+' | wc -l

and I'd really like thigns like that to be close to optimal. 

How much the system call overhead is, I don't know, though. So it might be 
worth testing out. Under Linux, you'll probably have a fairly hard time 
seeing any difference, but under other OS's you have both system call 
latency issues *and* possible scheduling issues (ie the above kind of 
pipeline can act very differently from a scheduling standpoint if you send 
lots of small things rather than buffer things a bit on the generating 
side)

		Linus
