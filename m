Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AE326B74A
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 22:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758322252; cv=none; b=usL71ZkRtG43cCQYEUtKtPKxLfpRdDAJF7pqNxbfj66GK2Qbyi/+fFlaSrqsN41YVlQ+qZIRlCg+VzzO4uW0x8SnZtELqxOcP3XRowPDwHmRfRCQAe+T6CI0yGuMrEkXVkPtZe7QsLGnA5+TnqeZ7nnAP6P97zg+hu7DZLwr3x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758322252; c=relaxed/simple;
	bh=g2eE/FUo68Geg2slDgr5TfMDEMklKiVZUoifBx6b9RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxdD+8WLIBbcDgPYDOt/zVSkhEzKZ+E/R7QBuwLYbNNYMPc2S+XSk8SIQrRjBPyH1TDAg+Qv65j2QEdpwGS1ewW3KnG5ucEGtXyCOdXU+mBNeqjKyNZuahHt1ABK8E5/eCd79Fsj47Bkgcb7NBm1wS1ASVFwjef4FMpmkMOgV3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gsro6hMG; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gsro6hMG"
Received: (qmail 134815 invoked by uid 109); 19 Sep 2025 22:50:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=g2eE/FUo68Geg2slDgr5TfMDEMklKiVZUoifBx6b9RE=; b=gsro6hMGGagWzV75w40S2uq/HklP8Aq+trncTzMcoyhfrBMkB/FeCv86Vy1Nr43IyuIZtgPzS7G1siSPh/w3ovu6ZY4hvQRNYUDkL/UHp4QyALYa+vIw8GAc8spgZTVO6M3i+Z1z+KsVeJ7wK40eQLMIrR+zlpyfouor9AwmaHXlJ1hDa7WibSq7lr159joBhzPN1HYW172z0XiwHDe0S/oY1QpfOrYn9E02TcoYal1s17FuLlU9MPwE2Jz8VJjy32FjNvgWi/zIJCfUjveMuL+56lNglvxy80mzyFSUeF7PY0d/WmK92pONqOaAFS6ndfbYKg85SN1MKJKSQUVh2A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Sep 2025 22:50:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 211462 invoked by uid 111); 19 Sep 2025 22:50:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Sep 2025 18:50:48 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Sep 2025 18:50:48 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Lauri Niskanen <ape@ape3000.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 5/6] treewide: pass strvecs around for
 setup_revisions_from_strvec()
Message-ID: <20250919225048.GE594545@coredump.intra.peff.net>
References: <20250919223351.GA3906184@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250919223351.GA3906184@coredump.intra.peff.net>

The previous commit converted callers of setup_revisions() with a strvec
to use the safer and easier _from_strvec() variant.

Let's now convert spots that don't directly have a strvec, but receive
an argc/argv pair that eventually comes from one. We'll instead pass the
strvec down to the point where we call setup_revisions().

That makes these functions slightly less flexible if they were to grow
other callers that don't use strvecs, but this rigidity is buying us
some safety. It is only safe to pass the free_removed_argv_elements
option to setup_revisions() if we know the elements of argv/argc are
allocated on the heap. That isn't communicated in the type system when
we are passed the bare elements. But if we get a strvec, we know that
the elements are allocated strings.

And at any rate, each of these modified functions has only a single
caller (that has a strvec), so the loss of flexibility is unlikely to
ever matter.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 6 +++---
 builtin/rebase.c       | 3 +--
 sequencer.c            | 7 ++++---
 sequencer.h            | 4 ++--
 shallow.c              | 4 ++--
 shallow.h              | 4 ++--
 upload-pack.c          | 7 +++----
 7 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1494afcf3d..5856b5f6bf 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4650,7 +4650,7 @@ static void get_object_list_path_walk(struct rev_info *revs)
 		die(_("failed to pack objects via path-walk"));
 }
 
-static void get_object_list(struct rev_info *revs, int ac, const char **av)
+static void get_object_list(struct rev_info *revs, struct strvec *argv)
 {
 	struct setup_revision_opt s_r_opt = {
 		.allow_exclude_promisor_objects = 1,
@@ -4660,7 +4660,7 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
 	int save_warning;
 
 	save_commit_buffer = 0;
-	setup_revisions(ac, av, revs, &s_r_opt);
+	setup_revisions_from_strvec(argv, revs, &s_r_opt);
 
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
@@ -5229,7 +5229,7 @@ int cmd_pack_objects(int argc,
 			revs.include_check = is_not_in_promisor_pack;
 			revs.include_check_obj = is_not_in_promisor_pack_obj;
 		}
-		get_object_list(&revs, rp.nr, rp.v);
+		get_object_list(&revs, &rp);
 		release_revisions(&revs);
 	}
 	cleanup_preferred_base();
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 67c0352bf8..c468828189 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -299,8 +299,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 			     oid_to_hex(&opts->restrict_revision->object.oid));
 
 	ret = sequencer_make_script(the_repository, &todo_list.buf,
-				    make_script_args.nr, make_script_args.v,
-				    flags);
+				    &make_script_args, flags);
 	if (ret) {
 		error(_("could not generate todo list"));
 		goto cleanup;
diff --git a/sequencer.c b/sequencer.c
index 9ae40a91b2..3d7909a399 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6064,8 +6064,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	return 0;
 }
 
