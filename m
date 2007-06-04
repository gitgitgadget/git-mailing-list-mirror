From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Add git-filter-branch
Date: Mon, 04 Jun 2007 18:34:53 +0200
Organization: eudaptics software gmbh
Message-ID: <46643F2D.7C896CBC@eudaptics.com>
References: <Pine.LNX.4.64.0706030129110.4046@racer.site> <4663BCDA.F1BADDD8@eudaptics.com> <Pine.LNX.4.64.0706041711500.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 04 18:34:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvFVY-0000D4-1w
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 18:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668AbXFDQdw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 12:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756921AbXFDQdw
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 12:33:52 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.24]:60134 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756250AbXFDQdu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 12:33:50 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtp (Exim 4.44)
	id 1HvFV5-0005Uo-Bd; Mon, 04 Jun 2007 18:33:49 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 14FFE6EF; Mon,  4 Jun 2007 18:33:47 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.043
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49115>

Johannes Schindelin wrote:
> 
> Hi,
> 
> On Mon, 4 Jun 2007, Johannes Sixt wrote:
> > I propose that you just get rid of the "seed" stance and don't fail if a
> > commit cannot be mapped - just use it unchanged (don't forget to adjust
> > the map() function, too).
> 
> It is as much for debug reasons as for consistency, so I'd rather keep it.
> One more safety valve for catching bugs.
> 
> > Then you can get rid of -r and use -k to specify everything you want
> > under "--not" in the rev-list.
> 
> Actually, -r is quite useful. It means "start rewriting with this commit",
> and saying "--not <commit>^" is _not_ the same when <commit> is a merge.

But this makes only sense if you have a linear history. Consider this
history, where you want to rewrite the commits that are only on branch
'next':

--A--B--C--D--E--F--G--H       <- master
   \  \  \  \  \  \  \  \
    X--o--o--o--o--o--o--o--o  <- next

How would you go about with the current calling convention? It's
unpractical to say the least:

   git filter-branch -r X -k B -k C -k D ... -k H new-next

If you don't give all the -k, then you get the "assertion failed" error
because the parents B..H are not registered in the commit id map. This
is not something I'd like to try on a history like git.git's.

OTOH, rev-list can easily restrict the commits regardless of how many
merges there are in 'next':

   git rev-list next --not master

Why not use its powers?

-- Hannes
