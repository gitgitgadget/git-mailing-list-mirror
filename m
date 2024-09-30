Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2A218859F
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 22:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734932; cv=none; b=PyZloyMWWv3/DniB5MLzwUZptrfrAtqrhtrRXKCNvkk5xC4PIuh+QldNB2oi70ZlDY7ELTKLd0HLjsRAtYAE/uLBB8DC4uyPdoIZkHOFjZ/uwl81VB/NkaUvw6dXg2vveErzm32g1SKIBiZYDt0MxGEQFGI5sXsUuPmsjLnvhoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734932; c=relaxed/simple;
	bh=CNkB9ycQ2wCb2lWTRDC5JvnfIKbyfwbQYYDl1HIxGVo=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=N7/n4MvpOVVDaUgHqcEsYB1blEkQKwy7sa2TElk+p/1uaBLKkI5rezoRDZrlUjZxJe1De2hU4Ku8y02J+E/QfgkYazbYKwS8YwbR4TD5MU1gqn6Dn+s1H2RJUOJTFTbaNDXvfWPGpXxtF6fSyho0i99+K/CSUE2o6Hc8empvX40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=WeEzeL7u; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="WeEzeL7u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=07gNpbR203+J9+4bMSBX1XsHsaLmTpppzI+SBVJKGlE=;
 b=WeEzeL7upfsidDM5/WtRqIK2M4XCnDcuS9BVuO440BjW0u3gp5lg6sHs+Ji0lcNFVNk3ypob8UNX
   Z6tplibtV0oL8bMuIM4ngJgiEX+gdqoe8MEgEmnA8l+lfPllQiDRONvgFZ4KadwI0BGSwf6HidRx
   w3m2OPxQwei96RweSf0racmw4Co5KnRyJnt04Mxsvkxn/T1Yd2r2y/QB5HeaIAmgPdwscRQGNUoF
   caLf5UQVfsz0pH8trUtb2ODeXUGEG/+AsaAHNs6iR3eFmDkdDr0uLhTwK/p1BlPMdxa/ua30RjM9
   9YSyG1Nby3ib9NCPCqVwxfzvzIovN501SEDURw==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SKN00BGWCSUSK80@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 30 Sep 2024 22:22:06 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v4 1/5] refs_update_symref: atomically record overwritten ref
Date: Tue,  1 Oct 2024 00:19:51 +0200
Message-id: <20240930222025.2349008-2-bence@ferdinandy.com>
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
 AAHyeI1GC1WEq4rT6PdihqO8P/mfN0dkRFH643wIUILRJE9M1SidZS4CDd3XE2nQ
 kt2nhmTIBMHS8zWb9GMcjObAD0bgyHTbzQ4i+jIyYBWd+TDJ022liVpoVuipCL3n
 Z50NxhFCD6TgD7oR18I425iJcZwN1Oi8dD6xN4Visk1riARNPlld3yFenFxUvJt/
 pj/1efGl18byo4Jg5QwG9HW3QNI9wCLyvEXYECNnYMCjQgZqp5NUnEWuuVmTVLKF
 HogVvm5oyzopoyUHw0+KKaaufpkouyiPvrvZVxYmnf6sxVtr/0dAFDaHOW+MkCXj
 1pT+2hskSTD8ohW2xR6/Zb44UskIebS43mXpYUJ4FzVOubG5ztXcoQ0gf/SehiZl
 wDEHD5DoQzOtxNK8Hx7I2krjw+BXiaxEMUpNkqd8o5Bj6DrI1ij6Zu0VYFPts4RX
 gGOcMZe1ZijHRja2km1aO3uBIBVNc96JVu+N3MXUjcjMDhXqso/tuRBJ

