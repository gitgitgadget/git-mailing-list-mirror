Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B2CC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 19:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 153882076D
	for <git@archiver.kernel.org>; Wed,  6 May 2020 19:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mLI5iYvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgEFTDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 15:03:21 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50871 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgEFTDU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 15:03:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E55B8CFDDA;
        Wed,  6 May 2020 15:03:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FDj20rdZJbBxBW8nyRy1kDC8lQw=; b=mLI5iY
        vn5oKCxgkc9OOlyBTMTMnSeUvyX6W2GQRg1JFDQIQfZnoXojgPZ4JtLo7mzA3AZQ
        RJXFwqfmEidPsweFjxR73yvuolrHS0Q01Q6eLsh+7D7K4OSEg+8EqS8hoh866QtZ
        fS7D4tjlmz4BQjjl/5Ko9+C42nCN2Iwm0hnlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=umw+XEtCAnlt15NctVnYHFRgPCoPZ2To
        OtUAuNI6hmuWWxEkG+PTbs3N7JHf0nF7VftGGb7GPhm8jupiHJTplHreEKsOSHvb
        mJt7A9D53rXaVBbKfu/Zz6Jsp1n6l8b8zxezHkybvNdv7ou17NGI3bGobSF4f64G
        gg66BLzDULE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DCBE0CFDD9;
        Wed,  6 May 2020 15:03:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 28FDACFDD7;
        Wed,  6 May 2020 15:03:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] auto-gc: pass --quiet down from am, commit, merge and rebase
References: <20200506094327.GC31637@rillettes>
        <xmqqd07h6kcs.fsf@gitster.c.googlers.com>
        <xmqqpnbg6gfv.fsf_-_@gitster.c.googlers.com>
Date:   Wed, 06 May 2020 12:03:14 -0700
In-Reply-To: <xmqqpnbg6gfv.fsf_-_@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 06 May 2020 11:56:04 -0700")
Message-ID: <xmqqlfm46g3x.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3DD773C0-8FCC-11EA-8D96-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A handful of commands take the --quiet option for their own
operation, but they forget to pass the option down when they
invoke "git gc --auto" internally.

Teach these commands to do so using the run_gc_auto() helper we
added earlier.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * And this is the earlier one, wrapped in a proper patch submission
   format, to conclude the two-patch series.

 builtin/am.c     | 3 +--
 builtin/commit.c | 3 +--
 builtin/merge.c  | 3 +--
 builtin/rebase.c | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index e3dfd93c25..955f91f076 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1691,7 +1691,6 @@ static int do_interactive(struct am_state *state)
  */
 static void am_run(struct am_state *state, int resume)
 {
-	const char *argv_gc_auto[] = {"gc", "--auto", NULL};
 	struct strbuf sb = STRBUF_INIT;
 
 	unlink(am_path(state, "dirtyindex"));
@@ -1796,7 +1795,7 @@ static void am_run(struct am_state *state, int resume)
 	if (!state->rebasing) {
 		am_destroy(state);
 		close_object_store(the_repository->objects);
-		run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+		run_gc_auto(state->quiet);
 	}
 }
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 7ba33a3bec..b08c51ae49 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1488,7 +1488,6 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 
 int cmd_commit(int argc, const char **argv, const char *prefix)
 {
-	const char *argv_gc_auto[] = {"gc", "--auto", NULL};
 	static struct wt_status s;
 	static struct option builtin_commit_options[] = {
 		OPT__QUIET(&quiet, N_("suppress summary after successful commit")),
@@ -1697,7 +1696,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		return 1;
 
 	repo_rerere(the_repository, 0);
-	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+	run_gc_auto(quiet);
 	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
 		commit_post_rewrite(the_repository, current_head, &oid);
diff --git a/builtin/merge.c b/builtin/merge.c
index d127d2225f..b6e9cebabf 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -447,7 +447,6 @@ static void finish(struct commit *head_commit,
 		if (verbosity >= 0 && !merge_msg.len)
 			printf(_("No merge message -- not updating HEAD\n"));
 		else {
-			const char *argv_gc_auto[] = { "gc", "--auto", NULL };
 			update_ref(reflog_message.buf, "HEAD", new_head, head,
 				   0, UPDATE_REFS_DIE_ON_ERR);
 			/*
@@ -455,7 +454,7 @@ static void finish(struct commit *head_commit,
 			 * user should see them.
 			 */
 			close_object_store(the_repository->objects);
-			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+			run_gc_auto(verbosity < 0);
 		}
 	}
 	if (new_head && show_diffstat) {
diff --git a/builtin/rebase.c b/builtin/rebase.c
index bff53d5d16..fe1a9aba45 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -763,7 +763,6 @@ static int apply_autostash(struct rebase_options *opts)
 static int finish_rebase(struct rebase_options *opts)
 {
 	struct strbuf dir = STRBUF_INIT;
-	const char *argv_gc_auto[] = { "gc", "--auto", NULL };
 	int ret = 0;
 
 	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
@@ -773,7 +772,7 @@ static int finish_rebase(struct rebase_options *opts)
 	 * We ignore errors in 'gc --auto', since the
 	 * user should see them.
 	 */
-	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+	run_auto_gc(!(opts->flags & (REBASE_NO_QUIET|REBASE_VERBOSE)));
 	if (opts->type == REBASE_MERGE) {
 		struct replay_opts replay = REPLAY_OPTS_INIT;
 
-- 
2.26.2-561-g07d8ea56f2

