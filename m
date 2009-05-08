From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 'git checkout' and unlink() calls (was: Re: )
Date: Fri, 8 May 2009 10:57:32 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905081050420.4983@localhost.localdomain>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504> <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com> <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504> <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain> <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504>
 <alpine.LFD.2.01.0905071248250.4983@localhost.localdomain> <alpine.LFD.2.01.0905071312000.4983@localhost.localdomain> <alpine.LFD.2.01.0905071446500.4983@localhost.localdomain> <86y6t77d8t.fsf_-_@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bevan Watkiss <bevan.watkiss@cloakware.com>,
	"'Alex Riesen'" <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Fri May 08 20:00:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2UMh-0007Vu-Eu
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 20:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023AbZEHR77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 13:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753881AbZEHR77
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 13:59:59 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60847 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753522AbZEHR76 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2009 13:59:58 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n48HvW7c030324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 May 2009 10:58:08 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n48HvW3U004271;
	Fri, 8 May 2009 10:57:32 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <86y6t77d8t.fsf_-_@broadpark.no>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118622>



On Fri, 8 May 2009, Kjetil Barvik wrote:
> 
>   So, if the numbers from strace is trustable, 0.71 seconds is used on
>   41 114 calls to lstat64().  But, look at the unlink line, where each
>   call took 259 microseconds (= 0.259 milliseconds), and all 14 379
>   calls took 3.72 seconds.

The system call times from strace are not really trustworthy. The overhead 
of tracing and in particular all the context switching back and forth 
between the tracer and the tracee means that the numbers should be taken 
with a large grain of salt. 

That said, they definitely aren't totally made up, and they tend to show 
real issues.

In this particular case, what is going on is that 'lstat()' does no IO at 
all, while 'unlink()' generally at the very least will add things to some 
journal etc, and when the journal fills up, it will force IO.

So doing 15k unlink() calls really is _much_ more expensive than doing 41k 
lstat() calls, since the latter will never force any IO at all (ok, so 
even doing just an lstat() may add atime updates etc to directories, but 
even if atime is enabled, that tends to only trigger one IO per second at 
most, and we never have to do any sync IO).

>   It should be noted that when switching branch the other way (from .25
>   to .27), the unlink() calls used less time (below 160 microseconds
>   each).

I don't think they are really "260 us each" or "160 us each". It's rather 
more likely that there are a few that are big due to forced IO, and most 
are in the couple of us case.

		Linus
