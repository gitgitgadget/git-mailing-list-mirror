Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 893A51FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 22:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752694AbdBIWYC (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 17:24:02 -0500
Received: from mout.gmx.net ([212.227.15.19]:53062 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751531AbdBIWXy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 17:23:54 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBWTO-1ckAaz3uMA-00ATAk; Thu, 09
 Feb 2017 23:23:08 +0100
Date:   Thu, 9 Feb 2017 23:23:06 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] Add a builtin helper for interactive rebases
In-Reply-To: <cover.1486678952.git.johannes.schindelin@gmx.de>
Message-ID: <1a0763311c382640cce182da81b40c9563e783b1.1486678952.git.johannes.schindelin@gmx.de>
References: <cover.1472805251.git.johannes.schindelin@gmx.de> <cover.1486678952.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IPxQWp9idk1f1wi8i+Wk84IpsnxrYfCftI2hVywlylR98KzdO10
 YmfQhGPMMrd8QqfKzhbqgJg5oZ0jHWVNeQpQ3EzORvpAzuHbLPcifuF9FN9nnYZXlI7gMCM
 JyIqqQ6kVb+4ucoq2TQ6N77oj8zsKw+iSTxg1s+rA3P7DTXVw7ZiuJmTdwT05d/PntGu0yA
 WI9T5dMPrtL9V+jQyF6qQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ePU0hqt/pLs=:BWBfIZAsxaBF0QX88vpaHI
 beLtaxHpXv1WhlIk8cP0lKfBZgmf1sApgGYuOL/so8PxrS6iJLxXWoM7+VBoPOIVQgFnBIwh9
 yzC/uEgxCwKkSej5YDloutHHtwjrM83HeTdHKRISFYhm9au5DYH+JcA4BVbq0X415/SeFa/Ka
 gL0bE9w1Xzqn7Ruh4VjRu0JmTZGtlb460RRtSNxChr7UgG9EX2Yw6A5n82DcObKkod4BiEep7
 ykjPKyFmeHliBDlEqEnKHAnHaOi8Lb2Hyx6Tri+W/Z6wl6LHXawinu3ng8E4vjN3VIXoINKdN
 kRW3pZLtvFCpq6uGFdFeuJUgpHtEq925VHRTekYVGkl3d4v20aY+PFf19xoG3vkAton3Pm1ls
 lWw6QVQ6CHqJdcaFp/gsVP+KU7VFcHiSg2/Tiug4vPdoQh8FD57Qd7OKbiiOPW5C0WFhGnjCH
 B/AS5bOhYrZDQMnJmY+pvJr91LDvjZ17L18VDxBXS4knVXPXjjS9NSwa4qaSsACxD8L1yjR35
 FpZ9Pljs9NcHJnZwjbrnQf55nvu6RoTAwC0ZvBL6QUbYLBFv2TLpe/qoh8RaS/e7Es/7VkESp
 aplF1TuK54zA4RxuTw11kjioljaA9ZyT45SWfhzpJOryCwlHa0yo55d5q7VlpUvlP62w21qqr
 2odfbVbdtt/FGPpOnKJrgtiNmWxdSaS/9qoYmSYKDg1qJw8gojLDOoXU6uHOVUdwmbnmEkR7J
 fcmX/d9C9g6on1QIRczmdGRLyiWzS26KPlgoUKgRhIap0ItT9j0Y0AizOLTwH/E6GhUgy2z9+
 2DZCSRa
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
index b1020b875f..833ef3b0b7 100644
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
index 8e4081e061..29f8663509 100644
--- a/Makefile
+++ b/Makefile
@@ -932,6 +932,7 @@ BUILTIN_OBJS += builtin/prune.o
 BUILTIN_OBJS += builtin/pull.o
 BUILTIN_OBJS += builtin/push.o
 BUILTIN_OBJS += builtin/read-tree.o
+BUILTIN_OBJS += builtin/rebase--helper.o
 BUILTIN_OBJS += builtin/receive-pack.o
 BUILTIN_OBJS += builtin/reflog.o
 BUILTIN_OBJS += builtin/remote.o
diff --git a/builtin.h b/builtin.h
index 67f80519da..9e4a89816d 100644
--- a/builtin.h
+++ b/builtin.h
@@ -103,6 +103,7 @@ extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
 extern int cmd_pull(int argc, const char **argv, const char *prefix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
 extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_rebase__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_receive_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_reflog(int argc, const char **argv, const char *prefix);
 extern int cmd_remote(int argc, const char **argv, const char *prefix);
diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
new file mode 100644
index 0000000000..ca1ebb2fa1
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
index c887272b12..33f52acbcc 100644
--- a/git.c
+++ b/git.c
@@ -473,6 +473,7 @@ static struct cmd_struct commands[] = {
 	{ "pull", cmd_pull, RUN_SETUP | NEED_WORK_TREE },
 	{ "push", cmd_push, RUN_SETUP },
 	{ "read-tree", cmd_read_tree, RUN_SETUP | SUPPORT_SUPER_PREFIX},
+	{ "rebase--helper", cmd_rebase__helper, RUN_SETUP | NEED_WORK_TREE },
 	{ "receive-pack", cmd_receive_pack },
 	{ "reflog", cmd_reflog, RUN_SETUP },
 	{ "remote", cmd_remote, RUN_SETUP },
-- 
2.11.1.windows.1


