Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7BCC433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240528AbhK3VmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344272AbhK3VmD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:42:03 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8F4C06175A
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:38:28 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v11so47466518wrw.10
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oswnOYVaHQo//llJo5Xops/IuG8r8YVTby08wRo7sh0=;
        b=P62G+CPiFX6Quyzulo3j8Oepkp36WqN8M897OndF+42YAMIJeMccxQlf91VTyBYIRC
         q5u1v01vq4PK2kl+YVz9qnucz69oQRNECwxFLRLXLlmwbBR3rAtbWVchY/AjQm/N6yWO
         QnDGGhmtk3n9r2Fl6TO8qJuKDrm1ZR7KdrZ9vHTFDrvOGUNm8qbfEyLKnTaPomr25NnB
         rXjyQ2nAii2ZajCmQy2gg4221SIxE5EH/sTfNhomlLGk2lPyi5yH3izdHsvBC7CxBzPV
         U1zT9bjzgvswdKzvBK8BhdpMrRpgm7xx4KNWw90dHNJNMHEScTP4wwaE/IZfhQ5PMZ2A
         oi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oswnOYVaHQo//llJo5Xops/IuG8r8YVTby08wRo7sh0=;
        b=UOcXn4QL/pButf1BCgDg22xi+666i/Awx3ursBp+sKlWB25HNvcsYSDGbzfR7R3mya
         odaOtNG7brMTFsaHIomIx7jUL56IAFMwBjrUuUVHKGdNnTsPH4ugFw9p19P8Bsfd/dWQ
         GF5HmqFBHsXJ0nDyBHmlfqg3L7QD1oYBUwtV7HFmfJF6ilRIb37f2B/UhZ+qbCamjvTc
         dMxWmrYDNjpNoM8XcuJbI6ImUvuuRoOGbu/IGg5E2sCzkB564HS7Tq/YAucCrzO2tNQs
         iBGsOjfpZdg4ssY8aicZwf+sH2zeCQy8EAXRvscLFzwqKjjDeQg8ZDlM2bN2eWS1CjUx
         +cSA==
X-Gm-Message-State: AOAM532AvTKoRTRqBBtJYXxeZ3PIoxm2AwVUE1NhMJOO2R2RSQeFHvZe
        8JiiDRG03mymghAZSPLe9W7sYueEkL8NQQ==
X-Google-Smtp-Source: ABdhPJwOST41oXaH1OpZKad05FWoSmMETx3GJC5NP6rFL02eH9vdX/EqIOvWwXphj9itiad2vK28Kg==
X-Received: by 2002:adf:e387:: with SMTP id e7mr1715794wrm.412.1638308306671;
        Tue, 30 Nov 2021 13:38:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v8sm17006914wrd.84.2021.11.30.13.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:38:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/12] reflog + refs-backend: move "verbose" out of the backend
Date:   Tue, 30 Nov 2021 22:38:11 +0100
Message-Id: <patch-09.12-6a8f3915898-20211130T213319Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.877.g7d5b0a3b8a6
In-Reply-To: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the handling of the "verbose" flag entirely out of
"refs/files-backend.c" and into "builtin/reflog.c". This allows the
backend to stop knowing about the EXPIRE_REFLOGS_VERBOSE flag.

The expire_reflog_ent() function shouldn't need to deal with the
implementation detail of whether or not we're emitting verbose output,
by doing this the --verbose output becomes backend-agnostic, so
reftable will get the same output.

