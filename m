From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git add --intent-to-add: fix removal of cached emptiness
Date: Fri, 28 Nov 2008 16:15:37 -0800
Message-ID: <7vk5an4cba.fsf_-_@gitster.siamese.dyndns.org>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0811272347010.30769@pacific.mpi-cbg.de>
 <7vtz9s8uzu.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0811281225040.30769@pacific.mpi-cbg.de>
 <20081128192033.GF23984@spearce.org>
 <7voczz4cfb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 29 01:17:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6DWT-0007gp-QG
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 01:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040AbYK2AQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 19:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753014AbYK2AQE
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 19:16:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59845 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbYK2AQD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 19:16:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B583817B30;
	Fri, 28 Nov 2008 19:16:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 03ED617B16; Fri,
 28 Nov 2008 19:15:39 -0500 (EST)
In-Reply-To: <7voczz4cfb.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 28 Nov 2008 16:13:12 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E6EC30A0-BDAA-11DD-A110-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101894>

This uses the extended index flag mechanism introduced earlier to mark
the entries added to the index via "git add -N" with CE_INTENT_TO_ADD.

The logic to detect an "intent to add" entry for the purpose of allowing
"git rm --cached $path" is tightened to check not just for a staged empty
blob, but with the CE_INTENT_TO_ADD bit.  This protects an empty blob that
was explicitly added and then modified in the work tree from being dropped
with this sequence:

	$ >empty
	$ git add empty
	$ echo "non empty" >empty
	$ git rm --cached empty

An index an "intent to add" entry is blocked.  This implies that you
cannot "git commit" from such a state; however "git commit -a" still
works.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This applies on top of the result of merging commit 06aaaa0 (Extend
   index to save more flags, 2008-10-01) from nd/narrow topic into 'master'.

 builtin-rm.c               |   11 ++++++-----
 builtin-write-tree.c       |    2 +-
 cache-tree.c               |   10 +++++++---
 cache.h                    |    3 ++-
 read-cache.c               |    2 ++
 t/t3600-rm.sh              |    4 ++--
 t/t3701-add-interactive.sh |   18 ++++++++++++++++++
 7 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/builtin-rm.c b/builtin-rm.c
index b7126e3..8debcec 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -73,14 +73,15 @@ static int check_local_mod(unsigned char *head, int index_only)
 		}
 		if (ce_match_stat(ce, &st, 0))
 			local_changes = 1;
-		if (no_head
-		     || get_tree_entry(head, name, sha1, &mode)
-		     || ce->ce_mode != create_ce_mode(mode)
-		     || hashcmp(ce->sha1, sha1))
+		if (no_head ||
+		    ((get_tree_entry(head, name, sha1, &mode)
+		      || ce->ce_mode != create_ce_mode(mode)
+		      || hashcmp(ce->sha1, sha1)) &&
+		     !(ce->ce_flags & CE_INTENT_TO_ADD)))
 			staged_changes = 1;
 
 		if (local_changes && staged_changes &&
-		    !(index_only && is_empty_blob_sha1(ce->sha1)))
+		    !(index_only && (ce->ce_flags & CE_INTENT_TO_ADD)))
 			errs = error("'%s' has staged content different "
 				     "from both the file and the HEAD\n"
 				     "(use -f to force removal)", name);
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
diff --git a/cache.h b/cache.h
index ef2e7f9..f15b3fc 100644
--- a/cache.h
+++ b/cache.h
@@ -176,10 +176,11 @@ struct cache_entry {
 /*
  * Extended on-disk flags
  */
+#define CE_INTENT_TO_ADD 0x20000000
 /* CE_EXTENDED2 is for future extension */
 #define CE_EXTENDED2 0x80000000
 
-#define CE_EXTENDED_FLAGS (0)
+#define CE_EXTENDED_FLAGS (CE_INTENT_TO_ADD)
 
 /*
  * Safeguard to avoid saving wrong flags:
diff --git a/read-cache.c b/read-cache.c
index abc627b..fa30a0f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -546,6 +546,8 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	ce->ce_flags = namelen;
 	if (!intent_only)
 		fill_stat_cache_info(ce, st);
+	else
+		ce->ce_flags |= CE_INTENT_TO_ADD;
 
 	if (trust_executable_bit && has_symlinks)
 		ce->ce_mode = create_ce_mode(st_mode);
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 5b4d6f7..b7d46e5 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -187,8 +187,8 @@ test_expect_success 'but with -f it should work.' '
 	test_must_fail git ls-files --error-unmatch baz
 '
 
-test_expect_failure 'refuse to remove cached empty file with modifications' '
-	touch empty &&
+test_expect_success 'refuse to remove cached empty file with modifications' '
+	>empty &&
 	git add empty &&
 	echo content >empty &&
 	test_must_fail git rm --cached empty
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
