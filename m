From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 5/5] branch: allow pattern arguments
Date: Sun, 28 Aug 2011 16:54:32 +0200
Message-ID: <0c487086643fbf0334140365f20fef62242b7dac.1314543252.git.git@drmicha.warpmail.net>
References: <cover.1314367414.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 16:55:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxglP-000078-57
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 16:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557Ab1H1Oyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 10:54:55 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50801 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751458Ab1H1Oyt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Aug 2011 10:54:49 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 73ACB20F55;
	Sun, 28 Aug 2011 10:54:49 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute5.internal (MEProxy); Sun, 28 Aug 2011 10:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=8x
	4E9oLnJ30YRZHk6+u8K/hGyDU=; b=twqBgesIfkiAmilzh89LNhLX8kbfzAZZaK
	wW0S6yf1bb7ToWX6zzvw6vOYbpGoMRHJ08chJOpl1vzr9kfgXkXDdoo3EmJS+d/X
	Ko3kjz5mOYr76wjgZA5SZzHvX2WEB41EYjxEposJwpzv8xAX8NRzFZK+HykKBSQx
	MH9t4q2kY=
X-Sasl-enc: anZZDC9fmbDwETOQhhNcwxhseF19VSJpVgUmJ2FiiUuP 1314543288
Received: from localhost (p54859364.dip0.t-ipconnect.de [84.133.147.100])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 88534A00251;
	Sun, 28 Aug 2011 10:54:48 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.845.gc3c05
In-Reply-To: <cover.1314367414.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1314543252.git.git@drmicha.warpmail.net>
References: <cover.1314543252.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180273>

Allow pattern arguments for the list mode just like for git tag -l.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-branch.txt |    8 ++++++--
 builtin/branch.c             |   24 +++++++++++++++++++++---
 t/t3203-branch-output.sh     |   10 ++++++++++
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index ac278fb..2b8bc84 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git branch' [--color[=<when>] | --no-color] [-r | -a]
 	[--list] [-v [--abbrev=<length> | --no-abbrev]]
-	[(--merged | --no-merged | --contains) [<commit>]]
+	[(--merged | --no-merged | --contains) [<commit>]] [<pattern>...]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
 'git branch' (-d | -D) [-r] <branchname>...
@@ -22,6 +22,9 @@ With no arguments, existing branches are listed and the current branch will
 be highlighted with an asterisk.  Option `-r` causes the remote-tracking
 branches to be listed, and option `-a` shows both. This list mode is also
 activated by the `--list` and `-v` options (see below).
+<pattern> restricts the output to matching branches, the pattern is a shell
+wildcard (i.e., matched using fnmatch(3))
+Multiple patterns may be given; if any of them matches, the tag is shown.
 
 With `--contains`, shows only the branches that contain the named commit
 (in other words, the branches whose tip commits are descendants of the
@@ -112,7 +115,8 @@ OPTIONS
 	List both remote-tracking branches and local branches.
 
 --list::
-	Activate the list mode.
+	Activate the list mode. `git branch <pattern>` would try to create a branch,
+	use `git branch --list <pattern>` to list matching branches.
 
 -v::
 --verbose::
diff --git a/builtin/branch.c b/builtin/branch.c
index 4a33b07..e6bef49 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -260,9 +260,22 @@ static char *resolve_symref(const char *src, const char *prefix)
 
 struct append_ref_cb {
 	struct ref_list *ref_list;
+	const char **pattern;
 	int ret;
 };
 
+static int match_patterns(const char **pattern, const char *refname)
+{
+	if (!*pattern)
+		return 1; /* no pattern always matches */
+	while (*pattern) {
+		if (!fnmatch(*pattern, refname, 0))
+			return 1;
+		pattern++;
+	}
+	return 0;
+}
+
 static int append_ref(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct append_ref_cb *cb = (struct append_ref_cb *)(cb_data);
@@ -297,6 +310,9 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	if ((kind & ref_list->kinds) == 0)
 		return 0;
 
+	if (!match_patterns(cb->pattern, refname))
+		return 0;
+
 	commit = NULL;
 	if (ref_list->verbose || ref_list->with_commit || merge_filter != NO_FILTER) {
 		commit = lookup_commit_reference_gently(sha1, 1);
@@ -492,7 +508,7 @@ static void show_detached(struct ref_list *ref_list)
 	}
 }
 
-static int print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit)
+static int print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit, const char **pattern)
 {
 	int i;
 	struct append_ref_cb cb;
@@ -506,6 +522,7 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	if (merge_filter != NO_FILTER)
 		init_revisions(&ref_list.revs, NULL);
 	cb.ref_list = &ref_list;
+	cb.pattern = pattern;
 	cb.ret = 0;
 	for_each_rawref(append_ref, &cb);
 	if (merge_filter != NO_FILTER) {
@@ -523,7 +540,7 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
 
 	detached = (detached && (kinds & REF_LOCAL_BRANCH));
-	if (detached)
+	if (detached && match_patterns(pattern, "HEAD"))
 		show_detached(&ref_list);
 
 	for (i = 0; i < ref_list.index; i++) {
@@ -701,7 +718,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
 	else if (list)
-		return print_ref_list(kinds, detached, verbose, abbrev, with_commit);
+		return print_ref_list(kinds, detached, verbose, abbrev,
+				      with_commit, argv);
 	else if (rename && (argc == 1))
 		rename_branch(head, argv[0], rename > 1);
 	else if (rename && (argc == 2))
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 61e095c..f2b294b 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -81,6 +81,16 @@ test_expect_success 'git branch -v shows branch summaries' '
 '
 
 cat >expect <<'EOF'
+two
+one
+EOF
+test_expect_success 'git branch -v pattern shows branch summaries' '
+	git branch -v branch* >tmp &&
+	awk "{print \$NF}" <tmp >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
 * (no branch)
   branch-one
   branch-two
-- 
1.7.6.845.gc3c05
