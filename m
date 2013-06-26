From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH 0/1] cygwin: Remove the Win32 l/stat() functions
Date: Wed, 26 Jun 2013 22:39:41 +0100
Message-ID: <51CB5F9D.3060202@ramsay1.demon.co.uk>
References: <51C5FD28.1070004@ramsay1.demon.co.uk> <51C6BC4B.9030905@web.de> <51C8BF2C.2050203@ramsay1.demon.co.uk> <7vy59y4w3r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, mlevedahl@gmail.com,
	dpotapov@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 00:07:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrxsV-0007WZ-5U
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 00:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880Ab3FZWHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 18:07:47 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:60566 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752841Ab3FZWHq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 18:07:46 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 740876F8C45;
	Wed, 26 Jun 2013 23:07:44 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id EDB636F8BBE;
	Wed, 26 Jun 2013 23:07:42 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Wed, 26 Jun 2013 23:07:40 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <7vy59y4w3r.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229063>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> Michael Haggerty and Jeff King have been re-vamping the reference
>> handling code. The failures noted above were provoked by patches
>> in the 'mh/ref-races' branch. At the time I wrote this patch, that
>> branch was only included in 'pu', but I notice that this topic has
>> now progressed to 'next' (see commit 71f1a182).
> 
> I had an impression that up to 98eeb09e (for_each_ref: load all
> loose refs before packed refs, 2013-06-20) that is now in 'next'
> does not agressively use the lstat timestamp of the packed-refs
> file, and the "optional" bit 5d478f5c (refs: do not invalidate the
> packed-refs cache unnecessarily, 2013-06-20), and the one in 'next'
> should be safe with the cheating-lstat.  Isn't it the case?

The next branch (from a couple of days ago, namely commit 4f488db) is
currently broken on cygwin, like so:

  $ cd t
  $ ./t3211-peel-ref.sh -i -v
  
  [ ... ]
  
  ok 7 - refs are peeled outside of refs/tags (old packed)
  
  expecting success:
          git pack-refs --all &&
          cp .git/packed-refs fully-peeled &&
          git branch yadda &&
          git pack-refs --all &&
          git branch -d yadda &&
          test_cmp fully-peeled .git/packed-refs
  
  fatal: internal error: packed-ref cache cleared while locked
  not ok 8 - peeled refs survive deletion of packed ref
  #
  #               git pack-refs --all &&
  #               cp .git/packed-refs fully-peeled &&
  #               git branch yadda &&
  #               git pack-refs --all &&
  #               git branch -d yadda &&
  #               test_cmp fully-peeled .git/packed-refs
  #
  $ cd trash\ directory.t3211-peel-ref/
  $ ls
  actual  base.t  expect
  $ ../../bin-wrappers/git pack-refs --all
  fatal: internal error: packed-ref cache cleared while locked
  $ gdb ../../git.exe
  GNU gdb 6.5.50.20060706-cvs (cygwin-special)
  Copyright (C) 2006 Free Software Foundation, Inc.
  GDB is free software, covered by the GNU General Public License, and you are
  welcome to change it and/or distribute copies of it under certain conditions.
  Type "show copying" to see the conditions.
  There is absolutely no warranty for GDB.  Type "show warranty" for details.
  This GDB was configured as "i686-pc-cygwin"...
  (gdb) b stat_validity_check
  Breakpoint 1 at 0x48a33f: file read-cache.c, line 1965.
  (gdb) run pack-refs --all
  Starting program: /home/ramsay/git/git.exe pack-refs --all
  Loaded symbols for /cygdrive/c/WINDOWS/system32/ntdll.dll
  Loaded symbols for /cygdrive/c/WINDOWS/system32/kernel32.dll
  Loaded symbols for /usr/bin/cygcrypto-0.9.8.dll
  Loaded symbols for /usr/bin/cygwin1.dll
  Loaded symbols for /cygdrive/c/WINDOWS/system32/advapi32.dll
  Loaded symbols for /cygdrive/c/WINDOWS/system32/rpcrt4.dll
  Loaded symbols for /cygdrive/c/WINDOWS/system32/secur32.dll
  Loaded symbols for /usr/bin/cygiconv-2.dll
  Loaded symbols for /usr/bin/cygz.dll
  
  Breakpoint 1, stat_validity_check (sv=0xa611a4,
      path=0x57d98c ".git/packed-refs") at read-cache.c:1965
  1965            if (stat(path, &st) < 0)
  (gdb) n
  1967            if (!sv->sd)
  (gdb) p sv
  $1 = (struct stat_validity *) 0xa611a4
  (gdb) p *sv
  $2 = {sd = 0xa62478}
  (gdb) p sv->sd
  $3 = (struct stat_data *) 0xa62478
  (gdb) p *sv->sd
  $4 = {sd_ctime = {sec = 1372194879, nsec = 671875000}, sd_mtime = {
      sec = 1372194879, nsec = 656250000}, sd_dev = 2899104371,
    sd_ino = 180184, sd_uid = 1005, sd_gid = 513, sd_size = 296}
  (gdb) p st
  $5 = {st_dev = 0, st_ino = 0, st_mode = 33152, st_nlink = 1, st_uid = 0,
    st_gid = 0, st_rdev = 0, st_size = 296, st_atim = {tv_sec = 1372195048,
      tv_nsec = 890625000}, st_mtim = {tv_sec = 1372194879,
      tv_nsec = 656250000}, st_ctim = {tv_sec = 1372194879,
      tv_nsec = 15625000}, st_blksize = 5636381, st_blocks = 1, st_spare4 = {
      10883480, 5757324}}
  (gdb) c
  Continuing.
  fatal: internal error: packed-ref cache cleared while locked
  
  Program exited with code 0200.
  (gdb) quit
  $ ../../test-stat .git/packed-refs
  stat for '.git/packed-refs':
  *dev:   -1395862925, 0
  *ino:   180184, 0
  *mode:  100644 -rw-, 100600 -rw-
   nlink: 1, 1
  *uid:   1005, 0
  *gid:   513, 0
  *rdev:  -1395862925, 0
   size:  296, 296
   atime: 1372195048, 1372195048 Tue Jun 25 22:17:28 2013
   mtime: 1372194879, 1372194879 Tue Jun 25 22:14:39 2013
   ctime: 1372194879, 1372194879 Tue Jun 25 22:14:39 2013
  $
  
Note that, as noted before, (at least) the following tests fail
due to the 'mh/ref-races' branch:

  t3210-pack-refs.sh                        (Wstat: 256 Tests: 16 Failed: 12)
    Failed tests:  4-9, 11-16
    Non-zero exit status: 1
  t3211-peel-ref.sh                         (Wstat: 256 Tests: 8 Failed: 1)
    Failed test:  8
    Non-zero exit status: 1
  t5500-fetch-pack.sh                       (Wstat: 256 Tests: 54 Failed: 1)
    Failed test:  43
    Non-zero exit status: 1

> In any case, if removing the cheating-lstat will improve the
> robustness without hurting performance, I am all for it.

I'm sure it will improve robustness (and help with maintainability),
but as for performance ...

> The less platform specific hacks, the better ;-).

Agreed.

ATB,
Ramsay Jones
