From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v5 0/1] git checkout: optimise away lots of lstat() calls
Date: Fri, 09 Jan 2009 20:05:53 +0100
Message-ID: <1231527954-868-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Pete Harlan <pgit@pcharlan.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 09 20:07:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLMhc-0001V6-Vg
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 20:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812AbZAITGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 14:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753481AbZAITGD
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 14:06:03 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:43557 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476AbZAITGA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 14:06:00 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KD700AUFX1YLZ20@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Fri, 09 Jan 2009 20:05:58 +0100 (CET)
Received: from localhost.localdomain ([80.203.29.70])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KD7000MTX1UQ130@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Fri, 09 Jan 2009 20:05:58 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc1.49.g7f705
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105030>

Changes since version 4:

- After looking at the changes in create_directories() inside entry.c
  for some more time, I got the idea to just use the lstat_cache()
  instead of almost use a separate cache implementation of its own.

- To be able to implement that, I had to be able to tell the cache to
  test the full length of input 'name'.  I also had to be able to tell
  the cache to use the stat() function instead of the lstat() function
  for a given prefix length.

- Fixed a missed cache optimisation where you is not able to cache a
  symlink or a none existing directory, but still wants to cache the
  real directory part.  Fixed a second missed cache optimisation where
  the 'name' argument is a (complete) substring of the cache on a path
  component basis.

- The cache can now also return LSTAT_REG for a regular file, but
  please note that it can only cache the directory part of that file.

- Since the changes made to the create_directories() function now is
  small and simple (just had to change an if-test, remove 2 unused
  variables and update the comments), patch 2/2 is gone and included
  into patch 1/1.

- More updates to the comments in the source code.

- Thanks to Pete Harlan for spelling fixes to the commit message!

I think that the patch starts to be in a good shape now, but please
comment on it, even if it is just a rename of a variable/function name
to increase the readability or a spelling fix!

For the fun of it, I did a test with 'git chekcout-index -q --all
--prefix=<a path containing 29 components>' from the my-v2.6.27 Linux
branch, and the savings was really huge: the numbers of lstat() and
stat() calls dropped from 778 145 to 26 674, and the real time also
dropped from 52 to 32 seconds on my laptop!  :-)

-----

I have just started to clone some interesting Linux git trees to watch
the development more closely, and therefore also started to use git. I
noticed that 'git checkout' takes some time, and especially that the
'git checkout' command does lots and lots of lstat() calls.

After some more investigation and thinking, I have made 1 patch and
been able to optimise away over 40% of all lstat() calls in some cases
for the 'git checkout' command.  Also, if you use a large path to the
'--prefix' argument to the 'git checkout-index' command, and you have
lots of files, the savings can be really huge!

The patch is against git master, and the git 'make test' test suite
still passes after the patch.  To document the improvement, below is
some numbers, which compares before and after the patch. To reproduce
the numbers:

- git clone the Linux git tree to be able to get the Linux tags
  'v2.6.25' and 'v2.6.27'.
- git checkout -b my-v2.6.27 v2.6.27
- git checkout -b my-v2.6.25 v2.6.25

Then, when the current branch is 'my-v2.6.25', do:

  strace -o strace_to27 -T git checkout -q my-v2.6.27

And then pretty print the 'strace_to27' file.  Below is the numbers
from the current git version (before the patch).  Notice that we do an
lstat() call on the "arch" directory over 6000 times!

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

Here is the numbers after applying the patch.  Notice how nice the top
20 entries list now looks!

TOTAL      134155 100.000% OK:122102 NOT: 12053  11.069389 sec   83 usec/call
lstat64     69876  52.086% OK: 63491 NOT:  6385   3.410007 sec   49 usec/call
  strings   69876 tot  30163 uniq   2.317 /uniq   3.410007 sec   49 usec/call
  files     61491 tot  28712 uniq   2.142 /uniq   3.023238 sec   49 usec/call
  dirs       2000 tot   1436 uniq   1.393 /uniq   0.085953 sec   43 usec/call
  errors     6385 tot   5189 uniq   1.230 /uniq   0.300816 sec   47 usec/call
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

Comments?


Kjetil Barvik (1):
  more cache effective symlink/directory detection

 builtin-add.c          |    1 +
 builtin-apply.c        |    1 +
 builtin-update-index.c |    1 +
 cache.h                |   24 +++++++-
 diff-lib.c             |    1 +
 entry.c                |   39 +++++-------
 symlinks.c             |  158 +++++++++++++++++++++++++++++++++++-------------
 unpack-trees.c         |    6 +-
 8 files changed, 162 insertions(+), 69 deletions(-)
