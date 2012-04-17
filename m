From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] builtin/merge.c: reduce parents early
Date: Tue, 17 Apr 2012 13:34:46 -0700
Message-ID: <1334694886-27756-5-git-send-email-gitster@pobox.com>
References: <1334694886-27756-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 22:35:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKF7L-0006rx-2H
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 22:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353Ab2DQUfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 16:35:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64968 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753318Ab2DQUe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 16:34:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04AB062B6
	for <git@vger.kernel.org>; Tue, 17 Apr 2012 16:34:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=hSVf
	ZDwFuAdxZVx6y2z+phhZ7Q0=; b=Ts/Fto3/n2edCnL7fYNvcYSs2oY8TV63EQGx
	/JCmKBfn7TPFP7STYyTcHp7Rg1vRWhgdjAdFtwlvCNAPevECcPms3afmuJdxi0md
	gliIEP4IaC065pkj4ilbSvQoU54rVYE3GzYHrTkdYHPVhSJHoym1BuW1ImppVJIu
	yk0a6yM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=NFiWGs
	mk6uNxE1zhUyEebsGvhVOjfT6/H9nXpGt/6IMYklwZ+8vUEdkPNe69FTp03lRPw5
	SHuwPf3fazREFLZeQeaXbXSdEQCDGEiz2BXJvZeHgfAxcIW/GBaj+kZ8bLV/+Jb/
	jISFBUuND10esvPCCLunTK1803q8BPJq49jgs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F060C62B5
	for <git@vger.kernel.org>; Tue, 17 Apr 2012 16:34:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38B6462B2 for
 <git@vger.kernel.org>; Tue, 17 Apr 2012 16:34:57 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.332.g1863c
In-Reply-To: <1334694886-27756-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CBDB5214-88CC-11E1-8AC6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195803>

Instead of waiting until we record the parents of resulting merge, reduce
redundant parents (including our HEAD) immediately after reading them.

The change to t7602 illustrates the essence of the effect of this change.
The octopus merge strategy used to be fed with redundant commits only to
discard them as "up-to-date", but we no longer feed such redundant commits
to it and the affected test degenerates to a regular two-head merge.

And obviously the known-to-be-broken test in t7602 is now fixed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c               |   65 +++++++++++++++++++++++++----------------
 t/t6028-merge-up-to-date.sh   |    2 +-
 t/t7602-merge-octopus-many.sh |   10 +++----
 3 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 2cef2f6..20aeca0 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -938,31 +938,22 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 }
 
 static int finish_automerge(struct commit *head,
+			    int head_subsumed,
 			    struct commit_list *common,
 			    struct commit_list *remoteheads,
 			    unsigned char *result_tree,
 			    const char *wt_strategy)
 {
-	struct commit_list *parents = NULL, *j;
+	struct commit_list *parents = NULL;
 	struct strbuf buf = STRBUF_INIT;
 	unsigned char result_commit[20];
 
 	free_commit_list(common);
-	if (allow_fast_forward) {
-		parents = remoteheads;
+	parents = remoteheads;
+	if (!head_subsumed || !allow_fast_forward)
 		commit_list_insert(head, &parents);
-		parents = reduce_heads(parents);
-	} else {
-		struct commit_list **pptr = &parents;
-
-		pptr = &commit_list_insert(head,
-				pptr)->next;
-		for (j = remoteheads; j; j = j->next)
-			pptr = &commit_list_insert(j->item, pptr)->next;
-	}
 	strbuf_addch(&merge_msg, '\n');
 	prepare_to_commit(remoteheads);
-	free_commit_list(remoteheads);
 	if (commit_tree(&merge_msg, result_tree, parents, result_commit,
 			NULL, sign_commit))
 		die(_("failed to write commit object"));
@@ -1137,12 +1128,16 @@ static int default_edit_option(void)
 		st_stdin.st_mode == st_stdout.st_mode);
 }
 
-static struct commit_list *collect_parents(int argc, const char **argv)
+static struct commit_list *collect_parents(struct commit *head_commit,
+					   int *head_subsumed,
+					   int argc, const char **argv)
 {
 	int i;
-	struct commit_list *remoteheads = NULL;
+	struct commit_list *remoteheads = NULL, *parents, *next;
 	struct commit_list **remotes = &remoteheads;
 
+	if (head_commit)
+		remotes = &commit_list_insert(head_commit, remotes)->next;
 	for (i = 0; i < argc; i++) {
 		struct commit *commit = get_merge_parent(argv[i]);
 		if (!commit)
@@ -1150,6 +1145,20 @@ static struct commit_list *collect_parents(int argc, const char **argv)
 		remotes = &commit_list_insert(commit, remotes)->next;
 	}
 	*remotes = NULL;
+
+	parents = reduce_heads(remoteheads);
+
+	*head_subsumed = 1; /* we will flip this to 0 when we find it */
+	for (remoteheads = NULL, remotes = &remoteheads;
+	     parents;
+	     parents = next) {
+		struct commit *commit = parents->item;
+		next = parents->next;
+		if (commit == head_commit)
+			*head_subsumed = 0;
+		else
+			remotes = &commit_list_insert(commit, remotes)->next;
+	}
 	return remoteheads;
 }
 
