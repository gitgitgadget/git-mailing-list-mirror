From: Junio C Hamano <junkio@cox.net>
Subject: Re: Users of git-check-files?
Date: Wed, 03 Aug 2005 10:30:21 -0700
Message-ID: <7vy87jc4ia.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.58.0508030944210.3258@g5.osdl.org>
	<Pine.LNX.4.63.0508031849270.24318@wgmdd8.biozentrum.uni-wuerzburg.de>
	<200508031908.22562.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 19:31:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0N4i-0000CU-74
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 19:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbVHCRaZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 13:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbVHCRaZ
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 13:30:25 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:11985 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262362AbVHCRaX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 13:30:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050803173023.PWTB3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 3 Aug 2005 13:30:23 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200508031908.22562.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Wed, 3 Aug 2005 19:08:22 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> ~/tmp/git/clone2> cg-push
> 'refs/heads/branch2': updating from 80e4d426dd4c865b943cc1121b580a946eee921d 
> to 8196067677e3415ce404ea5bc35731ac7d56115d
> fatal: bad object f7e944b036fd00af656b262140c1dc93ceffadb1
> Packing 0 objects
> Unpacking 0 objects

Ahhhh.

Yes, we read from the remote and use old->sha1 when doing the
pack generation.  If we do not have that object (in Josef's
example because it is not something we have pulled yet), then
rev-list has no way to create the necessary pack.

I have a feeling this explains what I've been seeing as well.
The first thing I do before I push is to fetch (but not
merge-pull) from kernel.org, but this happens against
www.kernel.org (to make sure people are seeing what I want them
to see), not against master.  So if I happen to do my push cycle
twice before the things propagate from master to www.kernel.org,
_and_ if I happened to have run git prune in my private
repository just before the second cycle, I may end up not having
the objects referenced by "pu" branch there in my private
repository.
