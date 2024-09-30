Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97842188CB6
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727735356; cv=none; b=u69lIENFRUnVdUWyREqVVcN3w/KGZWKhNjMRlDOYFLQMs6iJB2Dmzn38E33QhBdAAdGaMPA5w5zvuZOMGerwXjyvCYf9fCIqHwPVN917pNZ9uz7ZAfQhYaT5oraiKH/nrpv3XhbKGV7qxbEfb/1kFeLsTZQfvWci9X6qQEoVroA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727735356; c=relaxed/simple;
	bh=e3R1Yh88GAoA1f6ftytNrQ9B+Zoi776UPXAq5ph/B9s=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=OwBYF+P94YO67nKTM6cvxx3JRGLWJakGgx5sIMZl2up3rtB9jmMNSMtj8DfhO3heKVhXkN0P0XQSLm0Rxya4jERig/bWU03hmUJzCx62RyjoK4vobEW2y+po0pjVvNK5P7PG5Tbm9mUdfRrWWcwXnA0sPg4qdHZvMYbKKFZEgAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=GIby9Z0+; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="GIby9Z0+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=9XrG/PadRZOoo0NJ0qyaQ/54WC+SwA8KJ/ZJalR7UJI=;
 b=GIby9Z0+dTaoJrQVHpVfOU7FMD+9EzFxZ8Go2Z7y/kieq3+WtqHKdkikpFKLenTMNMBWIpenjFDe
   K10JgT6r1UE4J/M14abGrVwl+KaU6PPNgc+Atj9auE5ECpikIzWUM5W+mEJszJjFymIK4fltUg6d
   Ml6koguEle7pHS4o4CQ+dQyUKWXweGHXAbEsuQjWzrVWBSj8a1Hlb3/Bn+0hETt+wN0FkPmILjR1
   KexVXB6FYT3OhXqqVRkGv+caivZKjM/TsojP5U/li27Zh4O8MY4EM04uBJzMXWaxCy4jugWi4z4D
   0l6JyxhmzdTVqgoGTaHzl7xZ6U3qkfq97gTNLA==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SKN00399CW6RU60@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 30 Sep 2024 22:24:06 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v4 4/5] refs_update_symref: add create_only option
Date: Tue,  1 Oct 2024 00:19:54 +0200
Message-id: <20240930222025.2349008-5-bence@ferdinandy.com>
In-reply-to: <20240930222025.2349008-1-bence@ferdinandy.com>
References: <D4JIG4VS5WVN.2F0PNU5514UEL@ferdinandy.com>
 <20240930222025.2349008-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHZwkTWDLgHwA9ZRNNKp49+rH3LojH12GvMbCKPwfa+i3+1bnoxK0HQ5V6xyCdg
 AlEKEauLTZVPUx7oZRpdQwB4L2jL1QZcxGIBL+E4lK8B58DLCxLuHrWYVw8Ep57E
 Uo4pxDZwVGQmVvd1A4mHEIPg+FIKPgXWlHhoYuCqyBSbOO0zg+hIXczOLtDrMqXl
 4tVzBiDndDafyPEgHXLl17k0JLh7dTJFTBaE89rx0PS1wTNglZU6bwhF2ZklJL7Q
 RN6Q2aYall62wBc1o76ooKpRo4LsjqErokQvb97KRdTn0uBZmGHJHndrJMePQ8+b
 fgYHiFtkbB1A+OYBXuQOyKJYATCYvmBQ6XTTgyQAGtFEVDstZi96DqYxu1Mq5m8V
 9DyXRAbdljFUZd6AT4+RzylSOqF9eOyTaB1hy5Re9SLATtdFoLaZ9RSjcZatfTzI
 +fydmekwKkGu0EvyKVtrUTL/ONKtRRLH8YWifeWu4+9p9R2bUzQK3Do=

