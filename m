From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/8] port brnach.c to use ref-filter APIs
Date: Wed, 19 Aug 2015 00:45:37 +0530
Message-ID: <1439925345-9969-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 21:15:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRmMM-0003a2-K1
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 21:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848AbbHRTPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 15:15:41 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33289 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221AbbHRTPl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 15:15:41 -0400
Received: by pdrh1 with SMTP id h1so72029199pdr.0
        for <git@vger.kernel.org>; Tue, 18 Aug 2015 12:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=LoJk6TiT3MSNSat6kdyGMVSniYxSgDqIV0viPunKwH4=;
        b=iUB3tHsTln1A0hUX+chSWVdT0GBApAIQHYCwDtRzezNZ7rB5x8JYtiw2dE4rIK20pS
         wAGGNPar34/hNaomJYZ0KEVs0BStTGFB+Kf9LnZaLsq+Z4FMMkWWgpr19GPctNYcata7
         lBApl3oa3/yEXlUxxru9P7f7KAQZfF3WBqtQNtDwLi4fERrnnwjI+VnbVN2vfXAnqWcM
         PijTNRYTBAuuU3tnmxMq5CFROzWyUdPsbh4DLmBfxomqwpo6R49Ol0HPH6J99jQiouve
         Eg5k3CXspd/hzR297f7NLNx2FMV8NYjJ8YgsfRA2ajGqLWfz8Pbiz/G+Z+8KwueNIxIg
         U4sQ==
X-Received: by 10.70.48.40 with SMTP id i8mr9197347pdn.10.1439925340344;
        Tue, 18 Aug 2015 12:15:40 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id v2sm43800pda.34.2015.08.18.12.15.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Aug 2015 12:15:38 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276147>

This is part of my GSoC project to "unify the code of tag -l, branch,
and for-each-ref".
Version 1 can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/275264

Changes:
* The filtering of refs based on type has been moved over to the
  series of porting tag.c to ref-filter.
* 1/8: we first check for ignore before computing width.
* 2/8: spelling error.
* 3/8: add a to_free variable. 

Karthik Nayak (8):
  branch: refactor width computation
  branch: bump get_head_description() to the top
  branch: roll show_detached HEAD into regular ref_list
  branch: move 'current' check down to the presentation layer
  branch: drop non-commit error reporting
  branch.c: use 'ref-filter' data structures
  branch.c: use 'ref-filter' APIs
  branch: add '--points-at' option

 Documentation/git-branch.txt |  13 +-
 builtin/branch.c             | 508 +++++++++++++------------------------------
 ref-filter.c                 |   2 +-
 ref-filter.h                 |   6 +-
 t/t1430-bad-ref-name.sh      |  10 +-
 t/t3203-branch-output.sh     |  20 ++
 6 files changed, 200 insertions(+), 359 deletions(-)

Interdiff:

