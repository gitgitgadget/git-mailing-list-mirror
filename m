From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: bug: git-repack -a -d produces broken pack on NFS
Date: Sat, 29 Apr 2006 00:27:50 +0200
Message-ID: <20060428222750.GA6462@steel.home>
References: <20060427213207.GA6709@steel.home> <Pine.LNX.4.64.0604271500500.3701@g5.osdl.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 29 00:28:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZbRo-0000nm-CR
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 00:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbWD1W2V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Apr 2006 18:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbWD1W2V
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 18:28:21 -0400
Received: from devrace.com ([198.63.210.113]:55815 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1751777AbWD1W2V (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Apr 2006 18:28:21 -0400
Received: from tigra.home (p54A0512D.dip.t-dialin.net [84.160.81.45])
	by devrace.com (Postfix) with ESMTP id 80EE04CE;
	Fri, 28 Apr 2006 17:28:15 -0500 (CDT)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1FZbRI-0000wp-00; Sat, 29 Apr 2006 00:27:52 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FZbRG-00028C-UY; Sat, 29 Apr 2006 00:27:51 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604271500500.3701@g5.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19287>

Linus Torvalds, Fri, Apr 28, 2006 00:11:13 +0200:
> > NFS server: 2.6.15
> > Client: 2.6.17-rc2
> > mount options: tigra:/home /net/home nfs rw,nosuid,nodev,noatime,vers=3,rsize=8192,wsize=32768,hard,intr,proto=udp,timeo=7,retrans=3,addr=tigra 0 0
> 
> It's repeatable? Can you check if it goes away if your remove "intr"?

It does not go away if I remove intr:

    $ grep 'nfs\>' /proc/mounts
    tigra:/home /net/home nfs rw,nosuid,nodev,noatime,vers=3,rsize=8192,wsize=32768,hard,proto=udp,timeo=7,retrans=3,addr=tigra 0 0

And this is really a broken packfile:

    $ git fsck-objects --full
    git-fsck-objects: error: Packfile .git/objects/pack/pack-9021635f04e29bb9f3313a54124f64589eca5764.pack SHA1 mismatch with itself
    git-fsck-objects: fatal: failed to read delta-pack base object a23816d3e9a1684794c8e5a8f1cc0cce26fb61d8

And I actually was kind of sure about the hardware (like in: "it
worked flawlessly for in the past 2 years"). Until looked today in the
logs and saw this:

    Apr 19 11:49:35 tigra kernel: eth1: tx underrun with maximum tx threshold, txcfg 0xd0f0102e.
    Apr 19 11:49:35 tigra kernel: eth1: Link wake-up event 0xffffffff
    Apr 19 11:49:35 tigra kernel: eth1: PCI error 0xf00000

Well, this is actually not _that_ day. And this:

    Apr 28 23:42:19 tigra kernel: eth1: tx underrun with maximum tx threshold, txcfg 0xd0f0102e.

is not exactly the time of most recent test (the one without the "hard"
mount option). But this _is_ that very same interface, and "PCI error"
looks nasty. Ok, looking at the card... Seats kinda skewed in the
slot, pressing on it... Wow! (lights go out):

    Apr 29 00:13:35 tigra kernel: eth1: Link wake-up event 0x00020b
    Apr 29 00:13:35 tigra kernel: eth1: PCI error 0xf00000
    Apr 29 00:13:39 tigra kernel: NETDEV WATCHDOG: eth1: transmit timed out
    Apr 29 00:13:39 tigra kernel: eth1: Transmit timed out, status 0x000000, resetting...
    Apr 29 00:13:39 tigra kernel: eth1: DSPCFG accepted after 0 usec.
    Apr 29 00:13:39 tigra kernel: eth1: Setting full-duplex based on negotiated link capability.

Redoing test... (Two times only, it's late already):

    $SRC/test2.git$ git repack -a -d
    Generating pack...
    Done counting 235775 objects.
    Deltifying 235775 objects.
     100% (235775/235775) done
    Writing 235775 objects.
     100% (235775/235775) done
    Total 235775, written 235775 (delta 181885), reused 223766 (delta 171462)
    Pack pack-9021635f04e29bb9f3313a54124f64589eca5764 created.
    $SRC/test2.git$ git fsck-objects --full
    dangling blob 419301f9bff67932cb9551f2d8436b277a3022b0
    $SRC/test2.git$ git repack -a -d
    Generating pack...
    Done counting 235775 objects.
    Deltifying 235775 objects.
     100% (235775/235775) done
    Writing 235775 objects.
     100% (235775/235775) done
    Total 235775, written 235775 (delta 181958), reused 235702 (delta 181885)
    Pack pack-9021635f04e29bb9f3313a54124f64589eca5764 created.
    $SRC/test2.git$ git fsck-objects --full
    dangling blob 419301f9bff67932cb9551f2d8436b277a3022b0

Hmm... Ok, apologies everyone, I'm just lazy and stupid.

Still, would be nice not to loose a repository just because
user is an idiot.
