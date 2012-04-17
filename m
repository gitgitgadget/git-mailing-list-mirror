From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] builtin/merge.c: remove "remoteheads" global variable
Date: Tue, 17 Apr 2012 13:34:44 -0700
Message-ID: <1334694886-27756-3-git-send-email-gitster@pobox.com>
References: <1334694886-27756-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 22:35:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKF7J-0006rx-Nc
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 22:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262Ab2DQUe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 16:34:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64912 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101Ab2DQUex (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 16:34:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7FCB62AA
	for <git@vger.kernel.org>; Tue, 17 Apr 2012 16:34:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=hete
	zbLE3zGxiOYzu9UWgVyyCY4=; b=WnM14K4GVbT+EepsCuzm8JlTKqfRR5/kH8CM
	kwqBHQ4Uo+oTq58W0PN6wfLhHd0sSBeVz+USKUMkQmZa57ZbSXz0130Ffx0rVkdl
	/YIdSOwwntPR/mtzFpZ/JNYOEzukG4D8+kBVQ3KxiVWaufH5eiNlCfZLJQgC3KHB
	ai4TI4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=BLwgjZ
	WYyMoxvwb5S+dJPv/gYEa12R4gc2Xy1jkysDz9risi2hds91UaS6LGHMMJpdhXk0
	hPy392Ok52aGiKhHqRth6wW2G5McjKGRgnGdhWkg57ndAjx4CJWXd8MhI2bokeHe
	duryRhlsAlabn2z8cLJ6KMTFmC9caJh16sWOc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A092362A9
	for <git@vger.kernel.org>; Tue, 17 Apr 2012 16:34:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D471E62A8 for
 <git@vger.kernel.org>; Tue, 17 Apr 2012 16:34:51 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.332.g1863c
In-Reply-To: <1334694886-27756-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C8A5131E-88CC-11E1-8A8A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195801>

Instead pass it around starting from the toplevel cmd_merge()
as an explicit parameter.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c |   51 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 5126443..c5ca70b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -52,7 +52,6 @@ static int fast_forward_only, option_edit = -1;
 static int allow_trivial = 1, have_message;
 static int overwrite_ignore = 1;
 static struct strbuf merge_msg = STRBUF_INIT;
-static struct commit_list *remoteheads;
 static struct strategy **use_strategies;
 static size_t use_strategies_nr, use_strategies_alloc;
 static const char **xopts;
@@ -318,7 +317,7 @@ static void finish_up_to_date(const char *msg)
 	drop_save();
 }
 
-static void squash_message(struct commit *commit)
+static void squash_message(struct commit *commit, struct commit_list *remoteheads)
 {
 	struct rev_info rev;
 	struct strbuf out = STRBUF_INIT;
@@ -366,6 +365,7 @@ static void squash_message(struct commit *commit)
 }
 
 static void finish(struct commit *head_commit,
+		   struct commit_list *remoteheads,
 		   const unsigned char *new_head, const char *msg)
 {
 	struct strbuf reflog_message = STRBUF_INIT;
@@ -380,7 +380,7 @@ static void finish(struct commit *head_commit,
 			getenv("GIT_REFLOG_ACTION"), msg);
 	}
 	if (squash) {
-		squash_message(head_commit);
+		squash_message(head_commit, remoteheads);
 	} else {
 		if (verbosity >= 0 && !merge_msg.len)
 			printf(_("No merge message -- not updating HEAD\n"));
@@ -681,6 +681,7 @@ int try_merge_command(const char *strategy, size_t xopts_nr,
 }
 
 static int try_merge_strategy(const char *strategy, struct commit_list *common,
+			      struct commit_list *remoteheads,
 			      struct commit *head, const char *head_arg)
 {
 	int index_fd;
@@ -874,14 +875,14 @@ static void read_merge_msg(struct strbuf *msg)
 		die_errno(_("Could not read from '%s'"), filename);
 }
 
-static void write_merge_state(void);
-static void abort_commit(const char *err_msg)
+static void write_merge_state(struct commit_list *);
+static void abort_commit(struct commit_list *remoteheads, const char *err_msg)
 {
 	if (err_msg)
 		error("%s", err_msg);
 	fprintf(stderr,
 		_("Not committing merge; use 'git commit' to complete the merge.\n"));
-	write_merge_state();
+	write_merge_state(remoteheads);
 	exit(1);
 }
 
@@ -892,7 +893,7 @@ N_("Please enter a commit message to explain why this merge is necessary,\n"
    "Lines starting with '#' will be ignored, and an empty message aborts\n"
    "the commit.\n");
 
-static void prepare_to_commit(void)
+static void prepare_to_commit(struct commit_list *remoteheads)
 {
 	struct strbuf msg = STRBUF_INIT;
 	const char *comment = _(merge_editor_comment);
@@ -905,18 +906,18 @@ static void prepare_to_commit(void)
 		 git_path("MERGE_MSG"), "merge", NULL, NULL);
 	if (option_edit) {
 		if (launch_editor(git_path("MERGE_MSG"), NULL, NULL))
-			abort_commit(NULL);
+			abort_commit(remoteheads, NULL);
 	}
 	read_merge_msg(&msg);
 	stripspace(&msg, option_edit);
 	if (!msg.len)
-		abort_commit(_("Empty commit message."));
+		abort_commit(remoteheads, _("Empty commit message."));
 	strbuf_release(&merge_msg);
 	strbuf_addbuf(&merge_msg, &msg);
 	strbuf_release(&msg);
 }
 
