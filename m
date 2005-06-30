From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 13:52:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org>
 <Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org> <42C454B2.6090307@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 22:49:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do5xo-0006Me-5A
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 22:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263148AbVF3Uzx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 16:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbVF3UvK
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 16:51:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6839 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263152AbVF3UuU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 16:50:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5UKo6jA025068
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 30 Jun 2005 13:50:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5UKo5oQ031814;
	Thu, 30 Jun 2005 13:50:05 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42C454B2.6090307@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 30 Jun 2005, H. Peter Anvin wrote:
> 
> If I've understood this correctly, it's not a constant factor 
> improvement in the number of files (in the size, yes); it's changing it 
> from O(t*c) to O(t) where t is number of trees and c is number of 
> changesets.  That's key.

No, it _is_ a constant factor even in number of files, if you just keep 
the pack objects around without re-packing them.

Basically, you'd get one new pack-file every time I push. That's better
than getting <n> "raw object" files (where <n> can be anything from just a
couple to several thousand, depending on whether I had pulled things), but
it's still just a constant factor on both number of files and size of
files.

Now, you could re-pack the objects every once in a while: it would force a
whole new "epoch", of course and then the mirrorers would have to fetch
the whole repacked file, but that might be fine. Especially if you stop
re-packing after you've hit a certain size (say, a couple of megs), and
then start on the next pack.

> For the purposes of rsync, storing the objects in a single append-only 
> file would be a very efficient method, since the rsync algorithm will 
> quickly discover an invariant head and only transmit the tail.

Actually, it won't be "quick" - it will have to read the whole file and do 
it's hash window thing.

You _could_ append the pack-files into one single "superpack" file (since
you can figure out where the pack boundaries are), but it would be
extremely big after a while, and rsync would spend all its time doing over
the hash window. You'd definitely be better off with re-packing.

		Linus
