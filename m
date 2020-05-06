Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBB4C4725A
	for <git@archiver.kernel.org>; Wed,  6 May 2020 20:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 493232075E
	for <git@archiver.kernel.org>; Wed,  6 May 2020 20:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BYDN76jj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgEFUSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 16:18:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60811 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgEFUSf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 16:18:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5AE0348513;
        Wed,  6 May 2020 16:18:33 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=bip3QuKqifkb9ukwgnt54++G+
        FY=; b=BYDN76jjHR4GBDUjn3Drfe2BqD5lEHDgNjdzQJ6nAs3EYkOH13lZ5xw0Y
        jUBRcx8Fs0+tL9FyN9heIJlRaozG6H2A/oMIl9Ginin43tbeqQ5Ji7W4VIze+iWH
        gaq47gwic00xEy/KP9dxZovIQyzXsIvN5YdziL7EjnU6y2jB5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=B9NAnVkOTIecYZCaAi2
        8ln7oE4TfvkXN66OMT1FBh0wOYMVh8AM4QsYBoTiVNvzfDGT0WWRbsjJN6BhCRMK
        XtRQir/W18ecwBOM8dF16t3eoi2w3N71Cf8Bbwarw2tHbjwRUobXejRe91C5stXG
        VOoRtji68vr8SB5Bsr3fzjTo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5329E48512;
        Wed,  6 May 2020 16:18:33 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CEAD748510;
        Wed,  6 May 2020 16:18:32 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] auto-gc: pass --quiet down from am, commit, merge and rebase
Date:   Wed,  6 May 2020 13:18:30 -0700
Message-Id: <20200506201830.92818-3-gitster@pobox.com>
X-Mailer: git-send-email 2.26.2-561-g07d8ea56f2
In-Reply-To: <20200506201830.92818-1-gitster@pobox.com>
References: <20200506094327.GC31637@rillettes>
 <20200506201830.92818-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: C1FD5430-8FD6-11EA-9007-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These commands take the --quiet option for their own operation, but
they forget to pass the option down when they invoke "git gc --auto"
internally.

Teach them to do so using the run_auto_gc() helper we added in the
previous step.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c     | 3 +--
 builtin/commit.c | 3 +--
 builtin/merge.c  | 3 +--
 builtin/rebase.c | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index e3dfd93c25..69e50de018 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1691,7 +1691,6 @@ static int do_interactive(struct am_state *state)
  */
 static void am_run(struct am_state *state, int resume)
 {
-	const char *argv_gc_auto[] =3D {"gc", "--auto", NULL};
 	struct strbuf sb =3D STRBUF_INIT;
=20
 	unlink(am_path(state, "dirtyindex"));
@@ -1796,7 +1795,7 @@ static void am_run(struct am_state *state, int resu=
me)
 	if (!state->rebasing) {
 		am_destroy(state);
 		close_object_store(the_repository->objects);
-		run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+		run_auto_gc(state->quiet);
 	}
 }
=20
diff --git a/builtin/commit.c b/builtin/commit.c
index 7ba33a3bec..fa8eca623e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1488,7 +1488,6 @@ static int git_commit_config(const char *k, const c=
har *v, void *cb)
=20
 int cmd_commit(int argc, const char **argv, const char *prefix)
 {
-	const char *argv_gc_auto[] =3D {"gc", "--auto", NULL};
 	static struct wt_status s;
 	static struct option builtin_commit_options[] =3D {
 		OPT__QUIET(&quiet, N_("suppress summary after successful commit")),
@@ -1697,7 +1696,7 @@ int cmd_commit(int argc, const char **argv, const c=
har *prefix)
 		return 1;
=20
 	repo_rerere(the_repository, 0);
-	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+	run_auto_gc(quiet);
 	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
 		commit_post_rewrite(the_repository, current_head, &oid);
diff --git a/builtin/merge.c b/builtin/merge.c
index d127d2225f..c66b9b532c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -447,7 +447,6 @@ static void finish(struct commit *head_commit,
 		if (verbosity >=3D 0 && !merge_msg.len)
 			printf(_("No merge message -- not updating HEAD\n"));
 		else {
-			const char *argv_gc_auto[] =3D { "gc", "--auto", NULL };
 			update_ref(reflog_message.buf, "HEAD", new_head, head,
 				   0, UPDATE_REFS_DIE_ON_ERR);
 			/*
@@ -455,7 +454,7 @@ static void finish(struct commit *head_commit,
 			 * user should see them.
 			 */
 			close_object_store(the_repository->objects);
-			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+			run_auto_gc(verbosity < 0);
 		}
 	}
 	if (new_head && show_diffstat) {
diff --git a/builtin/rebase.c b/builtin/rebase.c
index bff53d5d16..fe1a9aba45 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -763,7 +763,6 @@ static int apply_autostash(struct rebase_options *opt=
s)
 static int finish_rebase(struct rebase_options *opts)
 {
 	struct strbuf dir =3D STRBUF_INIT;
-	const char *argv_gc_auto[] =3D { "gc", "--auto", NULL };
 	int ret =3D 0;
=20
 	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
@@ -773,7 +772,7 @@ static int finish_rebase(struct rebase_options *opts)
 	 * We ignore errors in 'gc --auto', since the
 	 * user should see them.
 	 */
-	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+	run_auto_gc(!(opts->flags & (REBASE_NO_QUIET|REBASE_VERBOSE)));
 	if (opts->type =3D=3D REBASE_MERGE) {
 		struct replay_opts replay =3D REPLAY_OPTS_INIT;
=20
--=20
2.26.2-561-g07d8ea56f2

