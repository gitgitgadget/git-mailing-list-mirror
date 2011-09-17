From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 3/4] merge: remove global variable head[]
Date: Sat, 17 Sep 2011 21:57:44 +1000
Message-ID: <1316260665-1728-3-git-send-email-pclouds@gmail.com>
References: <1316260665-1728-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 17 13:58:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4tXK-0005Dj-Se
	for gcvg-git-2@lo.gmane.org; Sat, 17 Sep 2011 13:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180Ab1IQL6N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Sep 2011 07:58:13 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35780 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609Ab1IQL6K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2011 07:58:10 -0400
Received: by mail-iy0-f174.google.com with SMTP id q3so3214468iaq.19
        for <git@vger.kernel.org>; Sat, 17 Sep 2011 04:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vHBdu8bcACdOj/wSJ5BWA+fLuxBrFbPOCcokJZLGqQU=;
        b=agimFQNC6OCq46SzqCc3fg1IxnyPH3Dbi/epK6m0wUoCu6su2qhHFnExaLayt/5jCC
         zzv3WSfPaQ7SRxkEt7yHOOptf0Jpg1U0G+Wo4qE+EoJkIbkbP9X1rEw/4iqJOzh+ay+G
         /kt/bvhwBXhk5TaiQm6jBsaZJwdwTYaGbSoKs=
Received: by 10.42.197.67 with SMTP id ej3mr805216icb.213.1316260690147;
        Sat, 17 Sep 2011 04:58:10 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id j2sm14265671ibx.11.2011.09.17.04.58.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Sep 2011 04:58:09 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 17 Sep 2011 21:58:01 +1000
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1316260665-1728-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181578>

Also kill head_invalid in favor of "head_commit =3D=3D NULL".

Local variable "head" in cmd_merge() is renamed to "head_sha1" to make
sure I don't miss any access because this variable should not be used
after head_commit is set (use head_commit->object.sha1 instead).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/merge.c |   97 ++++++++++++++++++++++++++++++-----------------=
--------
 1 files changed, 53 insertions(+), 44 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index c371484..f5eb3f5 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -50,7 +50,6 @@ static int fast_forward_only;
 static int allow_trivial =3D 1, have_message;
 static struct strbuf merge_msg;
 static struct commit_list *remoteheads;
-static unsigned char head[20];
 static struct strategy **use_strategies;
 static size_t use_strategies_nr, use_strategies_alloc;
 static const char **xopts;
@@ -279,7 +278,8 @@ static void reset_hard(unsigned const char *sha1, i=
nt verbose)
 		die(_("read-tree failed"));
 }
=20
-static void restore_state(const unsigned char *stash)
+static void restore_state(const unsigned char *head,
+			  const unsigned char *stash)
 {
 	struct strbuf sb =3D STRBUF_INIT;
 	const char *args[] =3D { "stash", "apply", NULL, NULL };
@@ -309,10 +309,9 @@ static void finish_up_to_date(const char *msg)
 	drop_save();
 }
=20
-static void squash_message(void)
+static void squash_message(struct commit *commit)
 {
 	struct rev_info rev;
-	struct commit *commit;
 	struct strbuf out =3D STRBUF_INIT;
 	struct commit_list *j;
 	int fd;
@@ -327,7 +326,6 @@ static void squash_message(void)
 	rev.ignore_merges =3D 1;
 	rev.commit_format =3D CMIT_FMT_MEDIUM;
=20
-	commit =3D lookup_commit(head);
 	commit->object.flags |=3D UNINTERESTING;
 	add_pending_object(&rev, &commit->object, NULL);
=20
@@ -356,9 +354,11 @@ static void squash_message(void)
 	strbuf_release(&out);
 }
