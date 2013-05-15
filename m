From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: [PATCH] combine-diff.c: Fix output when changes are exactly 3 lines apart
Date: Wed, 15 May 2013 19:42:14 +0200
Message-ID: <1368639734-27746-1-git-send-email-matthijs@stdin.nl>
References: <20130515173312.GR25742@login.drsnuggles.stderr.nl>
Cc: git@vger.kernel.org, Matthijs Kooijman <matthijs@stdin.nl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 15 20:02:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucg1v-0008MB-SI
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 20:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759828Ab3EOSCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 14:02:19 -0400
Received: from 84-245-11-97.dsl.cambrium.nl ([84.245.11.97]:33299 "EHLO
	grubby.stderr.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759752Ab3EOSCT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 14:02:19 -0400
X-Greylist: delayed 1176 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 May 2013 14:02:18 EDT
Received: from matthijs by grubby.stderr.nl with local (Exim 4.80)
	(envelope-from <matthijs@stdin.nl>)
	id 1Ucfie-0007E5-N2; Wed, 15 May 2013 19:42:28 +0200
X-Mailer: git-send-email 1.8.3.rc1
In-Reply-To: <20130515173312.GR25742@login.drsnuggles.stderr.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224434>

When a deletion is followed by exactly 3 (or whatever the number of
context lines) unchanged lines, followed by another change, the combined
diff output would hide the first deletion, resulting in a malformed
diff.

This happened because the 3 lines before each change are painted
interesting, but also marked as no_pre_delete to prevent showing deletes
that were previously marked as uninteresting. This behaviour was
introduced in c86fbe53 (diff -c/--cc: do not include uninteresting
deletion before leading context). However, as a side effect, this could
also mark deletes that were already interesting as no_pre_delete. This
would happen only if the delete was exactly 3 lines away from the next
change, since lines farther away would not be touched by the "paint
three lines before the change" code and lines closer would be painted
by the "merge two adjacent hunks" code instead, which does not set the
no_pre_delete flag.

This commit fixes this problem by only setting the no_pre_delete flag
for changes that were previously uninteresting.

Signed-off-by: Matthijs Kooijman <matthijs@stdin.nl>
---
 combine-diff.c           |  7 +++++--
 t/t4038-diff-combined.sh | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 77d7872..3e8bb17 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -518,8 +518,11 @@ static int give_context(struct sline *sline, unsigned long cnt, int num_parent)
 		unsigned long k;
 
 		/* Paint a few lines before the first interesting line. */
-		while (j < i)
-			sline[j++].flag |= mark | no_pre_delete;
+		while (j < i) {
+			if (!(sline[j].flag & mark))
+				sline[j].flag |= no_pre_delete;
+			sline[j++].flag |= mark;
+		}
 
 	again:
 		/* we know up to i is to be included.  where does the
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 1261dbb..a23ca7e 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -353,4 +353,51 @@ test_expect_failure 'combine diff coalesce three parents' '
 	compare_diff_patch expected actual
 '
 
+# Test for a bug reported at
+# http://thread.gmane.org/gmane.comp.version-control.git/224410
+# where a delete lines were missing from combined diff output when they
+# occurred exactly before the context lines of a later change.
+test_expect_success 'combine diff missing delete bug' '
+	git commit -m initial --allow-empty &&
+	cat <<-\EOF >test &&
+	1
+	2
+	3
+	4
+	EOF
+	git add test
+	git commit -a -m side1 &&
+	git checkout -B side1 &&
+	git checkout HEAD^ &&
+	cat <<-\EOF >test &&
+	0
+	1
+	2
+	3
+	4modified
+	EOF
+	git commit -a -m side2 &&
+	git branch -f side2 &&
+	test_must_fail git merge --no-commit side1 &&
+	cat <<-\EOF >test &&
+	1
+	2
+	3
+	4modified
+	EOF
+	git add test &&
+	git commit -a -m merge &&
+	git diff-tree -c -p HEAD >actual.tmp &&
+	sed -e "1,/^@@@/d" < actual.tmp >actual &&
+	tr -d Q <<-\EOF >expected &&
+	- 0
+	  1
+	  2
+	  3
+	 -4
+	 +4modified
+	EOF
+	compare_diff_patch expected actual
+'
+
 test_done
-- 
1.8.3.rc1
