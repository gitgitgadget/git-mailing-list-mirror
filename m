From: Miklos Vajna <vmiklos@suse.cz>
Subject: [PATCH] merge: allow using --no-ff and --ff-only at the same time
Date: Mon, 1 Jul 2013 09:01:43 +0200
Message-ID: <20130701070143.GB17269@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 01 09:01:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtY7Y-000353-BE
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 09:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597Ab3GAHBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 03:01:52 -0400
Received: from cantor2.suse.de ([195.135.220.15]:42907 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008Ab3GAHBw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 03:01:52 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id B7D15A535C;
	Mon,  1 Jul 2013 09:01:48 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229292>

1347483 (Teach 'git merge' and 'git pull' the option --ff-only,
2009-10-29) says this is not allowed, as they contradict each other.

However, --ff-only is about asserting the input of the merge, and
--no-ff is about instructing merge to always create a merge commit, i.e.
it makes sense to use these options together in some workflow, e.g. when
branches are integrated by rebasing then merging, and the maintainer
wants to be sure the branch is rebased.

Signed-off-by: Miklos Vajna <vmiklos@suse.cz>
---
 builtin/merge.c  | 12 ++++++++----
 t/t7600-merge.sh | 11 ++++++++---
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 2ebe732..7026ce0 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1162,9 +1162,6 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		option_commit = 0;
 	}
 
-	if (!allow_fast_forward && fast_forward_only)
-		die(_("You cannot combine --no-ff with --ff-only."));
-
 	if (!abort_current_merge) {
 		if (!argc) {
 			if (default_to_upstream)
@@ -1433,7 +1430,14 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (fast_forward_only)
+	/*
+	 * If --ff-only was used without --no-ff, or: --ff-only and --no-ff was
+	 * used at the same time, and this is not a fast-forward.
+	 */
+	if (fast_forward_only && (allow_fast_forward || remoteheads->next ||
+				common->next ||
+				hashcmp(common->item->object.sha1,
+					head_commit->object.sha1)))
 		die(_("Not possible to fast-forward, aborting."));
 
 	/* We are going to make a new commit. */
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 460d8eb..bf3d9b2 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -497,9 +497,14 @@ test_expect_success 'combining --squash and --no-ff is refused' '
 	test_must_fail git merge --no-ff --squash c1
 '
 
-test_expect_success 'combining --ff-only and --no-ff is refused' '
-	test_must_fail git merge --ff-only --no-ff c1 &&
-	test_must_fail git merge --no-ff --ff-only c1
+test_expect_success 'combining --ff-only and --no-ff (ff is possible)' '
+	git reset --hard c0 &&
+	git merge --ff-only --no-ff c1
+'
+
+test_expect_success 'combining --ff-only and --no-ff (ff is not possible)' '
+	git reset --hard c1 &&
+	test_must_fail git merge --ff-only --no-ff c2
 '
 
 test_expect_success 'merge c0 with c1 (ff overrides no-ff)' '
-- 
1.8.1.4
