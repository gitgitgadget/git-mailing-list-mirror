From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v6 0/3] git checkout: optimise away lots of lstat() calls
Date: Sun, 11 Jan 2009 14:28:59 +0100
Message-ID: <1231680542-17315-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Ren=E9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 11 14:30:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM0Or-000569-I8
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 14:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685AbZAKN3M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Jan 2009 08:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753593AbZAKN3L
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 08:29:11 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:33547 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbZAKN3J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 08:29:09 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDB00DF56SJDUB0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 11 Jan 2009 14:29:07 +0100 (CET)
Received: from localhost.localdomain ([80.203.78.153])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KDB00HSC6SEFR30@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 11 Jan 2009 14:29:07 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc1.49.g7f705
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105178>

Changes since version 5:

- After comments from Ren=E9 Scharfe, the usage of the lstat_stat()
  function inside entry.c has got it's own wrapper,
  has_dirs_only_path().

- All wrapper functions inside cache.h is moved inside symlink.c, and
  updated to be normal C extern functions (not inline functions).
  Thanks, Ren=E9!

- The clear_lstat_cache() function is deleted, and instead we do an
  safeguard if-test to detect changes to track_flags or
  prefix_len_stat_func.

- Introduce a 'static inline reset_lstat_cache()' function, and make
  an struct of all the cache variables.

- The patch is split up into 3 parts again.

That's all changes this time!  Then some questions:

* Inside commit message for commit c40641b77b0274186fd1b327d5dc3246f814=
aaaf
* ("Optimize symlink/directory detection") Linus Torvalds writes
| [...]
| This can - and should - probably be extended upon so that we
| eventually never do a bare 'lstat()' on any path entries at *all*
| when checking the index, but always check the full path
| carefully. Right now we do not generally check the whole path for
| all our normal quick index revalidation.

  I am not quite sure what Linus is thinking of here, and in
  particular what an (eventually) extended interface should look like.

  I have been thinking of maybe introduce a "git_lstat()" like wrapper
  with the same arguments as the lstat() function, and then when
  possible, retrieve the contents of 'struct stat' from the cache.
  Would this sort of "git_lstat()" like wrapper be useful?

  I think it then could be used to simplify the first 7 lines of the
  check_removed() function inside diff-lib.c, to in some cases be able
  to do 1 instead of 2 calls to lstat(), and maybe similar things at
  other places?

  Should the wrapper return an error if it is able to discover an
  symlink somewhere in the path, like has_symlink_leading_path()
  already does today?

  But, unless someone strongly ask for this "git_lstat()" like wrapper
  to be included inside this patch series, I guess this should be
  future work.

  I hope that the now 3 patches is at least one step in the right
  direction!

| We should also make sure that we're careful about all the
| invalidation, ie when we remove a link and replace it by a directory
| we should invalidate the symlink cache if it matches (and vice versa
| for the directory cache).

  This is an argument for the clear_lstat_cache() function, I guess.
       =20

-----

I have just started to clone some interesting Linux git trees to watch
the development more closely, and therefore also started to use git. I
noticed that 'git checkout' takes some time, and especially that the
'git checkout' command does lots and lots of lstat() calls.

After some more investigation and thinking, I have made 3 patches and
been able to optimise away over 40% of all lstat() calls in some cases
for the 'git checkout' command.  Also, if you use a large path to the
'--prefix' argument to the 'git checkout-index' command, and you have
lots of files, the savings can be really huge!

The 3 patches is against git master, and the git 'make test' test
suite still passes after each patch.  To document the improvement,
below is some numbers, which compares before and after the 3
patches. To reproduce the numbers:

- git clone the Linux git tree to be able to get the Linux tags
  'v2.6.25' and 'v2.6.27'.
- git checkout -b my-v2.6.27 v2.6.27
- git checkout -b my-v2.6.25 v2.6.25

Then, when the current branch is 'my-v2.6.25', do:

  strace -o strace_to27 -T git checkout -q my-v2.6.27

And then pretty print the 'strace_to27' file.  Below is the numbers
from the current git version (before the 3 patches).  Notice that we
do an lstat() call on the "arch" directory over 6000 times!

