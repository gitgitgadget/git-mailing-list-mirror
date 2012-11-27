From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCH v2 3/3] Add option to transpose parents of merge commit
Date: Wed, 28 Nov 2012 00:00:17 +0100
Message-ID: <1354057217-65886-4-git-send-email-draenog@pld-linux.org>
References: <1354057217-65886-1-git-send-email-draenog@pld-linux.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Kacper Kornet <draenog@pld-linux.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 00:18:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdUPq-00006C-Fe
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 00:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756355Ab2K0XRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 18:17:38 -0500
Received: from carme.pld-linux.org ([193.239.45.140]:13588 "EHLO
	carme.pld-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754151Ab2K0XRb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 18:17:31 -0500
X-Greylist: delayed 1028 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Nov 2012 18:17:31 EST
Received: from draenog by carme.pld-linux.org with local (Exim 4.80.1)
	(envelope-from <draenog@carme.pld-linux.org>)
	id 1TdU8X-000H9X-Hr; Wed, 28 Nov 2012 00:00:17 +0100
X-Mailer: git-send-email 1.8.0.1
In-Reply-To: <1354057217-65886-1-git-send-email-draenog@pld-linux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210626>

When the changes are pushed upstream, and in the meantime someone else
updated upstream branch git advises to use git pull. This results in
history:

     ---A---B---C--
         \     /
          D---E

where B is the local commit. D, E are commits pushed by someone else
when the developer was working on B. However sometimes the following
history is preferable:

    ---A---D---C'--
        \     /
         '-B-'

The difference between C and C' is the order of parents. This change
allow for easier way to obtain this effect by introducing the option
--transpose-parents to git-merge and git-pull, which changes the order
of parents in resulting commit moving the original first parent to
the very end of list of parents.

The transposition is done just before the commit is finalized, so the
meaning of "our" and "their" for conflict resolution is not changed, so
"ours" denotes local version and "theirs" upstream.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---
 Documentation/merge-options.txt |  7 +++++++
 builtin/commit.c                |  8 +++++++-
 builtin/merge.c                 | 16 ++++++++++++----
 commit.c                        | 11 +++++++++++
 commit.h                        |  2 ++
 git-pull.sh                     |  4 +++-
 6 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 0bcbe0a..b4fbfdc 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -88,6 +88,13 @@ option can be used to override --squash.
 	Synonyms to --stat and --no-stat; these are deprecated and will be
 	removed in the future.
 
+--transpose-parents::
+	Transpose the parents in the final commit. The change is made
+	just before the commit so the meaning of 'our' and 'their'
+	concepts remains the same (i.e. 'our' means current branch before
+	the merge).
+
+
 ifndef::git-pull[]
 -q::
 --quiet::
diff --git a/builtin/commit.c b/builtin/commit.c
index ee0e884..ab2b844 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1477,6 +1477,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	} else if (whence == FROM_MERGE) {
 		struct strbuf m = STRBUF_INIT;
 		FILE *fp;
+		int reversed_order=0;
 
 		if (!reflog_msg)
 			reflog_msg = "commit (merge)";
@@ -1484,10 +1485,13 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 			while (strbuf_getline(&m, fp, '\n') != EOF) {
 				if (!strcmp(m.buf, "no-ff"))
 					allow_fast_forward = 0;
+				if (!strcmp(m.buf, "reversed-order"))
+					reversed_order = 1;
 			}
 			fclose(fp);
 		}
-		pptr = &commit_list_insert(current_head, pptr)->next;
+		if (!reversed_order)
+			pptr = &commit_list_insert(current_head, pptr)->next;
 		fp = fopen(git_path("MERGE_HEAD"), "r");
 		if (fp == NULL)
 			die_errno(_("could not open '%s' for reading"),
@@ -1502,6 +1506,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		}
 		fclose(fp);
 		strbuf_release(&m);
