From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] git add --intent-to-add: do not let an empty blob
 committed by accident
Date: Fri, 28 Nov 2008 19:56:34 -0800
Message-ID: <7vk5an2nil.fsf_-_@gitster.siamese.dyndns.org>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0811272347010.30769@pacific.mpi-cbg.de>
 <7vtz9s8uzu.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0811281225040.30769@pacific.mpi-cbg.de>
 <20081128192033.GF23984@spearce.org>
 <7voczz4cfb.fsf@gitster.siamese.dyndns.org>
 <7vk5an4cba.fsf_-_@gitster.siamese.dyndns.org>
 <7vvdu72nq9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 29 04:58:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6GyX-0007SV-Bz
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 04:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbYK2D5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 22:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753040AbYK2D5J
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 22:57:09 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48099 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbYK2D5H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 22:57:07 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 20041827C4;
	Fri, 28 Nov 2008 22:57:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 919DE827C2; Fri,
 28 Nov 2008 22:56:36 -0500 (EST)
In-Reply-To: <7vvdu72nq9.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 28 Nov 2008 19:51:58 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C9B5D508-BDC9-11DD-8B0C-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101899>

Writing a tree out of an index with an "intent to add" entry is blocked.
This implies that you cannot "git commit" from such a state; however "git
commit -a" still works.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-write-tree.c       |    2 +-
 cache-tree.c               |   10 +++++++---
 t/t3701-add-interactive.sh |   18 ++++++++++++++++++
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index 52a3c01..9d64050 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -42,7 +42,7 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 		die("%s: error reading the index", me);
 		break;
 	case WRITE_TREE_UNMERGED_INDEX:
-		die("%s: error building trees; the index is unmerged?", me);
+		die("%s: error building trees", me);
 		break;
 	case WRITE_TREE_PREFIX_ERROR:
 		die("%s: prefix %s not found", me, prefix);
diff --git a/cache-tree.c b/cache-tree.c
index 5f8ee87..3d8f218 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -155,13 +155,17 @@ static int verify_cache(struct cache_entry **cache,
 	funny = 0;
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = cache[i];
-		if (ce_stage(ce)) {
+		if (ce_stage(ce) || (ce->ce_flags & CE_INTENT_TO_ADD)) {
 			if (10 < ++funny) {
 				fprintf(stderr, "...\n");
 				break;
 			}
-			fprintf(stderr, "%s: unmerged (%s)\n",
-				ce->name, sha1_to_hex(ce->sha1));
+			if (ce_stage(ce))
+				fprintf(stderr, "%s: unmerged (%s)\n",
+					ce->name, sha1_to_hex(ce->sha1));
+			else
+				fprintf(stderr, "%s: not added yet\n",
+					ce->name);
 		}
 	}
 	if (funny)
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index e95663d..473ef85 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -133,6 +133,24 @@ test_expect_success 'real edit works' '
 	test_cmp expected output
 '
 
+test_expect_success 'cannot commit with i-t-a entry' '
+	git reset --hard &&
+	echo xyzzy >rezrov &&
+	echo frotz >nitfol &&
+	git add rezrov &&
+	git add -N nitfol &&
+	test_must_fail git commit
+'
+
+test_expect_success 'can commit with an unrelated i-t-a entry in index' '
+	git reset --hard &&
+	echo xyzzy >rezrov &&
+	echo frotz >nitfol &&
+	git add rezrov &&
+	git add -N nitfol &&
+	git commit -m partial rezrov
+'
+
 if test "$(git config --bool core.filemode)" = false
 then
     say 'skipping filemode tests (filesystem does not properly support modes)'
-- 
1.6.0.4.850.g6bd829