TOTAL      185151 100.000% OK:165544 NOT: 19607  11.136001 sec   60 use=
c/call
lstat64    120954  65.327% OK:107013 NOT: 13941   5.388727 sec   45 use=
c/call
  strings  120954 tot  30163 uniq   4.010 /uniq   5.388727 sec   45 use=
c/call
  files     61491 tot  28712 uniq   2.142 /uniq   2.740520 sec   45 use=
c/call
  dirs      45522 tot   1436 uniq  31.701 /uniq   1.994448 sec   44 use=
c/call
  errors    13941 tot   5189 uniq   2.687 /uniq   0.653759 sec   47 use=
c/call
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

Here is the numbers after applying the 3 patches.  Notice how nice the
top 20 entries list now looks!

TOTAL      134155 100.000% OK:122102 NOT: 12053  11.069389 sec   83 use=
c/call
lstat64     69876  52.086% OK: 63491 NOT:  6385   3.410007 sec   49 use=
c/call
  strings   69876 tot  30163 uniq   2.317 /uniq   3.410007 sec   49 use=
c/call
  files     61491 tot  28712 uniq   2.142 /uniq   3.023238 sec   49 use=
c/call
  dirs       2000 tot   1436 uniq   1.393 /uniq   0.085953 sec   43 use=
c/call
  errors     6385 tot   5189 uniq   1.230 /uniq   0.300816 sec   47 use=
c/call
                4   0.006% OK:     4 NOT:     0  ".gitignore"
                4   0.006% OK:     4 NOT:     0  ".mailmap"
                4   0.006% OK:     4 NOT:     0  "CREDITS"
                4   0.006% OK:     4 NOT:     0  "Documentation/00-INDE=
X"
                4   0.006% OK:     4 NOT:     0  "Documentation/ABI/tes=
ting/sysfs-block"
                4   0.006% OK:     4 NOT:     0  "Documentation/ABI/tes=
ting/sysfs-firmware-acpi"
                4   0.006% OK:     4 NOT:     0  "Documentation/CodingS=
tyle"
                4   0.006% OK:     4 NOT:     0  "Documentation/DMA-API=
=2Etxt"
                4   0.006% OK:     4 NOT:     0  "Documentation/DMA-map=
ping.txt"
                4   0.006% OK:     4 NOT:     0  "Documentation/DocBook=
/Makefile"
                4   0.006% OK:     4 NOT:     0  "Documentation/DocBook=
/gadget.tmpl"
                4   0.006% OK:     4 NOT:     0  "Documentation/DocBook=
/kernel-api.tmpl"
                4   0.006% OK:     4 NOT:     0  "Documentation/DocBook=
/kernel-locking.tmpl"
                4   0.006% OK:     4 NOT:     0  "Documentation/DocBook=
/procfs-guide.tmpl"
                4   0.006% OK:     4 NOT:     0  "Documentation/DocBook=
/procfs_example.c"
                4   0.006% OK:     4 NOT:     0  "Documentation/DocBook=
/rapidio.tmpl"
                4   0.006% OK:     4 NOT:     0  "Documentation/DocBook=
/s390-drivers.tmpl"
                4   0.006% OK:     4 NOT:     0  "Documentation/DocBook=
/uio-howto.tmpl"
                4   0.006% OK:     4 NOT:     0  "Documentation/DocBook=
/videobook.tmpl"
                4   0.006% OK:     4 NOT:     0  "Documentation/DocBook=
/writing_usb_driver.tmpl"

Comments?


Kjetil Barvik (3):
  lstat_cache(): more cache effective symlink/directory detection
  lstat_cache(): introduce has_symlink_or_noent_leading_path() function
  lstat_cache(): introduce has_dirs_only_path() function

 cache.h        |    2 +
 entry.c        |   34 +++------
 symlinks.c     |  210 ++++++++++++++++++++++++++++++++++++++++++++----=
-------
 unpack-trees.c |    4 +-
 4 files changed, 183 insertions(+), 67 deletions(-)
