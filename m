Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4345F1BC9EE
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567205; cv=none; b=YELQ5VJ5hJrrcV9lCdSPObfxt8y3VSRK5dwboZNTRQtvNeC2r5+70SCk9E7Y6aq9L7Ei2WbvMf4hurTzOWY87cyUVQV3flpwkNZbiOWTQEL9IS5J+YraylH7ZRhQJB6QS/it0ucyA3nnN7oYJQUdnjqUCpSm+2oligbaUWt+s44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567205; c=relaxed/simple;
	bh=jQvoiAN2vpzAfr13/DXF1fzootMxKajiEkfEsNmD2HM=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=qHicV16JHgY5lbboKaFoRbOGq7xbRqn4aabWLM8am5YBGMjGn6M8Up/oslGPExb8CpheUr57F0zN2TkqeA0RpoJF6HDyNJKVKX3WBuC8ncaA2aIgTGxTwErKBgs4xggYKGuT+wIl9l5qqbxw1zGbyCeAs0KL8e+3bOGtP623lBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=JhzMb542; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="JhzMb542"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=S0ne6qec74gVBvz33MpZXW9lLh8B7Nj53EodC8Jo/KQ=;
 b=JhzMb5421o5xrrDmyVzJ2/mF2VWKO1yTn71qqR69w7w9BZCS1d391Qtwy76bs4N+AJAIEZ3Iu4ac
   GcQQpnVW7BYFdnN2rFPYN8BGT/ld8pYXd7FNxNGzcVoNE/Ux4SXLhBFrN3XMvFZz6aUDdueRAJCm
   x3fLg4nXEvjnWqptNaBnlqTssRmZCkNtlf8vjR3H3ujf+IJgWtusYPEHtSPq17ZfZtX+jIU37hQQ
   8uIfKCPtYJN3FoYe+M9GWt2rn1vkbD+3QNmcQaQQPmswfeP9ePdS3wKCqvK2S4S05YQNw4fV66oT
   Y9ZPDGr4WKN8pUmNTExf0BPV2TqPK6pCvx7TjA==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SL500JYH6ZKZ150@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 10 Oct 2024 13:33:20 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	Taylor Blau <me@ttaylorr.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v6 5/6] refs_update_symref: add create_only option
Date: Thu, 10 Oct 2024 15:30:00 +0200
Message-id: <20241010133022.1733542-5-bence@ferdinandy.com>
In-reply-to: <20241010133022.1733542-1-bence@ferdinandy.com>
References: <xmqqzfndndfm.fsf@gitster.g>
 <20241010133022.1733542-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAFkClu7NkgDEEonQIdFjym5PUIXUg+VdM8Ay2cp+dCBY9xLP4cUVO/XMVf0/mOI
 U+17Ngn0FwXy+vKWWKeOFb+bdkNajqEU0GTCmXJMsnUwzkhT5v/xmTqXFaSXh3QX
 VlhP6nGuTzkj17zDEm+RJXX+tqDWnt2B7tgkYj6cZvBox+3rscc8II5glRS1GzqL
 AEkQC6g3/I1jpapMaKDtp6Vk6JzDw2ws/1svnbUWM1aO1NapTOgGp2aWK4hIqtBA
 m0SIvzYth/c47SuFPjrizGoiok7aE1F0bFP1qwy0iXPaGyeLQisvfl4K1lkY2M3B
 N854MlS8PVvcdlQmEDXsPd5t1EiYY0dWrgUO8WqyBUgyHSyE9k/4mC1TedyuKudV
 XoEMpxQeKnTCXqkmvsi6X+rFtULnX28sskXYHzaw/J+uogqNX50ak/L9Zi/CNMdC
 V6u0mM/92jBx2LdKL8FBna+AQgO64DDRNhzd7tpEdK8lIOfemEJplxDk

