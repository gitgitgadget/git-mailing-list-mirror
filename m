From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv4 5/5] branch: allow pattern arguments
Date: Thu,  8 Sep 2011 16:25:58 +0200
Message-ID: <26dcd6b4b97f848c4a417f07804a01be87188403.1315491900.git.git@drmicha.warpmail.net>
References: <4E6889DF.7030404@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 16:26:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1fYc-0001yn-U9
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 16:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268Ab1IHO0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 10:26:09 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:46690 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750848Ab1IHO0E (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2011 10:26:04 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 836DF29ACB;
	Thu,  8 Sep 2011 10:26:04 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Thu, 08 Sep 2011 10:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=NT
	4dnU+TrOgNK76rX4hIYbCb23I=; b=FefnK5Fw3BNCTQogtB9k6d7hlOiPIdksJk
	iQrG2zWlBZ80wpJec7aF+jcbwoke3twiyEk2zOP6cFE9GsRZZiTN6/qD+4S52tye
	2Lozw3V615KWxhW32SO0uU7N6/jnl17DsIFavq+ICxoKnqqka+6yeOOQSOihCwGM
	z2uL68ugc=
X-Sasl-enc: 58MhptrlWWA0FnJSJbAMwJucB80k/9tRymxKvFVSL6Jr 1315491963
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DA3C278020D;
	Thu,  8 Sep 2011 10:26:03 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.469.g9eb94
In-Reply-To: <4E6889DF.7030404@drmicha.warpmail.net>
In-Reply-To: <cover.1315491900.git.git@drmicha.warpmail.net>
References: <cover.1315491900.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180974>

Allow pattern arguments for the list mode just like for git tag -l.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-branch.txt |    8 ++++++--
 builtin/branch.c             |   24 +++++++++++++++++++++---
 t/t3203-branch-output.sh     |   23 +++++++++++++++++++++++
 3 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 26024b6..2e27ee4 100644
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
 activated by the `--list` option (see below).
+<pattern> restricts the output to matching branches, the pattern is a shell
+wildcard (i.e., matched using fnmatch(3)).
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
index b17ad26..099c75c 100644
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
@@ -707,7 +724,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
index 97d10b1..76fe7e0 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -38,6 +38,15 @@ test_expect_success 'git branch --list shows local branches' '
 '
 
 cat >expect <<'EOF'
+  branch-one
+  branch-two
+EOF
+test_expect_success 'git branch --list pattern shows matching local branches' '
+	git branch --list branch* >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
   origin/HEAD -> origin/branch-one
   origin/branch-one
   origin/branch-two
@@ -72,6 +81,20 @@ test_expect_success 'git branch -v shows branch summaries' '
 '
 
 cat >expect <<'EOF'
+two
+one
+EOF
+test_expect_success 'git branch --list -v pattern shows branch summaries' '
+	git branch --list -v branch* >tmp &&
+	awk "{print \$NF}" <tmp >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git branch -v pattern does not show branch summaries' '
+	test_must_fail git branch -v branch*
+'
+
+cat >expect <<'EOF'
 * (no branch)
   branch-one
   branch-two
-- 
1.7.7.rc0.469.g9eb94
