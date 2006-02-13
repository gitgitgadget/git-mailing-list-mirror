From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fake linear history in a deterministic manner.
Date: Mon, 13 Feb 2006 08:34:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602130819490.3691@g5.osdl.org>
References: <46a038f90602121746v5adb448ej73cc2be6dd3745ce@mail.gmail.com> 
 <7vk6bz3k7e.fsf@assigned-by-dhcp.cox.net> <46a038f90602122158n51fc94a8h2ff2631c16cd28b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 17:35:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8gem-0004z8-AG
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 17:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWBMQe3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 11:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWBMQe3
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 11:34:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28814 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932127AbWBMQe2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 11:34:28 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1DGYKDZ009000
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 13 Feb 2006 08:34:21 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1DGYJ61025400;
	Mon, 13 Feb 2006 08:34:20 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90602122158n51fc94a8h2ff2631c16cd28b5@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16074>



On Mon, 13 Feb 2006, Martin Langhoff wrote:
> 
> In any case, I'm undecided whether to use --topo-order or
> --merge-order. Does it really matter?

Use topo-order.

merge-order is much more expensive to calculate, and doesn't even exist if 
NO_OPENSSL is set.

Anyway, while linearization in general is impossible, I'd suggest a few 
heuristics:

 - you obviously must remember the head of the previous linearization. Any 
   tree choices you made in the past are not something you can change any 
   more for cvs export.

   This may sound obvious, but the fact is, especially if you do the cvs 
   export frequently, and the main maintainer updates the tree in a timely 
   manner, it will limit your choices a LOT. In fact, most of the time 
   you'll have no choice at all: you will have an unambiguous "TRUNK" that 
   is defined by the fact that there is only one linear path from the 
   previous export-head to the current HEAD.

In short, most of the time you won't have any issues in a stable system. 
You'll see a true "fork in the road" choice only when the maintainer 
hasn't pushed his tree to the thing you export in a while, long enough 
that no CVS exporting has taken place over a whole parallel cycle. It's 
probably rare.

So the main issue of "which child to choose" becomes one of the initial 
export, and then just occasionally thereafter. And in that case, there's 
really just one obvious algorithm:

 - simply enumerate the possible paths (not that hard - it's just 
   enumerating a tree once you've generated the graph in memory with child 
   and parent pointers), and just selecting the one with the "longest 
   weighted path".

I say "weighted path", because you might want to consider different 
commits to have different weights. For example, you might want to consider 
merge commits to be less interesting (so weight them as 0.5 commits) in 
order to get as many "real" commits as possible. And you might consider 
commits made by a certain person to be "more TRUNKish", and give them a 
weight of 2, so that you'll be more likely to follow the "maintainer view" 
over any other linearized history.

No other algorithm seems very sane. 

		Linus
