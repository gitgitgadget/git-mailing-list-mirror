From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Add pack.depth option to git-pack-objects and change default depth to 50
Date: Tue, 8 May 2007 14:09:47 -0400
Message-ID: <20070508180947.GB15796@thunk.org>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net> <11786309073709-git-send-email-tytso@mit.edu> <11786309072612-git-send-email-tytso@mit.edu> <alpine.LFD.0.99.0705081136050.24220@xanadu.home> <20070508163044.GA15796@thunk.org> <Pine.LNX.4.64.0705081848330.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 08 20:10:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlU8T-0001cV-Ap
	for gcvg-git@gmane.org; Tue, 08 May 2007 20:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967033AbXEHSJ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 14:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966987AbXEHSJ7
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 14:09:59 -0400
Received: from THUNK.ORG ([69.25.196.29]:44982 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967033AbXEHSJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 14:09:58 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HlUF4-0003i9-Ub; Tue, 08 May 2007 14:16:55 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HlU8B-00080B-NG; Tue, 08 May 2007 14:09:47 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705081848330.4167@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46606>

On Tue, May 08, 2007 at 06:49:47PM +0200, Johannes Schindelin wrote:
> I'd be happier if that test was done on _at least_ the kernel repo, if not 
> something larger, _plus_ having the numbers on page faults. Swapping can 
> kill performance substantially...

Given how the delta cache works, I really don't think it's going to
matter.  In any case, my laptop has 2gigs of memory, and the kernel
pack file is only 134megs, so you're not going to see any major page
faults....

In any case, here is a quick run:

                git-gc                     git-log -S'object'     
             real/user/sys/min.faults   real/user/sys/min.faults  pack size
w=10,d=10    4:31/257.7/6.2/391711      5:53/326.9/1.7/255156     155940k
w=10,d=30    4:16/242.7/6.5/378193      5:39/331.6/2.3/437283     143144k
w=10,d=50    4:29/250.1/6.7/554493      5:43/334.5/1.9/362574     140080k

You'll note that it's the same thing; git-gc, git-log doesn't change
much, while the pack size decreases as --depth increases.  We're only
seeing at 10% decrease in the pack size, compared to the 20% decrease
with the git repository, but that's probably because of the HTML and
man branches, which no doubt delta compress really, really well.

I can run a full set of benchmarks, varying both --window and --depth,
and also including a non-pickaxe git-log test as requested, but not
until tonight.  I really don't think we'll see any surprises compared
to the earlier runs, though.

After all, if we just stop and think about how the delta caching
works, and how the repacking algorithm works, it's pretty clear that
there shouldn't be any scaling issues with increasing --depth, and
that increasing --window is just going to be painful, and these should
hold true regardless of the size of the repo.

					- Ted
