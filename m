From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Is cogito really this inefficient
Date: Thu, 14 Jul 2005 08:26:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507140813150.19183@g5.osdl.org>
References: <20050713135052.C6791@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0507131325170.17536@g5.osdl.org> <20050714083700.A26322@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 17:29:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dt5dJ-0004ew-CD
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 17:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263044AbVGNP1M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 11:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263046AbVGNP1L
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 11:27:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33700 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263044AbVGNP0S (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2005 11:26:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6EFQ8jA032006
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Jul 2005 08:26:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6EFQ7Tv017618;
	Thu, 14 Jul 2005 08:26:07 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050714083700.A26322@flint.arm.linux.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 14 Jul 2005, Russell King wrote:
> 
> cg-update origin
> and then I edited drivers/serial/8250.c

Hmm.. 

> it appears that cg-diff does a
> 
> 	git-update-cache --refresh >/dev/null
> 
> each time it's run, which is taking the bulk of the time.  Also note
> that curiously, it exits with status 1.

That part is normal - a update-cache is fast (it takes me 0.08 sec for the
kernel) if the cache is already mostly up-to-date, and the non-zero exit
status just means that some file was different (ie it's telling the caller
that there are edits in your tree - drivers/serial/8250.c).

The update-cache is slow only if the index isn't up-to-date, which can
happen either if somebody plays games with the index, or if somebody
touches all the files in the tree.

It's quite possible that some path in cg-update ends up not updating the 
index properly. For example, I notice that the "fast-forward" uses 
"git-checkout-cache -f -a", which can do so (lack of "-u" fila), but then 
it does do a "git-update-cache --refresh" later, so that doesn't seem to 
be it either.

If you do a "git-diff-files" every once in a while, it will _scream_ at
you whenever you have files that aren't up-to-date in the cache. That's
normal in small doses, of course (eg your edit of drivers/serial/8250.c
would make that one not up-to-date), but if you get a _lot_ of files
listed, that's usually a sign that something screwed up your index. 

		Linus
