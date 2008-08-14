From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t5304-prune: adjust file mtime based on system time rather
 than file mtime
Date: Wed, 13 Aug 2008 19:49:30 -0500
Message-ID: <ubiY6pg8BYUJusLOylTtvFzdFYgkEJy7i2m0bW1TMtF04C0_AUVHwQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 02:50:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTR33-00026L-Md
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 02:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449AbYHNAtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 20:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754551AbYHNAtf
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 20:49:35 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46589 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754424AbYHNAte (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 20:49:34 -0400
Received: by mail.nrlssc.navy.mil id m7E0nVUB000463; Wed, 13 Aug 2008 19:49:31 -0500
X-OriginalArrivalTime: 14 Aug 2008 00:49:31.0178 (UTC) FILETIME=[9CC808A0:01C8FDA7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92300>

test-chmtime can adjust the mtime of a file based on the file's mtime, or
based on the system time. For files accessed over NFS, the file's mtime is
set by the NFS server, and as such may vary a great deal from the NFS
client's system time if the clocks of the client and server are out of
sync. Since these tests are testing the expire feature of git-prune, an
incorrect mtime could cause a file to be expired or not expired incorrectly
and produce a test failure.

Avoid this NFS pitfall by modifying the calls to test-chmtime so that the
mtime is adjusted based on the system time, rather than the file's mtime.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Those are a lot of words to say that my system clock is about a minute off
from my NFS server and it caused this test to fail.

>From looking at how precise the second two test-chmtime()'s are, it seems
like this change is what was originally intended anyway.

-brandon


 t/t5304-prune.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 9fd9d07..771c0a0 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -21,7 +21,7 @@ test_expect_success 'prune stale packs' '
 	orig_pack=$(echo .git/objects/pack/*.pack) &&
 	: > .git/objects/tmp_1.pack &&
 	: > .git/objects/tmp_2.pack &&
-	test-chmtime -86501 .git/objects/tmp_1.pack &&
+	test-chmtime =-86501 .git/objects/tmp_1.pack &&
 	git prune --expire 1.day &&
 	test -f $orig_pack &&
 	test -f .git/objects/tmp_2.pack &&
@@ -39,7 +39,7 @@ test_expect_success 'prune --expire' '
 	git prune --expire=1.hour.ago &&
 	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
 	test -f $BLOB_FILE &&
-	test-chmtime -86500 $BLOB_FILE &&
+	test-chmtime =-86500 $BLOB_FILE &&
 	git prune --expire 1.day &&
 	test $before = $(git count-objects | sed "s/ .*//") &&
 	! test -f $BLOB_FILE
@@ -53,11 +53,11 @@ test_expect_success 'gc: implicit prune --expire' '
 	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
 	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
 	test -f $BLOB_FILE &&
-	test-chmtime -$((86400*14-30)) $BLOB_FILE &&
+	test-chmtime =-$((86400*14-30)) $BLOB_FILE &&
 	git gc &&
 	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
 	test -f $BLOB_FILE &&
-	test-chmtime -$((86400*14+1)) $BLOB_FILE &&
+	test-chmtime =-$((86400*14+1)) $BLOB_FILE &&
 	git gc &&
 	test $before = $(git count-objects | sed "s/ .*//") &&
 	! test -f $BLOB_FILE
-- 
1.6.0.rc2.51.g0dc95
