From: Petr Baudis <pasky@ucw.cz>
Subject: Re: I'm missing isofs.h
Date: Thu, 28 Apr 2005 01:51:16 +0200
Message-ID: <20050427235115.GN22956@pasky.ji.cz>
References: <20050426214338.32e9ac27.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 01:46:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQwE7-0004Sz-Fu
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 01:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVD0XvV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 19:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVD0XvV
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 19:51:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:35245 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262103AbVD0XvR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 19:51:17 -0400
Received: (qmail 26608 invoked by uid 2001); 27 Apr 2005 23:51:16 -0000
To: Andrew Morton <akpm@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050426214338.32e9ac27.akpm@osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Apr 27, 2005 at 06:43:38AM CEST, I got a letter
where Andrew Morton <akpm@osdl.org> told me that...
> In a current tree, using git-pasky-0.7:
> 
> bix:/usr/src/git26> cat .git/tags/v2.6.12-rc3 
> a2755a80f40e5794ddc20e00f781af9d6320fafb
> bix:/usr/src/git26> git diff -r v2.6.12-rc3|grep isofs.h
> +#include "isofs.h"
>  #include "zisofs.h"
> +#include "isofs.h"
> +#include "isofs.h"
> +#include "isofs.h"
>  #include "zisofs.h"
> +#include "isofs.h"
> +#include "isofs.h"
> +#include "isofs.h"
> +#include "isofs.h"
> 
> 
> That diff should have included the addition of the new isofs.h, but it
> isn't there.

Ouch.

Well, using -r v2.6.12-rc3: is a workable workaround, but this is a
problem. With the trailing :, you are diffing against your latest
commit, whilst without the trailing :, you are diffing against your
working tree. ;-)

The problem is in how the latter is implemented:

        export GIT_INDEX_FILE=$(mktemp -t gitdiff.XXXXXX)
        cp .git/index $GIT_INDEX_FILE
        read-tree -m $(tree-id "$id1")
        update-cache --refresh
        tree=$(tree-id "$id1")
	diff-cache -r -z $tree | xargs -0 cg-Xdiffdo ...

So, we are recording our adds to the index cache, but here we use a
different one with the adds are not recorded - so diff-cache won't catch
them.

So I fixed this by doing diff-cache --cached and updating the tmp index
by the +- entries. Pushed out, thanks.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
