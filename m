From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] ls-tree path restriction semantics fixes
Date: Fri, 27 May 2005 20:31:05 -0700
Message-ID: <7v1x7syqkm.fsf@assigned-by-dhcp.cox.net>
References: <20050527120851.GA11823@port.evillabs.net>
	<7vmzqgzg8a.fsf@assigned-by-dhcp.cox.net>
	<1117221986.11542.29.camel@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 05:29:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dbs0U-0005OA-3Z
	for gcvg-git@gmane.org; Sat, 28 May 2005 05:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVE1DbK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 23:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVE1DbK
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 23:31:10 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:29695 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261700AbVE1DbH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 23:31:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050528033104.VLUY8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 23:31:04 -0400
To: Jason McMullan <jason.mcmullan@timesys.com>
In-Reply-To: <1117221986.11542.29.camel@jmcmullan.timesys> (Jason McMullan's
 message of "Fri, 27 May 2005 15:26:25 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JM" == Jason McMullan <jason.mcmullan@timesys.com> writes:

JM>   git-ls-tree reporting just the tree's hash is valid, because if
JM> you want everything in that tree, you can just do:

JM> git-ls-tree `git-ls-tree HEAD path/dir | (read m t h n; echo $h)`

JM>   I don't see the problem there.

I do not see the problem either in Turing sense, but that is
like saying you could code anything given an assembler.  There
is a difference between being possible and being practical.

I do think the current behaviour is broken, so I think we are in
half agreement.  What I think is the cleanest would be to make
"git-ls-tree $tree" behave similarly to what "/bin/ls -a" does.
Then we have various combination of options, and also path
arguments, to think about.  How about doing something like this?

 - Running without any paths.

   "git-ls-tree $tree" shows everything first level, just like
   "/bin/ls -a" shows everything in cwd.  There is nothing to
   fix here.

 - Running with paths.

   "git-ls-tree $tree path1 path2..." should show path$n if
   path$n is not a tree and everything under path$n including
   path$n itself if path$n is a tree, just like the way "/bin/ls
   -a path1 path2..." works.  There is major breakage here as
   you pointed out with your "git-ls-tree $tree t" vs
   "git-ls-tree $tree t t" example.

 - Recursive behaviour without paths.

   "git-ls-tree -r $tree" should show everything recursively,
   just like what "/bin/ls -a -R" does.  There is nothing to
   fix.

 - Recursive behaviour with paths.

   "git-ls-tree -r $tree path1 path2..." should show everything
   recursively under path$n, just like what "/bin/ls -a -R path1
   path2..." does.  Again this is not how it currently works as
   you pointed out.

 - With paths but not descending into them.

   "git-ls-tree -d $tree path1 path2..." should show only the
   named path$n even when path$n is a tree, just like what
   "/bin/ls -a -R -d path1 path2..." does.  This is what is
   missing from today's git-ls-tree.

