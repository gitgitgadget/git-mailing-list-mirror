From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC PATCH] cogito --- don't overwrite metadata files in place
 (breaks CoW use)
Date: Wed, 13 Jul 2005 14:05:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507131402210.17536@g5.osdl.org>
References: <20050712190552.GA7178@taniwha.stupidest.org>
 <loom.20050712T233332-364@post.gmane.org> <20050713045338.GA19819@taniwha.stupidest.org>
 <pan.2005.07.13.07.03.26.398212@smurf.noris.de> <20050713185339.GA9260@taniwha.stupidest.org>
 <Pine.LNX.4.58.0507131256490.17536@g5.osdl.org> <20050713204458.GB11403@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Urlichs <smurf@smurf.noris.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 13 23:13:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsoWt-0003AD-Ua
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 23:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262816AbVGMVMQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 17:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbVGMVJU
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 17:09:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10721 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262741AbVGMVGO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2005 17:06:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6DL5ajA020532
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 13 Jul 2005 14:05:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6DL5Zmr004461;
	Wed, 13 Jul 2005 14:05:35 -0700
To: Chris Wedgwood <cw@f00f.org>
In-Reply-To: <20050713204458.GB11403@taniwha.stupidest.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 13 Jul 2005, Chris Wedgwood wrote:
> 
> The complexity I added was to deal with a situation where we have
> 
>   tree1/
> 	.git/HEAD -> refs/head/master
> 
> and I do "cp -Rl tree1 tree2" giving me:
> 
>   tree2/
> 	.git/HEAD -> refs/head/master
> 
>   and .git/refs/head/master is hardlinked between both trees.

AND THAT IS WRONG.

You shouldn't hardlink whole trees. Git will not guarantee that it breaks 
the links.

Right now, if you go a "git commit", and a number of other core git 
operations, it will use ">" to overwrite the HEAD. You're screwed.

> > That is COW-safe, but the thing is, it's incredibly painful for many
> > other operations, and I won't guarantee that git in general is
> > always going to be COW-safe wrt all the git files.
> 
> What operations is this painful for?

Your script was tens of lines of code, and it was BUGGY.

And now you ask what it's painful for?

Guys, if you want to mess up code, the #1 rule is:
 - make complex code to handle insane situations

You're well on your way to do that.

Don't hardlink git trees. It's a bug to do so. It will eventually change 
the other git tree.

Hardlink git _object_ directories. That's a totally different thing.

		Linus
