From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: [RFC] branch: list branches by single remote
Date: Wed, 24 Aug 2011 17:14:16 +0200
Message-ID: <4E551548.9090807@elegosoft.com>
References: <4E383132.3040907@elegosoft.com> <20110804040646.GA5104@sigill.intra.peff.net> <4E4A729D.9030906@drmicha.warpmail.net> <20110816151448.GA5152@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 24 17:14:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwFAF-0003SY-Mn
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 17:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129Ab1HXPOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 11:14:43 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:37575 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893Ab1HXPOm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 11:14:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id C43CCDE066;
	Wed, 24 Aug 2011 17:14:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wOuBMiMJNQSR; Wed, 24 Aug 2011 17:14:32 +0200 (CEST)
Received: from [10.10.10.197] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id A6A84DE01D;
	Wed, 24 Aug 2011 17:14:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <20110816151448.GA5152@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180007>

On 08/16/2011 05:14 PM, Jeff King wrote:
> On Tue, Aug 16, 2011 at 03:37:33PM +0200, Michael J Gruber wrote:
> 
>>> This isn't right. You are assuming that a remote called "foo" will have
>>> all of its branches in refs/remotes/foo. That's true under the default
>>> configuration, but technically speaking, the remote tracking branches of
>>> "foo" are defined by the right-hand side of foo's fetch refspecs.
>>
>> You are 100% right here, but...
>>
>>> So I think you want something more like this:
>>
>> ...the op still might want to filter simply by the remote name.
> 
> That is a perfectly reasonable approach. It just should be called
> "--glob" or something, and not "remote".  git-tag allows patterns to an
> explicit "tag -l", but "-l" is already taken for git-branch.

As suggested, I've just called it "--glob" for now.

--- 8< ---

Subject: [PATCH] branch: add option "glob" to filter listed branches

When calling "git branch" with either "-r" or "-a", there is no way to
further limit the output. Add an option "--glob=<pattern>" to allow
limiting the output to matching branch names.

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---
 Documentation/git-branch.txt |    8 ++++++--
 builtin/branch.c             |   13 ++++++++++---
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index c50f189..5de3c79 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -8,7 +8,7 @@ git-branch - List, create, or delete branches
 SYNOPSIS
 --------
 [verse]
-'git branch' [--color[=<when>] | --no-color] [-r | -a]
+'git branch' [--color[=<when>] | --no-color] [(-r | -a) [--glob=<pattern>]]
 	[-v [--abbrev=<length> | --no-abbrev]]
 	[(--merged | --no-merged | --contains) [<commit>]]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
@@ -20,7 +20,8 @@ DESCRIPTION
 
 With no arguments, existing branches are listed and the current branch will
 be highlighted with an asterisk.  Option `-r` causes the remote-tracking
-branches to be listed, and option `-a` shows both.
+branches to be listed, option `-a` shows both and `--glob` limits the
+output to branches matching <pattern>.
 
 With `--contains`, shows only the branches that contain the named commit
 (in other words, the branches whose tip commits are descendants of the
@@ -105,6 +106,9 @@ OPTIONS
 -a::
 	List both remote-tracking branches and local branches.
 
+--glob=<pattern>::
+	List only branches matching pattern.
+
 -v::
 --verbose::
 	Show sha1 and commit subject line for each head, along with
diff --git a/builtin/branch.c b/builtin/branch.c
index 3142daa..74730ad 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -17,7 +17,7 @@
 #include "revision.h"
 
 static const char * const builtin_branch_usage[] = {
-	"git branch [options] [-r | -a] [--merged | --no-merged]",
+	"git branch [options] [(-r | -a) [--glob=<pattern>]] [--merged | --no-merged]",
 	"git branch [options] [-l] [-f] <branchname> [<start-point>]",
 	"git branch [options] [-r] (-d | -D) <branchname>...",
 	"git branch [options] (-m | -M) [<oldbranch>] <newbranch>",
@@ -260,6 +260,7 @@ static char *resolve_symref(const char *src, const char *prefix)
 
 struct append_ref_cb {
 	struct ref_list *ref_list;
+	const char *glob;
 	int ret;
 };
 
@@ -297,6 +298,9 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	if ((kind & ref_list->kinds) == 0)
 		return 0;
 
+	if (cb->glob && fnmatch(cb->glob, refname, 0))
+		return 0;
+
 	commit = NULL;
 	if (ref_list->verbose || ref_list->with_commit || merge_filter != NO_FILTER) {
 		commit = lookup_commit_reference_gently(sha1, 1);
@@ -492,7 +496,7 @@ static void show_detached(struct ref_list *ref_list)
 	}
 }
 
-static int print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit)
+static int print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit, const char *glob)
 {
 	int i;
 	struct append_ref_cb cb;
@@ -506,6 +510,7 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	if (merge_filter != NO_FILTER)
 		init_revisions(&ref_list.revs, NULL);
 	cb.ref_list = &ref_list;
+	cb.glob = glob;
 	cb.ret = 0;
 	for_each_rawref(append_ref, &cb);
 	if (merge_filter != NO_FILTER) {
@@ -618,6 +623,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	enum branch_track track;
 	int kinds = REF_LOCAL_BRANCH;
 	struct commit_list *with_commit = NULL;
+	char *glob = NULL;
 
 	struct option options[] = {
 		OPT_GROUP("Generic options"),
@@ -647,6 +653,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_GROUP("Specific git-branch actions:"),
 		OPT_SET_INT('a', NULL, &kinds, "list both remote-tracking and local branches",
 			REF_REMOTE_BRANCH | REF_LOCAL_BRANCH),
+		OPT_STRING(0, "glob", &glob, "pattern", "list only branches matching the pattern"),
 		OPT_BIT('d', NULL, &delete, "delete fully merged branch", 1),
 		OPT_BIT('D', NULL, &delete, "delete branch (even if not merged)", 2),
 		OPT_BIT('m', NULL, &rename, "move/rename a branch and its reflog", 1),
@@ -699,7 +706,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
 	else if (argc == 0)
-		return print_ref_list(kinds, detached, verbose, abbrev, with_commit);
+		return print_ref_list(kinds, detached, verbose, abbrev, with_commit, glob);
 	else if (rename && (argc == 1))
 		rename_branch(head, argv[0], rename > 1);
 	else if (rename && (argc == 2))
-- 
1.7.6.577.g8d918.dirty
