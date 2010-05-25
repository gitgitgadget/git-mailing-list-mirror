From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git log follow question
Date: Tue, 25 May 2010 11:49:25 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005251141580.3689@i5.linux-foundation.org>
References: <006d01caf300$703e96a0$50bbc3e0$@burgmann.anu.edu.au> <20100514043704.GC6075@coredump.intra.peff.net> <alpine.LFD.2.00.1005140730030.3711@i5.linux-foundation.org> <20100525093140.GA32460@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Albert Krawczyk <albert@burgmann.anu.edu.au>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 25 20:52:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGzEr-0002Mp-Rw
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 20:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758895Ab0EYSwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 14:52:25 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46578 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756378Ab0EYSwY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 May 2010 14:52:24 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o4PIqCSx020223
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 25 May 2010 11:52:13 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o4PIqB81008791;
	Tue, 25 May 2010 11:52:11 -0700
In-Reply-To: <20100525093140.GA32460@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.444 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147722>



On Tue, 25 May 2010, Jeff King wrote:
> 
> Thanks for the input. I took a look at it myself and it is a bit more
> complex than just turning on pruning. I have a prototype --follow that
> handles arbitrary pathspecs instead of single files; instead of
> replacing the single-file pathspec, it just widens the pathspec as it
> traverses history.

Doing it "right" is actually a _lot_ more complex than that.

Think especially about the case of the file having been renamed in one 
branch, and in another branch it was created from scratch, and then a 
merge that sorts it all out (think two people aiming for the same thing, 
just doing it differently - but with similar approaches).

Now, imagine reaching the common commit by walking _one_ of the chains 
before having walked the other one fully. So now you're looking at a 
commit using one set of pathnames, and then later on you'll hit the _same_ 
commit (through the other branch), but with another set of pathnames. But 
by then you've already handled that commit.

The above isn't an issue with the regular pathname pruning, because the 
pruning rules never change - so the order of handling commits never 
matter, and you can do the pruning before/independently of having done any 
history following.

And it's not an issue with the current total hack, because the current 
total hack doesn't even _try_ to handle it, and doesn't even really try to 
do anything proper. The current hack is very much by design was a "hey, 
this is about as good as CVS/SVN could ever do", rather than anything that 
has any good design.

		Linus
