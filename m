From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/2] use test-genrandom in tests instead of /dev/urandom
Date: Wed, 11 Apr 2007 13:35:13 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704111333560.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 19:35:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbgj1-0005KR-N5
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 19:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbXDKRfQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 13:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753425AbXDKRfP
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 13:35:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:41470 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367AbXDKRfO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 13:35:14 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGC00GNSGUPJ890@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 11 Apr 2007 13:35:13 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44247>

This way tests are completely deterministic and possibly more portable.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 t/t5301-sliding-window.sh |    2 +-
 t/t5302-pack-index.sh     |    9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/t/t5301-sliding-window.sh b/t/t5301-sliding-window.sh
index a6dbb04..fce77f1 100755
--- a/t/t5301-sliding-window.sh
+++ b/t/t5301-sliding-window.sh
@@ -12,7 +12,7 @@ test_expect_success \
      for i in a b c
      do
          echo $i >$i &&
-         dd if=/dev/urandom bs=32k count=1 >>$i &&
+         test-genrandom "$i" 32768 >>$i &&
          git-update-index --add $i || return 1
      done &&
      echo d >d && cat c >>d && git-update-index --add d &&
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 3371964..b863c17 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -13,15 +13,14 @@ test_expect_success \
      for i in `seq -w 100`
      do
          echo $i >file_$i &&
-         dd if=/dev/urandom bs=8k count=1 >>file_$i &&
+         test-genrandom "$i" 8192 >>file_$i &&
          git-update-index --add file_$i || return 1
      done &&
-     echo 101 >file_101 && tail -c 8k file_100 >>file_101 &&
+     echo 101 >file_101 && tail -c 8192 file_100 >>file_101 &&
      git-update-index --add file_101 &&
      tree=`git-write-tree` &&
      commit=`git-commit-tree $tree </dev/null` && {
 	 echo $tree &&
-	 echo $commit &&
 	 git-ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
      } >obj-list &&
      git-update-ref HEAD $commit'
@@ -78,7 +77,7 @@ test_expect_success \
     '[index v1] 1) stream pack to repository' \
     'git-index-pack --index-version=1 --stdin < "test-1-${pack1}.pack" &&
      git-prune-packed &&
-     test "`git-count-objects`" = "0 objects, 0 kilobytes" &&
+     git-count-objects | ( read nr rest && test "$nr" -eq 1 ) &&
      cmp "test-1-${pack1}.pack" ".git/objects/pack/pack-${pack1}.pack" &&
      cmp "test-1-${pack1}.idx"  ".git/objects/pack/pack-${pack1}.idx"'
 
@@ -116,7 +115,7 @@ test_expect_success \
     'rm -f .git/objects/pack/* &&
      git-index-pack --index-version=2,0x40000 --stdin < "test-1-${pack1}.pack" &&
      git-prune-packed &&
-     test "`git-count-objects`" = "0 objects, 0 kilobytes" &&
+     git-count-objects | ( read nr rest && test "$nr" -eq 1 ) &&
      cmp "test-1-${pack1}.pack" ".git/objects/pack/pack-${pack1}.pack" &&
      cmp "test-3-${pack1}.idx"  ".git/objects/pack/pack-${pack1}.idx"'
 
-- 
1.5.1.777.gd14d3-dirty
