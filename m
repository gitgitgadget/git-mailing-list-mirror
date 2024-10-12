Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA2E42A8E
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 23:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728774946; cv=none; b=tMlzlCR/67QoOeRfk0mokdKFbYXoYtYhDpS7D39vuCwrm25e9Ri2kbIYiH2WqrqLDjG2/WYqquhu4+cb5JVycL6+rzsz7KXRAnK4kS5DXjOuXNsDYHzSPegj5lzbqUlbef7341ht4kXq4X8xUCWCmjAd3uz7rZJqybZbBaRbPk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728774946; c=relaxed/simple;
	bh=gI47RIXrBqKEIU2HLzg0vlvktVSjdM+/u4TiwnBYLLI=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=WR00umNp9ZIQ809GvZSfQfDbD+xL+k+OsbNh0QOcaKRh+dQCVnaMkHNS7+hAbA+0fqBAZx2feymhh5BuKFpA6drLmaRrW9+MpBE3NVeJ9bVNCDhWm/ff2rY7w1QH1/mN+5gYPMMc0e9ZsXcbnQiwbiifbgm8pPyMkSGIzEmfu+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=Nt3ry9NT; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="Nt3ry9NT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=e1i+jKujmv88NwN+lwglJDBd0k4NnFzOQ1FUmYOY/Hg=;
 b=Nt3ry9NTMxWAhX5NHp+mKfv4DUsyrj7h9wzI1hzUfYZ/luL2qO5xd0PqTPzv25nsMfWpo+4oybKN
   JCqBX1MAyPsiC3tmTv+dKJaNJqqHTVxtcCn+GsjzE5FOc5nH+eF463biaU6TPUcOd/SSeyPxI6Bb
   k+dpucLDcMKJMVF17Rup+K7d7cIkrWngqy35EYQWrIeeLM5gcMdVWRNSpvdFn2gm6CV6H+youJHu
   Lm0PGjv67aStgnUQBUa2n7Svw2woetysok0/qKk18fVlBQCwtN/ahBd8aHCffu+otuItbeD9ZjTf
   wRcf5gTlVrqBliqtM0PsRkrqFLnYnRW7Lxwxvg==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SL900BFHNA1Q9A0@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sat, 12 Oct 2024 23:15:37 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	Taylor Blau <me@ttaylorr.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v7 1/6] refs: atomically record overwritten ref in update_symref
Date: Sun, 13 Oct 2024 01:03:21 +0200
Message-id: <20241012230428.3259229-1-bence@ferdinandy.com>
In-reply-to: <20241010133022.1733542-1-bence@ferdinandy.com>
References: <20241010133022.1733542-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAH5WjwJA9YJE1eMNxG4kucu7BjGwMzMiiZCwtQcLQfhQVT3cNAlp8pJlIUdzg4y
 sh3cOykRyQotKGSzVWC8hpHd3upg32zoUimX0pfmwf9ER2kI14KHxf+XfaQT4fo5
 pUmEuT8aH988rcmnPP7cDlDnlW90apPvZJpppayNEgbxX72RZ1hppnvfkoSYfO2e
 E+IdFpLLkUcJ/FCLbjyzYhY6Cz55xlHIJugpDGdLy6KKL42udRtu3KTHJ9BuhdpZ
 zN2HgQTej/SaCBoLJ8NT3pa6IX5XDkC5ZLW9pwSBZD088pTBuaKNmq3Hr2FBLIka
 GJAMozOb/VicKEXUT54mBw/TZc/YDAaYdBoKMD5to/bYk18KLSbHECwzYKDW33y0
 2JuhAletKqMoANWWo7p9i83/9FZ/Ekb/Aewz/G0uVV5mKhGKPQFUJLV+ixLjkN5j
 OMKLNfSBRPyhAlIMEXXhK51gluEB87wCacEY6OWj5pf/GIWpAkvQKY7x

When updating a symref it's currently not possible to know for sure what
was the previous value that was overwritten. Record the value after the
ref has been locked if the caller of refs_update_symref requests it via
a new variable in the function call.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v4: new patch
    
    v5: - added before_target to reftables backend
        - added an extra safety check for transaction's existence in refs.c
    
    v6: - no change
    
    v7: - remove the whole before_target concept from the backends and
          handle checking it in refs.c instead (thanks Karthik)
        - rename the before_target to referent which is how the same concept
          is called in the backends
        - change commit prefix to be more in line with project standards

 builtin/branch.c          |  2 +-
 builtin/checkout.c        |  4 ++--
 builtin/clone.c           |  6 +++---
 builtin/notes.c           |  2 +-
 builtin/remote.c          |  6 +++---
 builtin/symbolic-ref.c    |  2 +-
 builtin/worktree.c        |  2 +-
 refs.c                    | 16 +++++++++++-----
 refs.h                    |  3 ++-
 reset.c                   |  2 +-
 sequencer.c               |  2 +-
 setup.c                   |  2 +-
 t/helper/test-ref-store.c |  2 +-
 13 files changed, 29 insertions(+), 22 deletions(-)

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
index 5f729ed412..b964ac44d0 100644
--- a/refs.c
+++ b/refs.c
@@ -2114,7 +2114,8 @@ int peel_iterated_oid(struct repository *r, const struct object_id *base, struct
 }
 
 int refs_update_symref(struct ref_store *refs, const char *ref,
-		       const char *target, const char *logmsg)
+		       const char *target, const char *logmsg,
+		       struct strbuf *referent)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
@@ -2122,17 +2123,23 @@ int refs_update_symref(struct ref_store *refs, const char *ref,
 
 	transaction = ref_store_transaction_begin(refs, &err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, ref, NULL, NULL,
+		ref_transaction_update(transaction, ref, NULL, NULL,
 				   target, NULL, REF_NO_DEREF,
 				   logmsg, &err) ||
-	    ref_transaction_commit(transaction, &err)) {
+		ref_transaction_prepare(transaction, &err)) {
 		ret = error("%s", err.buf);
+		goto cleanup;
 	}
+	if (referent)
+		refs_read_symbolic_ref(refs, ref, referent);
+
+	if (ref_transaction_commit(transaction, &err))
+		ret = error("%s", err.buf);
 
+cleanup:
 	strbuf_release(&err);
 	if (transaction)
 		ref_transaction_free(transaction);
-
 	return ret;
 }
 
@@ -2948,4 +2955,3 @@ int ref_update_expects_existing_old_ref(struct ref_update *update)
 	return (update->flags & REF_HAVE_OLD) &&
 		(!is_null_oid(&update->old_oid) || update->old_target);
 }
-
diff --git a/refs.h b/refs.h
index 108dfc93b3..b09a3a4384 100644
--- a/refs.h
+++ b/refs.h
@@ -571,7 +571,8 @@ int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
 		    const char *newref, const char *logmsg);
 
 int refs_update_symref(struct ref_store *refs, const char *refname,
-		       const char *target, const char *logmsg);
+		       const char *target, const char *logmsg,
+		       struct strbuf *referent);
 
 enum action_on_err {
 	UPDATE_REFS_MSG_ON_ERR,
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
2.47.0.7.g072c39eddb.dirty

