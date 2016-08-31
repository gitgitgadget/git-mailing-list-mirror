Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BF5B1F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933631AbcHaIyx (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:54:53 -0400
Received: from mout.gmx.net ([212.227.17.22]:62026 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757955AbcHaIy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:54:26 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MGRhs-1bsEgb1GOe-00DCPW; Wed, 31 Aug 2016 10:54:17
 +0200
Date:   Wed, 31 Aug 2016 10:54:16 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/34] sequencer (rebase -i): implement the 'exec' command
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <9191749ed726a88903c06e55478db64a32b632ec.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zia7wNvlqL8BisT92pYvVHqbQdC4cDfGGvRC48mD16w2mLdjyQu
 c/HVYJPE8Hjb9mxG8kz9jf3W75V1feQ0/iJzSJPKZghkf5rP0VuGMIK3r9LKwzZl3xXSDLE
 2DStgu+pePaBjVYF+xqn5TpFOVuGzqJFYVBXWGRzoSpqBYKqoXewWWGe+DB3NO9hLa6hXgM
 doJ4bnNoF41Erfen/Dlgw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AUtLziTnurQ=:6T8NG97mIp1PUvExXYZyXN
 8oyN80i2Z8lQY++P6YPJrVLP/umSbjgyAWuyV5BMNY6v/+q1Oz227B46sKEOvxAcqZFKi95uD
 2kDfGF8SHuTVV9PE4ptVERRn0xH1nBFtmfsm9Kobo/Sycmpmoq6+V47mTFAmcRVvsu+X9hCWk
 Yt+D0+gu7DAqZnKttQLTGLnVy36Ilsp6AJOyxJDh6zamFmo6vETK2d1ML6BfCDcFBJ0tvUACo
 3RBJAg4h54mEtZY39UdG4PCeJOkl+L75K7IbRqQ5zdxWa19yVDpCFmmhFI2cVuhjXhR0TjHQb
 o3gK3UJPTwC0ZZIXIaBkeGv7nOJfvdJoibdrYzPHcdjQj0sU6Kkg22S+oregKAGQJ1bYkNrED
 cCRNAAEewuZJNOnb++qurswuUvRsbKNVltrke5qPMTEhwHSTI+xapElLeRF+6tDTbUXtCiWm4
 QzpfnPq+udrUCSejRW6if+0zpH15yK0HKMaSb1nqtRAvhvKyhV52zNCpxiDkEeG61lnZOyR+m
 VfErl+nWKwyv8SAqMDx9bYylMXrWOtV/fD4OZI+YSgt0SRnM8trQrJCfBxFMX5ieaCh9lcws0
 uDG6zyg/tCs3Dkwh1T3xZgBFJymdQO63y6DSAOqY5oMUW0PJidyQR1Un+9z555z7s358CAtQu
 i12FMdTGS3SvfO0HFJVrElCdr/QpWAFBaiv1uAcoEEMIvjN6Cz/9Xn7bR7+zztkjdNnisDz0D
 QLPoFaEHxo4qXqJXE4VqNYBFo9RQjnR537Bk08Kt6/ddVJ1dHV6/6MRiN83a+A+p5oy/o00dk
 tCi3tN2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'exec' command is a little special among rebase -i's commands, as it
does *not* have a SHA-1 as first parameter. Instead, everything after the
`exec` command is treated as command-line to execute.

Let's reuse the arg/arg_len fields of the todo_item structure (which hold
the oneline for pick/edit commands) to point to the command-line.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index fe2f6e7..a58bb91 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -17,6 +17,7 @@
 #include "argv-array.h"
 #include "quote.h"
 #include "log-tree.h"
+#include "wt-status.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -661,6 +662,7 @@ enum todo_command {
 	TODO_PICK,
 	TODO_REVERT,
 	TODO_EDIT,
+	TODO_EXEC,
 	TODO_NOOP
 };
 
@@ -668,6 +670,7 @@ static const char *todo_command_strings[] = {
 	"pick",
 	"revert",
 	"edit",
+	"exec",
 	"noop"
 };
 
@@ -964,6 +967,12 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 		return -1;
 	bol += padding;
 
+	if (item->command == TODO_EXEC) {
+		item->arg = bol;
+		item->arg_len = (int)(eol - bol);
+		return 0;
+	}
+
 	end_of_object_name = (char *) bol + strcspn(bol, " \t\n");
 	saved = *end_of_object_name;
 	*end_of_object_name = '\0';
@@ -1372,6 +1381,47 @@ static int error_with_patch(struct commit *commit,
 	return exit_code;
 }
 
+static int do_exec(const char *command_line)
+{
+	const char *child_argv[] = { NULL, NULL };
+	int dirty, status;
+
+	fprintf(stderr, "Executing: %s\n", command_line);
+	child_argv[0] = command_line;
+	status = run_command_v_opt(child_argv, RUN_USING_SHELL);
+
+	/* force re-reading of the cache */
+	if (discard_cache() < 0 || read_cache() < 0)
+		return error(_("Could not read index"));
+
+	dirty = require_clean_work_tree("rebase", NULL, 1, 1);
+
+	if (status) {
+		warning("Execution failed: %s\n%s"
+			"You can fix the problem, and then run\n"
+			"\n"
+			"  git rebase --continue\n"
+			"\n",
+			command_line,
+			dirty ? "and made changes to the index and/or the "
+				"working tree\n" : "");
+		if (status == 127)
+			/* command not found */
+			status = 1;
+	}
+	else if (dirty) {
+		warning("Execution succeeded: %s\nbut "
+			"left changes to the index and/or the working tree\n"
+			"Commit or stash your changes, and then run\n"
+			"\n"
+			"  git rebase --continue\n"
+			"\n", command_line);
+		status = 1;
+	}
+
+	return status;
+}
+
 static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 {
 	int res = 0;
@@ -1401,6 +1451,14 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 					!res);
 			}
 		}
+		else if (item->command == TODO_EXEC) {
+			char *end_of_arg = (char *)(item->arg + item->arg_len);
+			int saved = *end_of_arg;
+
+			*end_of_arg = '\0';
+			res = do_exec(item->arg);
+			*end_of_arg = saved;
+		}
 		else if (item->command != TODO_NOOP)
 			return error("Unknown command %d", item->command);
 
-- 
2.10.0.rc2.102.g5c102ec


