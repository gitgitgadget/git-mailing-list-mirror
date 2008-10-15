From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] reset --hard/read-tree --reset -u: remove unmerged new paths
Date: Wed, 15 Oct 2008 16:00:06 -0700
Message-ID: <7vy70ppiq1.fsf_-_@gitster.siamese.dyndns.org>
References: <20081015115654.fb34438f.akpm@linux-foundation.org>
 <alpine.DEB.1.10.0810151208100.7808@asgard.lang.hm>
 <alpine.DEB.1.10.0810151211580.7808@asgard.lang.hm>
 <alpine.LFD.2.00.0810151219120.3288@nehalem.linux-foundation.org>
 <20081015124949.b657a8db.akpm@linux-foundation.org>
 <alpine.LFD.2.00.0810151256410.3288@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0810151311210.3288@nehalem.linux-foundation.org>
 <7v3aixqzrn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@linux-foundation.org>, david@lang.hm,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Oct 16 01:01:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqFN3-0001ea-QJ
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 01:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423AbYJOXA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 19:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbYJOXA0
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 19:00:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41314 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbYJOXAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 19:00:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7E99A6F34D;
	Wed, 15 Oct 2008 19:00:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0DF9A6F346; Wed, 15 Oct 2008 19:00:15 -0400 (EDT)
In-Reply-To: <7v3aixqzrn.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 15 Oct 2008 15:06:36 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0CF21DAC-9B0D-11DD-839D-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98336>

When aborting a failed merge that has brought in a new path using "git
reset --hard" or "git read-tree --reset -u", we used to first forget about
the new path (via read_cache_unmerged) and then matched the working tree
to what is recorded in the index, thus ending up leaving the new path in
the work tree.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Junio C Hamano <gitster@pobox.com> writes:

 > Linus Torvalds <torvalds@linux-foundation.org> writes:
 >
 >> On Wed, 15 Oct 2008, Linus Torvalds wrote:
 >>> 
 >> It's quite possible that we should remove unmerged entries. Except that's 
 >> not how our internal 'read_cache_unmerged()' function works. It really 
 >> just ignores them, and throws them on the floor. We _could_ try to just 
 >> turn them into a (since) stage-0 entry.
 >>
 >> Junio?
 >
 > I am not sure what should happen when we can't drop the unmerged entry
 > down to stage-0 due to D/F conflicts, though.  IIRC, read-tree proper
 > would not touch the work tree in such a case, but merge-recursive creates
 > our and their versions with funny suffixes, which will not be known to the
 > index and will be left in the working tree.

 I am still unsure what we should do when we hit D/F conflicts; this one
 simply replaces but it may be safer to drop ADD_CACHE_OK_TO_REPLACE from
 the options to trigger an error in such a case.  I dunno.

 read-cache.c               |   32 +++++++++++++++++++-------------
 t/t1005-read-tree-reset.sh |   30 ++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index c229fd4..efbab6a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1489,25 +1489,31 @@ int write_index(const struct index_state *istate, int newfd)
 int read_index_unmerged(struct index_state *istate)
 {
 	int i;
-	struct cache_entry **dst;
-	struct cache_entry *last = NULL;
+	int unmerged = 0;
 
 	read_index(istate);
-	dst = istate->cache;
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
-		if (ce_stage(ce)) {
-			remove_name_hash(ce);
-			if (last && !strcmp(ce->name, last->name))
-				continue;
-			cache_tree_invalidate_path(istate->cache_tree, ce->name);
-			last = ce;
+		struct cache_entry *new_ce;
+		int size, len, option;
+
+		if (!ce_stage(ce))
 			continue;
-		}
-		*dst++ = ce;
+		unmerged = 1;
+		len = strlen(ce->name);
+		size = cache_entry_size(len);
+		new_ce = xcalloc(1, size);
+		hashcpy(new_ce->sha1, ce->sha1);
+		memcpy(new_ce->name, ce->name, len);
+		new_ce->ce_flags = create_ce_flags(len, 0);
+		new_ce->ce_mode = ce->ce_mode;
+		option = ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE;
+		if (add_index_entry(istate, new_ce, option))
+			return error("%s: cannot drop to stage #0",
+				     ce->name);
+		i = index_name_pos(istate, new_ce->name, len);
 	}
-	istate->cache_nr = dst - istate->cache;
-	return !!last;
+	return unmerged;
 }
 
 struct update_callback_data
diff --git a/t/t1005-read-tree-reset.sh b/t/t1005-read-tree-reset.sh
index b0d31f5..0cd519c 100755
--- a/t/t1005-read-tree-reset.sh
+++ b/t/t1005-read-tree-reset.sh
@@ -27,4 +27,34 @@ test_expect_success 'reset should work' '
   test_cmp expect actual
 '
 
+test_expect_success 'reset should remove remnants from a failed merge' '
+  git read-tree --reset -u HEAD &&
+  git ls-files -s >expect &&
+  sha1=$(git rev-parse :new) &&
+  (
+	echo "100644 $sha1 1	old"
+	echo "100644 $sha1 3	old"
+  ) | git update-index --index-info &&
+  >old &&
+  git ls-files -s &&
+  git read-tree --reset -u HEAD &&
+  git ls-files -s >actual &&
+  ! test -f old
+'
+
+test_expect_success 'Porcelain reset should remove remnants too' '
+  git read-tree --reset -u HEAD &&
+  git ls-files -s >expect &&
+  sha1=$(git rev-parse :new) &&
+  (
+	echo "100644 $sha1 1	old"
+	echo "100644 $sha1 3	old"
+  ) | git update-index --index-info &&
+  >old &&
+  git ls-files -s &&
+  git reset --hard &&
+  git ls-files -s >actual &&
+  ! test -f old
+'
+
 test_done
-- 
1.6.0.2.717.gc6f0a
