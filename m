From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v2] merge-base: teach "git merge-base" to accept more
 than 2 arguments
Date: Sun, 27 Jul 2008 05:33:24 +0200
Message-ID: <20080727053324.b54fe48e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 27 05:30:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMwxy-000084-0O
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 05:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075AbYG0D3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 23:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755246AbYG0D3i
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 23:29:38 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:59099 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754936AbYG0D3h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 23:29:37 -0400
Received: from smtp4-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 985EC3EA0BA;
	Sun, 27 Jul 2008 05:29:35 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g19.free.fr (Postfix) with SMTP id 248C23EA0B8;
	Sun, 27 Jul 2008 05:29:35 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90303>

Before this patch "git merge-base" accepted only 2 arguments, so
only merge bases between 2 references could be computed.

The purpose of this patch is to make "git merge-base" accept more
than 2 arguments, so that the merge bases between the first given
reference and all the other references can be computed.

This is easily implemented because the "get_merge_bases_many"
function in "commit.c" already implements the needed computation.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-merge-base.txt |   27 +++++++++++++++-------
 builtin-merge-base.c             |   45 ++++++++++++++++++++++++++-----------
 commit.h                         |    2 +
 3 files changed, 51 insertions(+), 23 deletions(-)

	Hi,

	No tests yet, but the following changes since the first version:

	- added documentation
	- don't use static variables anymore

	Thanks for your comments,
	Christian.

diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 1a7ecbf..463c230 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -8,26 +8,35 @@ git-merge-base - Find as good common ancestors as possible for a merge
 
 SYNOPSIS
 --------
-'git merge-base' [--all] <commit> <commit>
+'git merge-base' [--all] <commit> <commit>...
 
 DESCRIPTION
 -----------
 
-'git-merge-base' finds as good a common ancestor as possible between
-the two commits. That is, given two commits A and B, `git merge-base A
-B` will output a commit which is reachable from both A and B through
-the parent relationship.
+'git-merge-base' finds as good common ancestors as possible between
+the first commit and the other commits. The default behavior is to
+output only one as good as possible common ancestor, called a merge
+base.
+
+For example, given two commits A and B, `git merge-base A B` will
+output a commit which is reachable from both A and B through the
+parent relationship.
+
+Given three commits A, B and C, `git merge-base A B C` will output a
+commit which is reachable through the parent relationship from both A
+and B, or from both A and C.
 
 Given a selection of equally good common ancestors it should not be
 relied on to decide in any particular way.
 
-The 'git-merge-base' algorithm is still in flux - use the source...
-
 OPTIONS
 -------
 --all::
-	Output all common ancestors for the two commits instead of
-	just one.
+	Output all merge bases for the commits instead of just one. No
+	merge bases in the output should be an ancestor of another
+	merge base in the output. Each common ancestor of the first
+	commit and any of the other commits passed as arguments,
+	should be an ancestor of one of the merge bases in the output.
 
 Author
 ------
diff --git a/builtin-merge-base.c b/builtin-merge-base.c
index 1cb2925..f2c9756 100644
--- a/builtin-merge-base.c
+++ b/builtin-merge-base.c
@@ -2,9 +2,11 @@
 #include "cache.h"
 #include "commit.h"
 
-static int show_merge_base(struct commit *rev1, struct commit *rev2, int show_all)
+static int show_merge_base(struct commit *rev1, int prev2_nr,
+			   struct commit **prev2, int show_all)
 {
-	struct commit_list *result = get_merge_bases(rev1, rev2, 0);
+	struct commit_list *result = get_merge_bases_many(rev1, prev2_nr,
+							  prev2, 0);
 
 	if (!result)
 		return 1;
@@ -20,12 +22,20 @@ static int show_merge_base(struct commit *rev1, struct commit *rev2, int show_al
 }
 
 static const char merge_base_usage[] =
-"git merge-base [--all] <commit-id> <commit-id>";
+"git merge-base [--all] <commit-id> <commit-id>...";
+
+static struct commit *get_commit_reference(const char *arg)
+{
+	unsigned char revkey[20];
+	if (get_sha1(arg, revkey))
+		die("Not a valid object name %s", arg);
+	return lookup_commit_reference(revkey);
+}
 
 int cmd_merge_base(int argc, const char **argv, const char *prefix)
 {
-	struct commit *rev1, *rev2;
-	unsigned char rev1key[20], rev2key[20];
+	struct commit *rev1, **prev2 = NULL;
+	size_t prev2_nr = 0, prev2_alloc = 0;
 	int show_all = 0;
 
 	git_config(git_default_config, NULL);
@@ -38,15 +48,22 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 			usage(merge_base_usage);
 		argc--; argv++;
 	}
-	if (argc != 3)
+	if (argc < 3)
 		usage(merge_base_usage);
-	if (get_sha1(argv[1], rev1key))
-		die("Not a valid object name %s", argv[1]);
-	if (get_sha1(argv[2], rev2key))
-		die("Not a valid object name %s", argv[2]);
-	rev1 = lookup_commit_reference(rev1key);
-	rev2 = lookup_commit_reference(rev2key);
-	if (!rev1 || !rev2)
+
+	rev1 = get_commit_reference(argv[1]);
+	if (!rev1)
 		return 1;
-	return show_merge_base(rev1, rev2, show_all);
+	argc--; argv++;
+
+	do {
+		struct commit *rev2 = get_commit_reference(argv[1]);
+		if (!rev2)
+			return 1;
+		ALLOC_GROW(prev2, prev2_nr + 1, prev2_alloc);
+		prev2[prev2_nr++] = rev2;
+		argc--; argv++;
+	} while (argc > 1);
+
+	return show_merge_base(rev1, prev2_nr, prev2, show_all);
 }
diff --git a/commit.h b/commit.h
index 77de962..4829a5c 100644
--- a/commit.h
+++ b/commit.h
@@ -121,6 +121,8 @@ int read_graft_file(const char *graft_file);
 struct commit_graft *lookup_commit_graft(const unsigned char *sha1);
 
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2, int cleanup);
+extern struct commit_list *get_merge_bases_many(struct commit *one,
+		int n, struct commit **twos, int cleanup);
 extern struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 
 extern int register_shallow(const unsigned char *sha1);
-- 
1.6.0.rc0.43.g00eb.dirty
