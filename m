From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] Add tests for git prune
Date: Sun, 16 Mar 2008 18:04:48 +0100
Message-ID: <200803161804.48573.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 16 17:55:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jaw8i-0001YC-Kb
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 17:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbYCPQyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 12:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbYCPQyh
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 12:54:37 -0400
Received: from smtp.katamail.com ([62.149.157.154]:44869 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751278AbYCPQyh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 12:54:37 -0400
Received: (qmail 19106 invoked by uid 89); 16 Mar 2008 16:52:38 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=RDNS_NONE autolearn=disabled
	version=3.2.3
Received: from unknown (HELO host229-57-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.57.229)
  by smtp2-pc with SMTP; 16 Mar 2008 16:52:37 -0000
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77366>

It seems that git prune changed behaviour with respect to revisions added
from command line, probably when it became a builtin. Currently, it prints
a short usage and exits: instead, it should take those revisions into
account and not prune them. So add a couple of test to point this out.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---

I'm not sure if I've disabled core.logAllRefUpdates correctly...

Is it ok to do this?

+	mv .git/logs .git/logs.old &&

 t/t5304-prune.sh |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 47090c4..d5fad4c 100644
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -78,4 +78,30 @@ test_expect_success 'gc: start with ok gc.pruneExpire' '
 
 '
 
+test_expect_success 'prune: prune unreachable heads' '
+
+	git config core.logAllRefUpdates false &&
+	mv .git/logs .git/logs.old &&
+	: > file2 &&
+	git add file2 &&
+	git commit -m temporary &&
+	tmp_head=$(git rev-list -1 HEAD) &&
+	git reset HEAD^ &&
+	git prune &&
+	test_must_fail git reset $tmp_head --
+
+'
+
+test_expect_failure 'prune: do not prune heads listed as an argument' '
+
+	: > file2 &&
+	git add file2 &&
+	git commit -m temporary &&
+	tmp_head=$(git rev-list -1 HEAD) &&
+	git reset HEAD^ &&
+	git prune $tmp_head &&
+	git reset $tmp_head --
+
+'
+
 test_done
-- 
1.5.4.3
