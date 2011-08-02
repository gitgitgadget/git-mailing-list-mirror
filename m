From: Michael Schubert <mschub@elegosoft.com>
Subject: [RFC] branch: list branches by single remote
Date: Tue, 02 Aug 2011 19:17:38 +0200
Message-ID: <4E383132.3040907@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 02 19:18:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoIbY-0006fm-8V
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 19:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411Ab1HBRSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 13:18:00 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:41113 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754594Ab1HBRR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 13:17:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 01CD0DE807
	for <git@vger.kernel.org>; Tue,  2 Aug 2011 19:17:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NpFZoUwoEad2 for <git@vger.kernel.org>;
	Tue,  2 Aug 2011 19:17:50 +0200 (CEST)
Received: from [10.10.10.197] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 13C8FDE801
	for <git@vger.kernel.org>; Tue,  2 Aug 2011 19:17:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110628 Thunderbird/5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178486>

I've always missed some option for "git branch" to limit the output to a single
remote. What's the right place to filter the output? The code below doesn't
look very smart..

---
 builtin/branch.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 3142daa..22e6be2 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -17,7 +17,7 @@
 #include "revision.h"
 
 static const char * const builtin_branch_usage[] = {
-	"git branch [options] [-r | -a] [--merged | --no-merged]",
+	"git branch [options] [-r | -a] [-R <remote>] [--merged | --no-merged]",
 	"git branch [options] [-l] [-f] <branchname> [<start-point>]",
 	"git branch [options] [-r] (-d | -D) <branchname>...",
 	"git branch [options] (-m | -M) [<oldbranch>] <newbranch>",
@@ -260,6 +260,7 @@ static char *resolve_symref(const char *src, const char *prefix)
 
 struct append_ref_cb {
 	struct ref_list *ref_list;
+	const char *remote;
 	int ret;
 };
 
@@ -297,6 +298,9 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	if ((kind & ref_list->kinds) == 0)
 		return 0;
 
+	if (cb->remote && strncmp(cb->remote, refname, strlen(cb->remote)))
+		return 0;
+
 	commit = NULL;
 	if (ref_list->verbose || ref_list->with_commit || merge_filter != NO_FILTER) {
 		commit = lookup_commit_reference_gently(sha1, 1);
@@ -492,7 +496,7 @@ static void show_detached(struct ref_list *ref_list)
 	}
 }
 
-static int print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit)
+static int print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit, const char *only)
 {
 	int i;
 	struct append_ref_cb cb;
@@ -506,6 +510,7 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	if (merge_filter != NO_FILTER)
 		init_revisions(&ref_list.revs, NULL);
 	cb.ref_list = &ref_list;
+	cb.remote = only;
 	cb.ret = 0;
 	for_each_rawref(append_ref, &cb);
 	if (merge_filter != NO_FILTER) {
@@ -618,6 +623,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	enum branch_track track;
 	int kinds = REF_LOCAL_BRANCH;
 	struct commit_list *with_commit = NULL;
+	char *single_remote = NULL;
 
 	struct option options[] = {
 		OPT_GROUP("Generic options"),
@@ -647,6 +653,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_GROUP("Specific git-branch actions:"),
 		OPT_SET_INT('a', NULL, &kinds, "list both remote-tracking and local branches",
 			REF_REMOTE_BRANCH | REF_LOCAL_BRANCH),
+		OPT_STRING('R', NULL, &single_remote, "remote", "list only branches by remote"),
 		OPT_BIT('d', NULL, &delete, "delete fully merged branch", 1),
 		OPT_BIT('D', NULL, &delete, "delete branch (even if not merged)", 2),
 		OPT_BIT('m', NULL, &rename, "move/rename a branch and its reflog", 1),
@@ -696,10 +703,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (!!delete + !!rename + !!force_create > 1)
 		usage_with_options(builtin_branch_usage, options);
 
+	if (single_remote)
+		kinds = REF_REMOTE_BRANCH;
+
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
 	else if (argc == 0)
-		return print_ref_list(kinds, detached, verbose, abbrev, with_commit);
+		return print_ref_list(kinds, detached, verbose, abbrev, with_commit, single_remote);
 	else if (rename && (argc == 1))
 		rename_branch(head, argv[0], rename > 1);
 	else if (rename && (argc == 2))
-- 
1.7.6.396.ge0613.dirty
