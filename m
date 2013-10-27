From: Torstein Hegge <hegge@resisty.net>
Subject: [PATCH] reflog: handle lightweight and annotated tags equally
Date: Sun, 27 Oct 2013 10:57:04 +0100
Message-ID: <1382867824-23540-1-git-send-email-hegge@resisty.net>
Cc: Torstein Hegge <hegge@resisty.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 27 13:56:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaPtC-00030w-JG
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 13:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994Ab3J0M4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 08:56:14 -0400
Received: from microbel.pvv.ntnu.no ([129.241.210.179]:41526 "EHLO
	microbel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab3J0M4N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 08:56:13 -0400
X-Greylist: delayed 10717 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Oct 2013 08:56:13 EDT
Received: from 120.179.202.84.customer.cdi.no ([84.202.179.120] helo=stacker.resisty.net)
	by microbel.pvv.ntnu.no with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <torstehe@pvv.ntnu.no>)
	id 1VaN6Y-0004n3-Hd; Sun, 27 Oct 2013 10:57:56 +0100
X-Mailer: git-send-email 1.8.4.1.808.g053d237
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236802>

When 'git reflog <tag>' is called on a lightweight tag, nothing is
output. However, when called on an annotated tag, shortened SHA-1s for
all reachable commits are written on a single line.

Teach add_pending_object_with_mode() to handle OBJ_TAG, so that 'git
reflog' on an annotated tag is quiet, like it is for lightweight tags,
commits and blobs.

Signed-off-by: Torstein Hegge <hegge@resisty.net>
---
Try 'GIT_PAGER=cat git reflog v1.8.4' on git.git to see an example of
this rather unexpected behavior.

 revision.c             |  2 +-
 t/t1411-reflog-show.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 0173e01..fa4e660 100644
--- a/revision.c
+++ b/revision.c
@@ -198,7 +198,7 @@ static void add_pending_object_with_mode(struct rev_info *revs,
 		return;
 	if (revs->no_walk && (obj->flags & UNINTERESTING))
 		revs->no_walk = 0;
-	if (revs->reflog_info && obj->type == OBJ_COMMIT) {
+	if (revs->reflog_info) {
 		struct strbuf buf = STRBUF_INIT;
 		int len = interpret_branch_name(name, 0, &buf);
 		int st;
diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index 6f47c0d..de9fb8d 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -166,4 +166,32 @@ test_expect_success 'git log -g -p shows diffs vs. parents' '
 	test_cmp expect actual
 '
 
+test_expect_success 'add annotated tag' '
+	git tag -a -m "tag message" annotated-tag
+'
+
+: >expect
+test_expect_success 'reflog on a tag' '
+	git reflog two >actual &&
+	test_cmp expect actual
+'
+
+: >expect
+test_expect_success 'reflog on an annotated tag' '
+	git reflog annotated-tag >actual &&
+	test_cmp expect actual
+'
+
+: >expect
+test_expect_success 'log -g on a tag' '
+	git log -g two >actual &&
+	test_cmp expect actual
+'
+
+: >expect
+test_expect_success 'log -g on an annotated tag' '
+	git log -g annotated-tag >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.4.1.808.g053d237
