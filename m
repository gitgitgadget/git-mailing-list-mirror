From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-prune-script eats data
Date: Wed, 22 Jun 2005 19:04:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506221857410.11175@ppc970.osdl.org>
References: <42B8B629.1040208@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 04:07:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlH7G-0006XQ-6H
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 04:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVFWCJV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 22:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVFWCF2
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 22:05:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30364 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262010AbVFWCCw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2005 22:02:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5N22fjA012716
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Jun 2005 19:02:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5N22eg5019857;
	Wed, 22 Jun 2005 19:02:40 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42B8B629.1040208@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 21 Jun 2005, Jeff Garzik wrote:
> 
> $ git-prune-script
> 
> $ git-fsck-cache
> error: cannot map sha1 file c39ae07f393806ccf406ef966e9a15afc43cc36a
> bad object in tag 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c
> bad sha1 entry '5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c'

It's exactly the same thing that Jens had. You have a tag object for the 
v2.6.11-tree thing, but you don't have the reference to the tag.

And now I realize what the problem is. It's _not_ that "git prune" has 
removed too much, like the obvious implication would be: it's that "git 
prune" has not removed _enough_.

"git prune" normally never removes tag-objects, whether reachable or not. 
That's because git-fsck-cache was explicitly ignoring them, which was 
because early on, the way you found tags was you did

	git-fsck-cache --tags

and then you created refs to them manually. 

But now that special case causes problems (and is no longer needed 
anyway), because it means that "git prune" will not remove unreachable 
tags, but it _will_ remove everything that an unreachable tag points to 
(because that is also unreachable).

So the trivial fix is to just remove the lines from fsck-cache.c that say

	/* Don't bother with tag reachability. */
	if (obj->type == tag_type)
		continue;

and that will fix it for you.

Will do.

		Linus
