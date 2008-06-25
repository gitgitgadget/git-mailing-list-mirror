From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 4/4] verify-pack: test for detection of index v2 object CRC
 mismatch
Date: Tue, 24 Jun 2008 23:19:44 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806242319070.2979@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 05:20:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBLYo-00029s-89
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 05:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755023AbYFYDTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 23:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755015AbYFYDTq
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 23:19:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24268 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947AbYFYDTp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 23:19:45 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K3000HLM18WG5A0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 24 Jun 2008 23:19:45 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86204>


Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 t/t5302-pack-index.sh |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 09fd917..ecec591 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -162,4 +162,18 @@ test_expect_success \
     '[index v2] 5) pack-objects refuses to reuse corrupted data' \
     '! git pack-objects test-5 <obj-list'
 
+test_expect_success \
+    '[index v2] 6) verify-pack detects CRC mismatch' \
+    'rm -f .git/objects/pack/* &&
+     git-index-pack --index-version=2 --stdin < "test-1-${pack1}.pack" &&
+     git verify-pack ".git/objects/pack/pack-${pack1}.pack" &&
+     chmod +w ".git/objects/pack/pack-${pack1}.idx" &&
+     dd if=/dev/zero of=".git/objects/pack/pack-${pack1}.idx" conv=notrunc \
+        bs=1 count=4 seek=$((8 + 256 * 4 + `wc -l <obj-list` * 20 + 0)) &&
+     ( while read obj
+       do git cat-file -p $obj >/dev/null || exit 1
+       done <obj-list ) &&
+     err=$(! git verify-pack ".git/objects/pack/pack-${pack1}.pack" 2>&1) &&
+     echo "$err" | grep "CRC mismatch"'
+
 test_done
-- 
1.5.6.56.g29b0d
