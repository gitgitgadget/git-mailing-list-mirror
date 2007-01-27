From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 11:25:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701271119300.25027@woody.linux-foundation.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org>
 <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
 <45BB9C8B.8020907@fs.ei.tum.de> <Pine.LNX.4.64.0701271103520.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Sat Jan 27 20:29:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAtER-00033G-3y
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 20:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbXA0T24 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 14:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752364AbXA0T24
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 14:28:56 -0500
Received: from smtp.osdl.org ([65.172.181.24]:60103 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353AbXA0T2z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 14:28:55 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0RJPd1m017213
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 27 Jan 2007 11:25:39 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0RJPcSB014848;
	Sat, 27 Jan 2007 11:25:39 -0800
In-Reply-To: <Pine.LNX.4.64.0701271103520.25027@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.484 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37989>



On Sat, 27 Jan 2007, Linus Torvalds wrote:
>
> Quoth Simon 'corecode' Schubert:
> > git log kdelibs/README takes 1:18.  One minute, eighteen seconds.
> > git rev-list and git blame take roughly the same time.

Btw, why do people even think this is "slow"?

Yeah, we should speed it up, just because I think having that large a repo 
will make it more obvious what we can do even better. No question about 
that.

But I actually think that it's perfectly ok for "whole-history" operations 
to be slow. If you want the whole history of a big repository, you 
shouldn't expect it to be totally fast. And you should NOT expect the 
history for "one file" to be any faster than the history for "the whole 
repo".

Because if you do, you have totally missed the whole point of git. It's 
not a "file tracker". It's a *content* tracker. A file doesn't have 
history.

So what you're basically saying is that getting the whole history of KDE 
takes just over a minute. That's pretty damned *fast*. And yes, we can 
make it faster still.

The operations that git has been optimized for is that the size of the 
history shouldn't affect *new* stuff. 

Basically, asking for "git log --since=1.week.ago" should be 
constant-time, regardless of how big the history is (well, it obviously 
depends on how many changes there have been in the last week, but the 
point is that it shouldn't get slower over time). And the git log output 
should "stream", so that you can do 

	git log ..randomfile..

and you'll always get speedy access to the stuff that happened recently, 
and we should *never* have to do the whole history just to get the recent 
changes.

That's why "git blame" is so horrible. It's fundamentally an operation 
that depends on "whole history" and thus cannot scale.

		Linus
