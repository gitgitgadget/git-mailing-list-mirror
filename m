From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git merging
Date: Fri, 17 Jun 2005 17:13:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506171700200.2268@ppc970.osdl.org>
References: <20050617133440.GI6957@suse.de> <Pine.LNX.4.58.0506170937260.8487@ppc970.osdl.org>
 <20050617175653.GS6957@suse.de> <Pine.LNX.4.58.0506171101450.2268@ppc970.osdl.org>
 <20050617181156.GT6957@suse.de> <Pine.LNX.4.58.0506171132390.2268@ppc970.osdl.org>
 <20050617183914.GX6957@suse.de> <Pine.LNX.4.58.0506171142500.2268@ppc970.osdl.org>
 <42B357D7.6030302@pobox.com> <Pine.LNX.4.58.0506171629320.2268@ppc970.osdl.org>
 <42B36207.3020209@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jens Axboe <axboe@suse.de>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 18 02:06:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjQql-0003Ts-61
	for gcvg-git@gmane.org; Sat, 18 Jun 2005 02:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVFRALi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Jun 2005 20:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVFRALg
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jun 2005 20:11:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32975 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261258AbVFRALZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2005 20:11:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5I0BIjA027656
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 17 Jun 2005 17:11:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5I0BHYK030820;
	Fri, 17 Jun 2005 17:11:18 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42B36207.3020209@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 17 Jun 2005, Jeff Garzik wrote:
> 
> This is definitely not the case; my .git/HEAD is _always_ a symlink.

Ok. Are you sure that you gave the same arguments (or rather, lack of
arguments) to both fsck and "git prune"? The thing is, they are both
really the same thing, so I'm pretty surprised. If git prune says 
something is unreachable, then git-fsck-cache shouldn't complain about it 
being gone, because one just depends on the other..

> My git-switch-tree script, attached, demonstrates how .git/HEAD symlink 
> is retargetted to the specified branch.  My workflow depends on 
> .git/HEAD being a symlink.

Btw, you can now do the same thing more safely and guarantee that it 
doesn't overwrite any old information by using

	git-read-tree -m -u <old-head> <new-head>

which basically switches from "old" to "new", and verifies that all the 
old index contents were valid in "old-head", and that any file that was 
dirty is not different in "new-head".

Your old script would silently overwrite any dirty state in your working
directory, and drop anything that you had done a git-update-cache on but
not committed.

Now, you may have _depended_ on that behaviour as a way to just reset the 
tree to a known state, but if so, I'd suggest using

	git-read-tree --reset HEAD && git-checkout-cache -q -f -u -a

for that instead (which will also throw away any partial merges).

So for the "switch" case, you might make it be something like

	if [ ! -f .git/refs/heads/$1 ]
	then
		echo "Branch '$1' not found"
		exit 1;
	fi
	git-read-tree -m -u HEAD "heads/$1" && ln -sf refs/heads/$1 .git/HEAD

which should do the right thing.

Totally untested, of course ;)

[ But the two-tree read-tree is definitely not untested: this is how we 
  do a safe "fast forward" in the git-resolve-script, which really ends up 
  being the exact same thing: it "switches" from one head to another ].

		Linus
