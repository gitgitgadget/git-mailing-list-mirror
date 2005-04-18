From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: full kernel history, in patchset format
Date: Mon, 18 Apr 2005 10:06:43 +1000
Message-ID: <1113782805.11910.36.camel@localhost.localdomain>
References: <20050416131528.GB19908@elte.hu>
	 <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
	 <1113780698.11910.8.camel@localhost.localdomain>
	 <20050417233936.GV1461@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 02:03:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNJji-0008Nm-EF
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 02:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVDRAHL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 20:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVDRAHL
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 20:07:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12489 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261576AbVDRAHB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 20:07:01 -0400
Received: from [150.203.247.9] (helo=[172.24.3.18])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DNJmz-0003Ph-W3; Mon, 18 Apr 2005 01:06:59 +0100
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050417233936.GV1461@pasky.ji.cz>
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-04-18 at 01:39 +0200, Petr Baudis wrote:
> I think this is bad, bad, bad. If you don't keep around all the
> _commits_, you get into all sorts of troubles - when merging, when doing
> git log, etc. And the commits themselves are probably actually pretty
> small portion of the thing. I didn't do any actual measurement but I
> would be pretty surprised if it would be much more than few megabytes of
> data for the kernel history.

I'm not sure it's that bad -- and everyone already seems perfectly happy
not to have history going back before 2.6.12-rc2. We're not talking
about doing this by _default_ -- we're talking about allowing people to
keep trees pruned if they _want_ to. So I might want to drop history
before 2.6.0 on my laptop, for example.

> Of course an entirely different thing are _trees_ associated with those
> commits. As long as you stay with a simple three-way merge, you
> basically never want to look at trees which aren't heads and which you
> don't specifically request to look at. And the trees and what they carry
> inside is the main bulk of data.

If the trees are absent and you're trying to merge, what do you gain
from having the commit objects? And for the case of 'git log', I
certainly think it's acceptable that you lose out on those parts of
prehistory which you've explicitly removed from your local tree --
that's a feature, not a bug. 

For the special case of removing history before 2.6.12-rc2 from the
trees, I certainly think we can do it by leaving out all the commits,
not just the trees. We can do that easily, but there's no way we can
_add_ that history retrospectively if we omit it in the first place.

For history older than 2.6.12-rc2 I'd suggest that it would be available
in a different place, and absent from the 'main' working tree that
everyone uses by default. The only difference we'd see in the working
tree is that the 2.6.12-rc2 commit -- the oldest commit in that tree --
would actually have an absentee parent instead of appearing to be an
import. And all the sha1 hashes of all subsequent commits would be
different, of course.

To allow pruning of older objects in the general case would be a little
bit harder than that, because as things stand you'd be re-fetching them
every time you rsync from elsewhere -- but that wouldn't really be hard
to fix if we care.

Either way, I think it can probably be done by omitting the commit
objects as well as the trees -- but the important point is that we
_should_ include a 'parent' pointer in the oldest commit of the tree
we're working with, pointing back to the imported history.

-- 
dwmw2