diff --git a/builtin/branch.c b/builtin/branch.c
index 5dad1da..dd2fdbe 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -113,7 +113,7 @@ static int branch_merged(int kind, const char *name,
 	void *reference_name_to_free = NULL;
 	int merged;
 
-	if (kind == REF_LOCAL_BRANCH) {
+	if (kind == FILTER_REFS_BRANCHES) {
 		struct branch *branch = branch_get(name);
 		const char *upstream = branch_get_upstream(branch, NULL);
 		unsigned char sha1[20];
@@ -191,14 +191,14 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	struct strbuf bname = STRBUF_INIT;
 
 	switch (kinds) {
-	case REF_REMOTE_BRANCH:
+	case FILTER_REFS_REMOTES:
 		fmt = "refs/remotes/%s";
 		/* For subsequent UI messages */
 		remote_branch = 1;
 
 		force = 1;
 		break;
-	case REF_LOCAL_BRANCH:
+	case FILTER_REFS_BRANCHES:
 		fmt = "refs/heads/%s";
 		break;
 	default:
@@ -215,7 +215,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		int flags = 0;
 
 		strbuf_branchname(&bname, argv[i]);
-		if (kinds == REF_LOCAL_BRANCH && !strcmp(head, bname.buf)) {
+		if (kinds == FILTER_REFS_BRANCHES && !strcmp(head, bname.buf)) {
 			error(_("Cannot delete the branch '%s' "
 			      "which you are currently on."), bname.buf);
 			ret = 1;
@@ -345,7 +345,7 @@ static void add_verbose_info(struct strbuf *out, struct ref_array_item *item,
 		sub = subject.buf;
 	}
 
-	if (item->kind == REF_LOCAL_BRANCH)
+	if (item->kind == FILTER_REFS_BRANCHES)
 		fill_tracking_info(&stat, refname, filter->verbose > 1);
 
 	strbuf_addf(out, " %s %s%s",
@@ -395,22 +395,23 @@ static void format_and_print_ref_item(struct ref_array_item *item, int maxwidth,
 	struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
 	const char *prefix = "";
 	const char *desc = item->refname;
+	char *to_free = NULL;
 
 	switch (item->kind) {
-	case REF_LOCAL_BRANCH:
+	case FILTER_REFS_BRANCHES:
 		skip_prefix(desc, "refs/heads/", &desc);
 		if (!filter->detached && !strcmp(desc, head))
 			current = 1;
 		else
 			color = BRANCH_COLOR_LOCAL;
 		break;
-	case REF_REMOTE_BRANCH:
+	case FILTER_REFS_REMOTES:
 		skip_prefix(desc, "refs/remotes/", &desc);
 		color = BRANCH_COLOR_REMOTE;
 		prefix = remote_prefix;
 		break;
-	case REF_DETACHED_HEAD:
-		desc = get_head_description();
+	case FILTER_REFS_DETACHED_HEAD:
+		desc = to_free = get_head_description();
 		current = 1;
 		break;
 	default:
@@ -449,8 +450,7 @@ static void format_and_print_ref_item(struct ref_array_item *item, int maxwidth,
 	}
 	strbuf_release(&name);
 	strbuf_release(&out);
-	if (item->kind == REF_DETACHED_HEAD)
-		free((void *)desc);
+	free(to_free);
 }
 
 static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
@@ -465,7 +465,7 @@ static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
 		skip_prefix(it->refname, "refs/remotes/", &desc);
 		w = utf8_strwidth(desc);
 
-		if (it->kind == REF_REMOTE_BRANCH)
+		if (it->kind == FILTER_REFS_REMOTES)
 			w += remote_bonus;
 		if (w > max)
 			max = w;
@@ -487,13 +487,13 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	 * then remote branches will have a "remotes/" prefix.
 	 * We need to account for this in the width.
 	 */
-	if (filter->branch_kind != REF_REMOTE_BRANCH)
+	if (filter->kind != FILTER_REFS_REMOTES)
 		remote_prefix = "remotes/";
 
 	memset(&array, 0, sizeof(array));
 
 	verify_ref_format("%(refname)%(symref)");
-	filter_refs(&array, filter, FILTER_REFS_BRANCHES);
+	filter_refs(&array, filter, filter->kind);
 
 	if (filter->verbose)
 		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
@@ -501,9 +501,9 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	index = array.nr;
 
 	/* Print detached HEAD before sorting and printing the rest */
-	if (filter->detached) {
+	if (filter->kind & FILTER_REFS_DETACHED_HEAD) {
 		format_and_print_ref_item(array.items[index - 1], maxwidth, filter, remote_prefix);
-		array.nr--;
+		array.nr -= 1;
 	}
 
 	if (!sorting) {
@@ -632,15 +632,15 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_STRING('u', "set-upstream-to", &new_upstream, "upstream", "change the upstream info"),
 		OPT_BOOL(0, "unset-upstream", &unset_upstream, "Unset the upstream info"),
 		OPT__COLOR(&branch_use_color, N_("use colored output")),
-		OPT_SET_INT('r', "remotes",     &filter.branch_kind, N_("act on remote-tracking branches"),
-			REF_REMOTE_BRANCH),
+		OPT_SET_INT('r', "remotes",     &filter.kind, N_("act on remote-tracking branches"),
+			FILTER_REFS_REMOTES),
 		OPT_CONTAINS(&filter.with_commit, N_("print only branches that contain the commit")),
 		OPT_WITH(&filter.with_commit, N_("print only branches that contain the commit")),
 		OPT__ABBREV(&filter.abbrev),
 
 		OPT_GROUP(N_("Specific git-branch actions:")),
-		OPT_SET_INT('a', "all", &filter.branch_kind, N_("list both remote-tracking and local branches"),
-			REF_REMOTE_BRANCH | REF_LOCAL_BRANCH),
+		OPT_SET_INT('a', "all", &filter.kind, N_("list both remote-tracking and local branches"),
+			FILTER_REFS_REMOTES | FILTER_REFS_BRANCHES),
 		OPT_BIT('d', "delete", &delete, N_("delete fully merged branch"), 1),
 		OPT_BIT('D', NULL, &delete, N_("delete branch (even if not merged)"), 2),
 		OPT_BIT('m', "move", &rename, N_("move/rename a branch and its reflog"), 1),
@@ -663,7 +663,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	};
 
 	memset(&filter, 0, sizeof(filter));
-	filter.branch_kind = REF_LOCAL_BRANCH;
+	filter.kind = FILTER_REFS_BRANCHES;
 	filter.abbrev = -1;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
@@ -711,11 +711,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
-		return delete_branches(argc, argv, delete > 1, filter.branch_kind, quiet);
+		return delete_branches(argc, argv, delete > 1, filter.kind, quiet);
 	} else if (list) {
 		/*  git branch --local also shows HEAD when it is detached */
-		if (filter.branch_kind & REF_LOCAL_BRANCH)
-			filter.branch_kind |= REF_DETACHED_HEAD;
+		if ((filter.kind & FILTER_REFS_BRANCHES) && filter.detached)
+			filter.kind |= FILTER_REFS_DETACHED_HEAD;
 		filter.name_patterns = argv;
 		print_ref_list(&filter, sorting);
 		print_columns(&output, colopts, NULL);
@@ -815,7 +815,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!branch)
 			die(_("no such branch '%s'"), argv[0]);
 
-		if (filter.branch_kind != REF_LOCAL_BRANCH)
+		if (filter.kind != FILTER_REFS_BRANCHES)
 			die(_("-a and -r options to 'git branch' do not make sense with a branch name"));
 
 		if (track == BRANCH_TRACK_OVERRIDE)

I've removed the diff which overlaps with the porting of tag.c to use
ref-filter.c APIs.

-- 
2.5.0
