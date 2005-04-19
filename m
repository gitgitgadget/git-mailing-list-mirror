From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] write-tree performance problems
Date: Tue, 19 Apr 2005 16:59:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504191651110.6467@ppc970.osdl.org>
References: <200504191250.10286.mason@suse.com><Pine.LNX.4.58.0504191017300.19286@ppc970.osdl.org><200504191412.00227.mason@suse.com><Pine.LNX.4.58.0504191143220.19286@ppc970.osdl.org><Pine.LNX.4.62.0504191508060.26365@qynat.qvtvafvgr.pbz><Pine.LNX.4.58.0504191514550.2274@ppc970.osdl.org><Pine.LNX.4.62.0504191557410.26365@qynat.qvtvafvgr.pbz>
 <Pine.LNX.4.58.0504191608230.2274@ppc970.osdl.org>
 <Pine.LNX.4.62.0504191629410.26365@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Mason <mason@suse.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 01:53:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO2X2-000675-RG
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 01:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVDSX5e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 19:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVDSX5e
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 19:57:34 -0400
Received: from fire.osdl.org ([65.172.181.4]:39130 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261285AbVDSX5Z (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 19:57:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3JNvKs4032002
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Apr 2005 16:57:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3JNvJB2008196;
	Tue, 19 Apr 2005 16:57:19 -0700
To: David Lang <david.lang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.62.0504191629410.26365@qynat.qvtvafvgr.pbz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 19 Apr 2005, David Lang wrote:
> >
> > If so, he should set up one repository per quilt patch.
> 
> a tool to do this automaticaly is what I was trying to suggest (and asking 
> if it would be useful)

Heh. It's certainly possible. Esepcially with the object sharing, you 
could create a git archive by just doing a "read-tree" and updating a few 
files, and you'd never have to even check out the rest of the files at 
all.

IOW, you can probably set up a new git archive in not much more time than
it takes for a "read-tree" + "write-tree", with very little in between.  
That comes out to about a second, and the write-tree index optimizations
would take it down to next to nothing..

However, it definitely wouldn't be useful for _me_. The whole thing that
I'm after is to allow painless merging of distributed work. If I have to
merge one patch at a time, I'd much rather see people send me patches
directly - that's much simpler than having a whole new GIT repository.

So at least to me, a git repository only makes sense when it is a
collection of patches.

Does that mean that it wouldn't make sense to others? No. It's really
cheap to keep a shared object directory, and have a number of different
git archives using that, and you can have ten different trees tracking ten
different things, with very little overhead.

But even "cheap" is relative. If you actually want to do _work_ in those
repositories, you want to check things out in them, and populate them with
files. Even if you do that with hardlinked blobs, just _populating_ the
tree itself (setting up the subdirectories and the links) is going to be
more expensive than applying a patch in quilt.

		Linus