@@ -1161,7 +1170,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	struct commit *head_commit;
 	struct strbuf buf = STRBUF_INIT;
 	const char *head_arg;
-	int flag, i, ret = 0;
+	int flag, i, ret = 0, head_subsumed;
 	int best_cnt = -1, merge_was_ok = 0, automerge_was_ok = 0;
 	struct commit_list *common = NULL;
 	const char *best_strategy = NULL, *wt_strategy = NULL;
@@ -1270,7 +1279,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		head_arg = argv[1];
 		argv += 2;
 		argc -= 2;
-		remoteheads = collect_parents(argc, argv);
+		remoteheads = collect_parents(head_commit, &head_subsumed, argc, argv);
 	} else if (!head_commit) {
 		struct commit *remote_head;
 		/*
@@ -1286,7 +1295,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		if (!allow_fast_forward)
 			die(_("Non-fast-forward commit does not make sense into "
 			    "an empty head"));
-		remoteheads = collect_parents(argc, argv);
+		remoteheads = collect_parents(head_commit, &head_subsumed, argc, argv);
 		remote_head = remoteheads->item;
 		if (!remote_head)
 			die(_("%s - not something we can merge"), argv[0]);
@@ -1305,7 +1314,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * the standard merge summary message to be appended
 		 * to the given message.
 		 */
-		remoteheads = collect_parents(argc, argv);
+		remoteheads = collect_parents(head_commit, &head_subsumed, argc, argv);
 		for (p = remoteheads; p; p = p->next)
 			merge_name(merge_remote_util(p->item)->name, &merge_names);
 
@@ -1351,7 +1360,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		option_edit = 0;
 
 	if (!use_strategies) {
-		if (!remoteheads->next)
+		if (!remoteheads)
+			; /* already up-to-date */
+		else if (!remoteheads->next)
 			add_strategies(pull_twohead, DEFAULT_TWOHEAD);
 		else
 			add_strategies(pull_octopus, DEFAULT_OCTOPUS);
@@ -1364,7 +1375,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			allow_trivial = 0;
 	}
 
-	if (!remoteheads->next)
+	if (!remoteheads)
+		; /* already up-to-date */
+	else if (!remoteheads->next)
 		common = get_merge_bases(head_commit, remoteheads->item, 1);
 	else {
 		struct commit_list *list = remoteheads;
@@ -1376,10 +1389,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	update_ref("updating ORIG_HEAD", "ORIG_HEAD", head_commit->object.sha1,
 		   NULL, 0, DIE_ON_ERR);
 
-	if (!common)
+	if (remoteheads && !common)
 		; /* No common ancestors found. We need a real merge. */
-	else if (!remoteheads->next && !common->next &&
-			common->item == remoteheads->item) {
+	else if (!remoteheads ||
+		 (!remoteheads->next && !common->next &&
+		  common->item == remoteheads->item)) {
 		/*
 		 * If head can reach all the merge then we are up to date.
 		 * but first the most common case of merging one remote.
@@ -1553,7 +1567,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * auto resolved the merge cleanly.
 	 */
 	if (automerge_was_ok) {
-		ret = finish_automerge(head_commit, common, remoteheads,
+		ret = finish_automerge(head_commit, head_subsumed,
+				       common, remoteheads,
 				       result_tree, wt_strategy);
 		goto done;
 	}
diff --git a/t/t6028-merge-up-to-date.sh b/t/t6028-merge-up-to-date.sh
index 824fca5..c518e9c 100755
--- a/t/t6028-merge-up-to-date.sh
+++ b/t/t6028-merge-up-to-date.sh
@@ -79,7 +79,7 @@ test_expect_success 'merge -s subtree up-to-date' '
 
 '
 
-test_expect_failure 'merge fast-forward octopus' '
+test_expect_success 'merge fast-forward octopus' '
 
 	git reset --hard c0 &&
 	test_tick &&
diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many.sh
index 5783ebf..7117b57 100755
--- a/t/t7602-merge-octopus-many.sh
+++ b/t/t7602-merge-octopus-many.sh
@@ -70,17 +70,15 @@ test_expect_success 'merge output uses pretty names' '
 '
 
 cat >expected <<\EOF
-Already up-to-date with c4
-Trying simple merge with c5
-Merge made by the 'octopus' strategy.
+Merge made by the 'recursive' strategy.
  c5.c |    1 +
  1 file changed, 1 insertion(+)
  create mode 100644 c5.c
 EOF
 
-test_expect_success 'merge up-to-date output uses pretty names' '
-	git merge c4 c5 >actual &&
-	test_cmp actual expected
+test_expect_success 'merge reduces irrelevant remote heads' '
+	GIT_MERGE_VERBOSITY=0 git merge c4 c5 >actual &&
+	test_cmp expected actual
 '
 
 cat >expected <<\EOF
-- 
1.7.10.332.g1863c
