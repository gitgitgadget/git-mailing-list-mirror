From: Elijah Newren <newren@gmail.com>
Subject: [WIP PATCH 09/10] Tests and fixes associated with rename/rename conflicts
Date: Mon, 21 Mar 2011 12:31:03 -0600
Message-ID: <1300732264-9638-10-git-send-email-newren@gmail.com>
References: <1300732264-9638-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 19:25:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1jmn-0000RW-Ky
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 19:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155Ab1CUSY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 14:24:59 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47678 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab1CUSY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 14:24:56 -0400
Received: by mail-vx0-f174.google.com with SMTP id 39so5223921vxi.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 11:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=mvXDtWjJ9mUCGJZFtQta47yjZQUpnUtP4rp4B07NMow=;
        b=f1l4vK9GwOmQN3yNlgWsSGnfxzKmXvctNpOT+N44vAztUfFIvfT5Cvu0HbuLhVh0W4
         hH+nkBM3B7rtOIiTpCaq031ds5wxflqcag6j8h2rwyxXzQVywLA6USbRayenxypwIUGd
         v/YLlu49MwK8qBIo3DzGuGAxmHxrvU3FEcQfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rRPtUtJQo1capmCU3SWrDxIzN0/npS2ibpBBoNuIgl3kefj6ofNe3lk2L3xo4c+sSC
         y3jzoV4gXe9cq4SHAGjHgbC2JVdXW7kYKlG+pvMrMcVEDbXlbMHAdh89CEPwO6JAXzYa
         rlkUHL+uWNpigJEdTHNKiHOSBYS49n6WcjaOE=
Received: by 10.220.193.193 with SMTP id dv1mr1287427vcb.103.1300731896397;
        Mon, 21 Mar 2011 11:24:56 -0700 (PDT)
Received: from localhost6.localdomain6 (c-174-56-87-200.hsd1.nm.comcast.net [174.56.87.200])
        by mx.google.com with ESMTPS id b6sm1507291vci.0.2011.03.21.11.24.54
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 11:24:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.120.g38a18
In-Reply-To: <1300732264-9638-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169631>

Add a new testcase for basic rename/rename (+modify/modify) -- temp12
Add a testcase for tough-to-handle rename/rename + criss-cross merges

Fix up most of temp12 testcase, but not yet handling merging of info from
other side of history.
---
 merge-recursive.c |   24 ++++++++--------
 t/temp12.sh       |   59 +++++++++++++++++++++++++++++++++++++++
 t/temp13.sh       |   79 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+), 12 deletions(-)
 create mode 100755 t/temp12.sh
 create mode 100755 t/temp13.sh