Allow the caller to specify that it only wants to update the symref if
it does not already exist. Silently ignore the error from the
transaction API if the symref already exists.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v4: new patch
    v5: no change
    
    v6: - switched from bool to int for create_only
        - refactored logic in refs_update_symref with goto as layed out by
          Junio

 builtin/branch.c          |  2 +-
 builtin/checkout.c        |  5 +++--
 builtin/clone.c           |  8 +++++---
 builtin/notes.c           |  3 ++-
 builtin/remote.c          |  9 ++++++---
 builtin/symbolic-ref.c    |  2 +-
 builtin/worktree.c        |  2 +-
 refs.c                    | 36 +++++++++++++++++++++++++-----------
 refs.h                    |  2 +-
 reset.c                   |  2 +-
 sequencer.c               |  3 ++-
 setup.c                   |  3 ++-
 t/helper/test-ref-store.c |  2 +-
 13 files changed, 51 insertions(+), 28 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 6c87690b58..2fcbcbfd59 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -559,7 +559,7 @@ static int replace_each_worktree_head_symref(struct worktree **worktrees,
 			continue;
 
 		refs = get_worktree_ref_store(worktrees[i]);
-		if (refs_update_symref(refs, "HEAD", newref, logmsg, NULL))
+		if (refs_update_symref(refs, "HEAD", newref, logmsg, NULL, 0))
 			ret = error(_("HEAD of working tree %s is not updated"),
 				    worktrees[i]->path);
 	}
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 356ee9bcde..9abb71dc07 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1015,7 +1015,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 			describe_detached_head(_("HEAD is now at"), new_branch_info->commit);
 		}
 	} else if (new_branch_info->path) {	/* Switch branches. */
-		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", new_branch_info->path, msg.buf, NULL) < 0)
+		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", new_branch_info->path,
+					msg.buf, NULL, 0) < 0)
 			die(_("unable to update HEAD"));
 		if (!opts->quiet) {
 			if (old_branch_info->path && !strcmp(new_branch_info->path, old_branch_info->path)) {
@@ -1479,7 +1480,7 @@ static int switch_unborn_to_new_branch(const struct checkout_opts *opts)
 		die(_("You are on a branch yet to be born"));
 	strbuf_addf(&branch_ref, "refs/heads/%s", opts->new_branch);
 	status = refs_update_symref(get_main_ref_store(the_repository),
-				    "HEAD", branch_ref.buf, "checkout -b", NULL);
+				    "HEAD", branch_ref.buf, "checkout -b", NULL, 0);
 	strbuf_release(&branch_ref);
 	if (!opts->quiet)
 		fprintf(stderr, _("Switched to a new branch '%s'\n"),
diff --git a/builtin/clone.c b/builtin/clone.c
index ead2af20ea..87e8f1421a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -661,7 +661,7 @@ static void update_remote_refs(const struct ref *refs,
 		strbuf_addstr(&head_ref, "HEAD");
 		if (refs_update_symref(get_main_ref_store(the_repository), head_ref.buf,
 				       remote_head_points_at->peer_ref->name,
-				       msg, NULL) < 0)
+				       msg, NULL, 0) < 0)
 			die(_("unable to update %s"), head_ref.buf);
 		strbuf_release(&head_ref);
 	}
