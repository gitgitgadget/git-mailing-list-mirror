From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Git-prune-script loses blobs referenced from an uncommitted
 cache.
Date: Mon, 2 May 2005 19:56:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505021953160.3594@ppc970.osdl.org>
References: <7vis21no03.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 04:49:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSnSY-0008WL-Gd
	for gcvg-git@gmane.org; Tue, 03 May 2005 04:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVECCyb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 22:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVECCyb
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 22:54:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:1472 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261324AbVECCyS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 22:54:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j432sBs4001804
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 2 May 2005 19:54:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j432sAR2004042;
	Mon, 2 May 2005 19:54:10 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vis21no03.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 2 May 2005, Junio C Hamano wrote:
>
> When a new blob is registered with update-cache, and before the cache
> is written as a tree and committed, git-fsck-cache will find the blob
> unreachable.  This patch fixes git-prune-script to keep such blob objects
> referenced from the cache.

Actually, I'd almost rather just have git-fsck-cache actually do a
"read_cache()" and walk through that and marking the sha1's as "needed".

That's useful for another reason: not only does it mean that we don't drop 
objects that may be in the current index, but it _also_ means that we 
check that the current index actually has everything that it needs. I had 
that situation a few times after I did a "convert-cache" - where I had an 
old index file that pointed to the old objects _before_ the conversion.

I noticed it the hard way, and happily it's easily fixed by just doing a 
"git-read-cache <new-head>", but it was actually very confusing when it 
happened, and it would have been good to have fsck-cache warn about it.

		Linus
