From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Fix read-tree not to discard errors
Date: Tue, 18 Mar 2008 22:01:28 -0700
Message-ID: <7v3aqn5mtz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 20:31:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc40w-0006jn-IL
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 20:31:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768AbYCST01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753279AbYCST01
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:26:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264AbYCSTZE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 15:25:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D9BB21BD9;
	Wed, 19 Mar 2008 01:01:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 102D51BD6; Wed, 19 Mar 2008 01:01:38 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77506>

This fixes the issue identified with recently added tests to t1004

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Linus's earlier "root on Solaris" unlink patch would be a no-op without
   this fix.

 t/t1004-read-tree-m-u-wf.sh |    2 +-
 unpack-trees.c              |    9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index 1356148..570d372 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -177,7 +177,7 @@ test_expect_success 'funny symlink in work tree' '
 
 '
 
-test_expect_failure 'funny symlink in work tree, un-unlink-able' '
+test_expect_success 'funny symlink in work tree, un-unlink-able' '
 
 	rm -fr a b &&
 	git reset --hard &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 4b359e0..a59f475 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -54,13 +54,14 @@ static void unlink_entry(char *name, char *last_symlink)
 }
 
 static struct checkout state;
-static void check_updates(struct unpack_trees_options *o)
+static int check_updates(struct unpack_trees_options *o)
 {
 	unsigned cnt = 0, total = 0;
 	struct progress *progress = NULL;
 	char last_symlink[PATH_MAX];
 	struct index_state *index = &o->result;
 	int i;
+	int errs = 0;
 
 	if (o->update && o->verbose_update) {
 		for (total = cnt = 0; cnt < index->cache_nr; cnt++) {
@@ -90,12 +91,13 @@ static void check_updates(struct unpack_trees_options *o)
 		if (ce->ce_flags & CE_UPDATE) {
 			ce->ce_flags &= ~CE_UPDATE;
 			if (o->update) {
-				checkout_entry(ce, &state, NULL);
+				errs |= checkout_entry(ce, &state, NULL);
 				*last_symlink = '\0';
 			}
 		}
 	}
 	stop_progress(&progress);
+	return errs != 0;
 }
 
 static inline int call_unpack_fn(struct cache_entry **src, struct unpack_trees_options *o)
@@ -369,7 +371,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		return unpack_failed(o, "Merge requires file-level merging");
 
 	o->src_index = NULL;
-	check_updates(o);
+	if (check_updates(o))
+		return -1;
 	if (o->dst_index)
 		*o->dst_index = o->result;
 	return 0;
-- 
1.5.5.rc0.122.g8e28f
