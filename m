From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: I'm missing isofs.h
Date: Wed, 27 Apr 2005 17:19:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504271708550.18901@ppc970.osdl.org>
References: <20050426214338.32e9ac27.akpm@osdl.org> <20050427235115.GN22956@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 02:12:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQwdR-0006w2-Qp
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 02:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVD1ARY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 20:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVD1ARY
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 20:17:24 -0400
Received: from fire.osdl.org ([65.172.181.4]:40127 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262118AbVD1ARL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 20:17:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3S0H8s4002920
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Apr 2005 17:17:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3S0H7DJ020071;
	Wed, 27 Apr 2005 17:17:08 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050427235115.GN22956@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Apr 2005, Petr Baudis wrote:
> 
> without the trailing :, you are diffing against your
> working tree. ;-)
> 
> The problem is in how the latter is implemented:
> 
>         export GIT_INDEX_FILE=$(mktemp -t gitdiff.XXXXXX)
>         cp .git/index $GIT_INDEX_FILE
>         read-tree -m $(tree-id "$id1")
>         update-cache --refresh
>         tree=$(tree-id "$id1")
> 	diff-cache -r -z $tree | xargs -0 cg-Xdiffdo ...
> 
> So, we are recording our adds to the index cache, but here we use a
> different one with the adds are not recorded - so diff-cache won't catch
> them.

Umm. 

Why do you create the new index file in the first place?

If you're diffing against the current working tree, you should just use 
your current index file, no?

And to get the difference between an old tree and the current working 
tree, you should just need to do

	diff-cache -r -z $tree

and you're done.

In other words, that temporary index file really isn't needed in the 
"diff-cache" world. It can diff the current index against _any_ old tree.

And together with Junio's stuff from today, you can literally just do

	diff-cache -p $tree

and you're done - it diffs any release "$tree" against the current state.

And if you want to diff against the current head (rather than current
working state), a simple

	diff-tree -p $tree $(cat .git/HEAD)

should do it.

			Linus