When updating a symref it's currently not possible to know for sure what
was the previous value that was overwritten. Make use of
ref_transaction's atomicity and record the previous value there. Add
a new variable to refs_update_symref's signature to be able to pass this
information back up to callers.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v4: new patch

 builtin/branch.c          | 2 +-
 builtin/checkout.c        | 4 ++--
 builtin/clone.c           | 6 +++---
 builtin/notes.c           | 2 +-
 builtin/remote.c          | 6 +++---
 builtin/symbolic-ref.c    | 2 +-
 builtin/worktree.c        | 2 +-
 refs.c                    | 8 ++++++--
 refs.h                    | 3 ++-
 refs/files-backend.c      | 1 +
 refs/refs-internal.h      | 8 ++++++++
 reset.c                   | 2 +-
 sequencer.c               | 2 +-
 setup.c                   | 2 +-
 t/helper/test-ref-store.c | 2 +-
 15 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index fd1611ebf5..6c87690b58 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -559,7 +559,7 @@ static int replace_each_worktree_head_symref(struct worktree **worktrees,
 			continue;
 
 		refs = get_worktree_ref_store(worktrees[i]);
-		if (refs_update_symref(refs, "HEAD", newref, logmsg))
+		if (refs_update_symref(refs, "HEAD", newref, logmsg, NULL))
 			ret = error(_("HEAD of working tree %s is not updated"),
 				    worktrees[i]->path);
 	}
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9c30000d3a..356ee9bcde 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1015,7 +1015,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 			describe_detached_head(_("HEAD is now at"), new_branch_info->commit);
 		}
 	} else if (new_branch_info->path) {	/* Switch branches. */
-		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", new_branch_info->path, msg.buf) < 0)
+		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", new_branch_info->path, msg.buf, NULL) < 0)
 			die(_("unable to update HEAD"));
 		if (!opts->quiet) {
 			if (old_branch_info->path && !strcmp(new_branch_info->path, old_branch_info->path)) {
@@ -1479,7 +1479,7 @@ static int switch_unborn_to_new_branch(const struct checkout_opts *opts)
 		die(_("You are on a branch yet to be born"));
 	strbuf_addf(&branch_ref, "refs/heads/%s", opts->new_branch);
 	status = refs_update_symref(get_main_ref_store(the_repository),
-				    "HEAD", branch_ref.buf, "checkout -b");
+				    "HEAD", branch_ref.buf, "checkout -b", NULL);
 	strbuf_release(&branch_ref);
 	if (!opts->quiet)
 		fprintf(stderr, _("Switched to a new branch '%s'\n"),
diff --git a/builtin/clone.c b/builtin/clone.c
index e77339c847..ead2af20ea 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -661,7 +661,7 @@ static void update_remote_refs(const struct ref *refs,
 		strbuf_addstr(&head_ref, "HEAD");
 		if (refs_update_symref(get_main_ref_store(the_repository), head_ref.buf,
 				       remote_head_points_at->peer_ref->name,
-				       msg) < 0)
+				       msg, NULL) < 0)
 			die(_("unable to update %s"), head_ref.buf);
 		strbuf_release(&head_ref);
 	}
@@ -673,7 +673,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
 	const char *head;
 	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
 		/* Local default branch link */
-		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", our->name, NULL) < 0)
+		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", our->name, NULL, NULL) < 0)
 			die(_("unable to update HEAD"));
 		if (!option_bare) {
 			refs_update_ref(get_main_ref_store(the_repository),
@@ -702,7 +702,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
 		 * Unborn head from remote; same as "our" case above except
 		 * that we have no ref to update.
 		 */
-		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", unborn, NULL) < 0)
+		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", unborn, NULL, NULL) < 0)
 			die(_("unable to update HEAD"));
 		if (!option_bare)
 			install_branch_config(0, head, remote_name, unborn);
diff --git a/builtin/notes.c b/builtin/notes.c
index 8c26e45526..ba646f06ff 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -980,7 +980,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 			die(_("a notes merge into %s is already in-progress at %s"),
 			    notes_ref, wt->path);
 		free_worktrees(worktrees);
-		if (refs_update_symref(get_main_ref_store(the_repository), "NOTES_MERGE_REF", notes_ref, NULL))
+		if (refs_update_symref(get_main_ref_store(the_repository), "NOTES_MERGE_REF", notes_ref, NULL, NULL))
 			die(_("failed to store link to current notes ref (%s)"),
 			    notes_ref);
 		fprintf(stderr, _("Automatic notes merge failed. Fix conflicts in %s "
diff --git a/builtin/remote.c b/builtin/remote.c
index 76670ddd8b..d8ff440027 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -244,7 +244,7 @@ static int add(int argc, const char **argv, const char *prefix)
 		strbuf_reset(&buf2);
 		strbuf_addf(&buf2, "refs/remotes/%s/%s", name, master);
 
-		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote add"))
+		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote add", NULL))
 			result = error(_("Could not setup master '%s'"), master);
 	}
 
@@ -864,7 +864,7 @@ static int mv(int argc, const char **argv, const char *prefix)
 		strbuf_reset(&buf3);
 		strbuf_addf(&buf3, "remote: renamed %s to %s",
 				item->string, buf.buf);
-		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, buf3.buf))
+		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, buf3.buf, NULL))
 			die(_("creating '%s' failed"), buf.buf);
 		display_progress(progress, ++refs_renamed_nr);
 	}
@@ -1444,7 +1444,7 @@ static int set_head(int argc, const char **argv, const char *prefix)
 		/* make sure it's valid */
 		if (!refs_ref_exists(get_main_ref_store(the_repository), buf2.buf))
 			result |= error(_("Not a valid ref: %s"), buf2.buf);
