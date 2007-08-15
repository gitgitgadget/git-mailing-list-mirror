From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Fix "git add -u" data corruption.
Date: Wed, 15 Aug 2007 14:12:14 -0700
Message-ID: <7v1we4pknl.fsf_-_@gitster.siamese.dyndns.org>
References: <f9v1t6$uph$1@sea.gmane.org>
	<7v643gplph.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Salikh Zakirov <salikh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 23:12:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILQAC-0007fH-Jo
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 23:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758386AbXHOVMV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 17:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758250AbXHOVMV
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 17:12:21 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:45270 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757570AbXHOVMU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 17:12:20 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 6AA6E120107;
	Wed, 15 Aug 2007 17:12:38 -0400 (EDT)
In-Reply-To: <7v643gplph.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 15 Aug 2007 13:49:30 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55948>

This applies to 'maint' to fix a rather serious data corruption
issue.  When "git add -u" affects a subdirectory in such a way
that the only changes to its contents are path removals, the
next tree object written out of that index was bogus, as the
remove codepath forgot to invalidate the cache-tree entry.

Kodos for noticing this breakage goes to Salikh Zakirov.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-add.c         |    1 +
 t/t2200-add-update.sh |   59 +++++++++++++++++++++++++++++++++++-------------
 2 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 1591171..a5fae7c 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -115,6 +115,7 @@ static void update_callback(struct diff_queue_struct *q,
 			break;
 		case DIFF_STATUS_DELETED:
 			remove_file_from_cache(path);
+			cache_tree_invalidate_path(active_cache_tree, path);
 			if (verbose)
 				printf("remove '%s'\n", path);
 			break;
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 83005e7..4c7c6af 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -13,26 +13,53 @@ only the updates to dir/sub.'
 
 . ./test-lib.sh
 
-test_expect_success 'setup' '
-echo initial >top &&
-mkdir dir &&
-echo initial >dir/sub &&
-git-add dir/sub top &&
-git-commit -m initial &&
-echo changed >top &&
-echo changed >dir/sub &&
-echo other >dir/other
+test_expect_success setup '
+	echo initial >check &&
+	echo initial >top &&
+	mkdir dir1 dir2 &&
+	echo initial >dir1/sub1 &&
+	echo initial >dir1/sub2 &&
+	echo initial >dir2/sub3 &&
+	git add check dir1 dir2 top &&
+	test_tick
+	git-commit -m initial &&
+
+	echo changed >check &&
+	echo changed >top &&
+	echo changed >dir2/sub3 &&
+	rm -f dir1/sub1 &&
+	echo other >dir2/other
+'
+
+test_expect_success update '
+	git add -u dir1 dir2
 '
 
-test_expect_success 'update' 'git-add -u dir'
+test_expect_success 'update noticed a removal' '
+	test "$(git-ls-files dir1/sub1)" = ""
+'
 
-test_expect_success 'update touched correct path' \
-  'test "`git-diff-files --name-status dir/sub`" = ""'
+test_expect_success 'update touched correct path' '
+	test "$(git-diff-files --name-status dir2/sub3)" = ""
+'
 
-test_expect_success 'update did not touch other tracked files' \
-  'test "`git-diff-files --name-status top`" = "M	top"'
+test_expect_success 'update did not touch other tracked files' '
+	test "$(git-diff-files --name-status check)" = "M	check" &&
+	test "$(git-diff-files --name-status top)" = "M	top"
+'
 
-test_expect_success 'update did not touch untracked files' \
-  'test "`git-diff-files --name-status dir/other`" = ""'
+test_expect_success 'update did not touch untracked files' '
+	test "$(git-ls-files dir2/other)" = ""
+'
+
+test_expect_success 'cache tree has not been corrupted' '
+
+	git ls-files -s |
+	sed -e "s/ 0	/	/" >expect &&
+	git ls-tree -r $(git write-tree) |
+	sed -e "s/ blob / /" >current &&
+	diff -u expect current
+
+'
 
 test_done
