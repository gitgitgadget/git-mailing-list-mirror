From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree -M performance regression in 'next'
Date: Sun, 12 Mar 2006 04:28:44 -0800
Message-ID: <7voe0bdeyr.fsf@assigned-by-dhcp.cox.net>
References: <20060311172818.GB32609@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 12 13:29:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIPgw-00024T-E5
	for gcvg-git@gmane.org; Sun, 12 Mar 2006 13:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWCLM2q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 07:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWCLM2q
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 07:28:46 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:15041 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932241AbWCLM2p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Mar 2006 07:28:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060312122722.RSDP15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Mar 2006 07:27:22 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17511>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> I turned out that the rename detection took almost 10 minutes on my
> machine. More specifically,
>
>    git-diff-tree -r -M --diff-filter=R v2.6.12 v2.6.14
>
> takes ~9 minutes with the current 'next'.

I have some updates to "next" tonight.

On my otherwise idle Duron 750 with slow disks, I am getting
something like these:

0.99.9m : 130m virtual, 40m resident, (0major+14205minor)
          67.62user 0.08system 1:15.95elapsed
master  : 130m virtual, 40m resident, (0major+12510minor)
          66.06user 0.07system 1:10.95elapsed
"next"  : 150m virtual, 65m resident, (0major+49858minor)
          51.41user 0.45system 0.57.55elapsed

The result will _not_ exactly match, because the similarity
estimation algorithms are different.

Judging the differences objectively is a bit hard, but my
impression is that the "next" one tends to find more sensible
renames.  To name a few:

* Documentation/dvb/README.dibusb from v2.6.12 seems pretty
  similar to Documentation/dvb/README.dvb-usb from v2.6.14, and
  "next" finds them, but "master" does not.

* "master" says arch/arm/configs/omnimeter_defconfig was
  copy-edited to produce arch/arm/configs/collie_defconfig; The
  diff output shows ~350 new lines and ~270 deleted lines, while
  these files are 800-900 lines long; "next" rejects them.  I
  think this is a border-line case.

* "next" finds Kconfig and Makefile in arch/arm/mach-omap-1/ are
  derived from arch/arm/mach-omap/; manual inspection of these
  files makes me feel that decision is sensible.  "master" does
  not find them.

* Same thing for config.c in arch/m68knommu/platform/68VZ328/;
  found to be derived from arch/m68knommu/platform/68VZ328/de2/ by
  "next" but not by "master".

* Other examples "next" finds but "master" misses include:

  arch/um/kernel/process.c	arch/um/os-Linux/start_up.c
  arch/um/kernel/tt/unmap.c	arch/um/sys-x86_64/unmap.c
  drivers/ide/cris/ide-v10.c	drivers/ide/cris/ide-cris.c
  include/asm-ppc/cputime.h	include/asm-xtensa/cputime.h
  include/asm-ppc64/ioctl.h	include/asm-xtensa/ioctl.h
  include/asm-ppc64/ioctls.h	include/asm-xtensa/ioctls.h
  include/asm-ppc64/mman.h	include/asm-xtensa/mman.h
  include/asm-ppc64/poll.h	include/asm-xtensa/poll.h
  include/asm-ppc64/shmbuf.h	include/asm-xtensa/shmbuf.h
  include/asm-ppc64/socket.h	include/asm-xtensa/socket.h
  include/asm-ppc64/termbits.h	include/asm-xtensa/termbits.h

* The "next" one is not perfect.  There are some quite bad
  choices made by it:

  include/asm-ppc64/timex.h	include/asm-powerpc/bugs.h
  include/asm-ppc64/iSeries/LparData.h	include/linux/i2c-isa.h