-		else if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote set-head"))
+		else if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote set-head", NULL))
 			result |= error(_("Could not setup %s"), buf.buf);
 		else if (opt_a)
 			printf("%s/HEAD set to %s\n", argv[0], head_name);
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 299d23d76a..7728fbc3c1 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -88,7 +88,7 @@ int cmd_symbolic_ref(int argc,
 		if (check_refname_format(argv[1], REFNAME_ALLOW_ONELEVEL) < 0)
 			die("Refusing to set '%s' to invalid ref '%s'", argv[0], argv[1]);
 		ret = !!refs_update_symref(get_main_ref_store(the_repository),
-					   argv[0], argv[1], msg);
+					   argv[0], argv[1], msg, NULL);
 		break;
 	default:
 		usage_with_options(git_symbolic_ref_usage, options);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index fc31d072a6..a7ab4193c1 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -517,7 +517,7 @@ static int add_worktree(const char *path, const char *refname,
 		ret = refs_update_ref(wt_refs, NULL, "HEAD", &commit->object.oid,
 				      NULL, 0, UPDATE_REFS_MSG_ON_ERR);
 	else
-		ret = refs_update_symref(wt_refs, "HEAD", symref.buf, NULL);
+		ret = refs_update_symref(wt_refs, "HEAD", symref.buf, NULL, NULL);
 	if (ret)
 		goto done;
 
diff --git a/refs.c b/refs.c
index 5f729ed412..301db0dcdc 100644
--- a/refs.c
+++ b/refs.c
@@ -2114,7 +2114,8 @@ int peel_iterated_oid(struct repository *r, const struct object_id *base, struct
 }
 
 int refs_update_symref(struct ref_store *refs, const char *ref,
-		       const char *target, const char *logmsg)
+		       const char *target, const char *logmsg,
+		       struct strbuf *before_target)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
@@ -2130,6 +2131,10 @@ int refs_update_symref(struct ref_store *refs, const char *ref,
 	}
 
 	strbuf_release(&err);
+
+	if (before_target && transaction->updates[0]->before_target)
+		strbuf_addstr(before_target, transaction->updates[0]->before_target);
+
 	if (transaction)
 		ref_transaction_free(transaction);
 
@@ -2948,4 +2953,3 @@ int ref_update_expects_existing_old_ref(struct ref_update *update)
 	return (update->flags & REF_HAVE_OLD) &&
 		(!is_null_oid(&update->old_oid) || update->old_target);
 }
-
diff --git a/refs.h b/refs.h
index 108dfc93b3..f38616db84 100644
--- a/refs.h
+++ b/refs.h
@@ -571,7 +571,8 @@ int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
 		    const char *newref, const char *logmsg);
 
 int refs_update_symref(struct ref_store *refs, const char *refname,
-		       const char *target, const char *logmsg);
+		       const char *target, const char *logmsg,
+		       struct strbuf *before_target);
 
 enum action_on_err {
 	UPDATE_REFS_MSG_ON_ERR,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0824c0b8a9..8415f2d020 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2577,6 +2577,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	}
 
 	update->backend_data = lock;
+	update->before_target = xstrdup_or_null(referent.buf);
 
 	if (update->type & REF_ISSYMREF) {
 		if (update->flags & REF_NO_DEREF) {
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 2313c830d8..7df3e6271e 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -104,6 +104,14 @@ struct ref_update {
 	 */
 	const char *old_target;
 
+	/*
+	 * The previous target before applying new_target will be
+	 * written here, to be used by callers when they do not want to
+	 * check old_target during the transaction, but do want to know
+	 * what it was.
+	 */
+	const char *before_target;
+
 	/*
 	 * One or more of REF_NO_DEREF, REF_FORCE_CREATE_REFLOG,
 	 * REF_HAVE_NEW, REF_HAVE_OLD, or backend-specific flags.
diff --git a/reset.c b/reset.c
index b22b1be792..cc36a9ed56 100644
--- a/reset.c
+++ b/reset.c
@@ -76,7 +76,7 @@ static int update_refs(const struct reset_head_opts *opts,
 		if (!ret)
 			ret = refs_update_symref(get_main_ref_store(the_repository),
 						 "HEAD", switch_to_branch,
-						 reflog_head);
+						 reflog_head, NULL);
 	}
 	if (!ret && run_hook)
 		run_hooks_l(the_repository, "post-checkout",
diff --git a/sequencer.c b/sequencer.c
index 8d01cd50ac..23b162924c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5107,7 +5107,7 @@ static int pick_commits(struct repository *r,
 			}
 			msg = reflog_message(opts, "finish", "returning to %s",
 				head_ref.buf);
-			if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", head_ref.buf, msg)) {
+			if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", head_ref.buf, msg, NULL)) {
 				res = error(_("could not update HEAD to %s"),
 					head_ref.buf);
 				goto cleanup_head_ref;
diff --git a/setup.c b/setup.c
index 94e79b2e48..d95f051465 100644
--- a/setup.c
+++ b/setup.c
@@ -2275,7 +2275,7 @@ void create_reference_database(enum ref_storage_format ref_storage_format,
 			die(_("invalid initial branch name: '%s'"),
 			    initial_branch);
 
-		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", ref, NULL) < 0)
+		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", ref, NULL, NULL) < 0)
 			exit(1);
 		free(ref);
 	}
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 65346dee55..a911302bea 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -120,7 +120,7 @@ static int cmd_create_symref(struct ref_store *refs, const char **argv)
 	const char *target = notnull(*argv++, "target");
 	const char *logmsg = *argv++;
 
-	return refs_update_symref(refs, refname, target, logmsg);
+	return refs_update_symref(refs, refname, target, logmsg, NULL);
 }
 
 static struct flag_definition transaction_flags[] = {
-- 
2.47.0.rc0.5.gf1cffeb8df.dirty