diff --git a/merge-recursive.c b/merge-recursive.c
index 544c504..cea6e27 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -991,12 +991,12 @@ static int process_renames(struct merge_options *o,
 	for (i = 0; i < a_renames->nr; i++) {
 		sre = a_renames->items[i].util;
 		string_list_insert(&a_by_dst, sre->pair->two->path)->util
-			= sre->dst_entry;
+			= (void*)sre;
 	}
 	for (i = 0; i < b_renames->nr; i++) {
 		sre = b_renames->items[i].util;
 		string_list_insert(&b_by_dst, sre->pair->two->path)->util
-			= sre->dst_entry;
+			= (void*)sre;
 	}
 
 	for (i = 0, j = 0; i < a_renames->nr || j < b_renames->nr;) {
@@ -1110,6 +1110,16 @@ static int process_renames(struct merge_options *o,
 					clean_merge = 0;
 					conflict_rename_delete(o, ren1->pair, branch1, branch2);
 				}
+			} else if ((item = string_list_lookup(renames2Dst, ren1_dst))) {
+				ren2 = item->util;
+				clean_merge = 0;
+				ren2->processed = 1;
+				output(o, 1, "CONFLICT (rename/rename): "
+				       "Rename %s->%s in %s. "
+				       "Rename %s->%s in %s",
+				       ren1_src, ren1_dst, branch1,
+				       ren2->pair->one->path, ren2->pair->two->path, branch2);
+				conflict_rename_rename_2to1(o, ren1, branch1, ren2, branch2);
 			} else if ((dst_other.mode == ren1->pair->two->mode) &&
 				   sha_eq(dst_other.sha1, ren1->pair->two->sha1)) {
 				/* Added file on the other side
@@ -1150,16 +1160,6 @@ static int process_renames(struct merge_options *o,
 					output(o, 1, "Adding as %s instead", new_path);
 					update_file(o, 0, dst_other.sha1, dst_other.mode, new_path);
 				}
-			} else if ((item = string_list_lookup(renames2Dst, ren1_dst))) {
-				ren2 = item->util;
-				clean_merge = 0;
-				ren2->processed = 1;
-				output(o, 1, "CONFLICT (rename/rename): "
-				       "Rename %s->%s in %s. "
-				       "Rename %s->%s in %s",
-				       ren1_src, ren1_dst, branch1,
-				       ren2->pair->one->path, ren2->pair->two->path, branch2);
-				conflict_rename_rename_2to1(o, ren1, branch1, ren2, branch2);
 			} else
 				try_merge = 1;
 
diff --git a/t/temp12.sh b/t/temp12.sh
new file mode 100755
index 0000000..47e657b
--- /dev/null
+++ b/t/temp12.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+test_description='rename/rename (2to1) handling'
+
+. ./test-lib.sh
+
+# Current git gets all kinds of things wrong with rename/rename (2to1); setup:
+#   Commit A: new files: a & b
+#   Commit B: rename a->c, modify b
+#   Commit C: rename b->c, modify a
+#
+# Merging of B & C should NOT be clean.  Questions:
+#   * Both a & b should be removed by the merge; are they?
+#   * The two c's should contain modifications to a & b; do they?
+#   * The index should contain two files, both for c; does it?
+#   * The working copy should have two files, both of form c~<unique>; does it?
+#   * Nothing else should be present.  Is anything?
+
+test_expect_success 'setup rename/rename (+ modify/modify)' '
+	printf "1\n2\n3\n4\n5\n" >a &&
+	printf "5\n4\n3\n2\n1\n" >b &&
+	git add a b &&
+	git commit -m A &&
+	git tag A &&
+
+	git checkout -b B A &&
+	git mv a c &&
+	echo 0 >>b &&
+	git add b &&
+	git commit -m B &&
+
+	git checkout -b C A &&
+	git mv b c &&
+	echo 6 >>a &&
+	git add a &&
+	git commit -m C
+'
+
+test_expect_success 'handle rename/rename conflict correctly' '
+	git checkout B^0 &&
+
+	test_must_fail git merge -s recursive C^0 >out &&
+	grep "CONFLICT (rename/rename)" out &&
+
+	test 2 -eq $(git ls-files -s | wc -l) &&
+	test 2 -eq $(git ls-files -u | wc -l) &&
+	test 2 -eq $(git ls-files -u c | wc -l) &&
+	test 3 -eq $(git ls-files -o | wc -l) &&
+
+	test ! -f a &&
+	test ! -f b &&
+	test -f c~HEAD &&
+	test -f c~C^0 &&
+
+	test $(git hash-object c~HEAD) = $(git rev-parse C:a) &&
+	test $(git hash-object c~B) = $(git rev-parse B:b)
+'
+
+test_done
diff --git a/t/temp13.sh b/t/temp13.sh
new file mode 100755
index 0000000..b455a8c
--- /dev/null
+++ b/t/temp13.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+
+test_description='recursive merge corner case: rename/rename (2to1) + criss-cross merge + introduce funny file on other side of history'
+
+. ./test-lib.sh
+
+#
+# Standard setup:
+#
+#      B   D
+#      o---o
+#     / \ / \
+#  A o   X   ? F
+#     \ / \ /
+#      o---o
+#      C   E
+#
+#   Commit A: new files: a, b
+#   Commit B: rename a->c
+#   Commit C: rename b->c
+#   Commit D: merge B&C, keeping c1 (a) & c2 (b)
+#   Commit E: merge B&C, keeping c1 (a) & c2 (b), and introducing c~HEAD, c~C
+#
+# Now, when we merge commits D & E, there should be no conflict...
+
+test_expect_success 'setup rename/rename + criss-cross + new funny files' '
+	echo content >a &&
+	echo other >b &&
+	git add a b &&
+	git commit -m A &&
+	git tag A &&
+
+	git checkout -b B A &&
+	git mv a c &&
+	git commit -m B &&
+
+	git checkout -b C A &&
+	git mv b c &&
+	git commit -m C &&
+
+	git checkout B^0 &&
+	test_must_fail git merge C &&
+	git clean -f &&
+	git rm -rf . &&
+	echo content >c1 &&
+	echo other >c2 &&
+	git add c1 c2 &&
+	git commit -m D &&
+	git tag D &&
+
+	git checkout C^0 &&
+	test_must_fail git merge B &&
+	git clean -f &&
+	git rm -rf . &&
+	git checkout D -- . &&
+	git add c1 c2 &&
+	git mv c1 "c~Temporary merge branch 1" &&
+	git mv c2 "c~Temporary merge branch 2" &&
+	git commit -m E &&
+	git tag E
+'
+
+test_expect_success 'differently renamed files conflict detected' '
+	git checkout D^0 &&
+
+	(
+		# Do not want to use test_must_fail here because we do not want
+		# a premature fatal exit via "BUG: There are unmerged index
+		# entries" (exit code 128) to count as success.  We want
+		# the code to run to completion, detect the conflict, and
+		# return an appropriate (not zero and not 128) exit code.
+		git merge -s recursive E^0;
+		exit_code=$? &&
+		test $exit_code -gt 0 -a $exit_code -lt 128
+	)
+
+'
+
+test_done
-- 
1.7.4
