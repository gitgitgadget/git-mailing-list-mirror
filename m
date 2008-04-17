From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH v3] git-branch: add support for --merged and --no-merged
Date: Thu, 17 Apr 2008 22:24:50 +0200
Message-ID: <1208463890-2870-1-git-send-email-hjemli@gmail.com>
References: <7vr6d4nvkm.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 22:40:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jmaew-0007kU-Lk
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 22:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494AbYDQUX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 16:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753291AbYDQUX5
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 16:23:57 -0400
Received: from mail48.e.nsc.no ([193.213.115.48]:56130 "EHLO mail48.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753494AbYDQUX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 16:23:56 -0400
Received: from localhost.localdomain (ti0025a380-0176.bb.online.no [88.89.68.176])
	by mail48.nsc.no (8.13.8/8.13.5) with ESMTP id m3HKNhNR023177;
	Thu, 17 Apr 2008 22:23:43 +0200 (MEST)
X-Mailer: git-send-email 1.5.5.64.gb1a99
In-Reply-To: <7vr6d4nvkm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79819>

These options filter the output from git branch to only include branches
whose tip is either merged or not merged into HEAD.

The use-case for these options is when working with integration of branches
from many remotes: `git branch --no-merged -a` will show a nice list of merge
candidates while `git branch --merged -a` will show the progress of your
integration work.

Also, a plain `git branch --merged` is a quick way to find local branches
which you might want to delete.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

Junio C Hamano wrote:
> If the existing --contains implemenation can be extended to allow negative
> selection, we do not have to introduce yet another mechanism that is very
> similar.

Very true, so here's an updated version which reuses has_commit(). Thanks
for the feedback.


 Documentation/git-branch.txt |    4 +++-
 builtin-branch.c             |   16 +++++++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 6f07a17..95e9d0d 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -8,7 +8,7 @@ git-branch - List, create, or delete branches
 SYNOPSIS
 --------
 [verse]
-'git-branch' [--color | --no-color] [-r | -a]
+'git-branch' [--color | --no-color] [-r | -a] [--merged | --no-merged]
 	   [-v [--abbrev=<length> | --no-abbrev]]
 	   [--contains <commit>]
 'git-branch' [--track | --no-track] [-l] [-f] <branchname> [<start-point>]
@@ -24,6 +24,8 @@ and option `-a` shows both.
 With `--contains <commit>`, shows only the branches that
 contains the named commit (in other words, the branches whose
 tip commits are descendant of the named commit).
+With `--merged`, only branches merged into HEAD will be listed, and
+with `--no-merged` only branches not merged into HEAD will be listed.
 
 In its second form, a new branch named <branchname> will be created.
 It will start out with a head equal to the one given as <start-point>.
diff --git a/builtin-branch.c b/builtin-branch.c
index 5bc4526..eecbcf2 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -15,7 +15,7 @@
 #include "branch.h"
 
 static const char * const builtin_branch_usage[] = {
-	"git-branch [options] [-r | -a]",
+	"git-branch [options] [-r | -a] [--merged | --no-merged]",
 	"git-branch [options] [-l] [-f] <branchname> [<start-point>]",
 	"git-branch [options] [-r] (-d | -D) <branchname>",
 	"git-branch [options] (-m | -M) [<oldbranch>] <newbranch>",
@@ -46,6 +46,8 @@ enum color_branch {
 	COLOR_BRANCH_CURRENT = 4,
 };
 
+static int mergefilter = -1;
+
 static int parse_branch_color_slot(const char *var, int ofs)
 {
 	if (!strcasecmp(var+ofs, "plain"))
@@ -210,6 +212,7 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	struct ref_item *newitem;
 	int kind = REF_UNKNOWN_TYPE;
 	int len;
+	static struct commit_list branch;
 
 	/* Detect kind */
 	if (!prefixcmp(refname, "refs/heads/")) {
@@ -231,6 +234,16 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	if ((kind & ref_list->kinds) == 0)
 		return 0;
 
+	if (mergefilter > -1) {
+		branch.item = lookup_commit_reference_gently(sha1, 1);
+		if (!branch.item)
+			die("Unable to lookup HEAD of branch %s", refname);
+		if (mergefilter == 0 && has_commit(head_sha1, &branch))
+			return 0;
+		if (mergefilter == 1 && !has_commit(head_sha1, &branch))
+			return 0;
+	}
+
 	/* Resize buffer */
 	if (ref_list->index >= ref_list->alloc) {
 		ref_list->alloc = alloc_nr(ref_list->alloc);
@@ -444,6 +457,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('M', NULL, &rename, "move/rename a branch, even if target exists", 2),
 		OPT_BOOLEAN('l', NULL, &reflog, "create the branch's reflog"),
 		OPT_BOOLEAN('f', NULL, &force_create, "force creation (when already exists)"),
+		OPT_SET_INT(0, "merged", &mergefilter, "list only merged branches", 1),
 		OPT_END(),
 	};
 
-- 
1.5.5.64.gb1a99
