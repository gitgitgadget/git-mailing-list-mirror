From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git log follow question
Date: Wed, 26 May 2010 07:40:22 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005260732490.3689@i5.linux-foundation.org>
References: <006d01caf300$703e96a0$50bbc3e0$@burgmann.anu.edu.au> <20100514043704.GC6075@coredump.intra.peff.net> <alpine.LFD.2.00.1005140730030.3711@i5.linux-foundation.org> <20100525093140.GA32460@coredump.intra.peff.net> <alpine.LFD.2.00.1005251141580.3689@i5.linux-foundation.org>
 <20100526055823.GA30409@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Albert Krawczyk <albert@burgmann.anu.edu.au>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 26 16:43:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHHpV-00048v-H1
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 16:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755Ab0EZOn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 10:43:27 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59732 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753290Ab0EZOn1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 May 2010 10:43:27 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o4QEhGuG007963
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 26 May 2010 07:43:17 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o4QEhFCv027851;
	Wed, 26 May 2010 07:43:16 -0700
In-Reply-To: <20100526055823.GA30409@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.444 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147802>



On Wed, 26 May 2010, Jeff King wrote:
> > 
> > Doing it "right" is actually a _lot_ more complex than that.
> 
> Did you mean doing history rewriting right is more complex than that,

History rewriting with changing pathspecs.

> or did you mean that handling multiple follow pathspecs is more complex 
> than pathspec-widening

No, the "expand pathspec to cover the newly found rename" part is pretty 
simple. But the fact that the pathspec changes over the history inevitably 
leads to the problem of finding commits in the right order.

The thing is, if the pathspec is history-dependent, then that means that 
in order to get it right, you should walk the history in topological order 
in order to get a proper pathspec. But you don't know what the topological 
order _is_ until you've walked the history - which in turn means that if 
you want to get "perfect" results, you need to walk the history first, and 
then have a separate phase to do the pathspec.

That's actually what the current --follow kind of does, but because the 
current follow isn't even trying to get a proper pathspec in the bigger 
picture (it only tracks a single global filename rather than widening the 
net), it also skips the topological part, since even if it did things in 
topological order it would _still_ get things wrong.

Doing it really right also actually would require making the pathspec be a 
per-commit thing rather than a single global one. Otherwise you get other 
odd effects, if that filename has ever been something different. But since 
you only do a simple widening, I guess you don't much care (you already 
get odd effects if there was a criss-cross rename, and will end up picking 
up the history for _both_ files, rather than just the original one).

				Linus
