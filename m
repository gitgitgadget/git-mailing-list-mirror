From: Olivier Galibert <galibert@pobox.com>
Subject: Re: [PATCH] write-tree performance problems
Date: Tue, 19 Apr 2005 20:51:25 +0200
Message-ID: <20050419185124.GB86697@dspnet.fr.eu.org>
References: <200504191250.10286.mason@suse.com> <Pine.LNX.4.58.0504191017300.19286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Apr 19 20:48:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNxks-0008Uy-Fp
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 20:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVDSSvf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 14:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVDSSvf
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 14:51:35 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:58896 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S261570AbVDSSvb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 14:51:31 -0400
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id 73D8834D26; Tue, 19 Apr 2005 20:51:25 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504191017300.19286@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2005 at 10:36:06AM -0700, Linus Torvalds wrote:
> In fact, git has all the same issues that BK had, and for the same 
> fundamental reason: if you do distributed work, you have to always 
> "append" stuff, and that means that you can never re-order anything after 
> the fact.

You can, moving a patch around is just a chain of merges.

[Warning, ascii "art" ahead]

A merge is traditionally seen as:

1- Start with (A, B, C... are nodes/trees..., Pn are patches/changesets):

     /--P1->B
    /
   A
    \
     \--P2->C

2- End with:

     /--P1->B
    /
   A----(P1+P2)->D
    \
     \--P2->C

   where D is the merge between B and C with A as common ancestor.

But you can also see the result as:

     /--P1->B--P2--\
    /               \
   A                 D
    \               /
     \--P2->C--P1--/

i.e. you have two patch chains, one being A-P1->B-P2->D and the other
A-P2->C-P1->D.  I.e. you have the two patches P1 and P2 in two
possible patching orders.  But you can do even more amusing.  Start
with a patch chain:

   E--P3-->F--P4-->G

and merge E and G with F as common ancestor.  You'll then get H where
E--P4-->H--P3-->G.  I.e. you inverted two patches in your patch chain.
Or, if you keep H instead of G as your head, you removed P3 from your
patch chain.

Of course you can permute blocs of patches that way by having E, F and
G further away from each other.  You just increase the merge conflict
probability.

That is, I think, the way to do quilt/arch patch handling with safe
distribution and safe backtracing procedures.

  OG.

