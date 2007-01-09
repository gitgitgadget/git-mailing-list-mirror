From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 6/6] Teach "git-merge-base --check-ancestry" about refs.
Date: Tue, 09 Jan 2007 02:41:30 -0800
Message-ID: <7v7ivwo52d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 09 11:41:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4EQO-0003nM-Iu
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 11:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbXAIKlg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 05:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbXAIKlg
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 05:41:36 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:35383 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbXAIKlb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 05:41:31 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109104131.OGOI20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Tue, 9 Jan 2007 05:41:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8yhm1W00K1kojtg0000000; Tue, 09 Jan 2007 05:41:47 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36346>

"git-merge-base --all -c $commit" is used to see if $commit is
reachable from any ref.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-merge-base.txt |    6 ++++-
 builtin-merge-base.c             |   45 ++++++++++++++++++++++++++++++++-----
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 7d4d027..21b5dd3 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git-merge-base' [--all] <commit> <commit>
-'git-merge-base' --check-ancestry <commit> <commit>...
+'git-merge-base' [--all] --check-ancestry <commit> <commit>...
 
 DESCRIPTION
 -----------
@@ -33,6 +33,10 @@ OPTIONS
 --all::
 	Output all common ancestors for the two commits instead of
 	just one.
++
+When used with `--check-ancestry` option, this uses all the
+commits that are at the tip of all refs to see if the given
+commit is an ancestor of any of them.
 
 --check-ancestry::
 
diff --git a/builtin-merge-base.c b/builtin-merge-base.c
index fa07352..eeb8763 100644
--- a/builtin-merge-base.c
+++ b/builtin-merge-base.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "commit.h"
+#include "refs.h"
 
 static const char merge_base_usage[] =
 "git-merge-base [--all] <commit> <commit> | --check-ancestry <commit> <commit>...";
@@ -21,13 +22,42 @@ static int show_merge_base(struct commit *rev1, struct commit *rev2, int show_al
 	return 0;
 }
 
-static int check_ancestry(int argc, const char **argv)
+struct add_one_ref_cb {
+	struct commit ***reference;
+	int n;
+};
+
+static int add_one_ref(const char *name, const unsigned char *sha1, int flags, void *cb_data)
+{
+	struct add_one_ref_cb *cb = (struct add_one_ref_cb *) cb_data;
+	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
+
+	if (!commit)
+		return 0;
+	cb->n++;
+	*cb->reference = xrealloc(*cb->reference,
+				  sizeof(struct commit *) * cb->n);
+	(*cb->reference)[cb->n-1] = commit;
+	return 0;
+}
+
+static int add_all_refs(struct commit ***reference, int n)
+{
+	struct add_one_ref_cb cb;
+
+	cb.reference = reference;
+	cb.n = n;
+	for_each_ref(add_one_ref, &cb);
+	return cb.n;
+}
+
+static int check_ancestry(int all, int argc, const char **argv)
 {
 	struct commit *one, *two, **reference;
 	unsigned char sha1[20];
 	int i;
 
-	if (argc < 2)
+	if (argc < 1 || (!all && argc < 2))
 		usage(merge_base_usage);
 	if (get_sha1(argv[0], sha1))
 		die("Not a valid object name %s", argv[0]);
@@ -44,7 +74,12 @@ static int check_ancestry(int argc, const char **argv)
 			return 1;
 		reference[i - 1] = two;
 	}
-	return !!in_merge_bases(one, reference, argc - 1);
+	i = argc - 1;
+
+	if (all)
+		i = add_all_refs(&reference, i);
+
+	return !in_merge_bases(one, reference, i);
 }
 
 int cmd_merge_base(int argc, const char **argv, const char *prefix)
@@ -68,9 +103,7 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	}
 
 	if (check) {
-		if (show_all)
-			die("--all and --check-ancestry are mutually incompatible");
-		return check_ancestry(argc - 1, argv + 1);
+		return check_ancestry(show_all, argc - 1, argv + 1);
 	}
 
 	if (argc != 3)
-- 
1.4.4.4.g564d