=20
-static void finish(const unsigned char *new_head, const char *msg)
+static void finish(struct commit *head_commit,
+		   const unsigned char *new_head, const char *msg)
 {
 	struct strbuf reflog_message =3D STRBUF_INIT;
+	const unsigned char *head =3D head_commit->object.sha1;
=20
 	if (!msg)
 		strbuf_addstr(&reflog_message, getenv("GIT_REFLOG_ACTION"));
@@ -369,7 +369,7 @@ static void finish(const unsigned char *new_head, c=
onst char *msg)
 			getenv("GIT_REFLOG_ACTION"), msg);
 	}
 	if (squash) {
-		squash_message();
+		squash_message(head_commit);
 	} else {
 		if (verbosity >=3D 0 && !merge_msg.len)
 			printf(_("No merge message -- not updating HEAD\n"));
@@ -664,7 +664,7 @@ int try_merge_command(const char *strategy, size_t =
xopts_nr,
 }
=20
 static int try_merge_strategy(const char *strategy, struct commit_list=
 *common,
-			      const char *head_arg)
+			      struct commit *head, const char *head_arg)
 {
 	int index_fd;
 	struct lock_file *lock =3D xcalloc(1, sizeof(struct lock_file));
@@ -710,7 +710,7 @@ static int try_merge_strategy(const char *strategy,=
 struct commit_list *common,
 			commit_list_insert(j->item, &reversed);
=20
 		index_fd =3D hold_locked_index(lock, 1);
-		clean =3D merge_recursive(&o, lookup_commit(head),
+		clean =3D merge_recursive(&o, head,
 				remoteheads->item, reversed, &result);
 		if (active_cache_changed &&
 				(write_cache(index_fd, active_cache, active_nr) ||
@@ -861,25 +861,26 @@ static void run_prepare_commit_msg(void)
 	read_merge_msg();
 }
=20
-static int merge_trivial(void)
+static int merge_trivial(struct commit *head)
 {
 	unsigned char result_tree[20], result_commit[20];
 	struct commit_list *parent =3D xmalloc(sizeof(*parent));
=20
 	write_tree_trivial(result_tree);
 	printf(_("Wonderful.\n"));
-	parent->item =3D lookup_commit(head);
+	parent->item =3D head;
 	parent->next =3D xmalloc(sizeof(*parent->next));
 	parent->next->item =3D remoteheads->item;
 	parent->next->next =3D NULL;
 	run_prepare_commit_msg();
 	commit_tree(merge_msg.buf, result_tree, parent, result_commit, NULL);
-	finish(result_commit, "In-index merge");
+	finish(head, result_commit, "In-index merge");
 	drop_save();
 	return 0;
 }
=20
-static int finish_automerge(struct commit_list *common,
+static int finish_automerge(struct commit *head,
+			    struct commit_list *common,
 			    unsigned char *result_tree,
 			    const char *wt_strategy)
 {
@@ -890,12 +891,12 @@ static int finish_automerge(struct commit_list *c=
ommon,
 	free_commit_list(common);
 	if (allow_fast_forward) {
 		parents =3D remoteheads;
-		commit_list_insert(lookup_commit(head), &parents);
+		commit_list_insert(head, &parents);
 		parents =3D reduce_heads(parents);
 	} else {
 		struct commit_list **pptr =3D &parents;
=20
-		pptr =3D &commit_list_insert(lookup_commit(head),
+		pptr =3D &commit_list_insert(head,
 				pptr)->next;
 		for (j =3D remoteheads; j; j =3D j->next)
 			pptr =3D &commit_list_insert(j->item, pptr)->next;
@@ -905,7 +906,7 @@ static int finish_automerge(struct commit_list *com=
mon,
 	run_prepare_commit_msg();
 	commit_tree(merge_msg.buf, result_tree, parents, result_commit, NULL)=
;
 	strbuf_addf(&buf, "Merge made by %s.", wt_strategy);
-	finish(result_commit, buf.buf);
+	finish(head, result_commit, buf.buf);
 	strbuf_release(&buf);
 	drop_save();
 	return 0;
@@ -939,7 +940,8 @@ static int suggest_conflicts(int renormalizing)
 	return 1;
 }
=20
-static struct commit *is_old_style_invocation(int argc, const char **a=
rgv)
+static struct commit *is_old_style_invocation(int argc, const char **a=
rgv,
+					      const unsigned char *head)
 {
 	struct commit *second_token =3D NULL;
 	if (argc > 2) {
@@ -1012,9 +1014,11 @@ int cmd_merge(int argc, const char **argv, const=
 char *prefix)
 {
 	unsigned char result_tree[20];
 	unsigned char stash[20];
+	unsigned char head_sha1[20];
+	struct commit *head_commit;
 	struct strbuf buf =3D STRBUF_INIT;
 	const char *head_arg;
-	int flag, head_invalid =3D 0, i;
+	int flag, i;
 	int best_cnt =3D -1, merge_was_ok =3D 0, automerge_was_ok =3D 0;
 	struct commit_list *common =3D NULL;
 	const char *best_strategy =3D NULL, *wt_strategy =3D NULL;
@@ -1027,11 +1031,16 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
 	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
 	 * current branch.
 	 */
-	branch =3D resolve_ref("HEAD", head, 0, &flag);
+	branch =3D resolve_ref("HEAD", head_sha1, 0, &flag);
 	if (branch && !prefixcmp(branch, "refs/heads/"))
 		branch +=3D 11;
-	if (!branch || is_null_sha1(head))
-		head_invalid =3D 1;
+	if (!branch || is_null_sha1(head_sha1))
+		head_commit =3D NULL;
+	else {
+		head_commit =3D lookup_commit(head_sha1);
+		if (!head_commit)
+			die(_("could not parse HEAD"));
+	}
=20
 	git_config(git_merge_config, NULL);
=20
@@ -1112,12 +1121,13 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
 	 * additional safety measure to check for it.
 	 */
=20
-	if (!have_message && is_old_style_invocation(argc, argv)) {
+	if (!have_message && head_commit &&
+	    is_old_style_invocation(argc, argv, head_commit->object.sha1)) {
 		strbuf_addstr(&merge_msg, argv[0]);
 		head_arg =3D argv[1];
 		argv +=3D 2;
 		argc -=3D 2;
-	} else if (head_invalid) {
+	} else if (!head_commit) {
 		struct object *remote_head;
 		/*
 		 * If the merged head is a valid one there is no reason
@@ -1164,7 +1174,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 		}
 	}
=20
-	if (head_invalid || !argc)
+	if (!head_commit || !argc)
 		usage_with_options(builtin_merge_usage,
 			builtin_merge_options);
=20
@@ -1205,17 +1215,16 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
 	}
=20
 	if (!remoteheads->next)
-		common =3D get_merge_bases(lookup_commit(head),
-				remoteheads->item, 1);
+		common =3D get_merge_bases(head_commit, remoteheads->item, 1);
 	else {
 		struct commit_list *list =3D remoteheads;
-		commit_list_insert(lookup_commit(head), &list);
+		commit_list_insert(head_commit, &list);
 		common =3D get_octopus_merge_bases(list);
 		free(list);
 	}
=20
-	update_ref("updating ORIG_HEAD", "ORIG_HEAD", head, NULL, 0,
-		DIE_ON_ERR);
+	update_ref("updating ORIG_HEAD", "ORIG_HEAD", head_commit->object.sha=
1,
+		   NULL, 0, DIE_ON_ERR);
=20
 	if (!common)
 		; /* No common ancestors found. We need a real merge. */
@@ -1229,13 +1238,13 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
 		return 0;
 	} else if (allow_fast_forward && !remoteheads->next &&
 			!common->next &&
-			!hashcmp(common->item->object.sha1, head)) {
+			!hashcmp(common->item->object.sha1, head_commit->object.sha1)) {
 		/* Again the most common case of merging one remote. */
 		struct strbuf msg =3D STRBUF_INIT;
 		struct object *o;
 		char hex[41];
=20
-		strcpy(hex, find_unique_abbrev(head, DEFAULT_ABBREV));
+		strcpy(hex, find_unique_abbrev(head_commit->object.sha1, DEFAULT_ABB=
REV));
=20
 		if (verbosity >=3D 0)
 			printf(_("Updating %s..%s\n"),
@@ -1251,10 +1260,10 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
 		if (!o)
 			return 1;
=20
-		if (checkout_fast_forward(head, remoteheads->item->object.sha1))
+		if (checkout_fast_forward(head_commit->object.sha1, remoteheads->ite=
m->object.sha1))
 			return 1;
=20
-		finish(o->sha1, msg.buf);
+		finish(head_commit, o->sha1, msg.buf);
 		drop_save();
 		return 0;
 	} else if (!remoteheads->next && common->next)
@@ -1274,8 +1283,8 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 			git_committer_info(IDENT_ERROR_ON_NO_NAME);
 			printf(_("Trying really trivial in-index merge...\n"));
 			if (!read_tree_trivial(common->item->object.sha1,
-					head, remoteheads->item->object.sha1))
-				return merge_trivial();
+					head_commit->object.sha1, remoteheads->item->object.sha1))
+				return merge_trivial(head_commit);
 			printf(_("Nope.\n"));
 		}
 	} else {
@@ -1294,8 +1303,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 			 * merge_bases again, otherwise "git merge HEAD^
 			 * HEAD^^" would be missed.
 			 */
-			common_one =3D get_merge_bases(lookup_commit(head),
-				j->item, 1);
+			common_one =3D get_merge_bases(head_commit, j->item, 1);
 			if (hashcmp(common_one->item->object.sha1,
 				j->item->object.sha1)) {
 				up_to_date =3D 0;
@@ -1333,7 +1341,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 		int ret;
 		if (i) {
 			printf(_("Rewinding the tree to pristine...\n"));
-			restore_state(stash);
+			restore_state(head_commit->object.sha1, stash);
 		}
 		if (use_strategies_nr !=3D 1)
 			printf(_("Trying merge strategy %s...\n"),
@@ -1345,7 +1353,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 		wt_strategy =3D use_strategies[i]->name;
=20
 		ret =3D try_merge_strategy(use_strategies[i]->name,
-			common, head_arg);
+					 common, head_commit, head_arg);
 		if (!option_commit && !ret) {
 			merge_was_ok =3D 1;
 			/*
@@ -1387,14 +1395,15 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
 	 * auto resolved the merge cleanly.
 	 */
 	if (automerge_was_ok)
-		return finish_automerge(common, result_tree, wt_strategy);
+		return finish_automerge(head_commit, common, result_tree,
+					wt_strategy);
=20
 	/*
 	 * Pick the result from the best strategy and have the user fix
 	 * it up.
 	 */
 	if (!best_strategy) {
-		restore_state(stash);
+		restore_state(head_commit->object.sha1, stash);
 		if (use_strategies_nr > 1)
 			fprintf(stderr,
 				_("No merge strategy handled the merge.\n"));
@@ -1406,14 +1415,14 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
 		; /* We already have its result in the working tree. */
 	else {
 		printf(_("Rewinding the tree to pristine...\n"));
-		restore_state(stash);
+		restore_state(head_commit->object.sha1, stash);
 		printf(_("Using the %s to prepare resolving by hand.\n"),
 			best_strategy);
-		try_merge_strategy(best_strategy, common, head_arg);
+		try_merge_strategy(best_strategy, common, head_commit, head_arg);
 	}
=20
 	if (squash)
-		finish(NULL, NULL);
+		finish(head_commit, NULL, NULL);
 	else {
 		int fd;
 		struct commit_list *j;
--=20
1.7.3.1.256.g2539c.dirty
