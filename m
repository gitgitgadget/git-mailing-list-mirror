From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH 8/9] merge-recursive: allow storing conflict hunks in index
Date: Tue,  4 Feb 2014 23:17:37 +0100
Message-ID: <adf5e5bd91a6441f0fea7412a6507ac5fd9f9a6f.1391549294.git.tr@thomasrast.ch>
References: <cover.1391549294.git.tr@thomasrast.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 23:18:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAoKU-0002Bf-7X
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 23:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934746AbaBDWSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 17:18:34 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:54777 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935410AbaBDWRy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 17:17:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 5244E4D658C
	for <git@vger.kernel.org>; Tue,  4 Feb 2014 23:17:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Dt2Uxu4TJd08 for <git@vger.kernel.org>;
	Tue,  4 Feb 2014 23:17:51 +0100 (CET)
Received: from linux.local (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 3AE764D65EC
	for <git@vger.kernel.org>; Tue,  4 Feb 2014 23:17:43 +0100 (CET)
X-Mailer: git-send-email 1.9.rc2.232.gdd31389
In-Reply-To: <cover.1391549294.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241573>

Add a --conflicts-in-index option to merge-recursive, which instructs
it to always store the 3-way merged result in the index.  (Normally it
only does so in recursive invocations, but not for the final result.)

This serves as a building block for the "remerge diff" feature coming
up in a subsequent patch.  The external option lets us easily use it
from tests, where we'd otherwise need a new test-* helper to access
the feature.

Furthermore, it might occasionally be useful for scripts that want to
look at the result of invoking git-merge without tampering with the
worktree.  They could already get the _conflicts_ with --index-only,
but not (conveniently) the conflict-hunk formatted files that would
normally be written to the worktree.

Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---
 Documentation/merge-strategies.txt |  5 +++++
 merge-recursive.c                  |  4 ++++
 merge-recursive.h                  |  1 +
 t/t3030-merge-recursive.sh         | 20 ++++++++++++++++++++
 4 files changed, 30 insertions(+)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 2934e99..3468d99 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -96,6 +96,11 @@ index-only;;
 	Write the merge result only to the index; do not touch the
 	worktree.
 
+conflicts-in-index;;
+	For conflicted files, write 3-way merged contents with
+	conflict hunks to the index, instead of leaving their entries
+	unresolved.
+
 octopus::
 	This resolves cases with more than two heads, but refuses to do
 	a complex merge that needs manual resolution.  It is
diff --git a/merge-recursive.c b/merge-recursive.c
index f59c1d3..b682812 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -724,6 +724,8 @@ static void update_file_flags(struct merge_options *o,
 			      int update_cache,
 			      int update_wd)
 {
+	if (o->conflicts_in_index)
+		update_cache = 1;
 	if (o->call_depth || o->no_worktree)
 		update_wd = 0;
 
@@ -2098,6 +2100,8 @@ int parse_merge_opt(struct merge_options *o, const char *s)
 	}
 	else if (!strcmp(s, "index-only"))
 		o->no_worktree = 1;
+	else if (!strcmp(s, "conflicts-in-index"))
+		o->conflicts_in_index = 1;
 	else
 		return -1;
 	return 0;
diff --git a/merge-recursive.h b/merge-recursive.h
index d8dd7a1..9b8e20b 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -16,6 +16,7 @@ struct merge_options {
 	unsigned buffer_output : 1;
 	unsigned renormalize : 1;
 	unsigned no_worktree : 1; /* do not touch worktree */
+	unsigned conflicts_in_index : 1; /* index will contain conflict hunks */
 	long xdl_opts;
 	int verbosity;
 	int diff_rename_limit;
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 2f3a16c..4192fd3 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -309,6 +309,26 @@ test_expect_success 'merge-recursive --index-only' '
 	test_cmp expected-diff actual-diff
 '
 
+test_expect_success 'merge-recursive --index-only --conflicts-in-index' '
+	# first pass: do a merge as usual to obtain "expected"
+	rm -fr [abcd] &&
+	git checkout -f "$c2" &&
+	test_expect_code 1 git merge-recursive "$c0" -- "$c2" "$c1" &&
+	git add [abcd] &&
+	git ls-files -s >expected &&
+	# second pass: actual test
+	rm -fr [abcd] &&
+	git checkout -f "$c2" &&
+	test_expect_code 1 \
+		git merge-recursive --index-only --conflicts-in-index \
+		"$c0" -- "$c2" "$c1" &&
+	git ls-files -s >actual &&
+	test_cmp expected actual &&
+	git diff HEAD >actual-diff &&
+	: >expected-diff &&
+	test_cmp expected-diff actual-diff
+'
+
 test_expect_success 'fail if the index has unresolved entries' '
 
 	rm -fr [abcd] &&
-- 
1.9.rc2.232.gdd31389
