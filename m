From: Petr Baudis <pasky@suse.cz>
Subject: Handling renames.
Date: Sat, 22 Oct 2005 02:47:43 +0200
Message-ID: <20051022004743.GN30889@pasky.or.cz>
References: <Pine.LNX.4.64.0510211631400.10477@g5.osdl.org> <20051022003733.GA8351@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 22 02:48:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET7YJ-0008N5-UR
	for gcvg-git@gmane.org; Sat, 22 Oct 2005 02:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbVJVArq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 20:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbVJVArq
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 20:47:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60645 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751284AbVJVArq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 20:47:46 -0400
Received: (qmail 14009 invoked by uid 2001); 22 Oct 2005 02:47:43 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20051022003733.GA8351@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10458>

  (Having Apr 14 flashbacks? Good memory!)

Dear diary, on Sat, Oct 22, 2005 at 02:37:33AM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> told me that...
> But my main concern is - will it be possible to do the rename detection
> here as well? Using --dense instead of explicit diff-tree calls in
> cg-log would be nice optimization, but I was about to add support for
> optional following of renames for cg-log <filename>. That's really
> pretty useful to have, every time I hit the Junio's big scripts rename
> I keep repeating that to myself. ;-) Now when core GIT got the comfort
> of per-file history, I only hope that it will start to annoy you as well.

  After all, this might be as good time to bring this up as any. Heavy
post-1.0 material follows:

  How to track renames? I believe the situation has changed in the last
half a year.  GIT really is a full-fledged SCM by now (at least its
major part code-wise), and I think it's hopefully becoming obvious that
we need to track renames. I actually decided to skip the whole
discussion why so, because we already _do_ concern ourselves with
renames - that's what the cool diff -M gadget does. And people start to
want to use it for all kind of history-digging stuff (not just for nice
diffs between trees).

  So the problem is whether we should make this explicit. diff -M is
only a heuristic and it can go wrong, while it was empirically found
out in other SCMs that people actually don't mind telling their SCM
about renames explicitly - no more than telling it about adds and
removals explicitly. So the user is willing to tell us what precisely
happened and it would be foolish to throw that away and insist on
guessing.  Besides, guessing (and even doing that everytime we go
through the history) is fundamentally slow, orders of magnitude more
than just a tree diff.


  If I convince you that it is worth tracking the renames explicitly,
"how" is already a minor question. One idea of mine was to add an "edge"
object describing the edge between two trees (that's optimized for
flexible use - some people use GIT for really weird things and perhaps
do not use commits at all; edge between two commits would be optimized
for flexibility in case we will later think of some other cool stuff to
track at the edge):

	trees c53f757133bb84a2d87e901c49207e9b7c48e1a6 6bc7aa4f652d0ef49108d9e30a7ea7fbf8e44639
	rename git-pull-script\0git-pull.sh\0
	copy somefile1\0somefile2\0
	rewrite anotherfile1\0anotherfile2\0

  (The "rewrite" line might be controversial. And you might want to
merge this with the delta objects during packing, or do something
similarly clever.)

  Then you could e.g. pass the edge object ID as the second ID on the
parent line:

	parent 99977bd5fdeabbd0608a70e9411c243007ec4ea2 edgeobjectid

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
