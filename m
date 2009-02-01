From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v2 0/7] git checkout: more cleanups, optimisation,
 less lstat() calls
Date: Sun, 01 Feb 2009 21:23:08 +0100
Message-ID: <cover.1233499703.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 01 21:24:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTis7-0001kb-O6
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 21:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbZBAUXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 15:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752837AbZBAUXT
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 15:23:19 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:55724 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbZBAUXS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 15:23:18 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KEE00585LYSCP80@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 01 Feb 2009 21:23:16 +0100 (CET)
Received: from localhost.localdomain ([80.203.78.229])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KEE00JWOLYRG920@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 01 Feb 2009 21:23:16 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107991>

Changes since v1

--- patch 1/7 ---
Kept the "match_len >= cache.len" trick only inside the
longest_match_lstat_cache() function.  Also removed the arguments to
reset_lstat_cache()

--- patch 2/7 ---
Applied all comments from Junio

--- patch 3/7 ---
Kept long format strings in printf() calls, even if source lines get
longer than 80 chars.  The patch touch less source lines because of
this.

--- patch 4/7 ---
Added sanity check to the if-test under which fstat() is called.

--- patch 5/7 ---
Updated commit log message

--- patch 7/7 ---
New patch which reduces the number of rmdir() calls significantly.
When tested with 'git chekcout -q my-v2.6.27' (checkout from Linux
v2.6.25 to v2.6.27), the numbers look like this before this patch:

rmdir          4532   3.314% OK:   174 NOT:  4358   0.263268 sec   58 usec/call
    strings    4532 tot    354 uniq  12.802 /uniq   0.263268 sec   58 usec/call
    errors     4358 tot    347 uniq  12.559 /uniq   0.249116 sec   57 usec/call
                233   5.141% OK:     1 NOT:   232  "include/asm-powerpc"
                187   4.126% OK:     1 NOT:   186  "include/asm-sh"
                172   3.795% OK:     0 NOT:   172  "include/asm-arm"
                169   3.729% OK:     1 NOT:   168  "include/asm-sparc64"
                161   3.553% OK:     1 NOT:   160  "include/asm-sparc"
                144   3.177% OK:     1 NOT:   143  "include/asm-ia64"
                143   3.155% OK:     1 NOT:   142  "include/asm-m68knommu"
                133   2.935% OK:     1 NOT:   132  "include/asm-alpha"
                126   2.780% OK:     1 NOT:   125  "include/asm-s390"
                122   2.692% OK:     1 NOT:   121  "include/asm-v850"

Notice the nice change in the top 10 list after this patch:

rmdir           331   0.255% OK:   174 NOT:   157   0.033435 sec  101 usec/call
    strings     331 tot    331 uniq   1.000 /uniq   0.033435 sec  101 usec/call
    errors      157 tot    157 uniq   1.000 /uniq   0.016300 sec  104 usec/call
                  1   0.302% OK:     0 NOT:     1  "Documentation"
                  1   0.302% OK:     0 NOT:     1  "Documentation/filesystems/configfs"
                  1   0.302% OK:     0 NOT:     1  "Documentation/firmware_class"
                  1   0.302% OK:     1 NOT:     0  "Documentation/hrtimer"
                  1   0.302% OK:     1 NOT:     0  "Documentation/hrtimers"
                  1   0.302% OK:     0 NOT:     1  "Documentation/i2c/busses"
                  1   0.302% OK:     1 NOT:     0  "Documentation/i386"
                  1   0.302% OK:     0 NOT:     1  "Documentation/networking"
                  1   0.302% OK:     0 NOT:     1  "Documentation/power"
                  1   0.302% OK:     0 NOT:     1  "Documentation/powerpc"



Kjetil Barvik (7):
  symlinks.c: small cleanup and optimisation
  remove some memcpy() and strchr() calls inside create_directories()
  cleanup of write_entry() in entry.c
  write_entry(): use fstat() instead of lstat() when file is open
  combine-diff.c: remove a call to fstat() inside show_patch_diff()
  lstat_cache(): print a warning if doing ping-pong between cache types
  unpack-trees.c: introduce schedule_dir_for_removal()

 combine-diff.c |    4 +--
 entry.c        |  106 +++++++++++++++++++++++++++-----------------------------
 symlinks.c     |   67 +++++++++++++++++++++++++----------
 unpack-trees.c |   97 ++++++++++++++++++++++++++++++++++++++-------------
 4 files changed, 172 insertions(+), 102 deletions(-)
