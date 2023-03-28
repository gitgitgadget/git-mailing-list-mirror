Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0D9C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 20:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjC1UzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjC1UzU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 16:55:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE3D1FDD
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:55:18 -0700 (PDT)
Received: (qmail 2263 invoked by uid 109); 28 Mar 2023 20:55:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Mar 2023 20:55:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2238 invoked by uid 111); 28 Mar 2023 20:55:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Mar 2023 16:55:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Mar 2023 16:55:17 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/7] builtins: annotate always-empty prefix parameters
Message-ID: <20230328205517.GC1754055@coredump.intra.peff.net>
References: <20230328205253.GA1753925@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230328205253.GA1753925@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's usually a bad idea for a builtin's cmd_foo() to ignore the "prefix"
argument it gets, as it needs to prepend that string when accessing any
paths given by the user.

But if a builtin does not ask for the git wrapper to run repository
setup (via the RUN_SETUP or RUN_SETUP_GENTLY flags), then we know the
prefix will always be NULL (it is adjusting for the chdir() done during
repo setup, but there cannot be one if we did not set up the repo). In
those cases it's OK to ignore "prefix", but it's worth annotating for a
few reasons:

  1. It serves as documentation to somebody reading the code about what
     we expect.

  2. If the flags in git.c ever change, the run-time assertion may help
     detect the problem (though only if the command is run from a
     subdirectory of the repository).

  3. It notes to the compiler that we are OK ignoring "prefix". In
     particular, this silences -Wunused-parameter. It _could_ also help
     the compiler generate better code (because it will know the prefix
     is NULL), but in practice this is quite unlikely to matter.

Note that I've only added this annotation to commands which triggered
-Wunused-parameter. It would be correct to add it to any builtin which
doesn't ask for RUN_SETUP, but most of the rest of them do the sensible
thing with "prefix" by passing it to parse_options(). So they're much
more likely to just work if they ever switched to RUN_SETUP, and aren't
worth annotating.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin.h                   | 10 ++++++++++
 builtin/check-ref-format.c  |  2 ++
 builtin/get-tar-commit-id.c |  2 ++
 builtin/mailsplit.c         |  2 ++
 builtin/remote-ext.c        |  2 ++
 builtin/remote-fd.c         |  2 ++
 builtin/upload-archive.c    |  2 ++
 7 files changed, 22 insertions(+)

diff --git a/builtin.h b/builtin.h
index 46cc7897898..cb0db676814 100644
--- a/builtin.h
+++ b/builtin.h
@@ -107,6 +107,16 @@ void setup_auto_pager(const char *cmd, int def);
 
 int is_builtin(const char *s);
 
+/*
+ * Builtins which do not use RUN_SETUP should never see
+ * a prefix that is not empty; use this to protect downstream
+ * code which is not prepared to call prefix_filename(), etc.
+ */
+#define BUG_ON_NON_EMPTY_PREFIX(prefix) do { \
+	if ((prefix)) \
+		BUG("unexpected prefix in builtin: %s", (prefix)); \
+} while (0)
+
 int cmd_add(int argc, const char **argv, const char *prefix);
 int cmd_am(int argc, const char **argv, const char *prefix);
 int cmd_annotate(int argc, const char **argv, const char *prefix);
diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index fd0e5f86832..462eefe1023 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -60,6 +60,8 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 	char *to_free = NULL;
 	int ret = 1;
 
+	BUG_ON_NON_EMPTY_PREFIX(prefix);
+
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(builtin_check_ref_format_usage);
 
diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index 491af9202dc..8f8f2ac3e68 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -24,6 +24,8 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 	long len;
 	char *end;
 
+	BUG_ON_NON_EMPTY_PREFIX(prefix);
+
 	if (argc != 1)
 		usage(builtin_get_tar_commit_id_usage);
 
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 73509f651bd..91e93f0c777 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -277,6 +277,8 @@ int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 	const char **argp;
 	static const char *stdin_only[] = { "-", NULL };
 
+	BUG_ON_NON_EMPTY_PREFIX(prefix);
+
 	for (argp = argv+1; *argp; argp++) {
 		const char *arg = *argp;
 
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index ee338bf440c..282782eccdd 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -197,6 +197,8 @@ static int command_loop(const char *child)
 
 int cmd_remote_ext(int argc, const char **argv, const char *prefix)
 {
+	BUG_ON_NON_EMPTY_PREFIX(prefix);
+
 	if (argc != 3)
 		usage(usage_msg);
 
diff --git a/builtin/remote-fd.c b/builtin/remote-fd.c
index b2a3980b1d5..9020fab9c58 100644
--- a/builtin/remote-fd.c
+++ b/builtin/remote-fd.c
@@ -59,6 +59,8 @@ int cmd_remote_fd(int argc, const char **argv, const char *prefix)
 	int output_fd = -1;
 	char *end;
 
+	BUG_ON_NON_EMPTY_PREFIX(prefix);
+
 	if (argc != 3)
 		usage(usage_msg);
 
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 945ee2b4126..7f9320ac6d0 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -79,6 +79,8 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 {
 	struct child_process writer = CHILD_PROCESS_INIT;
 
+	BUG_ON_NON_EMPTY_PREFIX(prefix);
+
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(upload_archive_usage);
 
-- 
2.40.0.675.gb17cd5d94c8