Allow the caller to specify that it only wants to update the symref if
it does not already exist. Silently ignore the error from the
transaction API if the symref already exists.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v4: new patch

 builtin/branch.c          |  2 +-
 builtin/checkout.c        |  5 +++--
 builtin/clone.c           |  8 +++++---
 builtin/notes.c           |  3 ++-
 builtin/remote.c          |  9 ++++++---
 builtin/symbolic-ref.c    |  2 +-
 builtin/worktree.c        |  2 +-
 refs.c                    | 29 +++++++++++++++++++++--------
 refs.h                    |  2 +-
 reset.c                   |  2 +-
 sequencer.c               |  3 ++-
 setup.c                   |  3 ++-
 t/helper/test-ref-store.c |  2 +-
 13 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 6c87690b58..3c9bc39800 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -559,7 +559,7 @@ static int replace_each_worktree_head_symref(struct worktree **worktrees,
 			continue;
 
 		refs = get_worktree_ref_store(worktrees[i]);
-		if (refs_update_symref(refs, "HEAD", newref, logmsg, NULL))
+		if (refs_update_symref(refs, "HEAD", newref, logmsg, NULL, false))
 			ret = error(_("HEAD of working tree %s is not updated"),
 				    worktrees[i]->path);
 	}
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 356ee9bcde..d9514e9b7a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1015,7 +1015,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 			describe_detached_head(_("HEAD is now at"), new_branch_info->commit);
 		}
 	} else if (new_branch_info->path) {	/* Switch branches. */
-		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", new_branch_info->path, msg.buf, NULL) < 0)
+		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", new_branch_info->path, 
+					msg.buf, NULL, false) < 0)
 			die(_("unable to update HEAD"));
 		if (!opts->quiet) {
 			if (old_branch_info->path && !strcmp(new_branch_info->path, old_branch_info->path)) {
@@ -1479,7 +1480,7 @@ static int switch_unborn_to_new_branch(const struct checkout_opts *opts)
 		die(_("You are on a branch yet to be born"));
 	strbuf_addf(&branch_ref, "refs/heads/%s", opts->new_branch);
 	status = refs_update_symref(get_main_ref_store(the_repository),
-				    "HEAD", branch_ref.buf, "checkout -b", NULL);
+				    "HEAD", branch_ref.buf, "checkout -b", NULL, false);
 	strbuf_release(&branch_ref);
 	if (!opts->quiet)
 		fprintf(stderr, _("Switched to a new branch '%s'\n"),
diff --git a/builtin/clone.c b/builtin/clone.c
index ead2af20ea..25d0bcf3aa 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -661,7 +661,7 @@ static void update_remote_refs(const struct ref *refs,
 		strbuf_addstr(&head_ref, "HEAD");
 		if (refs_update_symref(get_main_ref_store(the_repository), head_ref.buf,
 				       remote_head_points_at->peer_ref->name,
-				       msg, NULL) < 0)
+				       msg, NULL, false) < 0)
 			die(_("unable to update %s"), head_ref.buf);
 		strbuf_release(&head_ref);
 	}
