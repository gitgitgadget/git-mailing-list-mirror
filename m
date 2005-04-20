From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] write-tree performance problems
Date: Wed, 20 Apr 2005 08:46:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504200840240.6467@ppc970.osdl.org>
References: <200504191250.10286.mason@suse.com> <200504192049.21947.mason@suse.com>
 <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org> <200504201122.35448.mason@suse.com>
 <Pine.LNX.4.61.0504201128550.2630@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Mason <mason@suse.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 17:42:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOHJS-0002z0-0O
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 17:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVDTPoi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 11:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVDTPod
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 11:44:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:24225 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261693AbVDTPo0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 11:44:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3KFiLs4005037
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 08:44:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3KFiKCJ009856;
	Wed, 20 Apr 2005 08:44:20 -0700
To: "C. Scott Ananian" <cscott@cscott.net>
In-Reply-To: <Pine.LNX.4.61.0504201128550.2630@cag.csail.mit.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 20 Apr 2005, C. Scott Ananian wrote:
> 
> Hmm.  Are our index files too large, or is there some other factor?

They _are_ pretty large, but they have to be,

For the kernel, the index file is about 1.6MB. That's 

 - 17,000+ files and filenames
 - stat information for all of them
 - the sha1 for them all

ie for the kernel it averages to 93.5 bytes per file. Which is actually 
pretty dense (just the sha1 and stat information is about half of it, and 
those are required).

> I was considering using a chunked representation for *all* files (not just 
> blobs), which would avoid the original 'trees must reference other trees 
> or they become too large' issue -- and maybe the performance issue you're 
> referring to, as well?

No. The most common index file operation is reading, and that's the one 
that has to be _fast_. And it is - it's a single "mmap" and some parsing.

In fact, writing it is pretty fast too, exactly because the index file is 
totally linear and isn't compressed or anything fancy like that. It's a 
_lot_ faster than the "tree objects", exactly because it doesn't need to 
be as careful.

The main cost of the index file is probably the fact that I add a sha1 
signature of the file into itself to verify that it's ok. The advantage is 
that the signature means that the file is ok, and the parsing of it can be 
much more relaxed. You win some, you lose some.

		Linus