@@ -673,7 +673,8 @@ static void update_head(const struct ref *our, const struct ref *remote,
 	const char *head;
 	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
 		/* Local default branch link */
-		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", our->name, NULL, NULL) < 0)
+		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", our->name,
+					NULL, NULL, 0) < 0)
 			die(_("unable to update HEAD"));
 		if (!option_bare) {
 			refs_update_ref(get_main_ref_store(the_repository),
@@ -702,7 +703,8 @@ static void update_head(const struct ref *our, const struct ref *remote,
 		 * Unborn head from remote; same as "our" case above except
 		 * that we have no ref to update.
 		 */
-		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", unborn, NULL, NULL) < 0)
+		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", unborn,
+					NULL, NULL, 0) < 0)
 			die(_("unable to update HEAD"));
 		if (!option_bare)
 			install_branch_config(0, head, remote_name, unborn);
diff --git a/builtin/notes.c b/builtin/notes.c
index ba646f06ff..7b3138e3c3 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -980,7 +980,8 @@ static int merge(int argc, const char **argv, const char *prefix)
 			die(_("a notes merge into %s is already in-progress at %s"),
 			    notes_ref, wt->path);
 		free_worktrees(worktrees);
-		if (refs_update_symref(get_main_ref_store(the_repository), "NOTES_MERGE_REF", notes_ref, NULL, NULL))
+		if (refs_update_symref(get_main_ref_store(the_repository), "NOTES_MERGE_REF", notes_ref,
+					NULL, NULL, 0))
 			die(_("failed to store link to current notes ref (%s)"),
 			    notes_ref);
 		fprintf(stderr, _("Automatic notes merge failed. Fix conflicts in %s "
diff --git a/builtin/remote.c b/builtin/remote.c
index 24f9caf149..9774d8ffe3 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -244,7 +244,8 @@ static int add(int argc, const char **argv, const char *prefix)
 		strbuf_reset(&buf2);
 		strbuf_addf(&buf2, "refs/remotes/%s/%s", name, master);
 
-		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote add", NULL))
+		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf,
+					"remote add", NULL, 0))
 			result = error(_("Could not setup master '%s'"), master);
 	}
 
@@ -864,7 +865,8 @@ static int mv(int argc, const char **argv, const char *prefix)
 		strbuf_reset(&buf3);
 		strbuf_addf(&buf3, "remote: renamed %s to %s",
 				item->string, buf.buf);
-		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, buf3.buf, NULL))
+		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf,
+					buf3.buf, NULL, 0))
 			die(_("creating '%s' failed"), buf.buf);
 		display_progress(progress, ++refs_renamed_nr);
 	}
@@ -1469,7 +1471,8 @@ static int set_head(int argc, const char **argv, const char *prefix)
 		/* make sure it's valid */
 		if (!refs_ref_exists(refs, buf2.buf))
 			result |= error(_("Not a valid ref: %s"), buf2.buf);
