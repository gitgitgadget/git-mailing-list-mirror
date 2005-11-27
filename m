From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 6/8] ls-tree: work from subdirectory.
Date: Sun, 27 Nov 2005 01:21:53 -0800
Message-ID: <7vr792fnta.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
	<438371E8.2030701@op5.se>
	<Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
	<7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
	<Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
	<43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vy83cdu7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511251953081.13959@g5.osdl.org>
	<7voe477n4i.fsf_-_@assigned-by-dhcp.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 27 10:22:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgIjT-0006Vo-NP
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 10:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbVK0JV4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 04:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbVK0JV4
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 04:21:56 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:54749 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750957AbVK0JVz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2005 04:21:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051127092028.QXLJ17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 27 Nov 2005 04:20:28 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12799>

Linus Torvalds <torvalds@osdl.org> writes:

> And this is just ugly.
>
> git-ls-tree should be rewritten to use a pathspec the same way everybody 
> else does. Right now it's the odd man out: if you do
>
> 	git-ls-tree HEAD divers/char drivers/
>
> it will show the same files _twice_, which is not how pathspecs in general 
> work.

True; that is more or less deliberate.  The behaviour is
modelled after what "/bin/ls -a" does.

> How about this patch? It breaks some of the git-ls-tree tests, but it 
> makes git-ls-tree work a lot more like other git pathspec commands, and it 
> removes more than 150 lines by re-using the recursive tree traversal (but 
> the "-d" flag is gone for good, so I'm not pushing this too hard).

I am all for it if it were just me, and all the more so for its
cleanup value.  I do not think anybody uses "-d" (none of
Cogito, StGIT nor gitweb seems to use it, and I have not seen
Jason McMullan, who wanted to have a way in ls-tree to see just
the object name of a subtree, on the list for a while); I
suspect that nobody would miss that option.

However, this patch changes its behaviour in another way, and
that could impact Porcelains more than the removal of the "-d"
option.  Currently, "git-ls-tree <tree> $dir" shows what
"/bin/ls -a -1 $dir" would show --- the tree for $dir itself and
its immediate children.  This patch changes it to show the tree
for $dir and nothing else.  In effect, "-d" becomes the default
that you cannot turn off, except using "-r" to allow it go all
the way down.

I do not think StGIT is affected; it does not use ls-tree at all.
gitweb is not affected either.  It does not use paths specifier.

Cogito might need a slight adjustment.

 - cg-admin-cat may want to use -r for the first one (${ARGS[@]}
   may name a directory), but that also would change the
   behaviour.  The current one shows only one level, instead of
   going all the way down.

 - cg-log:117 uses ls-tree without -r, but I have a feeling that
   it might be just a bug, even with the current ls-tree; I
   suspect the user would not see things in subdirectories.
   This is only for the initial commit so it may or may not
   matter much.

 - cg-restore already uses ls-tree -r so that would not be
   affected.
