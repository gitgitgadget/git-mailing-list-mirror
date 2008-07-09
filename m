From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] branch --merged/--not-merged: allow specifying
 arbitrary  commit
Date: Wed, 09 Jul 2008 02:13:12 -0700
Message-ID: <7v8wwbl8t3.fsf@gitster.siamese.dyndns.org>
References: <7v8wwcx446.fsf@gitster.siamese.dyndns.org>
 <20080708101452.GB19202@artemis.madism.org>
 <20080708103408.GC19202@artemis.madism.org>
 <7vvdzfoo1s.fsf@gitster.siamese.dyndns.org>
 <7vmykronr1.fsf_-_@gitster.siamese.dyndns.org>
 <20080709074516.GA23482@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jul 09 11:14:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGVko-0003CK-Lp
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 11:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbYGIJN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 05:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbYGIJN0
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 05:13:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56708 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbYGIJNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 05:13:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C10B419CE3;
	Wed,  9 Jul 2008 05:13:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 63A5019CDE; Wed,  9 Jul 2008 05:13:19 -0400 (EDT)
In-Reply-To: <20080709074516.GA23482@artemis.madism.org> (Pierre Habouzit's
 message of "Wed, 09 Jul 2008 09:45:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 48348364-4D97-11DD-B1D1-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87861>

Pierre Habouzit <madcoder@debian.org> writes:

>   There's a way: declare --merge as (PARSE_OPT_)NONEG to tell parse-opt
> not to generate --no-merge by itself, and declare a --no-merge option as
> well.  I think it works, and if not, we should make parse-opt work with
> that. This is a quite disgusting hack, and no *new* options should be
> written this way, but we have to be flexible enough for backward
> compatibility's sake.

Nice, thanks.

With the obvious s/_FAKELASTARG/_LASTARG_DEFAULT/g to the first one, this
replaces the second one (with documentation updates for a change ;-), and
it seems to work Ok.

-- >8 --
Subject: branch --merged/--no-merged: allow specifying arbitrary commit

"git-branch --merged" is a handy way to list all the branches that have
already been merged to the current branch, but it did not allow checking
against anything but the current branch.  Having to switch branches only
to list the branches that are merged with another branch made the feature
practically useless.

This updates the option parser so that "git branch --merged next" is
accepted when you are on 'master' branch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-branch.txt |   27 ++++++++++++----------
 builtin-branch.c             |   50 +++++++++++++++++++++++++++++++++++------
 2 files changed, 57 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 0fd5808..450f903 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -8,24 +8,27 @@ git-branch - List, create, or delete branches
 SYNOPSIS
 --------
 [verse]
-'git-branch' [--color | --no-color] [-r | -a] [--merged | --no-merged]
-	   [-v [--abbrev=<length> | --no-abbrev]]
-	   [--contains <commit>]
+'git-branch' [--color | --no-color] [-r | -a]
+	[-v [--abbrev=<length> | --no-abbrev]]
+	[(--merged | --no-merged | --contains) [<commit>]]
 'git-branch' [--track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git-branch' (-m | -M) [<oldbranch>] <newbranch>
 'git-branch' (-d | -D) [-r] <branchname>...
 
 DESCRIPTION
 -----------
-With no arguments given a list of existing branches
-will be shown, the current branch will be highlighted with an asterisk.
-Option `-r` causes the remote-tracking branches to be listed,
-and option `-a` shows both.
-With `--contains <commit>`, shows only the branches that
-contains the named commit (in other words, the branches whose
-tip commits are descendant of the named commit).
-With `--merged`, only branches merged into HEAD will be listed, and
-with `--no-merged` only branches not merged into HEAD will be listed.
+
+With no arguments, existing branches are listed, the current branch will
+be highlighted with an asterisk.  Option `-r` causes the remote-tracking
+branches to be listed, and option `-a` shows both.
+
+With `--contains`, shows only the branches that contains the named commit
+(in other words, the branches whose tip commits are descendant of the
+named commit).  With `--merged`, only branches merged into the named
+commit (i.e. the branches whose tip commits are reachable from the named
+commit) will be listed.  With `--no-merged` only branches not merged into
+the named commit will be listed.  Missing <commit> argument defaults to
+'HEAD' (i.e. the tip of the current branch).
 
 In its second form, a new branch named <branchname> will be created.
 It will start out with a head equal to the one given as <start-point>.
diff --git a/builtin-branch.c b/builtin-branch.c
index 50cbc9c..1926c47 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -46,7 +46,12 @@ enum color_branch {
 	COLOR_BRANCH_CURRENT = 4,
 };
 
-static int mergefilter = -1;
+static enum merge_filter {
+	NO_FILTER = 0,
+	SHOW_NOT_MERGED,
+	SHOW_MERGED,
+} merge_filter;
+static unsigned char merge_filter_ref[20];
 
 static int parse_branch_color_slot(const char *var, int ofs)
 {
@@ -234,13 +239,15 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	if ((kind & ref_list->kinds) == 0)
 		return 0;
 
-	if (mergefilter > -1) {
+	if (merge_filter != NO_FILTER) {
 		branch.item = lookup_commit_reference_gently(sha1, 1);
 		if (!branch.item)
 			die("Unable to lookup tip of branch %s", refname);
-		if (mergefilter == 0 && has_commit(head_sha1, &branch))
+		if (merge_filter == SHOW_NOT_MERGED &&
+		    has_commit(merge_filter_ref, &branch))
 			return 0;
-		if (mergefilter == 1 && !has_commit(head_sha1, &branch))
+		if (merge_filter == SHOW_MERGED &&
+		    !has_commit(merge_filter_ref, &branch))
 			return 0;
 	}
 
@@ -421,6 +428,20 @@ static int opt_parse_with_commit(const struct option *opt, const char *arg, int
 	return 0;
 }
 
+static int opt_parse_merge_filter(const struct option *opt, const char *arg, int unset)
+{
+	merge_filter = ((opt->long_name[0] == 'n')
+			? SHOW_NOT_MERGED
+			: SHOW_MERGED);
+	if (unset)
+		merge_filter = SHOW_NOT_MERGED; /* b/c for --no-merged */
+	if (!arg)
+		arg = "HEAD";
+	if (get_sha1(arg, merge_filter_ref))
+		die("malformed object name %s", arg);
+	return 0;
+}
+
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, force_create = 0;
@@ -461,7 +482,18 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('M', NULL, &rename, "move/rename a branch, even if target exists", 2),
 		OPT_BOOLEAN('l', NULL, &reflog, "create the branch's reflog"),
 		OPT_BOOLEAN('f', NULL, &force_create, "force creation (when already exists)"),
-		OPT_SET_INT(0, "merged", &mergefilter, "list only merged branches", 1),
+		{
+			OPTION_CALLBACK, 0, "no-merged", &merge_filter_ref,
+			"commit", "print only not merged branches",
+			PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG,
+			opt_parse_merge_filter, (intptr_t) "HEAD",
+		},
+		{
+			OPTION_CALLBACK, 0, "merged", &merge_filter_ref,
+			"commit", "print only merged branches",
+			PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG,
+			opt_parse_merge_filter, (intptr_t) "HEAD",
+		},
 		OPT_END(),
 	};
 
@@ -471,9 +503,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		branch_use_color = git_use_color_default;
 
 	track = git_branch_track;
-	argc = parse_options(argc, argv, options, builtin_branch_usage, 0);
-	if (!!delete + !!rename + !!force_create > 1)
-		usage_with_options(builtin_branch_usage, options);
 
 	head = resolve_ref("HEAD", head_sha1, 0, NULL);
 	if (!head)
@@ -486,6 +515,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die("HEAD not found below refs/heads!");
 		head += 11;
 	}
+	hashcpy(merge_filter_ref, head_sha1);
+
+	argc = parse_options(argc, argv, options, builtin_branch_usage, 0);
+	if (!!delete + !!rename + !!force_create > 1)
+		usage_with_options(builtin_branch_usage, options);
 
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
-- 
1.5.6.2.276.gbb293
