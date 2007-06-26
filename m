From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-rev-list: give better diagnostic for failed write
Date: Tue, 26 Jun 2007 15:32:39 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706261528130.8675@woody.linux-foundation.org>
References: <87r6nzu666.fsf@rho.meyering.net>
 <alpine.LFD.0.98.0706251349540.8675@woody.linux-foundation.org>
 <878xa7u2gh.fsf@rho.meyering.net> <alpine.LFD.0.98.0706251505570.8675@woody.linux-foundation.org>
 <alpine.LFD.0.98.0706251536240.8675@woody.linux-foundation.org>
 <alpine.LFD.0.98.0706251607000.8675@woody.linux-foundation.org>
 <20070626171127.GA28810@thunk.org> <alpine.LFD.0.98.0706261024210.8675@woody.linux-foundation.org>
 <20070626220440.GB27828@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 27 00:33:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Jb3-00012g-Oe
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 00:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757425AbXFZWdL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 18:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757372AbXFZWdK
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 18:33:10 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50533 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756771AbXFZWdJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jun 2007 18:33:09 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5QMWilp030241
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Jun 2007 15:32:45 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5QMWdT3003748;
	Tue, 26 Jun 2007 15:32:39 -0700
In-Reply-To: <20070626220440.GB27828@thunk.org>
X-Spam-Status: No, hits=-4.618 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50983>



On Tue, 26 Jun 2007, Theodore Tso wrote:
> On Tue, Jun 26, 2007 at 10:32:23AM -0700, Linus Torvalds wrote:
> > But we actually _do_ want fully buffered from a performance angle. 
> > Especially for the big stuff, which is usually the *diffs*, not the commit 
> > messages. Not so much an issue with git-rev-list, but with "git log -p" 
> > you would normally not want it line-buffered, and it's actually much nicer 
> > to let it be fully buffered and then do a flush at the end.
> 
> Well, sometimes we do and sometimes we don't right?

No.

We basically _never_ want "line buffered" or "unbuffered", which is what 
stdio knows how to do. That sucks in _all_ cases.

What we want is "fully buffered" for plain files, and "record buffered" 
for anything else (where a "record" is basically the "commit + optional 
diff").

We can get the record buffered by adding the fflush() calls, but the thing 
is, we'd want to _avoid_ that if it was a file. It's just that there is no 
way to set that kind of flag portably with stdio, we'd have to carry it 
around _separately_ from stdio, which is a big pain.

But if we decide that this only matters with stdout (which currently is 
what the patches have done), we could of course just make it a single 
global variable (like "stdout" itself already is). Then we could just make 
git.c start out by testing stdout at startup and setting the global 
variable.

		Linus
