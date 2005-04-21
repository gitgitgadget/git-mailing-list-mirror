From: "Kenneth C. Schalk" <ken@xorian.net>
Subject: Similarities with Vesta
Date: Wed, 20 Apr 2005 23:33:53 -0400 (EDT)
Message-ID: <32982.192.168.1.11.1114054433.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Apr 21 05:30:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOSNy-0003Ag-Sf
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 05:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVDUDeH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 23:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVDUDeH
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 23:34:07 -0400
Received: from xorian.net ([66.92.66.120]:33258 "EHLO xorian.net")
	by vger.kernel.org with ESMTP id S261198AbVDUDdy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 23:33:54 -0400
Received: from eldritch.priv.xorian.net (localhost [127.0.0.1])
	by xorian.net (Postfix) with ESMTP id 2EEE13A6B
	for <git@vger.kernel.org>; Wed, 20 Apr 2005 23:33:53 -0400 (EDT)
Received: from 192.168.1.11
        (SquirrelMail authenticated user ken)
        by localhost with HTTP;
        Wed, 20 Apr 2005 23:33:53 -0400 (EDT)
To: git@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When I first read about git a few days ago, I was pretty surprised by
how similar it seemed to the project I've been working on for several
years.  (Coming off BK, I would have expected a more Darcs/Codeville
kind of change-merging-centric approach.)

Since I don't see any mention of Vesta on this list or lkml, I thought
I should at least join the list and say a few words.  Some of the
similarities which jumped out at me:

  - The Vesta repository is a filesystem.  It was written by a
  "filesystem person" at a systems research lab.  It has a versioning
  system (and a build system) built on top of it.

  - The Vesta repository's backing store is indexed by a hash of file
  contents (though this is a detail mostly hidden from users).

  - The Vesta repository stores complete copies of every source file,
  but only one copy of each (thanks to the hash-based indexing).

  - The Vesta repository's directory structure makes it possible to
  quickly determine what files and directories have changed between
  two versions.  (Actually, I normally just use "diff -r", but I
  hacked up something similar to git's diff-tree in about an hour
  using the Python binding for the repository's API.)

Since this isn't entirely on topic, I'll refrain from going into too
much detail, but I'd be happy to answer any questions.  (There's also
lots of information on http://www.vestasys.org/, multiple published
papers, and a book from Springer-Verlag coming out sometime later this
year.)  I'm hoping that there's some opportunities for the kernel
developers to get some benefit from the considerable research and
development that's gone into Vesta.

A very brief history of Vesta:

  - The project started in the early '90s at DEC's Systems Research
  Center.  In the mid '90s, a from-scratch re-write was done based on
  the research group's experiences with the first prototype.

  - In 1998, the Alpha microprocessor group started using it for chip
  design.  When the Alpha group was acquired by Intel in 2001, Compaq
  (which had acquired DEC) agreed to release Vesta as free software.

  - The former Alpha group continues to use Vesta at Intel, and
  employs two developers to work on maintaining and improving it.

Lastly, since I know git's development has been focused on
performance, here's a quick example of checking in, patching, and
diffing the kernel source in Vesta:

# Create a branch to use for the 2.6.0 sources.

% vbranch -O /vesta/ktest1.xorian.net/kernel/2.6.0
Creating branch /vesta/ktest1.xorian.net/kernel/2.6.0
% vcheckout /vesta/ktest1.xorian.net/kernel/2.6.0
Reserving version /vesta/ktest1.xorian.net/kernel/2.6.0/1
Creating session /vesta/ktest1.xorian.net/kernel/2.6.0/checkout/1
Making working directory /vesta-work/ken/kernel

# Unpack the 2.6.0 source into the working directory.

% cd /vesta-work/ken/kernel
% tar -jxf /tmp/kernel/linux-2.6.0.tar.bz2
31.90s user 7.98s system 46% cpu 1:24.92 total

# Move everything up out of the directory with the version name just
# to simplify the rest of the example.

