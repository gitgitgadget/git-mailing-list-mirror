From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] diff-files: careful when inspecting work tree items
Date: Sun, 30 Mar 2008 17:30:08 -0700
Message-ID: <7viqz3u44v.fsf@gitster.siamese.dyndns.org>
References: <200803290813.08419.chriscool@tuxfamily.org>
 <7v4panyduy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 31 02:31:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg7vX-0006to-13
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 02:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227AbYCaAaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 20:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754177AbYCaAaV
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 20:30:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbYCaAaU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 20:30:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C6DDF210C;
	Sun, 30 Mar 2008 20:30:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id DD5AC210B; Sun, 30 Mar 2008 20:30:12 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78539>

This fixes the same breakage in diff-files.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-lib.c                       |   17 +++++++++++------
 t/t2201-add-update-typechange.sh |    6 +++---
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index a8e107a..d4ad6b6 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -362,10 +362,12 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 	int silent_on_removed = option & DIFF_SILENT_ON_REMOVED;
 	unsigned ce_option = ((option & DIFF_RACY_IS_MODIFIED)
 			      ? CE_MATCH_RACY_IS_DIRTY : 0);
+	char symcache[PATH_MAX];
 
 	if (diff_unmerged_stage < 0)
 		diff_unmerged_stage = 2;
 	entries = active_nr;
+	symcache[0] = '\0';
 	for (i = 0; i < entries; i++) {
 		struct stat st;
 		unsigned int oldmode, newmode;
@@ -397,16 +399,17 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			memset(&(dpath->parent[0]), 0,
 			       sizeof(struct combine_diff_parent)*5);
 
-			if (lstat(ce->name, &st) < 0) {
-				if (errno != ENOENT && errno != ENOTDIR) {
+			changed = check_work_tree_entity(ce, &st, symcache);
+			if (!changed)
+				dpath->mode = ce_mode_from_stat(ce, st.st_mode);
+			else {
+				if (changed < 0) {
 					perror(ce->name);
 					continue;
 				}
 				if (silent_on_removed)
 					continue;
 			}
-			else
-				dpath->mode = ce_mode_from_stat(ce, st.st_mode);
 
 			while (i < entries) {
 				struct cache_entry *nce = active_cache[i];
@@ -459,8 +462,10 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 
 		if (ce_uptodate(ce))
 			continue;
-		if (lstat(ce->name, &st) < 0) {
-			if (errno != ENOENT && errno != ENOTDIR) {
+
+		changed = check_work_tree_entity(ce, &st, symcache);
+		if (changed) {
+			if (changed < 0) {
 				perror(ce->name);
 				continue;
 			}
diff --git a/t/t2201-add-update-typechange.sh b/t/t2201-add-update-typechange.sh
index 469a8e0..e15e3eb 100755
--- a/t/t2201-add-update-typechange.sh
+++ b/t/t2201-add-update-typechange.sh
@@ -104,7 +104,7 @@ test_expect_success modify '
 	} >expect-final
 '
 
-test_expect_failure diff-files '
+test_expect_success diff-files '
 	git diff-files --raw >actual &&
 	diff -u expect-files actual
 '
@@ -114,7 +114,7 @@ test_expect_success diff-index '
 	diff -u expect-index actual
 '
 
-test_expect_failure 'add -u' '
+test_expect_success 'add -u' '
 	rm -f ".git/saved-index" &&
 	cp -p ".git/index" ".git/saved-index" &&
 	git add -u &&
@@ -122,7 +122,7 @@ test_expect_failure 'add -u' '
 	diff -u expect-final actual
 '
 
-test_expect_failure 'commit -a' '
+test_expect_success 'commit -a' '
 	if test -f ".git/saved-index"
 	then
 		rm -f ".git/index" &&
-- 
1.5.5.rc2.131.g3d2f0
