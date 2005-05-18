From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] improved delta support for git
Date: Wed, 18 May 2005 00:32:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505180005230.20274@localhost.localdomain>
References: <Pine.LNX.4.62.0505112309480.5426@localhost.localdomain>
 <d6dohe$dql$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 06:39:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYGI7-0004Cy-4i
	for gcvg-git@gmane.org; Wed, 18 May 2005 06:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVEREgh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 00:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVEREfy
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 00:35:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34111 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S262079AbVEREcy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2005 00:32:54 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IGO005NR4MRO9@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 18 May 2005 00:32:51 -0400 (EDT)
In-reply-to: <d6dohe$dql$1@sea.gmane.org>
X-X-Sender: nico@localhost.localdomain
To: Dan Holmsand <holmsand@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 17 May 2005, Dan Holmsand wrote:

> I've been trying out your delta stuff as well. It was a bit
> disappointing at first, but some tweaking payed off in the end...

Cool!

My goal is to provide the mechanism that can be used by a higher level 
implementing the deltafication policy.  I only provided one script as an 
example, but it turns out that you found a way to achieve better space 
saving.  And I bet you that there is probably ways to do even better 
with more exhaustive delta targets.  For example you could try all 
possible combinations on an object list for each file (and let it run 
overnight).

> 1) Too many deltas get too big and/or compress badly.

One thing I've been wondering about is whether gzipping small deltas is 
actually a gain.  For very small files it seems that gzip is adding more 
overhead making the compressed file actually larger.  Might be worth 
storing some deltas uncompressed if the compressed version turns out to 
be larger.

> 2) Trees take up a big chunk of total space.

Tree objects can be deltafied as well, but I didn't had time to script 
it.  A large space saving can be expected there as well, especially for 
changesets that modify only a few files deep down the tree hierarchy.

> Therefore, I tried some other approaches. This one seemed to work
> best:
> 
> 1) I limit the maximum size of any delta to 10% of the size of the new
> version. That guarantees a big saving, as long as any delta is
> produced.

Well, any delta object smaller than its original object saves space, 
even if it's 75% of the original size. But...

> 2) If the "previous" version of a blob is a delta, I produce the new
> delta form the old deltas base version. This works surprisingly well.
> I'm guessing the reason for this is that most changes are really
> small, and they tend to be in the same area as a previous change (as
> in "Commit new feature. Commit bugfix for new feature. Commit fix for
> bugfix of new feature. Delete new feature as it doesn't work...").

... but then the ultimate solution is to try out all possible references 
within a given list.  My git-deltafy-script already finds out the list 
of objects belonging to the same file.  Maybe git-mkdelta should try 
all combinations between them.  This way a deeper delta chain could be 
allowed for maximum space saving.

> 3) I use the same method for all tree objects.

Yup.

> Attached is a patch (against current cogito). It is basically the same
> as yours, Nicolas, except for some hackery to make the above possible.
> I'm sure I've made lots of stupid mistakes in it (and the 10% limit is
> hardcoded right now; I'm lazy).

I will look at it and merge the good stuff.

Thanks for testing!


Nicolas
