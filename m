From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [1/5] Consider a blob to be parsed
Date: Wed, 27 Apr 2005 22:28:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504272217240.18901@ppc970.osdl.org>
References: <Pine.LNX.4.21.0504280100360.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 07:21:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR1SR-00004t-Lh
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 07:21:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVD1F0Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 01:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVD1F0Z
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 01:26:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:29086 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262008AbVD1F0K (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 01:26:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3S5Q6s4026435
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Apr 2005 22:26:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3S5Q5ss031689;
	Wed, 27 Apr 2005 22:26:06 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504280100360.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Apr 2005, Daniel Barkalow wrote:
>
> We don't parse blobs at all, so any that we've got are as parsed as
> they're going to get. Don't make fsck-cache mark them.

NO NO NO!

This is WRONG, dammit. I fixed it once, you are re-introducing the same
bug.

Daniel, the problem is that you parse them only when you SEE them, and 
that is totally different from having seen a REFERENCE to them. One says 
"I've seen this object", the other says "I _want_ to see this object". 
They are two totally different things.

You now mark all "blob" objects parsed regardless of whether you have 
actually seen the blob or not. Ie you mark a blob parsed just from having 
seen a _reference_ to it, and fsck can never know whether it actually 
really saw the object or not.

This is the commit that already fixed this bug once, and that you are now 
re-introducing:

	commit 4728b861ace127dc39c648f3bea64c3b86bbabc5
	tree 242227fc3c3a74d070ed36496e790335dd00c44a
	parent da6abf5d9c342a74dffbcc2015b9c27d7819a900
	author Linus Torvalds <torvalds@ppc970.osdl.org> Sun, 24 Apr 2005 14:10:55 -0700
	committer Linus Torvalds <torvalds@ppc970.osdl.org> Sun, 24 Apr 2005 14:10:55 -0700
	
	    fsck-cache: notice missing "blob" objects.
	    
	    We should _not_ mark a blob object "parsed" just because we
	    looked it up: it gets marked that way only once we've actually
	    seen it. Otherwise we can never notice a missing blob.

please think about it.

Try to make some test-cases for fsck. They are quite easy to make: copy a 
good directory, and 
 - remove one commit (in the middle)
 - remove at least on tree
 - remove at least one blob
 - corrupt a file obviously (make it not uncompress ok)
 - corrupt a file in a subtle way (make it uncompress ok and have the
   right signature, but be the wrong type - for example, make a "commit" 
   object that points to a "tree" object that actually is a "blob")

And you'll see how this "consider a blob parsed" totally destroys fsck's 
ability to notice that the blob doesn't even _exist_ any more (case 3 
above).

"parsing" and "looking up" are two totally independent operations. They
are independent for commits and trees, and they are independent for blobs.  

To mark a blob parsed, you _need_ to have actually looked it up and
verified that it exists and that the object header is valid (and if you're 
fsck, that the sha1 matches). You MUST NOT do it in "lookup_blob()".

		Linus
