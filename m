From: Anders Darander <anders.darander@gmail.com>
Subject: Re: git stash takes excessively long when many untracked files present
Date: Tue, 13 Aug 2013 10:11:11 +0000 (UTC)
Message-ID: <loom.20130813T120243-481@post.gmane.org>
References: <20130810214453.GA5719@jtriplet-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 13 12:15:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9BdA-0005zK-Od
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 12:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291Ab3HMKPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 06:15:06 -0400
Received: from plane.gmane.org ([80.91.229.3]:44370 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389Ab3HMKPF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 06:15:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1V9Bd1-0005tK-Gw
	for git@vger.kernel.org; Tue, 13 Aug 2013 12:15:03 +0200
Received: from pc-193-235-91-228.norrkoping.se ([193.235.91.228])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Aug 2013 12:15:03 +0200
Received: from anders.darander by pc-193-235-91-228.norrkoping.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Aug 2013 12:15:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 193.235.91.228 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.95 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232219>

Josh Triplett <josh <at> joshtriplett.org> writes:
> [CCing folks involved in the recent "stash-refuse-to-kill" merge.]
> 
> I keep portions of my home directory in git.  I tried to "git stash"
> some local changes, and it ran for several minutes with no progress.  ps
> showed that it was running "git ls-files --killed", which was taking
> 100% CPU, and occasionally reading the disk very slowly.

I've recently got the same problem, though in this case it's my 
openembedded directory that's giving me those problems. (Having an 
untracked build-directory of quiet a few GB takes some time).

I worked around it by locally patching git-stash:
-------------------------------------------
diff --git a/git-stash.sh b/git-stash.sh
index 85c9e2c..e5a2043 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -263,7 +263,7 @@ save_stash () {
                exit 0
        fi
        if test -z "$untracked$force" &&
-          test -n "$(git ls-files --killed | head -n 1)"
+          test -n "$(git ls-files --killed --directory | head -n 1)"
        then
                say "$(gettext "The following untracked files would NOT be 
saved
                test -n "$GIT_QUIET" || git ls-files --killed | sed 
's/^/\t/'
-------------------------------------------

It seems to work in my extremely limited testing. Though, I'm pretty sure 
that there'll be quite a few error cases... (Especially, as I just made
a naive attempt at patching git-stash, so I could go on with a few other 
things).

Do anyone have any better idea on how to approach this?

> strace shows that git ls-files --killed is doing a full recursive
> enumeration of my entire home directory.  That's a Really Bad Idea:
> 
> ~$ find | wc -l
> 3248997
> ~$ find -type d | wc -l
> 350680
> 
> Not only that, but it also appears to be attempting to stat and open
> several files in every single directory; for instance:
> 
> stat(".ccache/1/3/.git", 0x7fff254bc7a0) = -1 ENOENT (No such file or 
directory)
> open(".ccache/1/3/.git/HEAD", O_RDONLY) = -1 ENOENT (No such file or 
directory)
> stat(".ccache/1/3/.git", 0x7fff254bc770) = -1 ENOENT (No such file or 
directory)
> open(".ccache/1/3/.git/packed-refs", O_RDONLY) = -1 ENOENT (No such file 
or directory)
> 
> (Yes, in that order.)
> 
> I see a lot of room for optimization here.  Most importantly, git
> ls-files --killed really doesn't need to look at any directory entry
> unless something in the index would conflict with it.

I guess that this would be a good optimization. Or, are ls-files --killed 
used in other cases where the current behaviour would be requiered?

Cheers,
Anders