I think the output is rather bad currently, and should e.g. be
implemented with some better future mode of progress.[ch], but that's
a topic for another improvement.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c     | 42 +++++++++++++++++++++++++++++++-----------
 refs.h               |  3 +--
 refs/files-backend.c | 44 ++++++++++++++++++++------------------------
 3 files changed, 52 insertions(+), 37 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 48e4f5887b0..a77c0d96dce 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -45,6 +45,8 @@ struct expire_reflog_policy_cb {
 	struct cmd_reflog_expire_cb cmd;
 	struct commit *tip_commit;
 	struct commit_list *tips;
+	unsigned int dry_run:1,
+		     verbose:1;
 };
 
 struct worktree_reflogs {
@@ -294,29 +296,38 @@ static int should_expire_reflog_ent(struct object_id *ooid, struct object_id *no
 	struct commit *old_commit, *new_commit;
 
 	if (timestamp < cb->cmd.expire_total)
-		return 1;
+		goto expire;
 
 	old_commit = new_commit = NULL;
 	if (cb->cmd.stalefix &&
 	    (!keep_entry(&old_commit, ooid) || !keep_entry(&new_commit, noid)))
-		return 1;
+		goto expire;
 
 	if (timestamp < cb->cmd.expire_unreachable) {
 		switch (cb->unreachable_expire_kind) {
 		case UE_ALWAYS:
-			return 1;
+			goto expire;
 		case UE_NORMAL:
 		case UE_HEAD:
 			if (unreachable(cb, old_commit, ooid) || unreachable(cb, new_commit, noid))
-				return 1;
+				goto expire;
 			break;
 		}
 	}
 
 	if (cb->cmd.recno && --(cb->cmd.recno) == 0)
-		return 1;
+		goto expire;
+
+	if (cb->verbose)
+		printf("keep %s", message);
 
 	return 0;
+expire:
+	if (cb->dry_run)
+		printf("would prune %s", message);
+	else if (cb->verbose)
+		printf("prune %s", message);
+	return 1;
 }
 
 static int push_tip_to_list(const char *refname, const struct object_id *oid,
@@ -539,6 +550,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	int i, status, do_all, all_worktrees = 1;
 	int explicit_expiry = 0;
 	unsigned int flags = 0;
+	int verbose = 0;
 
 	default_reflog_expire_unreachable = now - 30 * 24 * 3600;
 	default_reflog_expire = now - 90 * 24 * 3600;
@@ -576,7 +588,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(arg, "--single-worktree"))
 			all_worktrees = 0;
 		else if (!strcmp(arg, "--verbose"))
-			flags |= EXPIRE_REFLOGS_VERBOSE;
+			verbose = 1;
 		else if (!strcmp(arg, "--")) {
 			i++;
 			break;
@@ -599,10 +611,10 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		revs.do_not_die_on_missing_tree = 1;
 		revs.ignore_missing = 1;
 		revs.ignore_missing_links = 1;
-		if (flags & EXPIRE_REFLOGS_VERBOSE)
+		if (verbose)
 			printf(_("Marking reachable objects..."));
 		mark_reachable_objects(&revs, 0, 0, NULL);
-		if (flags & EXPIRE_REFLOGS_VERBOSE)
+		if (verbose)
 			putchar('\n');
 	}
 
@@ -624,7 +636,11 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		free_worktrees(worktrees);
 
 		for_each_string_list_item(item, &collected.reflogs) {
-			struct expire_reflog_policy_cb cb = { .cmd = cmd };
+			struct expire_reflog_policy_cb cb = {
+				.cmd = cmd,
+				.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
+				.verbose = verbose,
+			};
 
 			set_reflog_expiry_param(&cb.cmd, explicit_expiry, item->string);
 			status |= reflog_expire(item->string, flags,
@@ -671,6 +687,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 	struct cmd_reflog_expire_cb cmd = { 0 };
 	int i, status = 0;
 	unsigned int flags = 0;
+	int verbose = 0;
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -681,7 +698,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(arg, "--updateref"))
 			flags |= EXPIRE_REFLOGS_UPDATE_REF;
 		else if (!strcmp(arg, "--verbose"))
-			flags |= EXPIRE_REFLOGS_VERBOSE;
+			verbose = 1;
 		else if (!strcmp(arg, "--")) {
 			i++;
 			break;
@@ -699,7 +716,10 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 		const char *spec = strstr(argv[i], "@{");
 		char *ep, *ref;
 		int recno;
-		struct expire_reflog_policy_cb cb = { 0 };
+		struct expire_reflog_policy_cb cb = {
+			.verbose = verbose,
+			.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
+		};
 
 		if (!spec) {
 			status |= error(_("not a reflog: %s"), argv[i]);
diff --git a/refs.h b/refs.h
index 45c34e99e3a..0c3374b405c 100644
--- a/refs.h
+++ b/refs.h
@@ -786,8 +786,7 @@ enum ref_type ref_type(const char *refname);
 enum expire_reflog_flags {
 	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
 	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
-	EXPIRE_REFLOGS_VERBOSE = 1 << 2,
-	EXPIRE_REFLOGS_REWRITE = 1 << 3
+	EXPIRE_REFLOGS_REWRITE = 1 << 2,
 };
 
 /*
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 451c4e2a052..c154c3c4a23 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3080,11 +3080,12 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 }
 
 struct expire_reflog_cb {
-	unsigned int flags;
 	reflog_expiry_should_prune_fn *should_prune_fn;
 	void *policy_cb;
 	FILE *newlog;
 	struct object_id last_kept_oid;
+	unsigned int rewrite:1,
+		     dry_run:1;
 };
 
 static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
@@ -3092,33 +3093,27 @@ static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
 			     const char *message, void *cb_data)
 {
 	struct expire_reflog_cb *cb = cb_data;
-	struct expire_reflog_policy_cb *policy_cb = cb->policy_cb;
+	reflog_expiry_should_prune_fn *fn = cb->should_prune_fn;
 
-	if (cb->flags & EXPIRE_REFLOGS_REWRITE)
+	if (cb->rewrite)
 		ooid = &cb->last_kept_oid;
 
-	if ((*cb->should_prune_fn)(ooid, noid, email, timestamp, tz,
-				   message, policy_cb)) {
-		if (cb->flags & EXPIRE_REFLOGS_DRY_RUN)
-			printf("would prune %s", message);
-		else if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
-			printf("prune %s", message);
-	} else {
-		if (!(cb->flags & EXPIRE_REFLOGS_DRY_RUN)) {
-			fprintf(cb->newlog, "%s %s %s %"PRItime" %+05d\t%s",
-				oid_to_hex(ooid), oid_to_hex(noid),
-				email, timestamp, tz, message);
-			oidcpy(&cb->last_kept_oid, noid);
-		}
-		if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
-			printf("keep %s", message);
-	}
+	if (fn(ooid, noid, email, timestamp, tz, message, cb->policy_cb))
+		return 0;
+
+	if (cb->dry_run)
+		return 0; /* --dry-run */
+
+	fprintf(cb->newlog, "%s %s %s %"PRItime" %+05d\t%s", oid_to_hex(ooid),
+		oid_to_hex(noid), email, timestamp, tz, message);
+	oidcpy(&cb->last_kept_oid, noid);
+
 	return 0;
 }
 
 static int files_reflog_expire(struct ref_store *ref_store,
 			       const char *refname,
-			       unsigned int flags,
+			       unsigned int expire_flags,
 			       reflog_expiry_prepare_fn prepare_fn,
 			       reflog_expiry_should_prune_fn should_prune_fn,
 			       reflog_expiry_cleanup_fn cleanup_fn,
@@ -3136,7 +3131,8 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	const struct object_id *oid;
 
 	memset(&cb, 0, sizeof(cb));
-	cb.flags = flags;
+	cb.rewrite = !!(expire_flags & EXPIRE_REFLOGS_REWRITE);
+	cb.dry_run = !!(expire_flags & EXPIRE_REFLOGS_DRY_RUN);
 	cb.policy_cb = policy_cb_data;
 	cb.should_prune_fn = should_prune_fn;
 
@@ -3172,7 +3168,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 
 	files_reflog_path(refs, &log_file_sb, refname);
 	log_file = strbuf_detach(&log_file_sb, NULL);
-	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
+	if (!cb.dry_run) {
 		/*
 		 * Even though holding $GIT_DIR/logs/$reflog.lock has
 		 * no locking implications, we use the lock_file
@@ -3199,7 +3195,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	refs_for_each_reflog_ent(ref_store, refname, expire_reflog_ent, &cb);
 	(*cleanup_fn)(cb.policy_cb);
 
-	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
+	if (!cb.dry_run) {
 		/*
 		 * It doesn't make sense to adjust a reference pointed
 		 * to by a symbolic ref based on expiring entries in
@@ -3209,7 +3205,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		 */
 		int update = 0;
 
-		if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
+		if ((expire_flags & EXPIRE_REFLOGS_UPDATE_REF) &&
 		    !is_null_oid(&cb.last_kept_oid)) {
 			int ignore_errno;
 			int type;
-- 
2.34.1.877.g7d5b0a3b8a6

