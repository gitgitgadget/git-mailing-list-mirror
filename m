Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3758A1F859
	for <e@80x24.org>; Fri,  2 Sep 2016 08:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbcIBIgV (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 04:36:21 -0400
Received: from mout.gmx.net ([212.227.17.21]:54867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751756AbcIBIgT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 04:36:19 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MgbvP-1bTyN52gqd-00Nx9Z; Fri, 02 Sep 2016 10:34:32
 +0200
Date:   Fri, 2 Sep 2016 10:34:31 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] Add a builtin helper for interactive rebases
In-Reply-To: <cover.1472805251.git.johannes.schindelin@gmx.de>
Message-ID: <501540c2c1cba7ad0f22d00825a2fd4b71c0b417.1472805251.git.johannes.schindelin@gmx.de>
References: <cover.1472805251.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2V1UDmU+9NXtBPdqmfTuMHQeLFLQk1ni/4lQYkwsvXkEJ7yCz0x
 PKi8/LgxkODr+qw3xRtMY/CRwkZFmHRxg5UIOTimRqr59kM+ylFYSzddixUlXGbQJEFbyTR
 DSeOU950Sq6Mdq7YEQPPH3ZIsQ9wtQeHLIScWZOiI+fe2gQYujo/Oj1BXFWx9koFXl+B8be
 oU/zssyasnyoJSyTWyTKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DecPTRCZbV0=:dyW57BsJf3fOu7tudTN912
 fnsQ00w2Nr6EK1MbWR9iBSPMKvC+u8EBjGTUFDFHRwJesZ8OvQMIJ5SK60Xm4gsoMbQkbOGxn
 6U7jaUP9TmOd68JYsrCNMs8F0HddOgtMN80NwlWsjQwpbCkIR3u8rJYGV9HLD/rpHrvJ1ynA4
 ZlCzKBC84zWq79qYeRW7uPKtlg4yX63iB3XGzrmoWVVlDSYaRJ1K3PfJfhGjxCYUTLWgCsuYm
 f6MeoGSZmWolM+ft0t77Wxac/LnA5L7YL2hoYgpb8NrS+PtIbAkxXJIZs7kbdNmOmYKtCp6OH
 eJDXNu3I48JI+rc+BuuADr+pK333RyCwv+MMWQEgzmeSY8cRlfiwHTRSbri6FdWT5icMOBroX
 qFGXgjwFbHQWRNtIB985M+sB/Qwb79ROqRl6bWxOw3kaymWmgP4mgTDtNjHKSd9RwshXTpna+
 cHSoOzcZ7GH7xPozTiN0lJVuhDEDWaaHvSyxi80o6KO4xX476sL5tofQO9vn0vU4TvjMlm6g1
 l9gCp4yJVRFUa0DB2Odery1HA5kgX2ycC5pBsNxmFm7skpUleUI3kDPWkVZ9D5SycRXfViaY1
 ZCww+Kjo43R+5N7q0+MY2abAsGcFgWtBNGFA4QNtYMT9zs18/GrfSBZG9x96X508jGH0vR9qp
 V3bGzCU1T2TnPwku+A9MDZpD93vIyQ5nRZ9N4V7R2E5Q2fylqQ1WAqWGs7b/N37rl+gH7tDK8
 n7LNaX/Kh+dNi3YXS4YjsP3XLUDCFR87GfSHu+hxLKEgwKhgj+k3UHy/WP8BXUTmyLSGBXz5F
 oNFk3kx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git's interactive rebase is still implemented as a shell script, despite
its complexity. This implies that it suffers from the portability point
of view, from lack of expressibility, and of course also from
performance. The latter issue is particularly serious on Windows, where
we pay a hefty price for relying so much on POSIX.

Unfortunately, being such a huge shell script also means that we missed
the train when it would have been relatively easy to port it to C, and
instead piled feature upon feature onto that poor script that originally
never intended to be more than a slightly pimped cherry-pick in a loop.

To open the road toward better performance (in addition to all the other
benefits of C over shell scripts), let's just start *somewhere*.

The approach taken here is to add a builtin helper that at first intends
to take care of the parts of the interactive rebase that are most
affected by the performance penalties mentioned above.

In particular, after we spent all those efforts on preparing the sequencer
to process rebase -i's git-rebase-todo scripts, we implement the `git
rebase -i --continue` functionality as a new builtin, git-rebase--helper.

Once that is in place, we can work gradually on tackling the rest of the
technical debt.

Note that the rebase--helper needs to learn about the transient
--ff/--no-ff options of git-rebase, as the corresponding flag is not
persisted to, and re-read from, the state directory.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore               |  1 +
 Makefile                 |  1 +
 builtin.h                |  1 +
 builtin/rebase--helper.c | 40 ++++++++++++++++++++++++++++++++++++++++
 git.c                    |  1 +
 5 files changed, 44 insertions(+)
 create mode 100644 builtin/rebase--helper.c

diff --git a/.gitignore b/.gitignore
index 05cb58a..a9b8c96 100644
--- a/.gitignore
+++ b/.gitignore
@@ -114,6 +114,7 @@
 /git-read-tree
 /git-rebase
 /git-rebase--am
+/git-rebase--helper
 /git-rebase--interactive
 /git-rebase--merge
 /git-receive-pack
diff --git a/Makefile b/Makefile
index d96ecb7..980e1dc 100644
--- a/Makefile
+++ b/Makefile
@@ -919,6 +919,7 @@ BUILTIN_OBJS += builtin/prune.o
 BUILTIN_OBJS += builtin/pull.o
 BUILTIN_OBJS += builtin/push.o
 BUILTIN_OBJS += builtin/read-tree.o
+BUILTIN_OBJS += builtin/rebase--helper.o
 BUILTIN_OBJS += builtin/receive-pack.o
 BUILTIN_OBJS += builtin/reflog.o
 BUILTIN_OBJS += builtin/remote.o
diff --git a/builtin.h b/builtin.h
index 6b95006..2e5de14 100644
--- a/builtin.h
+++ b/builtin.h
@@ -102,6 +102,7 @@ extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
 extern int cmd_pull(int argc, const char **argv, const char *prefix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
 extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_rebase__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_receive_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_reflog(int argc, const char **argv, const char *prefix);
 extern int cmd_remote(int argc, const char **argv, const char *prefix);
diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
new file mode 100644
index 0000000..ca1ebb2
--- /dev/null
+++ b/builtin/rebase--helper.c
@@ -0,0 +1,40 @@
+#include "builtin.h"
+#include "cache.h"
+#include "parse-options.h"
+#include "sequencer.h"
+
+static const char * const builtin_rebase_helper_usage[] = {
+	N_("git rebase--helper [<options>]"),
+	NULL
+};
+
+int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
+{
+	struct replay_opts opts = REPLAY_OPTS_INIT;
+	enum {
+		CONTINUE = 1, ABORT
+	} command = 0;
+	struct option options[] = {
+		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
+		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
+				CONTINUE),
+		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
+				ABORT),
+		OPT_END()
+	};
+
+	git_config(git_default_config, NULL);
+
+	opts.action = REPLAY_INTERACTIVE_REBASE;
+	opts.allow_ff = 1;
+	opts.allow_empty = 1;
+
+	argc = parse_options(argc, argv, NULL, options,
+			builtin_rebase_helper_usage, PARSE_OPT_KEEP_ARGV0);
+
+	if (command == CONTINUE && argc == 1)
+		return !!sequencer_continue(&opts);
+	if (command == ABORT && argc == 1)
+		return !!sequencer_remove_state(&opts);
+	usage_with_options(builtin_rebase_helper_usage, options);
+}
diff --git a/git.c b/git.c
index 0f1937f..26b4ad3 100644
--- a/git.c
+++ b/git.c
@@ -451,6 +451,7 @@ static struct cmd_struct commands[] = {
 	{ "pull", cmd_pull, RUN_SETUP | NEED_WORK_TREE },
 	{ "push", cmd_push, RUN_SETUP },
 	{ "read-tree", cmd_read_tree, RUN_SETUP },
+	{ "rebase--helper", cmd_rebase__helper, RUN_SETUP | NEED_WORK_TREE },
 	{ "receive-pack", cmd_receive_pack },
 	{ "reflog", cmd_reflog, RUN_SETUP },
 	{ "remote", cmd_remote, RUN_SETUP },
-- 
2.9.3.windows.3