-int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
-			  const char **argv, unsigned flags)
+int sequencer_make_script(struct repository *r, struct strbuf *out,
+			  struct strvec *argv, unsigned flags)
 {
 	char *format = NULL;
 	struct pretty_print_context pp = {0};
@@ -6106,7 +6106,8 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 	pp.fmt = revs.commit_format;
 	pp.output_encoding = get_log_output_encoding();
 
-	if (setup_revisions(argc, argv, &revs, NULL) > 1) {
+	setup_revisions_from_strvec(argv, &revs, NULL);
+	if (argv->nr > 1) {
 		ret = error(_("make_script: unhandled options"));
 		goto cleanup;
 	}
diff --git a/sequencer.h b/sequencer.h
index 304ba4b4d3..719684c8a9 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -186,8 +186,8 @@ int sequencer_remove_state(struct replay_opts *opts);
 #define TODO_LIST_REAPPLY_CHERRY_PICKS (1U << 7)
 #define TODO_LIST_WARN_SKIPPED_CHERRY_PICKS (1U << 8)
 
-int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
-			  const char **argv, unsigned flags);
+int sequencer_make_script(struct repository *r, struct strbuf *out,
+			  struct strvec *argv, unsigned flags);
 
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
diff --git a/shallow.c b/shallow.c
index ef3adb635f..d9cd4e219c 100644
--- a/shallow.c
+++ b/shallow.c
@@ -213,7 +213,7 @@ static void show_commit(struct commit *commit, void *data)
  * are marked with shallow_flag. The list of border/shallow commits
  * are also returned.
  */
-struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
+struct commit_list *get_shallow_commits_by_rev_list(struct strvec *argv,
 						    int shallow_flag,
 						    int not_shallow_flag)
 {
@@ -232,7 +232,7 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 
 	repo_init_revisions(the_repository, &revs, NULL);
 	save_commit_buffer = 0;
-	setup_revisions(ac, av, &revs, NULL);
+	setup_revisions_from_strvec(argv, &revs, NULL);
 
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
diff --git a/shallow.h b/shallow.h
index 9bfeade93e..59d54d48e7 100644
--- a/shallow.h
+++ b/shallow.h
@@ -36,8 +36,8 @@ void rollback_shallow_file(struct repository *r, struct shallow_lock *lk);
 
 struct commit_list *get_shallow_commits(struct object_array *heads,
 					int depth, int shallow_flag, int not_shallow_flag);
-struct commit_list *get_shallow_commits_by_rev_list(
-		int ac, const char **av, int shallow_flag, int not_shallow_flag);
+struct commit_list *get_shallow_commits_by_rev_list(struct strvec *argv,
+						    int shallow_flag, int not_shallow_flag);
 int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
 			  const struct oid_array *extra);
 
diff --git a/upload-pack.c b/upload-pack.c
index f78fabc1e1..1e87ae9559 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -913,13 +913,12 @@ static void deepen(struct upload_pack_data *data, int depth)
 }
 
 static void deepen_by_rev_list(struct upload_pack_data *data,
-			       int ac,
-			       const char **av)
+			       struct strvec *argv)
 {
 	struct commit_list *result;
 
 	disable_commit_graph(the_repository);
-	result = get_shallow_commits_by_rev_list(ac, av, SHALLOW, NOT_SHALLOW);
+	result = get_shallow_commits_by_rev_list(argv, SHALLOW, NOT_SHALLOW);
 	send_shallow(data, result);
 	free_commit_list(result);
 	send_unshallow(data);
@@ -955,7 +954,7 @@ static int send_shallow_list(struct upload_pack_data *data)
 			struct object *o = data->want_obj.objects[i].item;
 			strvec_push(&av, oid_to_hex(&o->oid));
 		}
-		deepen_by_rev_list(data, av.nr, av.v);
+		deepen_by_rev_list(data, &av);
 		strvec_clear(&av);
 		ret = 1;
 	} else {
-- 
2.51.0.568.g6b54b97edf

