From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Why pack+unpack?
Date: Mon, 25 Jul 2005 21:53:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507252145470.6074@g5.osdl.org>
References: <42D7F415.30609@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 26 06:54:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxHSr-0004yp-23
	for gcvg-git@gmane.org; Tue, 26 Jul 2005 06:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVGZEyM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jul 2005 00:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVGZEyM
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jul 2005 00:54:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2992 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261697AbVGZEyH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2005 00:54:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6Q4rkjA012413
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Jul 2005 21:53:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6Q4rj4Z032621;
	Mon, 25 Jul 2005 21:53:45 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42D7F415.30609@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 26 Jul, Jeff Garzik wrote:
>
>				AFAICT this is
> just a complete waste of time.  Why does this occur?
>
> Packing 1394 objects
> Unpacking 1394 objects
>   100% (1394/1394) done
> 
> It doesn't seem to make any sense to perform work, then immediately undo
> that work, just for a local pull.

First, make sure you have a recent git, it does better at optimizing the 
objects, so there are fewer of them. Of course, the above could be a real 
pull of a a fair amount of work, but check that your git has this commit:

	commit 4311d328fee11fbd80862e3c5de06a26a0e80046

	    Be more aggressive about marking trees uninteresting

because otherwise you sometimes get a fair number of objects just because
git-rev-list wasn't always being very careful, and took more objects than
it strictly needed.

Secondly, what's the problem? Sure, I could special-case the local case, 
but do you really want to have two _totally_ different code-paths? In 
other words, it's absolutely NOT a complete waste of time: it's very much 
a case of trying to have a unified architecture, and the fact that it 
spends a few seconds doing things in a way that is network-transparent is 
time well spent.

Put another way: do you argue that X network transparency is a total waste
of time? You could certainly optimize X if you always made it be
local-machine only. Or you could make tons of special cases, and have X 
have separate code-paths for local clients and for remote clients, rather 
than just always opening a socket connection.

See? Trying to have one really solid code-path is not a waste of time. 

We do end up having a special code-path for "clone" (the "-l" flag), which
does need it, but I seriously doubt you need it for a local pull. The most 
expensive operation in a local pull tends to be (if the repositories are 
unpacked and cold-cache) just figuring out the objects to pull, not the 
packing/unpacking per se.

			Linus
