From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: CAREFUL! No more delta object support!
Date: Tue, 28 Jun 2005 20:53:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506282041360.19755@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506281251380.30848-100000@iabervon.org>
 <Pine.LNX.4.58.0506281019450.19755@ppc970.osdl.org>
 <Pine.LNX.4.58.0506281111480.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 05:45:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnTVg-0001RU-DY
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 05:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVF2DwN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 23:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVF2DwN
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 23:52:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52110 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261184AbVF2DwH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2005 23:52:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5T3pvjA015746
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Jun 2005 20:51:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5T3prZu017322;
	Tue, 28 Jun 2005 20:51:55 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.58.0506281111480.19755@ppc970.osdl.org>
X-Spam-Status: No, hits=0.667 required=5 tests=MANY_EXCLAMATIONS
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 28 Jun 2005, Linus Torvalds wrote:
> 
> >						 I'm not sure I
> > want to write the "parse incoming pack-file" thing, but git-unpack-objects
> > comes _reasonably_ close (but right now it seeks around using the index
> > file to resolve deltas, instead of keeping them in memory and resolving
> > them when possible).
> 
> I'm still thinking about this one. I think I'll just do it.

Ok, done. I had to basically rewrite that unpacking logic, but the end 
result is actually slightly smaller and cleaner, and it can now unpack 
from a stream. That stream reading logic that uncompresses directly from 
the stream buffer might be considered a bit too subtle (and somebody 
should really double-check it), but hey, it works for me.

In fact, I just did this:

	#
	# Create empty git archive "~/unpack"	
	#
	mkdir ~/unpack
	cd ~/unpack
	git-init-db

	#
	# Copy the git archive there over a pipe
	#
	cd ~/git
	git-rev-list --objects HEAD | git-pack-objects --depth=50 --window=50 --stdout | (cd ~/unpack ; git-unpack-objects)

	#
	# Go to new archive, set up the head, and fsck to verify
	#
	cd ~/unpack
	cat ~/git/.git/HEAD > .git/HEAD 
	git-fsck-cache --unreachable

Now, the above is a silly example, since I _could_ just have moved the
pack file into .git/objects/pack, but that was not the point of this whole
thing. The point was to do what a "git-ssh-push" would basically boil down
to.

I'd like somebody who knows zlib intimately to take a look at how I do the 
streaming input thing (in particular, the "use(len - stream.avail_in);" 
part in the inflate loop in the "get_data()" function).

			Linus
