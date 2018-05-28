Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 012511F51C
	for <e@80x24.org>; Mon, 28 May 2018 09:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754173AbeE1Ji4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 05:38:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:54502 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754090AbeE1Jiz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 05:38:55 -0400
Received: (qmail 22272 invoked by uid 109); 28 May 2018 09:38:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 28 May 2018 09:38:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20798 invoked by uid 111); 28 May 2018 09:39:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 28 May 2018 05:39:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 May 2018 05:38:53 -0400
Date:   Mon, 28 May 2018 05:38:53 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] make show-index a builtin
Message-ID: <20180528093853.GA20229@sigill.intra.peff.net>
References: <20180528093740.GA6902@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180528093740.GA6902@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-show-index command is built as its own separate
program. There's really no good reason for this, and it
means we waste extra space on disk (and CPU time running the
linker). Let's fold it in to the main binary as a builtin.

The history here is actually a bit amusing. The program
itself is mostly self-contained, and doesn't even use our
normal pack index code. In a5031214c4 (slim down "git
show-index", 2010-01-21), we even stopped using xmalloc() so
that it could avoid libgit.a entirely. But then 040a655116
(cleanup: use internal memory allocation wrapper functions
everywhere, 2011-10-06) switched that back to xmalloc, which
later become ALLOC_ARRAY().

Making it a builtin should give us the best of both worlds:
no wasted space and no need to avoid the usual patterns.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile                             | 2 +-
 builtin.h                            | 1 +
 show-index.c => builtin/show-index.c | 2 +-
 git.c                                | 1 +
 4 files changed, 4 insertions(+), 2 deletions(-)
 rename show-index.c => builtin/show-index.c (96%)

diff --git a/Makefile b/Makefile
index ad880d1fc5..766c5909bf 100644
--- a/Makefile
+++ b/Makefile
@@ -689,7 +689,6 @@ PROGRAM_OBJS += http-backend.o
 PROGRAM_OBJS += imap-send.o
 PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAM_OBJS += shell.o
-PROGRAM_OBJS += show-index.o
 PROGRAM_OBJS += remote-testsvn.o
 
 # Binary suffix, set to .exe for Windows builds
@@ -1076,6 +1075,7 @@ BUILTIN_OBJS += builtin/send-pack.o
 BUILTIN_OBJS += builtin/serve.o
 BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
+BUILTIN_OBJS += builtin/show-index.o
 BUILTIN_OBJS += builtin/show-ref.o
 BUILTIN_OBJS += builtin/stripspace.o
 BUILTIN_OBJS += builtin/submodule--helper.o
diff --git a/builtin.h b/builtin.h
index 4e0f64723e..0362f1ce25 100644
--- a/builtin.h
+++ b/builtin.h
@@ -220,6 +220,7 @@ extern int cmd_serve(int argc, const char **argv, const char *prefix);
 extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
+extern int cmd_show_index(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
diff --git a/show-index.c b/builtin/show-index.c
similarity index 96%
rename from show-index.c
rename to builtin/show-index.c
index 1ead41e211..65fa86dd08 100644
--- a/show-index.c
+++ b/builtin/show-index.c
@@ -4,7 +4,7 @@
 static const char show_index_usage[] =
 "git show-index";
 
-int cmd_main(int argc, const char **argv)
+int cmd_show_index(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	unsigned nr;
diff --git a/git.c b/git.c
index 5771d62a32..c91e144d9a 100644
--- a/git.c
+++ b/git.c
@@ -470,6 +470,7 @@ static struct cmd_struct commands[] = {
 	{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
 	{ "show", cmd_show, RUN_SETUP },
 	{ "show-branch", cmd_show_branch, RUN_SETUP },
+	{ "show-index", cmd_show_index },
 	{ "show-ref", cmd_show_ref, RUN_SETUP },
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
-- 
2.17.0.1391.g6fdbf40724

