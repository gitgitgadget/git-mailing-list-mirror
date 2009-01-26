From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v1 0/6] git checkout: more cleanups, optimisation,
 less lstat() calls
Date: Mon, 26 Jan 2009 22:17:11 +0100
Message-ID: <1233004637-15112-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 22:19:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRYrD-0000UB-G4
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 22:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbZAZVRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 16:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752229AbZAZVRW
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 16:17:22 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:62233 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbZAZVRV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 16:17:21 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KE3003TKKGVXC90@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Mon, 26 Jan 2009 22:17:19 +0100 (CET)
Received: from localhost.localdomain ([80.203.78.144])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KE3001KZKGTUNC0@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Mon, 26 Jan 2009 22:17:19 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107281>

Here is 6 small patches which should further improve the time it take
to do 'git checkout'.  After the 6 patches, the numbers from the 'git
checkout -q my-v2.6.27' test, should now look like this:

TOTAL        136752 100.000% OK:124567 NOT: 12185   8.641698 sec   63 usec/call
lstat64       55502  40.586% OK: 49122 NOT:  6380   2.463762 sec   44 usec/call
    strings   55502 tot  30163 uniq   1.840 /uniq   2.463762 sec   44 usec/call
    files     47122 tot  23813 uniq   1.979 /uniq   2.070486 sec   44 usec/call
    dirs       2000 tot   1436 uniq   1.393 /uniq   0.087281 sec   44 usec/call
    errors     6380 tot   5187 uniq   1.230 /uniq   0.305995 sec   48 usec/call
                  4   0.007% OK:     3 NOT:     1  "arch/sh/boards"
                  3   0.005% OK:     3 NOT:     0  ".git/HEAD"
                  3   0.005% OK:     3 NOT:     0  ".git/refs/heads/my-v2.6.27"
                  3   0.005% OK:     3 NOT:     0  ".gitignore"
                  3   0.005% OK:     3 NOT:     0  ".mailmap"
                  3   0.005% OK:     3 NOT:     0  "CREDITS"
                  3   0.005% OK:     3 NOT:     0  "Documentation"
                  3   0.005% OK:     3 NOT:     0  "Documentation/00-INDEX"
                  3   0.005% OK:     3 NOT:     0  "Documentation/ABI/testing/sysfs-block"
                  3   0.005% OK:     3 NOT:     0  "Documentation/ABI/testing/sysfs-firmware-acpi"
                  3   0.005% OK:     3 NOT:     0  "Documentation/CodingStyle"
                  3   0.005% OK:     3 NOT:     0  "Documentation/DMA-API.txt"
                  3   0.005% OK:     3 NOT:     0  "Documentation/DMA-mapping.txt"
                  3   0.005% OK:     3 NOT:     0  "Documentation/DocBook/Makefile"
                  3   0.005% OK:     3 NOT:     0  "Documentation/DocBook/gadget.tmpl"
                  3   0.005% OK:     3 NOT:     0  "Documentation/DocBook/kernel-api.tmpl"
                  3   0.005% OK:     3 NOT:     0  "Documentation/DocBook/kernel-locking.tmpl"
                  3   0.005% OK:     3 NOT:     0  "Documentation/DocBook/procfs-guide.tmpl"
                  3   0.005% OK:     3 NOT:     0  "Documentation/DocBook/procfs_example.c"
                  3   0.005% OK:     3 NOT:     0  "Documentation/DocBook/rapidio.tmpl"
<snipp>
fstat64       14403  10.532% OK: 14403 NOT:     0   0.179938 sec   12 usec/call

So, since last time, and because of patch 4/6, almost 14 400 of the
lstat() calls has now become fstat() calls, and it seems we have saved
(* 14403 (- 44 12)) = 460 896 microseconds system time because of
this.  I am planing to do a more complete and long-running
/usr/bin/time test, to get real numbers.

With both patch-series, the count of lstat() calls for this particular
test have dropped from 120 954 to 55 502, which is a total reduction
of 65 452 calls or 54%.

Please note that patch 6/6 is only to be a debug patch, to catch a
possible ping-pong situation inside the lstat_cache(), so I think that
it should at _most_ be merged to the pu branch, such that people who
wish to test, can 'git cherry-pick' the patch from there.


Kjetil Barvik (6):
  symlinks.c: small cleanup and optimisation
  remove some memcpy() and strchr() calls inside create_directories()
  cleanup of write_entry() in entry.c
  use fstat() instead of lstat() when we have an opened file
  combine-diff.c: remove a call to fstat() inside show_patch_diff()
  lstat_cache(): print a warning if doing ping-pong between cache types

 combine-diff.c |    5 +-
 entry.c        |  144 ++++++++++++++++++++++++++++++--------------------------
 symlinks.c     |   48 ++++++++++++++-----
 3 files changed, 115 insertions(+), 82 deletions(-)
