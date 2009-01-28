From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] add -u: do not fail to resolve a path as deleted
Date: Wed, 28 Jan 2009 14:28:08 -0800
Message-ID: <7vbptrkqvb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 23:29:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSIui-00086W-W3
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 23:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbZA1W2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 17:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbZA1W2O
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 17:28:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52887 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbZA1W2N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 17:28:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EF92D1D815;
	Wed, 28 Jan 2009 17:28:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 40DA31D813; Wed,
 28 Jan 2009 17:28:10 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F26FFD52-ED8A-11DD-A8EC-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107590>

After you resolve a conflicted merge to remove the path, "git add -u"
failed to record the removal.  Instead it errored out by saying that the
removed path is not found in the work tree, but that is what the user
wanted to do and failing it is illogical.

This fixes it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c          |    5 +++++
 t/t2200-add-update.sh |   20 +++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index b1475ff..ddc0586 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1574,6 +1574,11 @@ static void update_callback(struct diff_queue_struct *q,
 		default:
 			die("unexpected diff status %c", p->status);
 		case DIFF_STATUS_UNMERGED:
+			/*
+			 * diff-files gives U followed by the work tree state
+			 * such as M or D, so we can ignore this.
+			 */
+			continue;
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_TYPE_CHANGED:
 			if (add_file_to_index(&the_index, path, data->flags)) {
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index cd9231c..e917a01 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -12,7 +12,7 @@ and issues a git add -u with path limiting on "dir" to add
 only the updates to dir/sub.
 
 Also tested are "git add -u" without limiting, and "git add -u"
-without contents changes.'
+without contents changes, and other conditions'
 
 . ./test-lib.sh
 
@@ -128,4 +128,22 @@ test_expect_success 'add -n -u should not add but just report' '
 
 '
 
+test_expect_success 'add -u resolves unmerged paths' '
+	git reset --hard &&
+	one=$(echo 1 | git hash-object -w --stdin) &&
+	two=$(echo 2 | git hash-object -w --stdin) &&
+	three=$(echo 3 | git hash-object -w --stdin) &&
+	for path in path1 path2
+	do
+		echo "100644 $one 1	$path"
+		echo "100644 $two 2	$path"
+		echo "100644 $three 3	$path"
+	done |
+	git update-index --index-info &&
+	echo 4 >path1 &&
+	git add -u &&
+	test 1 = "$(git ls-files path1 path2 | wc -l)"
+'
+
 test_done
+
-- 
1.6.1.1.278.g6a817
