From: arQon <arqon@gmx.com>
Subject: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 08:40:40 +0000 (UTC)
Message-ID: <loom.20111013T094053-111@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 10:45:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REGun-0005dc-6S
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 10:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960Ab1JMIpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 04:45:13 -0400
Received: from lo.gmane.org ([80.91.229.12]:43719 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002Ab1JMIpL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 04:45:11 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1REGua-0005ZL-5b
	for git@vger.kernel.org; Thu, 13 Oct 2011 10:45:09 +0200
Received: from 24-180-45-63.dhcp.crcy.nv.charter.com ([24.180.45.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 10:45:08 +0200
Received: from arqon by 24-180-45-63.dhcp.crcy.nv.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 10:45:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.180.45.63 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Ubuntu/10.04 (lucid) Firefox/3.6.23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183464>

Which, as you'd expect, results in both the on-disk copies and other branches
becoming corrupted.

Tested on git versions 1.7.6 and 1.7.7 (msysgit)

http://benno.id.au/blog/2011/10/01/git-recursive-merge-broken describes
something that sounds similar, but that's supposedly fixed on 1.7.7,
whereas this happens on that as well.

master is a tracking branch, "ttfcon" is the branch I was using to develop
a change. Got to a good point on the branch, merged it in:

$ git co master
$ git merge ttfcon
Updating b9f0c75..6280b7a
Fast-forward
 .gitignore                |    2 ++
 code/renderer/tr_font.cpp |   27 ++++++++-------------------
 2 files changed, 10 insertions(+), 19 deletions(-)

$ git st
# On branch master
# Your branch is ahead of 'origin/master' by 3 commits.

back to the branch to mess around with a couple of things to be sure this
is what i want to push
$ git co ttfcon
do stuff

$ git st
# On branch ttfcon
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       modified:   code/freetype-2.3.11/builds/win32/visualc/freetype.vcproj
#       modified:   code/renderer/tr_font.cpp

so far so good...

$ git ci -m "blah" code/freetype-2.3.11/builds/win32/visualc/freetype.vcproj
 1 files changed, 4 insertions(+), 0 deletions(-)

note that tr_font is locally modified and still *not committed* at this point.

$ git co master
M       code/renderer/tr_font.cpp
Switched to branch 'master'
Your branch is ahead of 'origin/master' by 3 commits.

boom. instead of rejecting the branch change, git switches branches anyway,
and doesn't do anything about the uncommitted changes in the file itself -
meaning they're now effectively "in" master because they're still on disk,
so now the master is poisoned.

"git st" does show the change:

# On branch master
# Changes not staged for commit:
#       modified:   code/renderer/tr_font.cpp

but it's a change I never MADE on this branch (ie master), only on the
other branch.

"git diff" is just as confused as I am:

$ git diff ttfcon
--- a/code/renderer/tr_font.cpp
+++ b/code/renderer/tr_font.cpp
+		// git branch bug

So it's picking up the difference between the two branches, but as far as
the *actual file* goes, master now has a line in it that shouldn't be there.

I'm just trying out git as a possible replacement for SVN, so maybe I'm
mistaken about what "should" happen, but AIUI git switching branches with
uncommitted changes is a bug (and given that it poisoned a branch that I
wasn't on, it certainly looks like one). A couple of days ago it DID complain
when I tried to switch with uncommitted files still present, so it was working
properly then. I have no idea what's made it happy to ignore them now:
nothing's changed that I know of.

At this point, reverting the master with "checkout --" also wipes out the
changes on the other branch. It's like the merge symlinked the two branches
rather than, well, merging them.

If this is user error, and merge is supposed to break the tree like that,
then sorry for wasting your time, but I can't find anything in the docs that
says (or even suggests) that it should, so...

Thanks.
