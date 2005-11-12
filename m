From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 4/5] Overhaul of changeset application
Date: Sat, 12 Nov 2005 12:49:28 -0800
Message-ID: <20051112204928.GA31205@mail.yhbt.net>
References: <20051112092336.GA16218@Muzzle> <20051112092533.GB16218@Muzzle> <20051112092721.GC16218@Muzzle> <20051112092920.GD16218@Muzzle> <20051112093045.GE16218@Muzzle> <46a038f90511120407y68031071v15244175f6458c54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 12 21:50:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb2Jh-0006jv-Jc
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 21:49:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVKLUtb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 15:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbVKLUtb
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 15:49:31 -0500
Received: from hand.yhbt.net ([66.150.188.102]:21904 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S964798AbVKLUta (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 15:49:30 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id A590F7DC0C1; Sat, 12 Nov 2005 12:49:28 -0800 (PST)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90511120407y68031071v15244175f6458c54@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11706>

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> Eric,
> 
>  I'd actually like to improve the script to handle directory renames
> and file modes correctly so we don't need to ever call the glacially
> slow `tla get` -- I don't think it's that much work, all I need is a
> sample repo. OTOH, if you think (or can convince me) that there are
> more serious problems ahead, perhaps we can have this as an
> alternative import mechanism?

tla get is hardly ever called, I don't think it's called any more than
before, even.  tla replay by far the most common case and still
reasonably fast.  I had to add the -I flag to rsync because it was going
at > 1 patch per second, plenty fast enough for me.

I also had an alternate implementation for using the revision library,
but that was slower than the current strategy because it had to do
two full Arch tree integrity checks for each patch applied.

Even on a hot (fully filled) revlib and all I had to do was tla
library-find + rsync, it ran more slowly, probably because rsync
couldn't take advantage of kernel/fs-level caching when it had to
work on a different directory each time.

Tracking renamed directories (especially when nested subdirectories are
also renamed) is very, very far from pleasant.

> On 11/12/05, Eric Wong <normalperson@yhbt.net> wrote:
> >  - Correctly parse multi-line summary text in patch-logs
> 
> Was this broken!? I'm sure I've imported multiline summaries!

It only got the first summary line when I tried it.  Also, it's possible
for hand-made message bodies to fool archimport if it has "headers"
after the first \n\n.  IIRC, some old tools copied entire logs of merged
changesets into the message body.

-- 
Eric Wong
