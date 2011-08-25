From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/5] branch: allow pattern arguments
Date: Thu, 25 Aug 2011 10:30:17 +0200
Message-ID: <00847b8ee77129433a5d908ad25c9ebaf7fa7130.1314259226.git.git@drmicha.warpmail.net>
References: <4E5607E0.1050300@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Schubert <mschub@elegosoft.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 10:31:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwVL1-0000B1-Tv
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 10:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868Ab1HYIab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 04:30:31 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:41035 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752741Ab1HYIa1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2011 04:30:27 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3985D2085D;
	Thu, 25 Aug 2011 04:30:27 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 25 Aug 2011 04:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=0h
	kKoWccwRInhO3U1KzDXmKkprg=; b=WtrPDdBwnmS8PKLMybQoM2IH/wiQJtKSNR
	VLZeFw79sCuzgVHGL+RDYZhxi7rgVHMKvIVUccdICd16kwtoFfP14vkIEGm03tps
	mACVUfQ3TKQ9S5RFCmV48agxwX9VbfE3U5ie9gFfN/Fji2dQ0GU+zzaUEcwkPBuc
	jJ4y+RW6Y=
X-Sasl-enc: bwwmnlPpjuYSdHU5KVY5OHEvy5ulGF7Y1MRFOnSLAbN2 1314261026
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A666C901ED5;
	Thu, 25 Aug 2011 04:30:26 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.845.gc3c05
In-Reply-To: <4E5607E0.1050300@drmicha.warpmail.net>
In-Reply-To: <cover.1314259226.git.git@drmicha.warpmail.net>
References: <cover.1314259226.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180071>

Allow pattern arguments for the list mode just like for git tag -l.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-branch.txt |    7 +++++--
 builtin/branch.c             |   13 +++++++++----
 t/t3203-branch-output.sh     |   10 ++++++++++
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index c50f189..2152d48 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git branch' [--color[=<when>] | --no-color] [-r | -a]
 	[-v [--abbrev=<length> | --no-abbrev]]
-	[(--merged | --no-merged | --contains) [<commit>]]
+	[(--merged | --no-merged | --contains) [<commit>]] [<pattern>]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
 'git branch' (-d | -D) [-r] <branchname>...
@@ -20,7 +20,10 @@ DESCRIPTION
 
 With no arguments, existing branches are listed and the current branch will
 be highlighted with an asterisk.  Option `-r` causes the remote-tracking
-branches to be listed, and option `-a` shows both.
+branches to be listed, and option `-a` shows both. This list mode is also
+activated by the `-v` option (see below).
+<pattern> restricts the output to matching branches, the pattern is a shell
+wildcard (i.e., matched using fnmatch(3))
 
 With `--contains`, shows only the branches that contain the named commit
 (in other words, the branches whose tip commits are descendants of the
diff --git a/builtin/branch.c b/builtin/branch.c
index 73d4170..6b40815 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -260,6 +260,7 @@ static char *resolve_symref(const char *src, const char *prefix)
 
 struct append_ref_cb {
 	struct ref_list *ref_list;
+	const char *pattern;
 	int ret;
 };
 
@@ -297,6 +298,9 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	if ((kind & ref_list->kinds) == 0)
 		return 0;
 
+	if (cb->pattern && fnmatch(cb->pattern, refname, 0))
+		return 0;
+
 	commit = NULL;
 	if (ref_list->verbose || ref_list->with_commit || merge_filter != NO_FILTER) {
 		commit = lookup_commit_reference_gently(sha1, 1);
@@ -492,7 +496,7 @@ static void show_detached(struct ref_list *ref_list)
 	}
 }
 
-static int print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit)
+static int print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit, const char *pattern)
 {
 	int i;
 	struct append_ref_cb cb;
@@ -506,6 +510,7 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	if (merge_filter != NO_FILTER)
 		init_revisions(&ref_list.revs, NULL);
 	cb.ref_list = &ref_list;
+	cb.pattern = pattern;
 	cb.ret = 0;
 	for_each_rawref(append_ref, &cb);
 	if (merge_filter != NO_FILTER) {
@@ -523,7 +528,7 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
 
 	detached = (detached && (kinds & REF_LOCAL_BRANCH));
-	if (detached)
+	if (detached && (!pattern || !fnmatch(pattern, "HEAD", 0)))
 		show_detached(&ref_list);
 
 	for (i = 0; i < ref_list.index; i++) {
@@ -695,8 +700,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
-	else if (argc == 0)
-		return print_ref_list(kinds, detached, verbose, abbrev, with_commit);
+	else if (argc == 0 || (verbose && argc == 1))
+		return print_ref_list(kinds, detached, verbose, abbrev, with_commit, argc ? argv[0] : NULL);
 	else if (rename && (argc == 1))
 		rename_branch(head, argv[0], rename > 1);
 	else if (rename && (argc == 2))
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 6b7c118..2df1d3d 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -67,6 +67,16 @@ test_expect_success 'git branch -v shows branch summaries' '
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
