From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] t3306,t5304: avoid clock skew issues
Date: Fri,  8 Apr 2011 19:58:53 +0200
Message-ID: <b384c3adae96498eafb2a1faddeaabe85a0f7225.1302285490.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 19:59:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8FxX-0007aZ-5q
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 19:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195Ab1DHR65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 13:58:57 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:47806 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752656Ab1DHR65 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2011 13:58:57 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B874E20930
	for <git@vger.kernel.org>; Fri,  8 Apr 2011 13:58:56 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute4.internal (MEProxy); Fri, 08 Apr 2011 13:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id; s=smtpout; bh=ybLyXWJ3h1jcmigJn+XNl7gbFKM=; b=Crv7OXhLF7xBlSHZ/Xpy0eBWex556SHCDDZYTvVK/v2TF61K30GJ3onwJWlRR9WWxMgjAFCZdhup/HWyuzSyhH+YBI2M0k4xKKrcnMTxFLveuRXF+VMxUHQWsA7zGesIeTBfL3+oqdTAoTGlT4UsGbwMkCo/P10eSUlO8NWz/6g=
X-Sasl-enc: kKkoycWnOQI4p2fSqaLalHZosz93W5AIaOD3tMZLQN16 1302285536
Received: from localhost (p54858E4C.dip0.t-ipconnect.de [84.133.142.76])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 053BE441748;
	Fri,  8 Apr 2011 13:58:55 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.rc0.365.g23929a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171138>

On systems where the local time and file modification time may be out of
sync (e.g. test directory on NFS) t3306 and t5305 can fail because prune
compares times such as "now" (client time) with file modification times
(server times for remote file systems). I.e., these are spurious test
failures.

Avoid this by setting the relevant modification times to the local time.

Noticed on a system with as little as 2s time skew.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I don't think we can safeguard prune itself properly. A filesystem may be out
of time sync sporadically (and produce incorrect time stamps) but then be in
sync when "git prune" is run so that we can't detect it.

 t/t3306-notes-prune.sh |    4 ++++
 t/t5304-prune.sh       |    3 ++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/t/t3306-notes-prune.sh b/t/t3306-notes-prune.sh
index c428217..3114972 100755
--- a/t/t3306-notes-prune.sh
+++ b/t/t3306-notes-prune.sh
@@ -20,6 +20,10 @@ test_expect_success 'setup: create a few commits with notes' '
 	git add file3 &&
 	test_tick &&
 	git commit -m 3rd &&
+	COMMIT=$(git rev-parse HEAD) &&
+	COMMIT_FILE=.git/objects/$(echo $COMMIT | sed "s/^../&\//") &&
+	test -f $COMMIT_FILE &&
+	test-chmtime =+0 $COMMIT_FILE &&
 	git notes add -m "Note #3"
 '
 
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index e2ed13d..d645328 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -14,7 +14,8 @@ add_blob() {
 	BLOB=$(echo aleph_0 | git hash-object -w --stdin) &&
 	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
 	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
-	test -f $BLOB_FILE
+	test -f $BLOB_FILE &&
+	test-chmtime =+0 $BLOB_FILE
 }
 
 test_expect_success setup '
-- 
1.7.5.rc0.365.g23929a
