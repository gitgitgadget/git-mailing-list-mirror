Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F6AF2018D
	for <e@80x24.org>; Thu, 11 May 2017 12:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932507AbdEKMGp (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 08:06:45 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:17840 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755463AbdEKMGn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 08:06:43 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTP id E5DA82003CE;
        Thu, 11 May 2017 14:06:40 +0200 (CEST)
From:   Jean-Noel Avila <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     Jean-Noel Avila <jn.avila@free.fr>
Subject: [PATCH v3 1/3] usability: don't ask questions if no reply is required
Date:   Thu, 11 May 2017 14:06:32 +0200
Message-Id: <20170511120634.17683-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.13.0
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
that they won't handle indeed. That's a source of confusion on UX
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
 builtin/am.c       | 5 +++--
 builtin/checkout.c | 5 ++---
 help.c             | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index a95dd8b4e..dd60fad1e 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1312,7 +1312,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 	}
 
 	if (is_empty_file(am_path(state, "patch"))) {
-		printf_ln(_("Patch is empty. Was it split wrong?"));
+		printf_ln(_("Patch is empty."));
 		die_user_resolve(state);
 	}
 
@@ -1940,7 +1940,8 @@ static void am_resolve(struct am_state *state)
 
 	if (unmerged_cache()) {
 		printf_ln(_("You still have unmerged paths in your index.\n"
-			"Did you forget to use 'git add'?"));
+			"You should 'git add' each file with resolved conflicts to mark them as such.\n"
+			"You might run `git rm` on a file to accept \"deleted by them\" for it."));
 		die_user_resolve(state);
 	}
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index bfa5419f3..85c04d252 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1286,9 +1286,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		 * new_branch && argc > 1 will be caught later.
 		 */
 		if (opts.new_branch && argc == 1)
-			die(_("Cannot update paths and switch to branch '%s' at the same time.\n"
-			      "Did you intend to checkout '%s' which can not be resolved as commit?"),
-			    opts.new_branch, argv[0]);
+			die(_("'%s' is not a commit and a branch '%s' cannot be created from it"),
+				argv[0], opts.new_branch);
 
 		if (opts.force_detach)
 			die(_("git checkout: --detach does not take a path argument '%s'"),
diff --git a/help.c b/help.c
index bc6cd19cf..a07f01e6f 100644
--- a/help.c
+++ b/help.c
@@ -411,8 +411,8 @@ const char *help_unknown_cmd(const char *cmd)
 
 	if (SIMILAR_ENOUGH(best_similarity)) {
 		fprintf_ln(stderr,
-			   Q_("\nDid you mean this?",
-			      "\nDid you mean one of these?",
+			   Q_("\nThe most similar command is",
+			      "\nThe most similar commands are",
 			   n));
 
 		for (i = 0; i < n; i++)
-- 
2.13.0

