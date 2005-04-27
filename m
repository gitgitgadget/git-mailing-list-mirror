From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Finding file revisions
Date: Wed, 27 Apr 2005 10:34:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504271027460.18901@ppc970.osdl.org>
References: <200504271251.00635.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 19:29:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQqKX-0001Ev-Je
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 19:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVD0RdW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 13:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVD0RdW
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 13:33:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:9873 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261834AbVD0RdC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 13:33:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3RHWus4027469
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Apr 2005 10:32:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3RHWt14028006;
	Wed, 27 Apr 2005 10:32:56 -0700
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504271251.00635.mason@suse.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 27 Apr 2005, Chris Mason wrote:
> 
> I haven't seen a tool yet to find which changeset modified a given file, so 
> I whipped up something.  The basic idea is to:
> 
> for each changeset in rev-list
> 	for each file in diff-tree -r parent changeset
> 		match against desired files
> 
> Is there a faster way? 

Yes. Tell "diff-tree" what your desired files are, and it will cut down 
the amount of work by a _lot_ (because then diff-tree doesn't need to 
recurse into subdirectories that don't matter).

So you should just do

	for each changeset in rev-list
	do 
		diff-tree -r parent changeset <file-list>
	...

instead. 

> This will scale pretty badly as the tree grows, but 
> I usually only want to search back a few months in the history.  So, it 
> might make sense to limit the results by date or commit/tag.

With more history, "rev-list" should do basically the right thing: it will
be constant-time for _recent_ commits, and it is linear time in how far
back you want to go. Which seems quite reasonable.

And diff-tree is obviously constant-time (and very fast at that, 
especially if you limit it to just a few files, since then it won't even 
bother with any other subdirectories).

		Linus
