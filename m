From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] git-rev-list: give better diagnostic for failed write
Date: Tue, 26 Jun 2007 18:04:40 -0400
Message-ID: <20070626220440.GB27828@thunk.org>
References: <87r6nzu666.fsf@rho.meyering.net> <alpine.LFD.0.98.0706251349540.8675@woody.linux-foundation.org> <878xa7u2gh.fsf@rho.meyering.net> <alpine.LFD.0.98.0706251505570.8675@woody.linux-foundation.org> <alpine.LFD.0.98.0706251536240.8675@woody.linux-foundation.org> <alpine.LFD.0.98.0706251607000.8675@woody.linux-foundation.org> <20070626171127.GA28810@thunk.org> <alpine.LFD.0.98.0706261024210.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 27 00:04:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3J9R-00047S-PE
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 00:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757286AbXFZWEo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 18:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757275AbXFZWEo
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 18:04:44 -0400
Received: from THUNK.ORG ([69.25.196.29]:50247 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756678AbXFZWEn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 18:04:43 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I3JH7-000127-4X; Tue, 26 Jun 2007 18:12:41 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I3J9M-0002gV-1s; Tue, 26 Jun 2007 18:04:40 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0706261024210.8675@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50980>

On Tue, Jun 26, 2007 at 10:32:23AM -0700, Linus Torvalds wrote:
> But we actually _do_ want fully buffered from a performance angle. 
> Especially for the big stuff, which is usually the *diffs*, not the commit 
> messages. Not so much an issue with git-rev-list, but with "git log -p" 
> you would normally not want it line-buffered, and it's actually much nicer 
> to let it be fully buffered and then do a flush at the end.

Well, sometimes we do and sometimes we don't right?  Some of it
depends on how large the *stuff* we are dumping out (diffs vs. commit
objects), and what the receiving process on the other bit of the
pipeline is doing with the data --- is it doing some kind of
statistical reduction (git-rev-log .. | wc -l) versus some kind of
asynchronous processing (git-rev-log as used by gitk).

So maybe the answer is that when outputing to a file, we always use
full stdio buffering, and in other cases there should be some
intelligent defaults plus command-line overrides.  So when we emit
lists of commit identifiers, it should probably be line buffered, and
if it is diffs, it should probably be fully buffered, etc.?

						- Ted