-static int merge_trivial(struct commit *head)
+static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 {
 	unsigned char result_tree[20], result_commit[20];
 	struct commit_list *parent = xmalloc(sizeof(*parent));
@@ -927,17 +928,18 @@ static int merge_trivial(struct commit *head)
 	parent->next = xmalloc(sizeof(*parent->next));
 	parent->next->item = remoteheads->item;
 	parent->next->next = NULL;
-	prepare_to_commit();
+	prepare_to_commit(remoteheads);
 	if (commit_tree(&merge_msg, result_tree, parent, result_commit, NULL,
 			sign_commit))
 		die(_("failed to write commit object"));
-	finish(head, result_commit, "In-index merge");
+	finish(head, remoteheads, result_commit, "In-index merge");
 	drop_save();
 	return 0;
 }
 
 static int finish_automerge(struct commit *head,
 			    struct commit_list *common,
+			    struct commit_list *remoteheads,
 			    unsigned char *result_tree,
 			    const char *wt_strategy)
 {
@@ -959,13 +961,13 @@ static int finish_automerge(struct commit *head,
 			pptr = &commit_list_insert(j->item, pptr)->next;
 	}
 	strbuf_addch(&merge_msg, '\n');
-	prepare_to_commit();
+	prepare_to_commit(remoteheads);
 	free_commit_list(remoteheads);
 	if (commit_tree(&merge_msg, result_tree, parents, result_commit,
 			NULL, sign_commit))
 		die(_("failed to write commit object"));
 	strbuf_addf(&buf, "Merge made by the '%s' strategy.", wt_strategy);
-	finish(head, result_commit, buf.buf);
+	finish(head, remoteheads, result_commit, buf.buf);
 	strbuf_release(&buf);
 	drop_save();
 	return 0;
@@ -1070,7 +1072,7 @@ static int setup_with_upstream(const char ***argv)
 	return i;
 }
 
-static void write_merge_state(void)
+static void write_merge_state(struct commit_list *remoteheads)
 {
 	const char *filename;
 	int fd;
@@ -1148,6 +1150,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	int best_cnt = -1, merge_was_ok = 0, automerge_was_ok = 0;
 	struct commit_list *common = NULL;
 	const char *best_strategy = NULL, *wt_strategy = NULL;
+	struct commit_list *remoteheads = NULL;
 	struct commit_list **remotes = &remoteheads;
 	void *branch_to_free;
 
@@ -1400,7 +1403,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			goto done;
 		}
 
-		finish(head_commit, commit->object.sha1, msg.buf);
+		finish(head_commit, remoteheads, commit->object.sha1, msg.buf);
 		drop_save();
 		goto done;
 	} else if (!remoteheads->next && common->next)
@@ -1422,7 +1425,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			if (!read_tree_trivial(common->item->object.sha1,
 					       head_commit->object.sha1,
 					       remoteheads->item->object.sha1)) {
-				ret = merge_trivial(head_commit);
+				ret = merge_trivial(head_commit, remoteheads);
 				goto done;
 			}
 			printf(_("Nope.\n"));
@@ -1493,7 +1496,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		wt_strategy = use_strategies[i]->name;
 
 		ret = try_merge_strategy(use_strategies[i]->name,
-					 common, head_commit, head_arg);
+					 common, remoteheads,
+					 head_commit, head_arg);
 		if (!option_commit && !ret) {
 			merge_was_ok = 1;
 			/*
@@ -1535,8 +1539,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * auto resolved the merge cleanly.
 	 */
 	if (automerge_was_ok) {
-		ret = finish_automerge(head_commit, common, result_tree,
-				       wt_strategy);
+		ret = finish_automerge(head_commit, common, remoteheads,
+				       result_tree, wt_strategy);
 		goto done;
 	}
 
@@ -1561,13 +1565,14 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		restore_state(head_commit->object.sha1, stash);
 		printf(_("Using the %s to prepare resolving by hand.\n"),
 			best_strategy);
-		try_merge_strategy(best_strategy, common, head_commit, head_arg);
+		try_merge_strategy(best_strategy, common, remoteheads,
+				   head_commit, head_arg);
 	}
 
 	if (squash)
-		finish(head_commit, NULL, NULL);
+		finish(head_commit, remoteheads, NULL, NULL);
 	else
-		write_merge_state();
+		write_merge_state(remoteheads);
 
 	if (merge_was_ok)
 		fprintf(stderr, _("Automatic merge went well; "
-- 
1.7.10.332.g1863c
