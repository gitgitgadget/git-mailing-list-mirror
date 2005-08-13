From: Petr Baudis <pasky@suse.cz>
Subject: Cloning speed comparison
Date: Sat, 13 Aug 2005 03:54:02 +0200
Message-ID: <20050813015402.GC20812@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 13 03:55:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3lEE-0007T5-1C
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 03:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbVHMByK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 21:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVHMByK
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 21:54:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:25874 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S932124AbVHMByJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2005 21:54:09 -0400
Received: (qmail 25015 invoked by uid 2001); 13 Aug 2005 01:54:03 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  I've wondered how slow the protocols other than rsync are, and the
(well, a bit dubious; especially wrt. caching on the remote side)
results are:

	git	clone-pack:ssh	25s
	git	rsync		27s
	git	http-pull	47s
	git	dumb-http	54s
	git	ssh-pull	660s

	cogito	clone-pack:ssh	35s (!)
	cogito	rsync		140s
	cogito	ssh-pull	480s
	cogito	http-pull	extrapolated to about an hour!
	cogito	dumb-http	N/A (missing info in the repository)

  (I didn't test the git server protocol, since kernel.org doesn't run
git server and I was too lazy to setup one.)

  The git repository contains one big pack, one small pack and few
standalone objects (5882 objects in total), while cogito is standalone
objects only (9670 objects in total, 8681 reachable).

  The numbers are off by some epsilons, as I didn't bother with multiple
measures, but shouldn't be hugely off for a general comparison. The
network connection has 2048kbit/s download, the other side was
www.kernel.org for HTTP and rsync, and master.kernel.org for ssh.

  Pulling from localhost (128M of RAM, 5M to 30M free - awful, yes):

	cogito	rsync:ssh	150s
	cogito	ssh-pull	120s (but didn't complete, see PS)
	cogito	http-pull	260s
	cogito	clone-pack:ssh	340s

  Anyway, clone-pack is a clear winner for networks (but someone should
re-check that, especially compared to rsync, wrt. server-side file
caching); really cool fast, but not very practical for anonymous access.
Any volunteers for a simple CGI (or gitweb addon) script + HTTP support
in clone-pack? HTTP is certainly the most suitable protocol for
anonymous pulls, so it's a shame it's still that sluggish.

  It is so slow here since it has some very ugly access pattern on the
objects database and my RAM is full so it does not get cached; even on
the servers, it was slower at first - unfortunately, I didn't measure
that, so what's in the top table are second accesses. Still, I would
expect the big repositories to stay mostly in the server cache, so this
isn't that big problem for those, I think.

  PS:
	With the latest git version as of time of writing this:
	$ time cg-clone git+ssh://pasky@localhost/home/pasky/WWW/dev/git/.g cogito
	...
	progress: 5759 objects, 10292457 bytes
	$ time cg-clone http://localhost/~pasky/dev/git/.g cogito
	...
	progress: 8681 objects, 14881571 bytes

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