-		else if (refs_update_symref(refs, buf.buf, buf2.buf, "remote set-head", &buf_prev))
+		else if (refs_update_symref(refs, buf.buf, buf2.buf,
+					"remote set-head", &buf_prev, 0))
 			result |= error(_("Could not setup %s"), buf.buf);
 		else if (opt_a) {
 			report_auto(argv[0], head_name, &buf_prev);
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 7728fbc3c1..cfbb53b30c 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -88,7 +88,7 @@ int cmd_symbolic_ref(int argc,
 		if (check_refname_format(argv[1], REFNAME_ALLOW_ONELEVEL) < 0)
 			die("Refusing to set '%s' to invalid ref '%s'", argv[0], argv[1]);
 		ret = !!refs_update_symref(get_main_ref_store(the_repository),
-					   argv[0], argv[1], msg, NULL);
+					   argv[0], argv[1], msg, NULL, 0);
 		break;
 	default:
 		usage_with_options(git_symbolic_ref_usage, options);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index a7ab4193c1..2e95367235 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -517,7 +517,7 @@ static int add_worktree(const char *path, const char *refname,
 		ret = refs_update_ref(wt_refs, NULL, "HEAD", &commit->object.oid,
 				      NULL, 0, UPDATE_REFS_MSG_ON_ERR);
 	else
-		ret = refs_update_symref(wt_refs, "HEAD", symref.buf, NULL, NULL);
+		ret = refs_update_symref(wt_refs, "HEAD", symref.buf, NULL, NULL, 0);
 	if (ret)
 		goto done;
 
diff --git a/refs.c b/refs.c
index 91cacee6f9..e23288b817 100644
--- a/refs.c
+++ b/refs.c
@@ -2115,29 +2115,43 @@ int peel_iterated_oid(struct repository *r, const struct object_id *base, struct
 
 int refs_update_symref(struct ref_store *refs, const char *ref,
 		       const char *target, const char *logmsg,
-		       struct strbuf *before_target)
+		       struct strbuf *before_target, int create_only)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 	int ret = 0;
 
 	transaction = ref_store_transaction_begin(refs, &err);
-	if (!transaction ||
-	    ref_transaction_update(transaction, ref, NULL, NULL,
-				   target, NULL, REF_NO_DEREF,
-				   logmsg, &err) ||
-	    ref_transaction_commit(transaction, &err)) {
+	if (!transaction) {
+	error_return:
 		ret = error("%s", err.buf);
+		goto cleanup;
 	}
+	if (create_only) {
+		int create_ret = 0;
+		if (ref_transaction_create(transaction, ref, NULL, target,
+					   REF_NO_DEREF, logmsg, &err))
+			goto error_return;
+		create_ret = ref_transaction_commit(transaction, &err);
+		if (create_ret && create_ret != TRANSACTION_CREATE_EXISTS)
+			ret = error("%s", err.buf);
 
-	strbuf_release(&err);
+	} else {
+		if (ref_transaction_update(transaction, ref, NULL, NULL,
+					   target, NULL, REF_NO_DEREF,
+					   logmsg, &err) ||
+		    ref_transaction_commit(transaction, &err))
+			goto error_return;
+	}
 
-	if (transaction && before_target && transaction->updates[0]->before_target)
-		strbuf_addstr(before_target, transaction->updates[0]->before_target);
+cleanup:
+	strbuf_release(&err);
 
-	if (transaction)
+	if (transaction) {
+		if (before_target && transaction->updates[0]->before_target)
+			strbuf_addstr(before_target, transaction->updates[0]->before_target);
 		ref_transaction_free(transaction);
-
+	}
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index 166affbc89..35f5439cd1 100644
--- a/refs.h
+++ b/refs.h
@@ -572,7 +572,7 @@ int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
 
 int refs_update_symref(struct ref_store *refs, const char *refname,
 		       const char *target, const char *logmsg,
-		       struct strbuf *before_target);
+		       struct strbuf *before_target, int create_only);
 
 enum action_on_err {
 	UPDATE_REFS_MSG_ON_ERR,
diff --git a/reset.c b/reset.c
index cc36a9ed56..919fb84f5f 100644
--- a/reset.c
+++ b/reset.c
@@ -76,7 +76,7 @@ static int update_refs(const struct reset_head_opts *opts,
 		if (!ret)
 			ret = refs_update_symref(get_main_ref_store(the_repository),
 						 "HEAD", switch_to_branch,
-						 reflog_head, NULL);
+						 reflog_head, NULL, 0);
 	}
 	if (!ret && run_hook)
 		run_hooks_l(the_repository, "post-checkout",
diff --git a/sequencer.c b/sequencer.c
index 23b162924c..103d0ddfb2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5107,7 +5107,8 @@ static int pick_commits(struct repository *r,
 			}
 			msg = reflog_message(opts, "finish", "returning to %s",
 				head_ref.buf);
-			if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", head_ref.buf, msg, NULL)) {
+			if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", head_ref.buf,
+						msg, NULL, 0)) {
 				res = error(_("could not update HEAD to %s"),
 					head_ref.buf);
 				goto cleanup_head_ref;
diff --git a/setup.c b/setup.c
index d95f051465..9bbc655ee4 100644
--- a/setup.c
+++ b/setup.c
@@ -2275,7 +2275,8 @@ void create_reference_database(enum ref_storage_format ref_storage_format,
 			die(_("invalid initial branch name: '%s'"),
 			    initial_branch);
 
-		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", ref, NULL, NULL) < 0)
+		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", ref,
+					NULL, NULL, 0) < 0)
 			exit(1);
 		free(ref);
 	}
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index a911302bea..f72b029e51 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -120,7 +120,7 @@ static int cmd_create_symref(struct ref_store *refs, const char **argv)
 	const char *target = notnull(*argv++, "target");
 	const char *logmsg = *argv++;
 
-	return refs_update_symref(refs, refname, target, logmsg, NULL);
+	return refs_update_symref(refs, refname, target, logmsg, NULL, 0);
 }
 
 static struct flag_definition transaction_flags[] = {
-- 
2.47.0.6.g07cb02250a

