From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 6/8] ls-tree: work from subdirectory.
Date: Sun, 27 Nov 2005 22:11:58 -0800
Message-ID: <7vpsol1ett.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vy83cdu7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511251953081.13959@g5.osdl.org>
	<7voe477n4i.fsf_-_@assigned-by-dhcp.cox.net>
	<7vpson4tqi.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511260855560.13959@g5.osdl.org>
	<7vr792fnta.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511270949540.13959@g5.osdl.org>
	<20051127182244.GK22159@pasky.or.cz>
	<Pine.LNX.4.64.0511271049090.13959@g5.osdl.org>
	<7vveyd37ic.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511271742520.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 07:21:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgcFE-0004RW-1A
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 07:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVK1GME (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 01:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbVK1GME
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 01:12:04 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:26034 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932072AbVK1GMC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 01:12:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051128061124.VEMJ20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 28 Nov 2005 01:11:24 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511271742520.13959@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 27 Nov 2005 17:46:33 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12850>

Linus Torvalds <torvalds@osdl.org> writes:

> You're right, we need to keep the "-r" behaviour. 
> If you take my last patch and make "ls_flags" default to 0 again, it 
> should work correctly.

Maybe making "-r" the default and resurrecting "-d" to turn it
off would be the approach of least impact (-r becomes a
noiseword), if we take this "ls-tree should parallel ls-files"
idea.

The merge-recursive strategy uses ls-tree without -r with path
specifier to grab the sha1/mode of the three trees involved.
git-cvsexportcommit has the same assumption on how ls-tree
works.  It extracts a single SHA1 for the blob from the commit
object by "ls-tree $commit $blob_path".

With your two patches, they need to do this with "-r".

git-checkout and git-reset use -r to grab the whole tree, so
they are fine either way.  git-svnimport uses -r to read from a
tree (potentially a subtree) all the way down, so this one is
also fine.

So it probably is safer to default ls_options to LS_RECURSIVE,
and use "-d" to restrict it not to recurse.

But after seeing some more examples, I tend to think the current
one that models after how "/bin/ls -a" works in a way that is a
lot easier to understand.  For example, with your two patches
(defaulting to recursive)

	git-ls-tree HEAD

shows everything from the tree.  In order to get prettyprint of
HEAD tree (i.e. single level listing):

	git-ls-tree -d HEAD

is needed.  But there is no way to get the single level with
pathspec with these patches, so:

	cd Documentation && git-ls-tree -d HEAD

would not show the single level of Documentation tree, but just
a single line "tree" object of Documentation tree.  Which means
the way it works from the top and the way it works in a
subdirectory is quite different.

I'll throw in your two patches to the proposed updates branch so
that Porcelain/Browser people can play with it and decide.  I
really love the decrease of number of lines of code, but I am
afraid this would end up breaking things without real merit.
