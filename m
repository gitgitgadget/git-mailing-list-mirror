Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 113AD2042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933866AbcLMPbv (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:31:51 -0500
Received: from mout.gmx.net ([212.227.15.19]:62048 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933247AbcLMPbq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:31:46 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MarNa-1c231g0XBS-00KRr0; Tue, 13
 Dec 2016 16:29:50 +0100
Date:   Tue, 13 Dec 2016 16:29:49 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 04/34] sequencer (rebase -i): implement the 'exec'
 command
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <54d4e8d3673662d1ec806f3f4a779a17effbdaf2.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:l3flsn1ZbeiIjQZzip9fcsfCsIJLBN3j5nNGUYDJd4tD3h+UYSt
 Vqb5YYlM1+DI733qxRMmEqR3ptppE2CkKetFQW6epmDNvxmHnyAVaZdygeTMHSFKT27Gj1v
 nxFItzhoou8YMG+0bGSpir3LhJNpZLOpHpQaaaDKmvh1BmcfgxAoZ33w41GqF/feqbnpAY+
 GKS0KqbWwpSJvxQNe/QCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JReW4Uj18tU=:DDFTxxFyLm8ZqxGeQtEAd9
 ir2xWAWq4oSyVKQ3oq0dXqozQoZ/zWGMc7C5OWqtdhS6VHtAnR1VnGEKzvg0tyrOsQwJboLEt
 ZGG/EzHnk/sN2HJZXvIxifN2e/aUulkk5st8O/byj4J88p0VIaSjOh+n8VNRChlRO/gUJMzcR
 /E7aTwwDSZN9pNrELcSeODP/17v0d+u759MrMZHPYIDXCV2wBQ8CLaaeLJ0kPZ9/rUA76UQHZ
 qnB6eWWe2aArMkdj/OhK9h24y8ZG9N8M6gBaqrj6EWr5lUqWl/M3oIKliJTv9Oi0S2GXtEavU
 GjEAFjzY6PSJIJuIn82Jwl+0SAS2ZLCaoO1Kz8wWgBEqU336Q/+T4A6Dvc+5VQJMCaWL28+Qs
 aWBbnrds6/8fL9dJ30CI+Bnpz7yflxRKCqTXrtRtVgTk3ZgfjVwgIfYHiALa9r5I2V0No3miB
 H8NnF3HTAKBJ4f99n0Ggn0af2UBj8/9abTc++vssXsq5jfDzMuNNIh7juArbyLtg+lIe7+thD
 cDRgMqrfJttgySNty/xeLiTBQdTl638JK0btZAZSgupidpXC+VIai/H3fW0cHoNBE/md30qlw
 1T2xEs4E2KkgTQy01+KuANEyXsgrPi6ajICh8nxYzmkO94K/reMX6NuCdPuYvTyy8Ua9nRgtU
 IWPnjP+STlMma39tXJFV2wLPDlPRfnKDbv9+zEH+P8WYDmu+NyJqq+8BCSAXwDlRZpbylEwYj
 /ERQdMzVzyO84sU6uq8GlghGux1Y5tuN13V8fGYhvMw1blUDcraYoslEs0OsxY3s4UyrlP5nJ
 H2SSHnJ
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
 sequencer.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 68e2c84803..700b7575ed 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -17,6 +17,7 @@
 #include "argv-array.h"
 #include "quote.h"
 #include "log-tree.h"
+#include "wt-status.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -664,6 +665,8 @@ enum todo_command {
 	TODO_PICK = 0,
 	TODO_REVERT,
 	TODO_EDIT,
+	/* commands that do something else than handling a single commit */
+	TODO_EXEC,
 	/* commands that do nothing but are counted for reporting progress */
 	TODO_NOOP
 };
@@ -672,6 +675,7 @@ static const char *todo_command_strings[] = {
 	"pick",
 	"revert",
 	"edit",
+	"exec",
 	"noop"
 };
 
@@ -971,6 +975,12 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
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
@@ -1396,6 +1406,47 @@ static int error_with_patch(struct commit *commit,
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
+		return error(_("could not read index"));
+
+	dirty = require_clean_work_tree("rebase", NULL, 1, 1);
+
+	if (status) {
+		warning(_("execution failed: %s\n%s"
+			  "You can fix the problem, and then run\n"
+			  "\n"
+			  "  git rebase --continue\n"
+			  "\n"),
+			command_line,
+			dirty ? N_("and made changes to the index and/or the "
+				"working tree\n") : "");
+		if (status == 127)
+			/* command not found */
+			status = 1;
+	}
+	else if (dirty) {
+		warning(_("execution succeeded: %s\nbut "
+			  "left changes to the index and/or the working tree\n"
+			  "Commit or stash your changes, and then run\n"
+			  "\n"
+			  "  git rebase --continue\n"
+			  "\n"), command_line);
+		status = 1;
+	}
+
+	return status;
+}
+
 static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 {
 	int res = 0;
@@ -1425,6 +1476,14 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
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
 			return error(_("unknown command %d"), item->command);
 
-- 
2.11.0.rc3.windows.1


