From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] read-tree A B: do not corrupt cache-tree
Date: Mon, 20 Apr 2009 03:58:17 -0700
Message-ID: <1240225100-29960-2-git-send-email-gitster@pobox.com>
References: <1240225100-29960-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 20 13:00:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvrEL-0001Cx-Pv
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 13:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562AbZDTK6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 06:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754471AbZDTK63
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 06:58:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60432 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964AbZDTK62 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 06:58:28 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B2CEDACEF7
	for <git@vger.kernel.org>; Mon, 20 Apr 2009 06:58:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 237A5ACEF6 for
 <git@vger.kernel.org>; Mon, 20 Apr 2009 06:58:26 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.rc1.18.g66996
In-Reply-To: <1240225100-29960-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2D5ED344-2D9A-11DE-83B4-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116967>

An earlier commit aab3b9a (read-tree A B C: do not create a bogus index
and do not segfault, 2009-03-12) resurrected the support for an obscure
(but useful) feature to read and overlay more than one tree into the index
without the -m (merge) option.  But the fix was not enough.

Exercising this feature exposes a longstanding bug in the code that primes
the cache-tree in the index from the tree that was read.  The intention
was that when we know that the index must exactly match the tree we just
read, we prime the entire cache-tree with it.

However, the logic to detect that case incorrectly triggered if you read
two trees without -m.  This resulted in a corrupted cache-tree, and
write-tree would have produced an incorrect tree object out of such an
index.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Meant for maint.

 builtin-read-tree.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 38fef34..e4e0e71 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -211,7 +211,6 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		case 3:
 		default:
 			opts.fn = threeway_merge;
-			cache_tree_free(&active_cache_tree);
 			break;
 		}
 
@@ -221,6 +220,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			opts.head_idx = 1;
 	}
 
+	cache_tree_free(&active_cache_tree);
 	for (i = 0; i < nr_trees; i++) {
 		struct tree *tree = trees[i];
 		parse_tree(tree);
@@ -235,10 +235,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	 * valid cache-tree because the index must match exactly
 	 * what came from the tree.
 	 */
-	if (nr_trees && !opts.prefix && (!opts.merge || (stage == 2))) {
-		cache_tree_free(&active_cache_tree);
+	if (nr_trees == 1 && !opts.prefix)
 		prime_cache_tree();
-	}
 
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    commit_locked_index(&lock_file))
-- 
1.6.3.rc1.18.g66996
