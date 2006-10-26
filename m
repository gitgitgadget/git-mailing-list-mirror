X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] Make git-cherry handle root trees
Date: Thu, 26 Oct 2006 18:52:39 +0200
Message-ID: <4540E7D7.1000208@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 16:53:29 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30238>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd8Tq-0006DA-9k for gcvg-git@gmane.org; Thu, 26 Oct
 2006 18:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423488AbWJZQxT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 12:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423491AbWJZQxT
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 12:53:19 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de
 ([217.172.187.230]:26814 "EHLO neapel230.server4you.de") by vger.kernel.org
 with ESMTP id S1423488AbWJZQxS (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26
 Oct 2006 12:53:18 -0400
Received: from [10.0.1.3] (p508E46C3.dip.t-dialin.net [80.142.70.195]) by
 neapel230.server4you.de (Postfix) with ESMTP id DD282802B; Thu, 26 Oct 2006
 18:53:16 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This patch on top of 'next' makes built-in git-cherry handle root
commits.

It moves the static function log-tree.c::diff_root_tree() to
tree-diff.c and makes it more similar to diff_tree_sha1() by
shuffling around arguments and factoring out the call to
log_tree_diff_flush().  Consequently the name is changed to
diff_root_tree_sha1().  It is a version of diff_tree_sha1() that
compares the empty tree (= root tree) against a single 'real' tree.

This function is then used in get_patch_id() to compute patch IDs
for initial commits instead of SEGFAULTing, as the current code
does if confronted with parentless commits.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

Example for testing: 'git-cherry v0.99.1 v0.99.2' in the git repo
hits root trees.

 builtin-log.c |    7 +++++--
 diff.h        |    2 ++
 log-tree.c    |   26 ++++----------------------
 tree-diff.c   |   18 ++++++++++++++++++
 4 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index fc5e476..fedb013 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -171,8 +171,11 @@ static void reopen_stdout(struct commit
 static int get_patch_id(struct commit *commit, struct diff_options *options,
 		unsigned char *sha1)
 {
-	diff_tree_sha1(commit->parents->item->object.sha1, commit->object.sha1,
-			"", options);
+	if (commit->parents)
+		diff_tree_sha1(commit->parents->item->object.sha1,
+		               commit->object.sha1, "", options);
+	else
+		diff_root_tree_sha1(commit->object.sha1, "", options);
 	diffcore_std(options);
 	return diff_flush_patch_id(options, sha1);
 }
diff --git a/diff.h b/diff.h
index ce3058e..ac7b21c 100644
--- a/diff.h
+++ b/diff.h
@@ -102,6 +102,8 @@ extern int diff_tree(struct tree_desc *t
 		     const char *base, struct diff_options *opt);
 extern int diff_tree_sha1(const unsigned char *old, const unsigned char *new,
 			  const char *base, struct diff_options *opt);
+extern int diff_root_tree_sha1(const unsigned char *new, const char *base,
+                               struct diff_options *opt);
 
 struct combine_diff_path {
 	struct combine_diff_path *next;
diff --git a/log-tree.c b/log-tree.c
index fbe1399..8787df5 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -252,26 +252,6 @@ int log_tree_diff_flush(struct rev_info
 	return 1;
 }
 
-static int diff_root_tree(struct rev_info *opt,
-			  const unsigned char *new, const char *base)
-{
-	int retval;
-	void *tree;
-	struct tree_desc empty, real;
-
-	tree = read_object_with_reference(new, tree_type, &real.size, NULL);
-	if (!tree)
-		die("unable to read root tree (%s)", sha1_to_hex(new));
-	real.buf = tree;
-
-	empty.buf = "";
-	empty.size = 0;
-	retval = diff_tree(&empty, &real, base, &opt->diffopt);
-	free(tree);
-	log_tree_diff_flush(opt);
-	return retval;
-}
-
 static int do_diff_combined(struct rev_info *opt, struct commit *commit)
 {
 	unsigned const char *sha1 = commit->object.sha1;
@@ -297,8 +277,10 @@ static int log_tree_diff(struct rev_info
 	/* Root commit? */
 	parents = commit->parents;
 	if (!parents) {
-		if (opt->show_root_diff)
-			diff_root_tree(opt, sha1, "");
+		if (opt->show_root_diff) {
+			diff_root_tree_sha1(sha1, "", &opt->diffopt);
+			log_tree_diff_flush(opt);
+		}
 		return !opt->loginfo;
 	}
 
diff --git a/tree-diff.c b/tree-diff.c
index 7e2f4f0..37d235e 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -215,6 +215,24 @@ int diff_tree_sha1(const unsigned char *
 	return retval;
 }
 
+int diff_root_tree_sha1(const unsigned char *new, const char *base, struct diff_options *opt)
+{
+	int retval;
+	void *tree;
+	struct tree_desc empty, real;
+
+	tree = read_object_with_reference(new, tree_type, &real.size, NULL);
+	if (!tree)
+		die("unable to read root tree (%s)", sha1_to_hex(new));
+	real.buf = tree;
+
+	empty.size = 0;
+	empty.buf = "";
+	retval = diff_tree(&empty, &real, base, opt);
+	free(tree);
+	return retval;
+}
+
 static int count_paths(const char **paths)
 {
