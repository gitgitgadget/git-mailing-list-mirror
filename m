Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31C1B207F8
	for <e@80x24.org>; Wed,  3 May 2017 21:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbdECVHq (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 17:07:46 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:15278 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750716AbdECVHp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 17:07:45 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTP id C3B2E2003DF;
        Wed,  3 May 2017 23:07:41 +0200 (CEST)
From:   Jean-Noel Avila <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     rashmipai36@gmail.com, Jean-Noel Avila <jn.avila@free.fr>
Subject: [PATCH v2 1/3] usability: don't ask questions if no reply is required
Date:   Wed,  3 May 2017 23:07:24 +0200
Message-Id: <20170503210726.24121-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170503162931.30721-1-jn.avila@free.fr>
References: <20170503162931.30721-1-jn.avila@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There has been a bug report by a corporate user that stated that
"spelling mistake of stash followed by a yes prints character 'y'
infinite times."

This analysis was false. When the spelling of a command contains
errors, the git program tries to help the user by providing candidates
which are close to the unexisting command. E.g Git prints the
following:

        git: 'stahs' is not a git command. See 'git --help'.
        Did you mean this?

        stash

and then exits.

The problem with this hint is that it is not formally indicated as an
hint and the user is in fact encouraged to reply to the question,
whereas the Git command is already finished.

The user was unlucky enough that it was the command he was looking
for, and replied "yes" on the command line, effectively launching the
`yes` program.

The initial error is that the Git programs, when launched in
command-line mode (without interaction) must not ask questions,
because these questions would normally require a user input as a reply
while they won't handle indeed. That's a source of confusion on UX
level.

To improve the general usability of the Git suite, the following rule
was applied:

if the sentence
 * appears in a non-interactive session
 * is printed last before exit
 * is a question addressing the user ("you")

the sentence is turned into affirmative and proposes the option.

The basic rewording of the question sentences has been extended to
other spots found in the source.

Requested at https://github.com/git/git-scm.com/issues/999 by rpai1

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
---
 builtin/am.c       | 4 ++--
 builtin/checkout.c | 2 +-
 help.c             | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index a95dd8b4e..f5afa438d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1312,7 +1312,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 	}
 
 	if (is_empty_file(am_path(state, "patch"))) {
-		printf_ln(_("Patch is empty. Was it split wrong?"));
+		printf_ln(_("Patch is empty. It may have been split wrong."));
 		die_user_resolve(state);
 	}
 
@@ -1940,7 +1940,7 @@ static void am_resolve(struct am_state *state)
 
 	if (unmerged_cache()) {
 		printf_ln(_("You still have unmerged paths in your index.\n"
-			"Did you forget to use 'git add'?"));
+			"You might want to use 'git add' on them."));
 		die_user_resolve(state);
 	}
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index bfa5419f3..05037b9b6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1287,7 +1287,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		 */
 		if (opts.new_branch && argc == 1)
 			die(_("Cannot update paths and switch to branch '%s' at the same time.\n"
-			      "Did you intend to checkout '%s' which can not be resolved as commit?"),
+			      "'%s' can not be resolved as commit, but it should."),
 			    opts.new_branch, argv[0]);
 
 		if (opts.force_detach)
diff --git a/help.c b/help.c
index bc6cd19cf..4658a55c6 100644
--- a/help.c
+++ b/help.c
@@ -411,8 +411,8 @@ const char *help_unknown_cmd(const char *cmd)
 
 	if (SIMILAR_ENOUGH(best_similarity)) {
 		fprintf_ln(stderr,
-			   Q_("\nDid you mean this?",
-			      "\nDid you mean one of these?",
+			   Q_("\nThe most approaching command is",
+			      "\nThe most approaching commands are",
 			   n));
 
 		for (i = 0; i < n; i++)
-- 
2.12.0

