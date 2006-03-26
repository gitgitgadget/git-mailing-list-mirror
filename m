From: Petr Baudis <pasky@ucw.cz>
Subject: Following renames
Date: Sun, 26 Mar 2006 03:49:47 +0200
Message-ID: <20060326014946.GB18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Mar 26 03:49:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNKNx-0007HZ-NV
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 03:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWCZBtj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 20:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWCZBti
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 20:49:38 -0500
Received: from w241.dkm.cz ([62.24.88.241]:50334 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751236AbWCZBti (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 20:49:38 -0500
Received: (qmail 29597 invoked by uid 2001); 26 Mar 2006 03:49:47 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18018>

  Hi,

  so, now that I've put up with the fuzzy rename autodetection (for
now), I'd like to make cg-log auto-follow renames and I'm wondering
about the best implementation (it seems that I won't do without core
Git cooperation). I think it should be possible to implement in a way
so that it has minimal performance impact and therefore I can have it
turned on by default.

  Now I'm using the notorious

	git-rev-list listoffiles | git-diff-tree --stdin

pipeline in cg-log, and I'm wondering about the best way to add rename
detection there.

  In [1], Linus suggests a non-core solution. Unfortunately, it doesn't
fly - it requires at least two git-ls-tree calls per revision which
would bog things down awfully (to roughly half of the original speed).

  But even if git-rev-list reported disappearing files, Cogito would
have to do a lot of complicated bookkeeping in order to properly track
renames in parallel branches - for each 'head' commit at any point of
the history traversal, you need to record a separate set of interesting
files. It would also have to restart git-rev-list at any moment when a
rename happens on any of the head commits. Scales well not.

  An obvious solution would be to have git-diff-tree --follow which
updates its interesting path set based on seen renames, and now that
I've written about non-linear history, it's obvious that it's incorrect.
The other obvious way to go is then to add rename detection support to
git-rev-list, and it's less obvious that this is a dead end too - I
didn't inspect the code myself yet, but for now I trust Linus in [2]
(I didn't quite understand the argument, I guess I need to sleep on it).

  So, any thoughts about how to approach this? Either git-diff-tree
would have to be taught about the heads bookkeeping, or the git-rev-list
hurdles would have to be overcome, or we might have a
git-rev-rename-filter or something, but that feels quite redundant and
might meet with the same problems as git-rev-list.

  == References ==

  [1] Oct 21 <Pine.LNX.4.64.0510211814050.10477@g5.osdl.org>
  [2] Oct 22 <Pine.LNX.4.64.0510221251330.10477@g5.osdl.org>

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
