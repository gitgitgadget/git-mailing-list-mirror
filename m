From: Junio C Hamano <junkio@cox.net>
Subject: Re: Dump http servers still slow?
Date: Sat, 30 Jul 2005 23:51:10 -0700
Message-ID: <7v1x5ftqn5.fsf@assigned-by-dhcp.cox.net>
References: <1122584423.12374.11.camel@localhost.localdomain>
	<7vy87qpcwg.fsf@assigned-by-dhcp.cox.net>
	<1122645821.4263.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Darrin Thompson <darrint@progeny.com>, barkalow@iabervon.org
X-From: git-owner@vger.kernel.org Sun Jul 31 08:51:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dz7fN-0004uA-3D
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 08:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263200AbVGaGvN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 02:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVGaGvN
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 02:51:13 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:64418 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261788AbVGaGvM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2005 02:51:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050731065109.FDKA1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 31 Jul 2005 02:51:09 -0400
To: git@vger.kernel.org
In-Reply-To: <1122645821.4263.6.camel@localhost.localdomain> (Darrin Thompson's message of "Fri, 29 Jul 2005 09:03:41 -0500")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Darrin Thompson <darrint@progeny.com> writes:

> 1. Pack files should reduce the number of http round trips.
> 2. What I'm seeing when I check out mainline git is the acquisition of a
> single large pack, then 600+ more recent objects. Better than before,
> but still hundreds of round trips.

I've packed the git.git repository, by the way.  It has 43
unpacked objects totalling 224 kilobytes, so cloning over dumb
http should go a lot faster until we accumulate more unpacked
objects.

Some of you may have noticed that in the proposed updates queue
("pu" branch) I have a couple of commits related to pulling from
a packed dumb http server.  There are two "git fetch http://"
commits to let you pull from such, and another stupid "count
objects" script that you can use to see how many unpacked
objects you have in your repository; the latter is to help
you decide when to repack.

Brave souls may want to try out the dumb http fetch.  For
example, it _should_ do the right thing even if you do the
following:

 $ git clone http://www.kernel.org/pub/scm/git/git.git/ newdir
 $ cd newdir
 $ mv .git/objects/pack/pack-* . ;# even if you unpack packs on your
 $ rm -f pack-*.idx		 ;# end, it should do the right thing.
 $ for pack in pack-*.pack; do
     git-unpack-objects <$pack
     rm -f "$pack"
   done
 $ rm -f .git/refs/heads/pu
 $ git prune ;# lose objects in "pu" but still not in "master"
 $ git pull origin pu
 $ git ls-remote origin |
   while read sha1 refname
   do
       case "$refname" in
       refs/heads/master) echo $sha1 >".git/$refname" ;;
       esac
   done ;# revert master to upstream master
 $ old=$(git-rev-parse master^^^^^^^^^^)
 $ echo "$old" >.git/refs/heads/master ;# rewind further
 $ git checkout -f master
 $ git prune ;# try losing a bit more objects.
 $ git pull origin master
 $ git ls-remote ./.		;# show me my refs
 $ git ls-remote origin		;# show me his refs

Unlike my other shell scripts I usually write in my e-mail
buffer, I have actually run the above ;-).

-jc