@@ -673,7 +673,8 @@ static void update_head(const struct ref *our, const struct ref *remote,
 	const char *head;
 	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
 		/* Local default branch link */
-		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", our->name, NULL, NULL) < 0)
+		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", our->name, 
+					NULL, NULL, false) < 0)
 			die(_("unable to update HEAD"));
 		if (!option_bare) {
 			refs_update_ref(get_main_ref_store(the_repository),
@@ -702,7 +703,8 @@ static void update_head(const struct ref *our, const struct ref *remote,
 		 * Unborn head from remote; same as "our" case above except
 		 * that we have no ref to update.
 		 */
-		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", unborn, NULL, NULL) < 0)
+		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", unborn, 
+					NULL, NULL, false) < 0)
 			die(_("unable to update HEAD"));
 		if (!option_bare)
 			install_branch_config(0, head, remote_name, unborn);
diff --git a/builtin/notes.c b/builtin/notes.c
index ba646f06ff..fb49e491c3 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -980,7 +980,8 @@ static int merge(int argc, const char **argv, const char *prefix)
 			die(_("a notes merge into %s is already in-progress at %s"),
 			    notes_ref, wt->path);
 		free_worktrees(worktrees);
-		if (refs_update_symref(get_main_ref_store(the_repository), "NOTES_MERGE_REF", notes_ref, NULL, NULL))
+		if (refs_update_symref(get_main_ref_store(the_repository), "NOTES_MERGE_REF", notes_ref, 
+					NULL, NULL, false))
 			die(_("failed to store link to current notes ref (%s)"),
 			    notes_ref);
 		fprintf(stderr, _("Automatic notes merge failed. Fix conflicts in %s "
diff --git a/builtin/remote.c b/builtin/remote.c
index c61a7800ff..a1cec6276d 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -244,7 +244,8 @@ static int add(int argc, const char **argv, const char *prefix)
 		strbuf_reset(&buf2);
 		strbuf_addf(&buf2, "refs/remotes/%s/%s", name, master);
 
-		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote add", NULL))
+		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf,
+					"remote add", NULL, false))
 			result = error(_("Could not setup master '%s'"), master);
 	}
 
@@ -864,7 +865,8 @@ static int mv(int argc, const char **argv, const char *prefix)
 		strbuf_reset(&buf3);
 		strbuf_addf(&buf3, "remote: renamed %s to %s",
 				item->string, buf.buf);
-		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, buf3.buf, NULL))
+		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf,
+					buf3.buf, NULL, false))
 			die(_("creating '%s' failed"), buf.buf);
 		display_progress(progress, ++refs_renamed_nr);
 	}
@@ -1466,7 +1468,8 @@ static int set_head(int argc, const char **argv, const char *prefix)
 		/* make sure it's valid */
 		if (!refs_ref_exists(refs, buf2.buf))
 			result |= error(_("Not a valid ref: %s"), buf2.buf);
