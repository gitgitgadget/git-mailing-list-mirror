From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] multi item packed files
Date: Fri, 22 Apr 2005 09:22:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504220916060.2344@ppc970.osdl.org>
References: <200504211113.13630.mason@suse.com> <200504211622.48065.mason@suse.com>
 <Pine.LNX.4.58.0504211530370.2344@ppc970.osdl.org> <200504212016.16729.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Krzysztof Halasa <khc@pm.waw.pl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 18:16:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP0oy-0002pb-DS
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 18:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVDVQUb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 12:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVDVQUb
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 12:20:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:61900 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262056AbVDVQUZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 12:20:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3MGKFs4014747
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 22 Apr 2005 09:20:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3MGKEv5032241;
	Fri, 22 Apr 2005 09:20:15 -0700
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504212016.16729.mason@suse.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 21 Apr 2005, Chris Mason wrote:
> 
> We can sort by the files before reading them in, but even if we order things 
> perfectly, we're spreading the io out too much across the drive.

No we don't.

It's easy to just copy the repository in a way where this just isn't true:  
you sort the objects by how far they are from the current HEAD, and you
just copy the repository in that order ("furthest" objects first - commits
last).

That's what I meant by defragmentation - you can actually do this on your 
own, even if your filesystem doesn't support it.

Do it twice a year, and I pretty much guarantee that your performance will
stay pretty constant over time. The one exception is fsck, which doesn't
seek in "history order".

And this works exactly because: 
 - we don't do no steenking delta's, and don't have deep "chains" of data 
   to follow. The longest chain we ever have is just a few deep, and it's 
   trivial to just encourage the filesystem to have recent things together.
 - we have an append-only mentality.

In fact, it works for exactly the same reason that makes us able to drop 
old history if we want to. We essentially "drop" the history to another 
part of the disk.

		Linus
