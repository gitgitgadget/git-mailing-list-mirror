From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-local-pull
Date: Sun, 26 Jun 2005 22:20:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506262213220.19755@ppc970.osdl.org>
References: <20050626.200555.39157645.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 27 07:11:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DmluJ-0001cd-I7
	for gcvg-git@gmane.org; Mon, 27 Jun 2005 07:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVF0FSd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Jun 2005 01:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVF0FSd
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jun 2005 01:18:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44972 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261820AbVF0FS1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2005 01:18:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5R5IPjA013932
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Jun 2005 22:18:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5R5IOqh007924;
	Sun, 26 Jun 2005 22:18:25 -0700
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050626.200555.39157645.davem@davemloft.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 26 Jun 2005, David S. Miller wrote:
> 
> I tried to start using git-clone-script to clone repositories
> locally.  It crunches on the disk for a couple of seconds,
> that's fine, but then I notice the disk activity stop and
> git-local-pull becomes cpu bound and grows to 80MB in size
> over the course of 5 minutes.

Try adding "-l" to the git-local-pull command line, to make it do 
hardlinks by default (and fall back to a copy if that fails).

> Is this a side effect of the new pack/unpack stuff?

Nope, nothing uses that yet. 

I think the 80MB is just because it built up the object relationship for 
the whole kernel db there. I don't know what the 5 minutes of CPU are, 
though, it should just be copying stuff (and at 250MB in and 250MB out, 
that's a lot of stuff to copy, but it shouldn't be five minutes worth, 
especially if it's all cached and you see a pegged CPU).

That copy is stupid, btw. Doing a "mmap + write" is a lot slower than
doing a "while (data) { read(8kB) + write(8kB) }" loop. The read() will
generally do better read-ahead and the small read/write will be better for 
the caches. But that still doesn't explain 5 minutes worth.

> Compared to what this thing is doing, manually symlinking
> the object database, copying over the HEAD, and building
> the index file is significantly faster.

Well, with "-l" that is what git-local-pull will do too. And if you want 
symlinks, use "-s". Or use both, in which case it will try a hardlink 
first, and then a symlink if it gets an EXDEV.

		Linus
