From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add support for changing packed_git_window_size at
	process start time
Date: Fri, 26 Dec 2008 13:36:04 -0800
Message-ID: <20081226213604.GA20356@spearce.org>
References: <1229895454-19498-1-git-send-email-tyler@slide.com> <1229895454-19498-2-git-send-email-tyler@slide.com> <20081221222848.GE17355@spearce.org> <1229927143.14882.17.camel@starfruit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Fri Dec 26 22:37:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGKN7-0004aT-3Z
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 22:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797AbYLZVgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 16:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752757AbYLZVgH
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 16:36:07 -0500
Received: from george.spearce.org ([209.20.77.23]:59125 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743AbYLZVgG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 16:36:06 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5636A38200; Fri, 26 Dec 2008 21:36:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1229927143.14882.17.camel@starfruit>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103952>

"R. Tyler Ballance" <tyler@slide.com> wrote:
> Ah, gotcha, sounds like a good idea. I went ahead and added the change
> and I'm still getting the memory issues. 

:-|
 
> I'm not as familiar with using gdb(1), so I'm having trouble tracking
> down the issue in a limited session, I get loads of issues like the
> following when trying to step through an execution of `git log`
> 
> Is there a means in which I can cause a core dump on an ENOMEM error passed back from mmap(2)? That or a way to impose these limits on the gdb git-subprocess but not on the gdb process?

Look at xmmap in git's code.  All of our mmap calls go through that
function and try to release pack windows if we get an error back
from mmap(), then it retries the mmap request.  xmalloc likewise
does the same thing for malloc requests; xcalloc for calloc, xstrdup
for strdup.  We have a number of these x variant functions to handle
memory allocation.

You might be be able to put a setrlimit call into main() in git.c to
drop the rlimit for Git to a lower limit than it inherited from gdb,
allowing you to start gdb with a much higher ulimit so it doesn't
barf when trying to inspect the git child.
 
-- 
Shawn.
