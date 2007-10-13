From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-fast-import crashes
Date: Fri, 12 Oct 2007 23:29:16 -0400
Message-ID: <20071013032916.GL27899@spearce.org>
References: <e66701d40710120242p6fc05148hd40d19d295373ac4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Shun Kei Leung <kevinlsk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 13 05:29:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgXh2-0008BR-J4
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 05:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965AbXJMD3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 23:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752337AbXJMD3Y
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 23:29:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48424 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbXJMD3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 23:29:23 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IgXga-00080y-NG; Fri, 12 Oct 2007 23:29:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F14BB20FBAE; Fri, 12 Oct 2007 23:29:16 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <e66701d40710120242p6fc05148hd40d19d295373ac4@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60717>

Shun Kei Leung <kevinlsk@gmail.com> wrote:
> Program received signal EXC_BAD_ACCESS, Could not access memory.
> Reason: KERN_INVALID_ADDRESS at address: 0x64617469
> in_window (win=0x5004d0, offset=3501) at sha1_file.c:701
> 701             off_t win_off = win->offset;
...
> (gdb) print win
> $1 = (struct pack_window *) 0x5004d0
> (gdb) print *win
> $2 = {
>   next = 0x64617461,
>   base = 0x20333936 <Address 0x20333936 out of bounds>,
>   offset = 22523564414626158,
>   len = 1685026675,
>   last_used = 795894075,
>   inuse_cnt = 0
> }

Wow.  There's no way that struct pack_window is valid anymore.
The base isn't a valid address.  The offset cannot possibly be
correct (you don't have that big of a packfile, do you?!

What does `git count-objects -v` give you?  I'm specifically
interested in how many packfiles you have.  The other thing that
may be interesting to see is the value of pack_open_windows and
peak_pack_open_windows (file scope in sha1_file.c).

Then again, maybe that isn't interesting.  This looks like it is
memory corruption (e.g. someone overwriting a free'd segment),
but that sort of memory corruption is very hard to track down.

-- 
Shawn.
