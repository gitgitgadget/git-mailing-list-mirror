From: Petr Baudis <pasky@suse.cz>
Subject: Three-way merge with the index as one way
Date: Thu, 3 Nov 2005 01:34:23 +0100
Message-ID: <20051103003423.GH1431@pasky.or.cz>
References: <20051015174103.GA2609@tumblerings.org> <7vu0fimzhn.fsf@assigned-by-dhcp.cox.net> <20051015192720.GA11364@tumblerings.org> <7v8xwummtm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zack Brown <zbrown@tumblerings.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 01:35:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXT3s-0006NA-1S
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 01:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbVKCAe1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 19:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbVKCAe1
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 19:34:27 -0500
Received: from w241.dkm.cz ([62.24.88.241]:10125 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030221AbVKCAe1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 19:34:27 -0500
Received: (qmail 8820 invoked by uid 2001); 3 Nov 2005 01:34:23 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xwummtm.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11060>

Dear diary, on Sun, Oct 16, 2005 at 12:34:29AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> I suspect cg-Xlib::tree_timewarp, which currently does
> "git-read-tree -m $branch" followed by diff-tree piped to xargs,
> can be taught to use "git-read-tree -m -u $base $branch" (and
> lose the git-checkout-index -f -a immediately after that while
> we are at it), but I do not do Porcelain, so...

This is problematic, since with our current way of tree timewarping,
restoring local changes to files which got deleted will make patch error
out, etc.

I wanted to make tree_timewarp do three-way merge, but didn't figure a
good way to do it. First, what do I want - a two-way merge between two
trees, which will however respect (not die on) local changes in the
working tree.

One approach is to take the working tree, construct a tree object from
it and then run the regular three-way merge on that. But that is a waste
of time and pollutes the database with nonsensical objects. The
advantage is that I can reuse the per-file merge resolution script
without any changes.

However, this seems to be the only way to do this right now. What do you
think about the disadvantages - should we care? A possible alternative I
can imagine is to make a two-way merge mode which somehow records the
conflicts with index back in the index file instead of committing
suicide. Possibly the hex(-1) sha1 might be used for the relevant index
items, meaning "the current working copy". The per-file merge resolution
scripts would have to be tweaked for this then, but it shouldn't be that
hard; what I found hard was actually getting my head 'round the weird
git-read-tree code recording the stages in the index file. ;-)

Opinions?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
