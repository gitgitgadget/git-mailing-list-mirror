From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v3 0/2] git checkout: optimise away lots of lstat() calls
Date: Wed, 07 Jan 2009 14:24:47 +0100
Message-ID: <1231334689-17135-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 14:27:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKYQv-0002rM-SN
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 14:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757899AbZAGNY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 08:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757885AbZAGNYz
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 08:24:55 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:32924 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757764AbZAGNYx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 08:24:53 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KD300KZTRXFMS90@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Wed, 07 Jan 2009 14:24:51 +0100 (CET)
Received: from localhost.localdomain ([80.202.166.60])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KD30044ARXDDW40@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Wed, 07 Jan 2009 14:24:51 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc1.49.g7f705
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104796>

I have just started to clone some interesting Linux git trees to watch
the development more closely, and therefore also started to use git. I
noticed that 'git checkout' takes some time, and especially that the
'git checkout' command does lots and lots of lstat() calls.

After some more investigation and thinking, I have made 2 patches and
been able to optimise away over 42% of all lstat() calls in some cases
for the 'git checkout' command.  I have not tested other git porcelain
commands for reduced lstat() calls, but I would guess that the more
effective 'lstat_cache()' compared to 'has_leading_symlink_cache()',
should also give better numbers in other cases.

Both patches is against git master, and the git 'make test' test suite
still passes after each patch.

To document the improvement, below is some numbers, which compares
before and after the 2 patches. To reproduce the numbers:

- git clone the Linux git tree to be able to get the Linux tags
  'v2.6.25' and 'v2.6.27'.
- git checkout -b my-v2.6.27 v2.6.27
- git checkout -b my-v2.6.25 v2.6.25

Then, when the current branch is 'my-v2.6.25' do:

  strace -o strace_to27 -T git checkout -q my-v2.6.27

And then you pretty print and collect stats from the 'strace_to27'
file.  If someone wants a copy of the strace_stat.pl script, which I
made/used to do the pretty printing, then give me a hint.

Below is the stats/numbers from the current git version (before the 2
patches).  Notice that we do an lstat() call on the "arch" directory
over 6000 times!

TOTAL      185151 100.000% OK:165544 NOT: 19607  11.136001 sec   60 usec/call
lstat64    120954  65.327% OK:107013 NOT: 13941   5.388727 sec   45 usec/call
  strings  120954 tot  30163 uniq   4.010 /uniq   5.388727 sec   45 usec/call
  files     61491 tot  28712 uniq   2.142 /uniq   2.740520 sec   45 usec/call
  dirs      45522 tot   1436 uniq  31.701 /uniq   1.994448 sec   44 usec/call
  errors    13941 tot   5189 uniq   2.687 /uniq   0.653759 sec   47 usec/call
             6297   5.206% OK:  6297 NOT:     0  "arch"
             4544   3.757% OK:  4544 NOT:     0  "drivers"
             1816   1.501% OK:  1816 NOT:     0  "arch/arm"
             1499   1.239% OK:  1499 NOT:     0  "include"
              912   0.754% OK:   912 NOT:     0  "arch/powerpc"
              764   0.632% OK:   764 NOT:     0  "fs"
              746   0.617% OK:   746 NOT:     0  "drivers/net"
              662   0.547% OK:   662 NOT:     0  "net"
              652   0.539% OK:   325 NOT:   327  "arch/sparc/include"
              636   0.526% OK:   636 NOT:     0  "drivers/media"
              606   0.501% OK:   606 NOT:     0  "include/linux"
              533   0.441% OK:   533 NOT:     0  "arch/sh"
              522   0.432% OK:   260 NOT:   262  "arch/powerpc/include"
              488   0.403% OK:   243 NOT:   245  "arch/sh/include"
              413   0.341% OK:   413 NOT:     0  "arch/sparc"
              390   0.322% OK:   390 NOT:     0  "arch/x86"
              383   0.317% OK:   383 NOT:     0  "Documentation"
              370   0.306% OK:   184 NOT:   186  "arch/ia64/include"
              366   0.303% OK:   366 NOT:     0  "drivers/media/video"
              348   0.288% OK:   173 NOT:   175  "arch/arm/include"

Here is the stats/numbers after applying the 2 patches.  Notice how
nice the top 20 entries list now looks!

