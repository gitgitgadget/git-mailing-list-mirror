From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] merge-recursive: don't segfault while handling rename
 clashes
Date: Thu, 30 Jul 2009 17:38:15 -0700
Message-ID: <7vd47h6614.fsf@alter.siamese.dyndns.org>
References: <D5F958F92101F74D8A5683C2FE14F4200F23102F@post.corp.w3data.com>
 <C695A6A4.61CD9%jbenjore@whitepages.com>
 <7vtz0uk5z3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh ben Jore <jbenjore@whitepages.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 02:38:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWg8l-0007OU-Af
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 02:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbZGaAiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 20:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbZGaAiW
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 20:38:22 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45824 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbZGaAiW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 20:38:22 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DAF5B1A638;
	Thu, 30 Jul 2009 20:38:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C86A91A636; Thu,
 30 Jul 2009 20:38:16 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 731B2CDC-7D6A-11DE-8C4B-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124494>

When a branch moves A to B while the other branch created B (or moved C to
B), the code tried to rename one of them to B~something to preserve both
versions, and failed to register temporary resolution for the original
path B at stage#0 during virtual ancestor computation.  This left the
index in unmerged state and caused a segfault.

A better solution is to merge these two versions of B's in place and use
the (potentially conflicting) result as the intermediate merge result in
the virtual ancestor.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Junio C Hamano <gitster@pobox.com> writes:

 > The codepath saw that one branch renamed dev-ubuntu/ stuff to dev/ at that
 > "unmerged" path, while the other branch added something else to the same
 > path, and decided to add that at an alternative path, and the intent of
 > that is so that it can safely resolve the "renamed" side to its final
 > destination.  The added update_file() call is about finishing that
 > conflict resolution the code forgets to do.
 > ...

 Yesterday's patch squashes the conflicted path down to stage#0 even for
 outermost merge, which is not quite correct.

 This may be a better fix.

 merge-recursive.c                 |   28 ++++++++++++++++--
 t/t6036-recursive-corner-cases.sh |   56 +++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 3 deletions(-)
 create mode 100755 t/t6036-recursive-corner-cases.sh

diff --git a/merge-recursive.c b/merge-recursive.c
index d415c41..10d7913 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -952,9 +952,31 @@ static int process_renames(struct merge_options *o,
 				       "%s added in %s",
 				       ren1_src, ren1_dst, branch1,
 				       ren1_dst, branch2);
-				new_path = unique_path(o, ren1_dst, branch2);
-				output(o, 1, "Adding as %s instead", new_path);
-				update_file(o, 0, dst_other.sha1, dst_other.mode, new_path);
+				if (o->call_depth) {
+					struct merge_file_info mfi;
+					struct diff_filespec one, a, b;
+
+					one.path = a.path = b.path =
+						(char *)ren1_dst;
+					hashcpy(one.sha1, null_sha1);
+					one.mode = 0;
+					hashcpy(a.sha1, ren1->pair->two->sha1);
+					a.mode = ren1->pair->two->mode;
+					hashcpy(b.sha1, dst_other.sha1);
+					b.mode = dst_other.mode;
+					mfi = merge_file(o, &one, &a, &b,
+							 branch1,
+							 branch2);
+					output(o, 1, "Adding merged %s", ren1_dst);
+					update_file(o, 0,
+						    mfi.sha,
+						    mfi.mode,
+						    ren1_dst);
+				} else {
+					new_path = unique_path(o, ren1_dst, branch2);
+					output(o, 1, "Adding as %s instead", new_path);
+					update_file(o, 0, dst_other.sha1, dst_other.mode, new_path);
+				}
 			} else if ((item = string_list_lookup(ren1_dst, renames2Dst))) {
 				ren2 = item->util;
 				clean_merge = 0;
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
new file mode 100755
index 0000000..a9d1613
--- /dev/null
+++ b/t/t6036-recursive-corner-cases.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+
+test_description='recursive merge corner cases'
+
+. ./test-lib.sh
+
+#
+#  L1  L2
+#   o---o
+#  / \ / \
+# o   X   ?
+#  \ / \ /
+#   o---o
+#  R1  R2
+#
+
+test_expect_success setup '
+	ten="0 1 2 3 4 5 6 7 8 9"
+	for i in $ten
+	do
+		echo line $i in a sample file
+	done >one &&
+	for i in $ten
+	do
+		echo line $i in another sample file
+	done >two &&
+	git add one two &&
+	test_tick && git commit -m initial &&
+
+	git branch L1 &&
+	git checkout -b R1 &&
+	git mv one three &&
+	test_tick && git commit -m R1 &&
+
+	git checkout L1 &&
+	git mv two three &&
+	test_tick && git commit -m L1 &&
+
+	git checkout L1^0 &&
+	test_tick && git merge -s ours R1 &&
+	git tag L2 &&
+
+	git checkout R1^0 &&
+	test_tick && git merge -s ours L1 &&
+	git tag R2
+'
+
+test_expect_success merge '
+	git reset --hard &&
+	git checkout L2^0 &&
+
+	test_must_fail git merge -s recursive R2^0
+'
+
+test_done
+
-- 
1.6.4.13.ge65800
