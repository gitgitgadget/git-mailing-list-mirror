Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE4EC388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 07:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E6C02177B
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 07:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374239AbgJWH0c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 03:26:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:40210 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368666AbgJWH0c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 03:26:32 -0400
Received: (qmail 26594 invoked by uid 109); 23 Oct 2020 07:26:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Oct 2020 07:26:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13626 invoked by uid 111); 23 Oct 2020 07:26:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Oct 2020 03:26:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Oct 2020 03:26:30 -0400
From:   Jeff King <peff@peff.net>
To:     VenomVendor <info@venomvendor.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: [PATCH 4/3] am, sequencer: stop parsing our own committer ident
Message-ID: <20201023072630.GA2918369@coredump.intra.peff.net>
References: <20201023070747.GA2198273@coredump.intra.peff.net>
 <20201023070939.GB2913115@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201023070939.GB2913115@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 23, 2020 at 03:09:39AM -0400, Jeff King wrote:

> Commit e8cbe2118a (am: stop exporting GIT_COMMITTER_DATE, 2020-08-17)
> rewrote the code for setting the committer date to use fmt_ident(),
> rather than setting an environment variable and letting commit_tree()
> handle it. But it introduced two bugs:
> 
>   - we use the author email string instead of the committer email
> 
>   - when parsing the committer ident, we used the wrong variable to
>     compute the length of the email, resulting in it always being a
>     zero-length string

By the way, I wondered why we needed to do this parsing at all. The
patch below does this in a much simpler way. It's a little bit ugly, I
think, because we have to call getenv() ourselves. But that's the way
fmt_ident() has always worked. We could probably improve that now that
it takes a whose_ident flag (before that, it had no idea if we wanted
author or committer ident).

This is on top of the fixes (but we'd perhaps just want to do those on
'maint' as the minimal fix).

-- >8 --
Subject: [PATCH 4/3] am, sequencer: stop parsing our own committer ident

For the --committer-date-is-author-date option of git-am and git-rebase,
we format the committer ident, then re-parse it to find the name and
email, and then feed those back to fmt_ident().

We can simplify this by handling it all at the time of the fmt_ident()
call. We pass in the appropriate getenv() results, and if they're not
present, then our WANT_COMMITTER_IDENT flag tells fmt_ident() to fill in
the appropriate value from the config. Which is exactly what
git_committer_ident() was doing under the hood.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/am.c | 19 +++----------------
 sequencer.c  | 28 ++--------------------------
 sequencer.h  |  2 --
 3 files changed, 5 insertions(+), 44 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 4949535a7f..52206bc56b 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -98,8 +98,6 @@ struct am_state {
 	char *author_name;
 	char *author_email;
 	char *author_date;
-	char *committer_name;
-	char *committer_email;
 	char *msg;
 	size_t msg_len;
 
@@ -132,8 +130,6 @@ struct am_state {
  */
 static void am_state_init(struct am_state *state)
 {
-	const char *committer;
-	struct ident_split id;
 	int gpgsign;
 
 	memset(state, 0, sizeof(*state));
@@ -154,14 +150,6 @@ static void am_state_init(struct am_state *state)
 
 	if (!git_config_get_bool("commit.gpgsign", &gpgsign))
 		state->sign_commit = gpgsign ? "" : NULL;
-
-	committer = git_committer_info(IDENT_STRICT);
-	if (split_ident_line(&id, committer, strlen(committer)) < 0)
-		die(_("invalid committer: %s"), committer);
-	state->committer_name =
-		xmemdupz(id.name_begin, id.name_end - id.name_begin);
-	state->committer_email =
-		xmemdupz(id.mail_begin, id.mail_end - id.mail_begin);
 }
 
 /**
@@ -173,8 +161,6 @@ static void am_state_release(struct am_state *state)
 	free(state->author_name);
 	free(state->author_email);
 	free(state->author_date);
-	free(state->committer_name);
-	free(state->committer_email);
 	free(state->msg);
 	strvec_clear(&state->git_apply_opts);
 }
@@ -1594,8 +1580,9 @@ static void do_commit(const struct am_state *state)
 			IDENT_STRICT);
 
 	if (state->committer_date_is_author_date)
-		committer = fmt_ident(state->committer_name,
-				      state->committer_email, WANT_COMMITTER_IDENT,
+		committer = fmt_ident(getenv("GIT_COMMITTER_NAME"),
+				      getenv("GIT_COMMITTER_EMAIL"),
+				      WANT_COMMITTER_IDENT,
 				      state->ignore_date ? NULL
 							 : state->author_date,
 				      IDENT_STRICT);
diff --git a/sequencer.c b/sequencer.c
index d76cbded00..07321a7d95 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -314,8 +314,6 @@ int sequencer_remove_state(struct replay_opts *opts)
 		}
 	}
 
-	free(opts->committer_name);
-	free(opts->committer_email);
 	free(opts->gpg_sign);
 	free(opts->strategy);
 	for (i = 0; i < opts->xopts_nr; i++)
@@ -1460,8 +1458,8 @@ static int try_to_commit(struct repository *r,
 		} else {
 			reset_ident_date();
 		}
-		committer = fmt_ident(opts->committer_name,
-				      opts->committer_email,
+		committer = fmt_ident(getenv("GIT_COMMITTER_NAME"),
+				      getenv("GIT_COMMITTER_EMAIL"),
 				      WANT_COMMITTER_IDENT,
 				      opts->ignore_date ? NULL : date.buf,
 				      IDENT_STRICT);
@@ -4467,22 +4465,6 @@ static int commit_staged_changes(struct repository *r,
 	return 0;
 }
 
-static int init_committer(struct replay_opts *opts)
-{
-	struct ident_split id;
-	const char *committer;
-
-	committer = git_committer_info(IDENT_STRICT);
-	if (split_ident_line(&id, committer, strlen(committer)) < 0)
-		return error(_("invalid committer '%s'"), committer);
-	opts->committer_name =
-		xmemdupz(id.name_begin, id.name_end - id.name_begin);
-	opts->committer_email =
-		xmemdupz(id.mail_begin, id.mail_end - id.mail_begin);
-
-	return 0;
-}
-
 int sequencer_continue(struct repository *r, struct replay_opts *opts)
 {
 	struct todo_list todo_list = TODO_LIST_INIT;
@@ -4494,9 +4476,6 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 	if (read_populate_opts(opts))
 		return -1;
 	if (is_rebase_i(opts)) {
-		if (opts->committer_date_is_author_date && init_committer(opts))
-			return -1;
-
 		if ((res = read_populate_todo(r, &todo_list, opts)))
 			goto release_todo_list;
 
@@ -5391,9 +5370,6 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 
 	res = -1;
 
-	if (opts->committer_date_is_author_date && init_committer(opts))
-		goto cleanup;
-
 	if (checkout_onto(r, opts, onto_name, &oid, orig_head))
 		goto cleanup;
 
diff --git a/sequencer.h b/sequencer.h
index b2a501e445..f925e349c5 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -50,8 +50,6 @@ struct replay_opts {
 
 	int mainline;
 
-	char *committer_name;
-	char *committer_email;
 	char *gpg_sign;
 	enum commit_msg_cleanup_mode default_msg_cleanup;
 	int explicit_cleanup;
-- 
2.29.0.583.g8e3ac41d8f

