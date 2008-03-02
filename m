From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] diff: show submodule object name when available even on
 the work tree side
Date: Sun,  2 Mar 2008 01:43:32 -0800
Message-ID: <1204451012-17487-4-git-send-email-gitster@pobox.com>
References: <1204451012-17487-1-git-send-email-gitster@pobox.com>
 <1204451012-17487-2-git-send-email-gitster@pobox.com>
 <1204451012-17487-3-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 10:45:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVkko-0000FY-Sz
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 10:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040AbYCBJoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 04:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753204AbYCBJoI
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 04:44:08 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58339 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116AbYCBJoD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 04:44:03 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 521D62251
	for <git@vger.kernel.org>; Sun,  2 Mar 2008 04:44:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 78B192250 for <git@vger.kernel.org>; Sun,  2 Mar 2008 04:43:59 -0500
 (EST)
X-Mailer: git-send-email 1.5.4.3.468.g36990
In-Reply-To: <1204451012-17487-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75758>

Traditionally, we consistently showed 0{40} when work tree side was
different from what it was being compared against.  This was primarily
because it did not make sense to re-hash potentially large blobs every
time diff-files and non-cached diff-index were asked for.

However, we can afford to read from submodule HEAD, as it is much cheaper
than hashing blobs.

This makes the output somewhat inconsistent, but it probably is a good
move to give easily available information than not giving it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This could be enhanced to also hash symlink blobs as they tend to be
   very short.

   HOWEVER.

   This changes the semantics established since almost day-one of git (at
   least this 0{40} convention can be traced back to show-diff as of Apr
   26, 2005), and tests (e.g. t3040) demonstrate that it breaks existing
   callers such as git-commit.

   Which means that I am sending this out only for discussion at this
   time, not for inclusion in the near term.

 diff-lib.c                |   32 +++++++++++++++++++++++++++++++-
 t/t4027-diff-submodule.sh |    2 +-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 4581b59..94e17a6 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -10,6 +10,26 @@
 #include "cache-tree.h"
 #include "path-list.h"
 #include "unpack-trees.h"
+#include "refs.h"
+
+/*
+ * Traditionally, we have _always_ showed 0{40} on the work tree
+ * side if there is a difference.  However, reading from HEAD of
+ * a submodule is much cheaper than rehashing regular blob objects.
+ */
+static const unsigned char *get_gitlink_data(const char *path)
+{
+	static unsigned char subhead[20];
+	/*
+	 * NOTE: strictly speaking, this makes it non re-entrant, but
+	 * we know the nature of the callchain makes it very
+	 * short-lived --- the caller will give this to
+	 * diff_addremove() or diff_change() immediately.
+	 */
+	if (!resolve_gitlink_ref(path, "HEAD", subhead))
+		return subhead;
+	return null_sha1;
+}
 
 /*
  * diff-files
@@ -349,6 +369,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		struct stat st;
 		unsigned int oldmode, newmode;
 		struct cache_entry *ce = active_cache[i];
+		const unsigned char *worktree_sha1;
 		int changed;
 
 		if (DIFF_OPT_TST(&revs->diffopt, QUIET) &&
@@ -454,8 +475,15 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			continue;
 		oldmode = ce->ce_mode;
 		newmode = ce_mode_from_stat(ce, st.st_mode);
+
+		if (S_ISGITLINK(newmode))
+			worktree_sha1 = get_gitlink_data(ce->name);
+		else if (changed)
+			worktree_sha1 = null_sha1;
+		else
+			worktree_sha1 = ce->sha1;
 		diff_change(&revs->diffopt, oldmode, newmode,
-			    ce->sha1, (changed ? null_sha1 : ce->sha1),
+			    ce->sha1, worktree_sha1,
 			    ce->name, NULL);
 
 	}
@@ -501,6 +529,8 @@ static int get_stat_data(struct cache_entry *ce,
 		if (changed) {
 			mode = ce_mode_from_stat(ce, st.st_mode);
 			sha1 = null_sha1;
+			if (S_ISGITLINK(mode))
+				sha1 = get_gitlink_data(ce->name);
 		}
 	}
 
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 3d2d081..c1c2500 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -32,7 +32,7 @@ test_expect_success setup '
 		cd sub &&
 		git rev-list HEAD
 	) &&
-	echo ":160000 160000 $3 $_z40 M	sub" >expect
+	echo ":160000 160000 $3 $2 M	sub" >expect
 '
 
 test_expect_success 'git diff --raw HEAD' '
-- 
1.5.4.3.468.g36990