TOTAL      133655 100.000% OK:121615 NOT: 12040  10.429999 sec   78 usec/call
lstat64     69603  52.077% OK: 63218 NOT:  6385   3.419920 sec   49 usec/call
  strings   69603 tot  30163 uniq   2.308 /uniq   3.419920 sec   49 usec/call
  files     61491 tot  28712 uniq   2.142 /uniq   3.034869 sec   49 usec/call
  dirs       1727 tot   1164 uniq   1.484 /uniq   0.075681 sec   44 usec/call
  errors     6385 tot   5189 uniq   1.230 /uniq   0.309370 sec   48 usec/call
                4   0.006% OK:     4 NOT:     0  ".gitignore"
                4   0.006% OK:     4 NOT:     0  ".mailmap"
                4   0.006% OK:     4 NOT:     0  "CREDITS"
                4   0.006% OK:     4 NOT:     0  "Documentation/00-INDEX"
                4   0.006% OK:     4 NOT:     0  "Documentation/ABI/testing/sysfs-block"
                4   0.006% OK:     4 NOT:     0  "Documentation/ABI/testing/sysfs-firmware-acpi"
                4   0.006% OK:     4 NOT:     0  "Documentation/CodingStyle"
                4   0.006% OK:     4 NOT:     0  "Documentation/DMA-API.txt"
                4   0.006% OK:     4 NOT:     0  "Documentation/DMA-mapping.txt"
                4   0.006% OK:     4 NOT:     0  "Documentation/DocBook/Makefile"
                4   0.006% OK:     4 NOT:     0  "Documentation/DocBook/gadget.tmpl"
                4   0.006% OK:     4 NOT:     0  "Documentation/DocBook/kernel-api.tmpl"
                4   0.006% OK:     4 NOT:     0  "Documentation/DocBook/kernel-locking.tmpl"
                4   0.006% OK:     4 NOT:     0  "Documentation/DocBook/procfs-guide.tmpl"
                4   0.006% OK:     4 NOT:     0  "Documentation/DocBook/procfs_example.c"
                4   0.006% OK:     4 NOT:     0  "Documentation/DocBook/rapidio.tmpl"
                4   0.006% OK:     4 NOT:     0  "Documentation/DocBook/s390-drivers.tmpl"
                4   0.006% OK:     4 NOT:     0  "Documentation/DocBook/uio-howto.tmpl"
                4   0.006% OK:     4 NOT:     0  "Documentation/DocBook/videobook.tmpl"
                4   0.006% OK:     4 NOT:     0  "Documentation/DocBook/writing_usb_driver.tmpl"

Note that the overall used system time as recorded from 'strace -T',
does not drop so much that the reduced lstat() time should indicate
for _this_ particular test run.  This is because now each unlink()
call takes much more time, at least for me on an slow ide disk (using
ext3) on a laptop.

A simple test gives me an overall improvement of 2.937 seconds: real
time drops from 28.195s (best of 5 runs with 'time git ...'), to
25.381s (best of 5 runs).

I have also noticed that inside the unlink_entry() function in file
unpack-trees.c, one could often end up calling rmdir() lots and lots
of times on none-empty directories.  Maybe one should schedule each
directory for removal by an appropriate function, and then at the end
call a new function to clean all the directories at once?

Comments?

----
  Changes since v2:
  = inside patch 1/2
      [[Following is updates after comments from Linus Torvalds - Thanks!]]
    - simplified the interface: introduce 2 static inline functions
      has_symlink_leading_path() and has_symlink_or_noent_leading_path()
    - similar, introduce 2 defines: clear_symlink_cache() and
      clear_symlink_or_noent_cache()
    - reorganise the patches: previous patch 2/4 and 4/4 is put into
      this one
    - update the commit message accordingly
    - keep the symlinks.c file
  = inside patch 2/2
    - was patch 3/4 in v2
    - always null terminate the dirs_path array
    - update the patch with some of the comments regarding patch 1/4
      from Junio C Hamano

  Changes since v1:
  = inside patch 1/4
    - always null terminate the cache_path array
    - added a paragraph to the commit message for this patch
    - small cleanup on 2 comments, and a small line indentation change
      [[Following is updates after comments from Junio C Hamano - Thanks!]]
    - removed the 'static inline update_path_cache()' function
    - replaced the else-part of the above inline function with a call
      to the 'clear_lstat_cache()' function.
    - deleted the '|| errno == ENOTDIR' part inside the big while-loop
      inside check_lstat_cache(), and updated the named BIT-fields
      accordingly
  = inside patch 2/4
    - moved a paragraph out from the commit message for this patch and
      into this cover-letter
      [[Following is updates after comments from Junio C Hamano - Thanks!]]
    - Removed the '|LSTAT_NOTDIR' part from the call to lstat_cache()
      inside function 'check_removed()' inside file diff-lib.c


Kjetil Barvik (2):
  Optimised, faster, more effective symlink/directory detection
  create_directories() inside entry.c: only check each directory once!

 builtin-add.c          |    1 +
 builtin-apply.c        |    1 +
 builtin-update-index.c |    1 +
 cache.h                |   23 +++++++++-
 diff-lib.c             |    1 +
 entry.c                |   82 +++++++++++++++++++++++++-------
 symlinks.c             |  123 +++++++++++++++++++++++++++++++-----------------
 unpack-trees.c         |    6 ++-
 8 files changed, 173 insertions(+), 65 deletions(-)
