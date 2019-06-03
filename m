Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9BBE1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 14:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfFCOZ0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 10:25:26 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:58018 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727650AbfFCOZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 10:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1559572108; bh=81c1dRjamg+ZEJv0kg+hDEkhOFmUHVfFsJrUYuU/46E=;
        h=From:To:Cc:Subject:Date;
        b=JpUVTx6Z8K3v+8xpGqkxiUpCkwLMWBkef7PPA5mZtg2Yml9awbkSeyfssx77yOH6a
         PTlf+NA3yZA5uaDb1tlsslafet2SvraTsxs76ky33lgSwMdwdJilucPphj5un/GFhO
         /pDb8j64+cMC4E4T9/QjjPHQcrkGXND23D7T8+Ww=
From:   Drew DeVault <sir@cmpwn.com>
To:     git@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>
Subject: [PATCH] am: add --check option
Date:   Mon,  3 Jun 2019 10:25:23 -0400
Message-Id: <20190603142523.3826-1-sir@cmpwn.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 Documentation/git-am.txt |  7 ++++++-
 builtin/am.c             | 13 +++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index fc3b993c33..bc01e87d85 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -9,7 +9,7 @@ git-am - Apply a series of patches from a mailbox
 SYNOPSIS
 --------
 [verse]
-'git am' [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8]
+'git am' [--signoff] [--keep] [--check] [--[no-]keep-cr] [--[no-]utf8]
 	 [--[no-]3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
@@ -44,6 +44,11 @@ OPTIONS
 --keep-non-patch::
 	Pass `-b` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
 
+--check::
+	Instead of applying the patch(es), see if they are
+	applicable to the current working tree and/or the index
+	file and detects errors.
+
 --[no-]keep-cr::
 	With `--keep-cr`, call 'git mailsplit' (see linkgit:git-mailsplit[1])
 	with the same option, to prevent it from stripping CR at the end of
diff --git a/builtin/am.c b/builtin/am.c
index 912d9821b1..9ae90dec28 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -112,6 +112,7 @@ struct am_state {
 	int keep; /* enum keep_type */
 	int message_id;
 	int scissors; /* enum scissors_type */
+	int check;
 	struct argv_array git_apply_opts;
 	const char *resolvemsg;
 	int committer_date_is_author_date;
@@ -1422,6 +1423,8 @@ static int run_apply(const struct am_state *state, const char *index_file)
 	} else
 		apply_state.check_index = 1;
 
+	apply_state.check = state->check;
+
 	/*
 	 * If we are allowed to fall back on 3-way merge, don't give false
 	 * errors during the initial attempt.
@@ -1565,6 +1568,9 @@ static void do_commit(const struct am_state *state)
 	const char *reflog_msg, *author;
 	struct strbuf sb = STRBUF_INIT;
 
+	if (state->check)
+		return;
+
 	if (run_hook_le(NULL, "pre-applypatch", NULL))
 		exit(1);
 
@@ -1775,6 +1781,11 @@ static void am_run(struct am_state *state, int resume)
 			printf_ln(_("Patch failed at %s %.*s"), msgnum(state),
 				linelen(state->msg), state->msg);
 
+			if (state->check) {
+				am_destroy(state);
+				exit(128);
+			}
+
 			if (advice_amworkdir)
 				advise(_("Use 'git am --show-current-patch' to see the failed patch"));
 
@@ -2195,6 +2206,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			0, PARSE_OPT_NONEG),
 		OPT_BOOL('c', "scissors", &state.scissors,
 			N_("strip everything before a scissors line")),
+		OPT_BOOL(0, "check", &state.check,
+			N_("instead of applying the patch, see if the patch is applicable")),
 		OPT_PASSTHRU_ARGV(0, "whitespace", &state.git_apply_opts, N_("action"),
 			N_("pass it through git-apply"),
 			0),
-- 
2.21.0

