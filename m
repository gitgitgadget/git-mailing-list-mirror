From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] Avoid "diff-index --cached" optimization under
 --find-copies-harder
Date: Sat, 23 May 2009 12:24:38 -0700
Message-ID: <1243106678-6343-6-git-send-email-gitster@pobox.com>
References: <1243106678-6343-1-git-send-email-gitster@pobox.com>
 <1243106678-6343-2-git-send-email-gitster@pobox.com>
 <1243106678-6343-3-git-send-email-gitster@pobox.com>
 <1243106678-6343-4-git-send-email-gitster@pobox.com>
 <1243106678-6343-5-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 21:25:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7wql-0002Cd-Ur
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 21:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755455AbZEWTYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 15:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755130AbZEWTYw
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 15:24:52 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54853 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134AbZEWTYs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 15:24:48 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 73B361914E
	for <git@vger.kernel.org>; Sat, 23 May 2009 15:24:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1028A1914D for
 <git@vger.kernel.org>; Sat, 23 May 2009 15:24:49 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.1.145.gb74d77
In-Reply-To: <1243106678-6343-5-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6288C1C0-47CF-11DE-B0AC-B4FDD46C8AFF-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119792>

When find-copies-harder is in effect, the diff frontends are expected to
feed all paths, not just changed paths, to the diffcore, so that copy
sources can be picked up.  In such a case, not descending into subtrees
using the cache-tree information is simply wrong.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-lib.c          |    5 +++--
 t/t4007-rename-3.sh |    5 +++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 1cb97af..ae75eac 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -446,7 +446,8 @@ int run_diff_index(struct rev_info *revs, int cached)
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
 	opts.index_only = cached;
-	opts.diff_index_cached = cached;
+	opts.diff_index_cached = (cached &&
+				  !DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER));
 	opts.merge = 1;
 	opts.fn = oneway_diff;
 	opts.unpack_data = revs;
@@ -503,7 +504,7 @@ int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
 	opts.index_only = 1;
-	opts.diff_index_cached = 1;
+	opts.diff_index_cached = !DIFF_OPT_TST(opt, FIND_COPIES_HARDER);
 	opts.merge = 1;
 	opts.fn = oneway_diff;
 	opts.unpack_data = &revs;
diff --git a/t/t4007-rename-3.sh b/t/t4007-rename-3.sh
index 25e7a83..11502b7 100755
--- a/t/t4007-rename-3.sh
+++ b/t/t4007-rename-3.sh
@@ -35,6 +35,11 @@ test_expect_success 'copy detection' '
 	compare_diff_raw current expected
 '
 
+test_expect_success 'copy detection, cached' '
+	git diff-index -C --find-copies-harder --cached $tree >current &&
+	compare_diff_raw current expected
+'
+
 # In the tree, there is only path0/COPYING.  In the cache, path0 and
 # path1 both have COPYING and the latter is a copy of path0/COPYING.
 # However when we say we care only about path1, we should just see
-- 
1.6.3.1.145.gb74d77
