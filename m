From: Mitchell Blank Jr <mitch@sfgoth.com>
Subject: [ANNOUNCE] gitfs pre-release 0.01
Date: Sat, 25 Jun 2005 21:24:57 -0700
Message-ID: <20050626042457.GB84203@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jun 26 06:16:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DmOYt-0007g8-QE
	for gcvg-git@gmane.org; Sun, 26 Jun 2005 06:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVFZEWq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Jun 2005 00:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVFZEWq
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jun 2005 00:22:46 -0400
Received: from gaz.sfgoth.com ([69.36.241.230]:57792 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S261512AbVFZEWY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2005 00:22:24 -0400
Received: from gaz.sfgoth.com (localhost.sfgoth.com [127.0.0.1])
	by gaz.sfgoth.com (8.12.10/8.12.10) with ESMTP id j5Q4P1i0046587
	for <git@vger.kernel.org>; Sat, 25 Jun 2005 21:25:01 -0700 (PDT)
	(envelope-from mitch@gaz.sfgoth.com)
Received: (from mitch@localhost)
	by gaz.sfgoth.com (8.12.10/8.12.6/Submit) id j5Q4Ov4I046580
	for git@vger.kernel.org; Sat, 25 Jun 2005 21:24:57 -0700 (PDT)
	(envelope-from mitch)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Sat, 25 Jun 2005 21:25:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

GITFS pre-release version 0.01

gitfs is a FUSE-based filesystem for working with source trees stored in
git repositories.  Currently only very basic functionality is implemented
but I'm hoping to expand it into a useful tool for managing many builds
and patches.

OVERALL PLAN
======= ====

Many years ago I had an idea for a filesystem that would make importing
patches and spinning kernel builds far more efficient.  The basic idea was:

  1. Store the unchanged part of the source tree in a shared repository;
     only keep a separate copy of the files and directories that have
     changed.  This would be similar to doing hardlinked source tree copies
     but be even faster -- checking out a new tree would be as quick as
     mkdir'ing a new empty directory.

  2. On top of this, implement a very-fast "diff" operator that only worked
     on changed files

  3. Have ccache-style compiler caching built in.  The filesystem could
     (using some wrapper programs) watch every file read and written to
     by a command like "gcc".  Since it knows what versions of those files
     were read at that time it can know very quickly if any of them changed.

     This saves the "gcc -E" step that ccache must do to determine that it
     can use the cached .o result and should be quite a bit faster.

So basically common operations such as "compile a test kernel with this
fix" and "produce a well-formed patch describing how my current tree
diverges from mainline" become very fast.

Several times I started to implement this idea but every time I got bogged
down in the details of making kernel parts of the file system and such work.
However, two things changed recently:

  1. git came along; I realized that I could use it for the backing data
     store.  Since the linux kernel is already published in git format
     this is especially handy.  Leveraging the existing git code and
     design has sped this up immeasurably.

  2. FUSE (filesystem in userspace) has become more widely available --
     it hasn't make it to mainline yet but it is in the -mm series kernels.
     This made getting started on actual implementation a lot easier.
     Writing a userspace filesystem on top of FUSE is really a joy.

I'm currently calling this project "gitfs" although perhaps that is a
bit of a misnomer since I am _absolutely_not_ trying to implement the
full SCM workflow as a filesystem.  In fact we present hardly any git
metadata like commit messages at all.  Also, I operate on the underlying
objects directly - the index file is never touched.

However, I decided to stick with the "gitfs" name for now -- I'm hoping that
this project can grow to become a useful compliment to the git workflow.
I'm not adverse to giving it a different name if it's an issue, though.

CURRENT STATE
======= =====

This is an early pre-release that only demonstrates the most basic of
functionality -- read-only access to the existing tags and objects in
the git repository.  Still, it's already a somewhat handy tool which is
why I'm announcing it now.

In addition to the missing functionality, currently there is a lot of
performance work to do -- I've been working on getting it functionally
correct first.  Specific performance work I'm planing includes:

  1. Every time we touch a directory (whether lookup or readdir) we parse
     the git tree object into a memory structure which then immediately gets
     thrown away.  There is some infrastructure for caching these objects
     in memory which will solve the problem, but it's not completed yet.

  2. On a related note, I need to do some data structure work -- in some
     places I'm using simple linked lists where I really should be using
     B-tree's or something.  I actually have a lot of this work done already
     but I need to do some heavy testing before I integrate that into my
     tree.

  3. Since we cache the uncompressed file data our read/write operations
     always go straight through to the underlying files.  A large performance
     boost would be available if at open()-time we could tell the kernel
     "here's the file descriptor I opened for you, do I/O to that"  That
     way we could avoid the need for all data to make two user/kernel
     transitions.  However, this would require some extensive work to
     FUSE to implement.

  4. We are currently single threaded; I eventually am planning on adding
     service threads for handling CPU bound tasks.  I want to keep the
     normal filesystem operations single-threaded (they're generally just
     walking in-memory structures so they're fast anyway), but things like
     uncompressing a git object should really be done in separate thread
     so they won't block other filesystem operations.

Finally, since I'm still working on finishing the infrastructure work, please
just consider this a "preview release"  Feel free to play with it, look at
the code, poke it with sticks, etc.  However, the code base is still rapidly
evolving so I probably won't be able to integrate any non-trivial patches yet.
The code also needs things like more comments and clear error messages.

BUILDING GITFS
======== =====

  Gitfs can currently be obtained at:
	http://www.sfgoth.com/~mitch/linux/gitfs/

  Please refer to the included INSTALL file for directions on compiling
  the gitfs binary.

RUNNING GITFS
======= =====

  MOUNT:
    gitfs [-d] [-O object_cache_dir] <gitdir> <mntpoint>
  UMOUNT:
    gitfs -u [-d] <dir>

  Options:

    -d -- debugging mode; we run in the foreground and print very verbose
          messages about what is going on (mostly courtesy of FUSE)

    -O -- specify an object cache directory.  For fast performance we always
	  store the result of decompressing a git "blob" object in a file.
	  This directory is where the decompressed objects live.

    	  This currently defaults to "/tmp/gitfs/ocache"  DO NOT make this
	  the same as your ".git/objects" directory or things will probably
	  become horribly broken!

	  Currently gitfs never removes anything from the ocache so it
	  can grow quite large.  However it's safe to prune files from it
	  (or even blow away the entire tree) while gitfs is running.

Under normal operation gitfs would run in the background until you unmount
it with "gitfs -u"  *However*, we currently always run in "debug" mode so the
gitfs program runs in the foreground.  To shut down you just have to send
it a ctrl-C and it should shut down cleanly.  For now you should only have
to use "gitfs -u" if something goes wrong and it crashes.

EXAMPLE SESSION
======= =======

  $ gitfs ~/git/linux-2.6 /tmp/fuse

  [then in another window]
  $ cd /tmp/fuse
  $ ls -l
  total 0
  dr-xr-xr-x  2 mitch mitch 0 Apr 20 16:38 HEADS
  dr-xr-xr-x  2 mitch mitch 0 May 24 20:32 TAGS
  $ ls -l TAGS
  total 0
  lrwxrwxrwx  1 mitch mitch 43 May  4 16:51 v2.6.11 -> ../5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c
  lrwxrwxrwx  1 mitch mitch 43 May  4 16:51 v2.6.11-tree -> ../5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c
  lrwxrwxrwx  1 mitch mitch 43 May  1 17:16 v2.6.12-rc2 -> ../9e734775f7c22d2f89943ad6c745571f1930105f
  lrwxrwxrwx  1 mitch mitch 43 May  1 17:15 v2.6.12-rc3 -> ../0397236d43e48e821cce5bbe6a80a1a56bb7cc3a
  lrwxrwxrwx  1 mitch mitch 43 May  6 22:22 v2.6.12-rc4 -> ../ebb5573ea8beaf000d4833735f3e53acb9af844c
  lrwxrwxrwx  1 mitch mitch 43 May 24 20:32 v2.6.12-rc5 -> ../06f6d9e2f140466eeb41e494e14167f90210f89d
  $ cd TAGS/v2.6.11
  $ ls
  arch     Documentation  init    MAINTAINERS  README          sound
  COPYING  drivers        ipc     Makefile     REPORTING-BUGS  usr
  CREDITS  fs             kernel  mm           scripts
  crypto   include        lib     net          security
  $ pwd
  /tmp/fuse/TAGS/v2.6.11
  $ /bin/pwd
  /var/tmp/fuse/5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c
  $ ls -l /tmp/fuse
  total 0
  dr-xr-xr-x  18 mitch mitch 352 May  4 16:50 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c
  dr-xr-xr-x   2 mitch mitch   0 Apr 20 16:38 HEADS
  dr-xr-xr-x   2 mitch mitch   0 May 24 20:32 TAGS
