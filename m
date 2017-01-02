Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26F8F205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756169AbdABP0z (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:26:55 -0500
Received: from mout.gmx.net ([212.227.15.18]:51325 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752820AbdABP0y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:26:54 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MZCQ8-1c5Jjg2Qay-00Kzf1; Mon, 02
 Jan 2017 16:26:48 +0100
Date:   Mon, 2 Jan 2017 16:26:47 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 07/38] sequencer (rebase -i): implement the 'exec'
 command
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <8f0c02dd91d69365554b3c410d95afb9d4665c87.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QiB+/siNHgEuMjDos0JOptmOBWYtxj60RrQzlibhtrS1zPJwhNP
 tXizDaEvFVDzDghIDPXFEPd7cPfJOWZzEaHoteP9MVkksyXdGO/Wizik8IJC+SCnK3ynT2N
 /Hgnl9yIhLu52nHpLsJchQE06cFFx46oy5rPhxcSSMsA/GDwrEPTZQXyrJIjueikM9efts2
 SKzTMhdMp4ugRtyuN+C3w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:35OgnN3mETs=:POYuQUUSm6khKZkwSyyVKz
 rZbcyCT/XN5NEAr7d1GG5Z9vDfD2159iivadPZ21lKv9mcynjysTYqrq+lSwq+nZbqHYSQYoM
 0OPVla7LF60hKHqJpV8gZJ8aU5NhkQJySsWHE76TSqBPm5sGW7au1vFPHoULCeleIRPzeBeMw
 19/9DjDmL1lumOR7/LHGEVZi9kPgZ2+Uqxx87uvoLTxTsWjbFkQd7EiTFC/HWwPowwyxoRfzJ
 5HPi3eOsmhpP5iN6bWTUlI7BNDz7vF13sMkAYeowi8SqxzXc0GQxl5L7PRJrjIb2l96xhR59s
 z9uFdvqpI3R48kiNnHQxfBETJNUvdQyXLBgRIInWUf8+EQEHCw7Jlg1LMDcWSHjFsPutvvo+M
 6mvoAeII+xdyac1OwIfcFfPEjILQs7PKMXUq5qC59imHzo8FHKY3GnbDQxJvKdDtX2u94ixlu
 NEfVzeIJ9NMYNkE9R85hAie6r9onjaitLqUUIa5u1tJyGgcUXarDKl/iNamMuK9bi4XqYYb7C
 Yfnqy7gSeo6brix+BsKYdME+e66Iyd1pxepdCeVxyfeIy29MC2ZhAcAF2tVq3LjWJIjsZ4cBH
 XqiFjq2XdGQywGZK5nw/eovfmePoIuqk47u4LUfpYjHl7v60sF8sfpSMfUUBq2TkCqWnJDW3z
 r5aRvASJ571ousconwKcVxOOH5NzO0+taaQmie4N5/Q+/1Ri8G3CVHPvGpdABuySKGdgONHDe
 5+ofUc/aPkyd5zvYjnZioaVGz9Sm3swczCiqVsPhIC5k292ETdSBB0RONptXR7BV2uSuhOSjG
 lKnm7ip
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
 sequencer.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index b138a3906c..e9c10d7fe5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -18,6 +18,7 @@
 #include "quote.h"
 #include "trailer.h"
 #include "log-tree.h"
+#include "wt-status.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -632,6 +633,8 @@ enum todo_command {
 	TODO_PICK = 0,
 	TODO_REVERT,
 	TODO_EDIT,
+	/* commands that do something else than handling a single commit */
+	TODO_EXEC,
 	/* commands that do nothing but are counted for reporting progress */
 	TODO_NOOP
 };
@@ -640,6 +643,7 @@ static const char *todo_command_strings[] = {
 	"pick",
 	"revert",
 	"edit",
+	"exec",
 	"noop"
 };
 
@@ -938,6 +942,12 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
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
@@ -1397,6 +1407,46 @@ static int error_with_patch(struct commit *commit,
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
+	} else if (dirty) {
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
@@ -1425,6 +1475,13 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 					item->arg, item->arg_len, opts, res,
 					!res);
 			}
+		} else if (item->command == TODO_EXEC) {
+			char *end_of_arg = (char *)(item->arg + item->arg_len);
+			int saved = *end_of_arg;
+
+			*end_of_arg = '\0';
+			res = do_exec(item->arg);
+			*end_of_arg = saved;
 		} else if (!is_noop(item->command))
 			return error(_("unknown command %d"), item->command);
 
-- 
2.11.0.rc3.windows.1


