From: Paul Mackerras <paulus@samba.org>
Subject: Re: Can I have this, pretty please?
Date: Mon, 13 Aug 2007 10:22:48 +1000
Message-ID: <18111.42072.605823.932110@cargo.ozlabs.ibm.com>
References: <85ir7kq42k.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708121140190.30176@woody.linux-foundation.org>
	<854pj4o8k5.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708121246020.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Aug 13 02:23:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKNi2-0007sn-0T
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 02:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934890AbXHMAW7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 20:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934814AbXHMAW6
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 20:22:58 -0400
Received: from ozlabs.org ([203.10.76.45]:39715 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759821AbXHMAW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 20:22:56 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 546B1DDEEA; Mon, 13 Aug 2007 10:22:55 +1000 (EST)
In-Reply-To: <alpine.LFD.0.999.0708121246020.30176@woody.linux-foundation.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55736>

Linus Torvalds writes:

> Well, gitk has certainly had performance problems in the past, they've 
> been fixable. I think this should just be fixed too. And if the rev-list 
> is fast enough, then the gitk fix may well be to just not compute the 
> *whole* history - ie the solution may be as simple as stopping the 
> background job that does all the graph calculations when it is (pick a 
> point at random) something like a thousand commits into the graph, and the 
> user hasn't scrolled down..

I have made a "dev" branch in the gitk.git repository that has some
tweaks to the graph layout algorithm which change the appearance a
bit; specifically it doesn't continue the graph lines downwards until
it has to terminate them with an arrow because the graph is getting
too wide.  Instead, it always terminates them if they are going to be
longer than a certain length (about 100 rows).  Also I made some
changes to reduce the incidence of two lines having a corner at the
same point, for visual clarity.

The point of terminating the graph lines early is that it means gitk
won't have to lay out the whole graph, just the visible bits and a
limited number of rows around that.  So I'm interested to know if
people think it looks OK visually.  (I think it's actually better,
myself.)

The other thing that takes time is reading in the topology for the
previous/next tag computations.  I did a patch that wrote out the
topology to a cache file but I ran into some problems where the cache
includes commits that have gone away since the cache was created.
What I need to do to update the cached information is basically the
equivalent of

	git rev-list --all ^root1 ^root2 ...

where root1, root2, etc. are the commits in the cache that had no
children (and of which all the other commits in the cache are
descendents).  However, git rev-list will barf if those commits no
longer exist.  Currently the only solution I can see is to validate
them one by one with separate invocations of git rev-list or something
(git rev-parse won't do).

Would it be possible to make git rev-list ignore commits that don't
exist if they have a "^" in front of them, i.e. where we're asking for
them to be excluded anyway?  If we can do that (or something
equivalent) then I can make the cache work reliably.  It does speed up
gitk enormously, and the cache file is only about 3MB for the kernel
tree, so it seems well worth while.

Paul.
