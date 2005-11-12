From: Petr Baudis <pasky@suse.cz>
Subject: Cloning speed comparison, round II
Date: Sat, 12 Nov 2005 16:53:02 +0100
Message-ID: <20051112155302.GD30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Nov 12 16:53:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eaxh7-0005nG-6j
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 16:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVKLPxF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 10:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVKLPxF
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 10:53:05 -0500
Received: from w241.dkm.cz ([62.24.88.241]:42440 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932392AbVKLPxE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 10:53:04 -0500
Received: (qmail 26595 invoked by uid 2001); 12 Nov 2005 16:53:02 +0100
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11692>

  Hello,

  here comes another round of the cloning speed comparison. For the
previous round, see

	6395   F Aug 13 Petr Baudis     ( 2.6K) Cloning speed comparison
	Message-ID: <20050813015402.GC20812@pasky.ji.cz>

  What do we have here:

	git.git: 10267 objects, mostly packed
	cogito.git: 99903903 objects, no packs

  (But please note that compared to the previous round, there are
probably more unpacked objects lying around in the git.git repository
- actually roughly 1000.)

  Latest GIT, latest Cogito, performed by cg-clone to the official
kernel.org hostnames for each transport. 'real' medians from several
tries (number of tries usually at least three, based on their variance):


             rsync   git+ssh(*)   git(**)   http

git.git      0m45s   0m34s        5m30s     4m01s (++)

cogito.git   2m09s   1m54s (+)    4m30s     15m11s (only single run)


(*) git+ssh was to master.kernel.org, which was under significant load
    from some seemingly runaway gzip process, so that slowed things
    down.

(**) The unpacking was slooooooooow yet the load was quite low. This
     should be investigated, the native git fetching is much slower
     than even HTTP.

(+) There was unusually high variance here - the results range from
    0m27s to 2m30s. In all other cases the results for all runs were
    very similiar.

(++) Messy - it stalls at 72 objects, then does seemingly nothing for
     a long while, then requests a pack. Huh? Also, I saw the

	Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/

     line about 100 times for the 72 objects (but never after the pack
     is fetched, at least).


  Conclusion: The GIT protocol has some major problem which is dragging
it down to ridiculous slowness (isn't it supposed to be as fast as git+ssh
or even slightly faster?). rsync unfortunately still provides the fastest
anonymous access. HTTP is better than it was, but especially when fetching
packs, there is a room for improvement - the mysterious stalls should be
eliminated, and it shouldn't get bogged down by repeated silly requests
for alternates lists etc.

  Compared to the last round, HTTP is much faster for unpacked object
stores (thanks to parallel fetching), but much slower for packed object
stores - however that can be caused by more objects lying unpacked now
in the git.git repository. git+ssh (back then clone-pack:ssh) is as
fast as usual - the 0m27s case suggests that it would be much faster
for Cogito if master.kernel.org wouldn't be under load.

  GIT protocol is the great disappointment. And I kind of hoped that I could
push the rsync deprecation further because of the GIT protocol.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