-		else if (refs_update_symref(refs, buf.buf, buf2.buf, "remote set-head", &buf_prev))
+		else if (refs_update_symref(refs, buf.buf, buf2.buf,
+					"remote set-head", &buf_prev, false))
 			result |= error(_("Could not setup %s"), buf.buf);
 		else if (opt_a) {
 			report_auto(argv[0], head_name, &buf_prev);
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 7728fbc3c1..169f5f5340 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -88,7 +88,7 @@ int cmd_symbolic_ref(int argc,
 		if (check_refname_format(argv[1], REFNAME_ALLOW_ONELEVEL) < 0)
 			die("Refusing to set '%s' to invalid ref '%s'", argv[0], argv[1]);
 		ret = !!refs_update_symref(get_main_ref_store(the_repository),
-					   argv[0], argv[1], msg, NULL);
+					   argv[0], argv[1], msg, NULL, false);
 		break;
 	default:
 		usage_with_options(git_symbolic_ref_usage, options);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index a7ab4193c1..46b515a243 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -517,7 +517,7 @@ static int add_worktree(const char *path, const char *refname,
 		ret = refs_update_ref(wt_refs, NULL, "HEAD", &commit->object.oid,
 				      NULL, 0, UPDATE_REFS_MSG_ON_ERR);
 	else
-		ret = refs_update_symref(wt_refs, "HEAD", symref.buf, NULL, NULL);
+		ret = refs_update_symref(wt_refs, "HEAD", symref.buf, NULL, NULL, false);
 	if (ret)
 		goto done;
 
diff --git a/refs.c b/refs.c
index 301db0dcdc..e012b89ee9 100644
--- a/refs.c
+++ b/refs.c
@@ -2115,19 +2115,32 @@ int peel_iterated_oid(struct repository *r, const struct object_id *base, struct
 
 int refs_update_symref(struct ref_store *refs, const char *ref,
 		       const char *target, const char *logmsg,
-		       struct strbuf *before_target)
+		       struct strbuf *before_target, bool create_only)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
-	int ret = 0;
+	int ret = 0, create_ret = 0;
 
 	transaction = ref_store_transaction_begin(refs, &err);
-	if (!transaction ||
-	    ref_transaction_update(transaction, ref, NULL, NULL,
-				   target, NULL, REF_NO_DEREF,
-				   logmsg, &err) ||
-	    ref_transaction_commit(transaction, &err)) {
-		ret = error("%s", err.buf);
+	if (create_only) {
+		if (!transaction ||
+		    ref_transaction_create(transaction, ref, NULL, target,
+					   REF_NO_DEREF, logmsg, &err)) {
+			ret = error("%s", err.buf);
+		}
+		else {
+		    create_ret = ref_transaction_commit(transaction, &err);
+		    if (create_ret && create_ret != TRANSACTION_CREATE_EXISTS)
+			ret = error("%s", err.buf);
+		}
+	}
+	else
+		if (!transaction ||
+		    ref_transaction_update(transaction, ref, NULL, NULL,
+					   target, NULL, REF_NO_DEREF,
+					   logmsg, &err) ||
+		    ref_transaction_commit(transaction, &err)) {
+			ret = error("%s", err.buf);
 	}
 
 	strbuf_release(&err);
diff --git a/refs.h b/refs.h
index 166affbc89..b64fd2318b 100644
--- a/refs.h
+++ b/refs.h
@@ -572,7 +572,7 @@ int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
 
 int refs_update_symref(struct ref_store *refs, const char *refname,
 		       const char *target, const char *logmsg,
-		       struct strbuf *before_target);
+		       struct strbuf *before_target, bool create_only);
 
 enum action_on_err {
 	UPDATE_REFS_MSG_ON_ERR,
diff --git a/reset.c b/reset.c
index cc36a9ed56..674896fb61 100644
--- a/reset.c
+++ b/reset.c
@@ -76,7 +76,7 @@ static int update_refs(const struct reset_head_opts *opts,
 		if (!ret)
 			ret = refs_update_symref(get_main_ref_store(the_repository),
 						 "HEAD", switch_to_branch,
-						 reflog_head, NULL);
+						 reflog_head, NULL, false);
 	}
 	if (!ret && run_hook)
 		run_hooks_l(the_repository, "post-checkout",
diff --git a/sequencer.c b/sequencer.c
index 23b162924c..1a46ef56ba 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5107,7 +5107,8 @@ static int pick_commits(struct repository *r,
 			}
 			msg = reflog_message(opts, "finish", "returning to %s",
 				head_ref.buf);
-			if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", head_ref.buf, msg, NULL)) {
+			if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", head_ref.buf, 
+						msg, NULL, false)) {
 				res = error(_("could not update HEAD to %s"),
 					head_ref.buf);
 				goto cleanup_head_ref;
diff --git a/setup.c b/setup.c
index d95f051465..67abbfaf3c 100644
--- a/setup.c
+++ b/setup.c
@@ -2275,7 +2275,8 @@ void create_reference_database(enum ref_storage_format ref_storage_format,
 			die(_("invalid initial branch name: '%s'"),
 			    initial_branch);
 
-		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", ref, NULL, NULL) < 0)
+		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", ref, 
+					NULL, NULL, false) < 0)
 			exit(1);
 		free(ref);
 	}
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index a911302bea..b6b06bb2e9 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -120,7 +120,7 @@ static int cmd_create_symref(struct ref_store *refs, const char **argv)
 	const char *target = notnull(*argv++, "target");
 	const char *logmsg = *argv++;
 
-	return refs_update_symref(refs, refname, target, logmsg, NULL);
+	return refs_update_symref(refs, refname, target, logmsg, NULL, false);
 }
 
 static struct flag_definition transaction_flags[] = {
-- 
2.47.0.rc0.5.gf1cffeb8df.dirty