+		if (reversed_order)
+			pptr = &commit_list_insert(current_head, pptr)->next;
 		if (allow_fast_forward)
 			parents = reduce_heads(parents);
 	} else {
diff --git a/builtin/merge.c b/builtin/merge.c
index a96e8ea..41738a5 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -65,6 +65,7 @@ static int abort_current_merge;
 static int show_progress = -1;
 static int default_to_upstream;
 static const char *sign_commit;
+static int reversed_order=0;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -213,6 +214,7 @@ static struct option builtin_merge_options[] = {
 	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key id"),
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	OPT_BOOLEAN(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
+	OPT_BOOLEAN(0, "transpose-parents", &reversed_order, N_("reverse order of parents")),
 	OPT_END()
 };
 
@@ -822,9 +824,9 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 
 	write_tree_trivial(result_tree);
 	printf(_("Wonderful.\n"));
-	parent->item = head;
+	parent->item = reversed_order ? remoteheads->item : head;
 	parent->next = xmalloc(sizeof(*parent->next));
-	parent->next->item = remoteheads->item;
+	parent->next->item = reversed_order ? head : remoteheads->item;
 	parent->next->next = NULL;
 	prepare_to_commit(remoteheads);
 	if (commit_tree(&merge_msg, result_tree, parent, result_commit, NULL,
@@ -848,8 +850,12 @@ static int finish_automerge(struct commit *head,
 
 	free_commit_list(common);
 	parents = remoteheads;
-	if (!head_subsumed || !allow_fast_forward)
+	if (!head_subsumed || !allow_fast_forward) {
+	    if (reversed_order )
+		commit_list_insert_end(head, &parents);
+	    else
 		commit_list_insert(head, &parents);
+	}
 	strbuf_addch(&merge_msg, '\n');
 	prepare_to_commit(remoteheads);
 	if (commit_tree(&merge_msg, result_tree, parents, result_commit,
@@ -994,7 +1000,9 @@ static void write_merge_state(struct commit_list *remoteheads)
 		die_errno(_("Could not open '%s' for writing"), filename);
 	strbuf_reset(&buf);
 	if (!allow_fast_forward)
-		strbuf_addf(&buf, "no-ff");
+		strbuf_addf(&buf, "no-ff\n");
+	if (reversed_order)
+		strbuf_addf(&buf, "reversed-order\n");
 	if (write_in_full(fd, buf.buf, buf.len) != buf.len)
 		die_errno(_("Could not write to '%s'"), filename);
 	close(fd);
diff --git a/commit.c b/commit.c
index e8eb0ae..6e58994 100644
--- a/commit.c
+++ b/commit.c
@@ -363,6 +363,17 @@ struct commit_list *commit_list_insert(struct commit *item, struct commit_list *
 	return new_list;
 }
 
+struct commit_list *commit_list_insert_end(struct commit *item, struct commit_list **list_p)
+{
+	struct commit_list *list_iter = *list_p;
+	while(list_iter->next)
+		list_iter = list_iter->next;
+	list_iter->next = xmalloc(sizeof(*list_iter->next));
+	list_iter->next->item = item;
+	list_iter->next->next = NULL;
+	return *list_p;
+}
+
 unsigned commit_list_count(const struct commit_list *l)
 {
 	unsigned c = 0;
diff --git a/commit.h b/commit.h
index b6ad8f3..17ae5e5 100644
--- a/commit.h
+++ b/commit.h
@@ -53,6 +53,8 @@ int find_commit_subject(const char *commit_buffer, const char **subject);
 
 struct commit_list *commit_list_insert(struct commit *item,
 					struct commit_list **list);
+struct commit_list *commit_list_insert_end(struct commit *item,
+					struct commit_list **list);
 struct commit_list **commit_list_append(struct commit *commit,
 					struct commit_list **next);
 unsigned commit_list_count(const struct commit_list *l);
diff --git a/git-pull.sh b/git-pull.sh
index 266e682..d9c7591 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -84,6 +84,8 @@ do
 		no_ff=--no-ff ;;
 	--ff-only)
 		ff_only=--ff-only ;;
+	--transpose-parents)
+		transpose_parents=--transpose-parents;;
 	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
 		--strateg=*|--strategy=*|\
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
@@ -283,7 +285,7 @@ true)
 	eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
 	;;
 *)
-	eval="git-merge $diffstat $no_commit $edit $squash $no_ff $ff_only"
+	eval="git-merge $diffstat $no_commit $edit $squash $no_ff $ff_only $transpose_parents"
 	eval="$eval  $log_arg $strategy_args $merge_args $verbosity $progress"
 	eval="$eval \"\$merge_name\" HEAD $merge_head"
 	;;
-- 
1.8.0.1
