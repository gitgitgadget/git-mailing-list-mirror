From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git merging
Date: Mon, 20 Jun 2005 08:58:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506200844420.2268@ppc970.osdl.org>
References: <20050617175653.GS6957@suse.de> <Pine.LNX.4.58.0506171101450.2268@ppc970.osdl.org>
 <20050617181156.GT6957@suse.de> <Pine.LNX.4.58.0506171132390.2268@ppc970.osdl.org>
 <20050617183914.GX6957@suse.de> <Pine.LNX.4.58.0506171142500.2268@ppc970.osdl.org>
 <42B357D7.6030302@pobox.com> <Pine.LNX.4.58.0506171629320.2268@ppc970.osdl.org>
 <42B36207.3020209@pobox.com> <Pine.LNX.4.58.0506171700200.2268@ppc970.osdl.org>
 <20050620123053.GI15021@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jgarzik@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 17:52:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkOY8-0003wY-EN
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 17:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVFTP4m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Jun 2005 11:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVFTP4m
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jun 2005 11:56:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51613 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261313AbVFTP43 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2005 11:56:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5KFuKjA013524
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 20 Jun 2005 08:56:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5KFuIo7003807;
	Mon, 20 Jun 2005 08:56:19 -0700
To: Jens Axboe <axboe@suse.de>, Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <20050620123053.GI15021@suse.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


[ Daniel put on the To: list to see if he can confirm or deny my theory ]

On Mon, 20 Jun 2005, Jens Axboe wrote:
> 
> axboe@nelson:[.]l/git/linux-2.6-block.git $ git prune
> error: cannot map sha1 file c39ae07f393806ccf406ef966e9a15afc43cc36a

That's the 2.6.11 "tree" object.

> bad sha1 entry '5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c'
> axboe@nelson:[.]l/git/linux-2.6-block.git $ git-fsck-cache 
> error: cannot map sha1 file c39ae07f393806ccf406ef966e9a15afc43cc36a
> bad object in tag 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c
> bad sha1 entry '5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c'
> 
> Running git prune again gives me the same output. What is wrong?

Very interesting. You have my "v2.6.11-tree" tag file pointing the 2.6.11
tree object, but you seem to not have that 2.6.11 tree itself.

Actually, judging from the fact that you got this error _during_ the
prune, maybe you never had it in that repository in the first place?

In particular, if you don't use "rsync", but instead use one of the
"optimized pull" things to create a repository (ie git-http-pull or
git-ssh-pull), I think your newly pulled tree will always miss anything
that isn't a head. And the 2.6.11 tree is a special case: it's a pure
"tree" object without any commit at all pointing to it, just a single tag
that points directly to the tree.

Anyway, the fact that you're missing the original 2.6.11 tree doesn't
really matter, so it's not a huge deal per se. You can re-populate it with
an "rsync -avz --ignore-existing", but clearly something seems to be
wrong.

Daniel: I think git-ssh-pull has problems with any refs that aren't
commits. I also noticed earlier that I can't use git-ssh-push -w to write
a tag - it is apparently unhappy because it would write a "tag" object,
and it only wants to write references to "commit" objects. The same thing
might be true about the special "tag to a tree" object?

Jeff, do you remember (did you check?) if your prune problems might also
have been about the tag to a tree?

		Linus
