From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Efficient way to import snapshots?
Date: Mon, 30 Jul 2007 12:52:52 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707301240330.4161@woody.linux-foundation.org>
References: <20070730180710.GA64467@nowhere>
 <alpine.LFD.0.999.0707301144180.4161@woody.linux-foundation.org>
 <20070730192922.GB64467@nowhere>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Craig Boston <craig@olyun.gank.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jul 30 21:53:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFbIx-0005hX-9k
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 21:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936932AbXG3TxH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 15:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935643AbXG3TxF
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 15:53:05 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56627 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761004AbXG3TxE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2007 15:53:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6UJqw6d022439
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 Jul 2007 12:52:59 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6UJqrS4027556;
	Mon, 30 Jul 2007 12:52:53 -0700
In-Reply-To: <20070730192922.GB64467@nowhere>
X-Spam-Status: No, hits=-2.729 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.15__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54258>


[ Junio added, because I think I noticed a performance bug ]

On Mon, 30 Jul 2007, Craig Boston wrote:
> 
> A couple questions on that:
> 
> 1. Will it notice deleted files?

Yes, although I think you need to do "git commit -a" for that. 

"git add ." could (and perhaps _should_) notice them and remove them from 
the cache, but doesn't. Whether that's the right behaviour or not (it does 
seem a bit strange that "git add" would actually remove files from the 
index too) is up for debate.

But with "git commit -a", it will be noticed at commit time, at least.

That said, I just noticed something nasty: "git add ." is *horrible*. It 
does the full SHA1 re-computation even though the index is up-to-date. 
That's really nasty.

So right now, due to this performance bug, it's actually much better to do 
something more complex, namely something like

	git ls-files -o | git update-index --add --stdin
	git commit -a

which is a lot more efficient than just doing "git add .".

Junio? I _thought_ we already took the index into account with "git add", 
but we obviously don't. 

> 2. How can I tell it what branch to commit to?

Whatever branch is checked out in the GIT_DIR will be the one that it 
commits to.

			Linus
