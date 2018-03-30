Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2B5F1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 18:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeC3SfB (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 14:35:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:49054 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751938AbeC3SfB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 14:35:01 -0400
Received: (qmail 24178 invoked by uid 109); 30 Mar 2018 18:35:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 18:35:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31087 invoked by uid 111); 30 Mar 2018 18:36:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 14:36:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 14:34:59 -0400
Date:   Fri, 30 Mar 2018 14:34:59 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2 2/5] trace.c: export trace_setup_key
Message-ID: <20180330183459.GB31135@sigill.intra.peff.net>
References: <20180330183425.GA30575@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180330183425.GA30575@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

This is so that we can print traces based on this key outside trace.c.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 trace.c | 14 +++++++-------
 trace.h |  1 +
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/trace.c b/trace.c
index 7f3b08e148..fc623e91fd 100644
--- a/trace.c
+++ b/trace.c
@@ -26,6 +26,7 @@
 
 struct trace_key trace_default_key = { "GIT_TRACE", 0, 0, 0 };
 struct trace_key trace_perf_key = TRACE_KEY_INIT(PERFORMANCE);
+struct trace_key trace_setup_key = TRACE_KEY_INIT(SETUP);
 
 /* Get a trace file descriptor from "key" env variable. */
 static int get_trace_fd(struct trace_key *key)
@@ -300,11 +301,10 @@ static const char *quote_crnl(const char *path)
 /* FIXME: move prefix to startup_info struct and get rid of this arg */
 void trace_repo_setup(const char *prefix)
 {
-	static struct trace_key key = TRACE_KEY_INIT(SETUP);
 	const char *git_work_tree;
 	char *cwd;
 
-	if (!trace_want(&key))
+	if (!trace_want(&trace_setup_key))
 		return;
 
 	cwd = xgetcwd();
@@ -315,11 +315,11 @@ void trace_repo_setup(const char *prefix)
 	if (!prefix)
 		prefix = "(null)";
 
-	trace_printf_key(&key, "setup: git_dir: %s\n", quote_crnl(get_git_dir()));
-	trace_printf_key(&key, "setup: git_common_dir: %s\n", quote_crnl(get_git_common_dir()));
-	trace_printf_key(&key, "setup: worktree: %s\n", quote_crnl(git_work_tree));
-	trace_printf_key(&key, "setup: cwd: %s\n", quote_crnl(cwd));
-	trace_printf_key(&key, "setup: prefix: %s\n", quote_crnl(prefix));
+	trace_printf_key(&trace_setup_key, "setup: git_dir: %s\n", quote_crnl(get_git_dir()));
+	trace_printf_key(&trace_setup_key, "setup: git_common_dir: %s\n", quote_crnl(get_git_common_dir()));
+	trace_printf_key(&trace_setup_key, "setup: worktree: %s\n", quote_crnl(git_work_tree));
+	trace_printf_key(&trace_setup_key, "setup: cwd: %s\n", quote_crnl(cwd));
+	trace_printf_key(&trace_setup_key, "setup: prefix: %s\n", quote_crnl(prefix));
 
 	free(cwd);
 }
diff --git a/trace.h b/trace.h
index 88055abef7..2b6a1bc17c 100644
--- a/trace.h
+++ b/trace.h
@@ -15,6 +15,7 @@ extern struct trace_key trace_default_key;
 
 #define TRACE_KEY_INIT(name) { "GIT_TRACE_" #name, 0, 0, 0 }
 extern struct trace_key trace_perf_key;
+extern struct trace_key trace_setup_key;
 
 extern void trace_repo_setup(const char *prefix);
 extern int trace_want(struct trace_key *key);
-- 
2.17.0.rc2.594.gdb94a0ce02