% mv linux-2.6.0/* .
% rmdir linux-2.6.0

# Take an immutable snapshot of the working copy.  This is basically
# hashing the file contents and taking a snapshot of the directory
# structure.  (The real work happens inside the repository server,
# which is running in the background.)

% vadvance
Advancing to /vesta/ktest1.xorian.net/kernel/2.6.0/checkout/1/1
0.75s user 1.08s system 4% cpu 39.371 total

# Check in the snapshot.  (This is a very fast operation, because all
# it's really doing is giving a new name to the snapshot taken in the
# previous step.)

% cd ..
% vcheckin kernel
Checking in /vesta/ktest1.xorian.net/kernel/2.6.0/1
Deleting /vesta-work/ken/kernel
0.10s user 0.07s system 33% cpu 0.510 total

# Make a new branch for 2.6.1 based on the 2.6.0 version just checked
# in.  (Again, no real work here.)

% vbranch -o /vesta/ktest1.xorian.net/kernel/2.6.0/1 \
  /vesta/ktest1.xorian.net/kernel/2.6.1
Creating branch /vesta/ktest1.xorian.net/kernel/2.6.1
0.01s user 0.01s system 27% cpu 0.073 total

# Apply the 2.6.1 patch.

% cd /vesta-work/ken/kernel
% bzcat /tmp/kernel/patch-2.6.1.bz2 | patch -p1
[...]
bzcat  0.70s user 0.03s system 91% cpu 0.796 total
patch  0.74s user 1.52s system 22% cpu 10.216 total

# Take a snapshot of the changes and check them in.

% vadvance
Advancing to /vesta/ktest1.xorian.net/kernel/2.6.1/checkout/1/1
0.33s user 0.38s system 22% cpu 3.092 total
% cd ..
% vcheckin kernel
Checking in /vesta/ktest1.xorian.net/kernel/2.6.1/1
Deleting /vesta-work/ken/kernel
0.05s user 0.03s system 41% cpu 0.193 total

# Repeat just for some more timing numbers.

% vbranch -o /vesta/ktest1.xorian.net/kernel/2.6.1/1 \
  /vesta/ktest1.xorian.net/kernel/2.6.2
Creating branch /vesta/ktest1.xorian.net/kernel/2.6.2
0.01s user 0.01s system 167% cpu 0.012 total
% vcheckout /vesta/ktest1.xorian.net/kernel/2.6.2
Reserving version /vesta/ktest1.xorian.net/kernel/2.6.2/1
Creating session /vesta/ktest1.xorian.net/kernel/2.6.2/checkout/1
Making working directory /vesta-work/ken/kernel
0.01s user 0.00s system 62% cpu 0.016 total
% cd /vesta-work/ken/kernel
% bzcat /tmp/kernel/patch-2.6.2.bz2 | patch -p1
[...]
bzcat  1.89s user 0.06s system 92% cpu 2.107 total
patch  1.67s user 3.21s system 19% cpu 24.807 total
% vadvance
Advancing to /vesta/ktest1.xorian.net/kernel/2.6.2/checkout/1/1
0.38s user 0.47s system 18% cpu 4.559 total
% cd ..
% vcheckin kernel
Checking in /vesta/ktest1.xorian.net/kernel/2.6.2/1
Deleting /vesta-work/ken/kernel
0.07s user 0.03s system 38% cpu 0.260 total

# Let's see how fast my quick diff-tree clone is.

% cd /vesta/ktest1.xorian.net/kernel
% diff-tree.py 2.6.0/1 2.6.1/1
< 2.6.0/1/CREDITS
> 2.6.1/1/CREDITS
< 2.6.0/1/Documentation/DocBook/kernel-locking.tmpl
> 2.6.1/1/Documentation/DocBook/kernel-locking.tmpl
[...]
< 2.6.0/1/sound/sound_core.c
> 2.6.1/1/sound/sound_core.c
< 2.6.0/1/usr/gen_init_cpio.c
> 2.6.1/1/usr/gen_init_cpio.c
1.50s user 0.44s system 50% cpu 3.871 total
% diff-tree.py 2.6.1/1 2.6.2/1
[...]
1.70s user 0.47s system 47% cpu 4.526 total
% diff-tree.py 2.6.0/1 2.6.2/1
[...]
1.85s user 0.56s system 48% cpu 4.935 total

# /vesta is a mount point for a virtual filesystem provided by the
# repository server.  All the versions created above can be accessed
# directly, so you can use normal diff to generate patches.

% diff -Nru 2.6.0/1 2.6.1/1 > /tmp/kernel/patch-2.6.1-recreated
0.79s user 2.00s system 39% cpu 7.149 total
% diff -Nru 2.6.1/1 2.6.2/1 > /tmp/kernel/patch-2.6.2-recreated
1.40s user 2.51s system 38% cpu 10.070 total

Just a couple final notes on this demonstration:

  - The repository server and all client programs were running on a
  1.7GHz AthlonXP

  - The Vesta tools came from the latest pre-release version
  (12.pre13/5)

Thanks for your time.

--Ken Schalk


