From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [1/5] Parsing code in revision.h
Date: Sun, 17 Apr 2005 11:18:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504171114020.7211@ppc970.osdl.org>
References: <Pine.LNX.4.21.0504171120400.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 20:13:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNEGY-0003kH-Tx
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 20:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVDQSQ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 14:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVDQSQ4
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 14:16:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:8931 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261391AbVDQSQy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 14:16:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3HIGns4007769
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 11:16:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3HIGmLL028969;
	Sun, 17 Apr 2005 11:16:49 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504171120400.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 17 Apr 2005, Daniel Barkalow wrote:
>
> --- 45f926575d2c44072bfcf2317dbf3f0fbb513a4e/revision.h  (mode:100644 sha1:28d0de3261a61f68e4e0948a25a416a515cd2e83)
> +++ 37a0b01b85c2999243674d48bfc71cdba0e5518e/revision.h  (mode:100644 sha1:523bde6e14e18bb0ecbded8f83ad4df93fc467ab)
> @@ -24,6 +24,7 @@
>  	unsigned int flags;
>  	unsigned char sha1[20];
>  	unsigned long date;
> +	unsigned char tree[20];
>  	struct parent *parent;
>  };
>  

I think this is really wrong.

The whole point of "revision.h" is that it's a generic framework for 
keeping track of relationships between different objects. And those 
objects are in no way just "commit" objects.

For example, fsck uses this "struct revision" to create a full free of 
_all_ the object dependencies, which means that a "struct revision" can be 
any object at all - it's not in any way limited to commit objects, and 
there is no "tree" object that is associated with these things at all.

Besides, why do you want the tree? There's really nothing you can do with 
the tree to a first approximation - you need to _first_ do the 
reachability analysis entirely on the commit dependencies, and then when 
you've selected a set of commits, you can just output those.

Later phases will indeed look up what the tree is, but that's only after
you've decided on the commit object. There's no point in looking up (or
even trying to just remember) _all_ the tree objects.

Hmm?

		Linus
