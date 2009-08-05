From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] diff-index: report unmerged new entries
Date: Wed,  5 Aug 2009 02:15:42 -0700
Message-ID: <1249463746-21538-2-git-send-email-gitster@pobox.com>
References: <1249463746-21538-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 11:16:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYcbW-00082b-6s
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 11:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933920AbZHEJQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 05:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933919AbZHEJQF
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 05:16:05 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933836AbZHEJP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 05:15:59 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B7C39210B6
	for <git@vger.kernel.org>; Wed,  5 Aug 2009 05:15:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E453C210B4 for
 <git@vger.kernel.org>; Wed,  5 Aug 2009 05:15:51 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.18.g07a4a
In-Reply-To: <1249463746-21538-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 95E302F0-81A0-11DE-8E5E-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124882>

Since an earlier change to diff-index by d1f2d7e (Make run_diff_index()
use unpack_trees(), not read_tree(), 2008-01-19), we stopped reporting an
unmerged path that does not exist in the tree, but we should.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-lib.c          |    4 ++--
 t/t7060-wtstatus.sh |   31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)
 create mode 100755 t/t7060-wtstatus.sh

diff --git a/diff-lib.c b/diff-lib.c
index ad2a4cd..ad5b6ca 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -348,8 +348,8 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	match_missing = !revs->ignore_merges;
 
 	if (cached && idx && ce_stage(idx)) {
-		if (tree)
-			diff_unmerge(&revs->diffopt, idx->name, idx->ce_mode, idx->sha1);
+		diff_unmerge(&revs->diffopt, idx->name, idx->ce_mode,
+			     idx->sha1);
 		return;
 	}
 
diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
new file mode 100755
index 0000000..5ad2cd1
--- /dev/null
+++ b/t/t7060-wtstatus.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+
+test_description='basic work tree status reporting'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit A &&
+	test_commit B oneside added &&
+	git checkout A^0 &&
+	test_commit C oneside created
+'
+
+test_expect_success 'A/A conflict' '
+	git checkout B^0 &&
+	test_must_fail git merge C
+'
+
+test_expect_success 'Report path with conflict' '
+	git diff --cached --name-status >actual &&
+	echo "U	oneside" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Report new path with conflict' '
+	git diff --cached --name-status HEAD^ >actual &&
+	echo "U	oneside" >expect &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.6.4.18.g07a4a
