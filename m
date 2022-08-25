Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC30C28D13
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 10:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241188AbiHYKvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 06:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240419AbiHYKvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 06:51:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6704ABF36
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 03:51:07 -0700 (PDT)
Received: (qmail 14183 invoked by uid 109); 25 Aug 2022 10:51:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 25 Aug 2022 10:51:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28466 invoked by uid 111); 25 Aug 2022 10:51:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 25 Aug 2022 06:51:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 25 Aug 2022 06:51:06 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH 2/3] maintenance: add parse-options boilerplate for
 subcommands
Message-ID: <YwdUGlRKkmZNM+OW@coredump.intra.peff.net>
References: <YwdSzrF3xaHvLsI+@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YwdSzrF3xaHvLsI+@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several of the git-maintenance subcommands don't take any options, so
they don't bother looking at argv at all. This means they'll silently
accept garbage, like:

  $ git maintenance register --foo
  [no output]

  $ git maintenance stop bar
  [no output]

Let's give them the basic boilerplate to detect and handle these cases:

  $ git maintenance register --foo
  error: unknown option `foo'
  usage: git maintenance register

  $ git maintenance stop bar
  usage: git maintenance stop

We could reduce the number of lines of code here a bit with a shared
helper function. But it's worth building out the boilerplate, as it may
serve as the base for adding options later.

Note one complication: maintenance_start() calls directly into
maintenance_register(), so it now needs to pass a plausible argv (we
don't care, but parse_options() is expecting there to at least be an
argv[0] program name). This is an extra line of code, but it eliminates
the need for an explanatory comment.

Signed-off-by: Jeff King <peff@peff.net>
---
I kind of hate the register_args thing from the last paragraph.
parse-options is actually capable of handling a 0-length argc except
that it blindly walks past the first argument at the start. So loosening
it like this:

  diff --git a/parse-options.c b/parse-options.c
  index a1ec932f0f..c95ecd366a 100644
  --- a/parse-options.c
  +++ b/parse-options.c
  @@ -538,7 +538,7 @@ static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
   {
          ctx->argc = argc;
          ctx->argv = argv;
  -       if (!(flags & PARSE_OPT_ONE_SHOT)) {
  +       if (!(flags & PARSE_OPT_ONE_SHOT) && ctx->argc) {
                  ctx->argc--;
                  ctx->argv++;
          }

makes the original code just work. But I dunno. It feels kind of subtle.
The solution in the patch below is ugly but fairly straightforward.

 builtin/gc.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 19d6b3b558..84549888f5 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1465,14 +1465,28 @@ static char *get_maintpath(void)
 	return strbuf_detach(&sb, NULL);
 }
 
+static char const * const builtin_maintenance_register_usage[] = {
+	N_("git maintenance register"),
+	NULL
+};
+
 static int maintenance_register(int argc, const char **argv, const char *prefix)
 {
+	struct option options[] = {
+		OPT_END(),
+	};
 	int rc;
 	char *config_value;
 	struct child_process config_set = CHILD_PROCESS_INIT;
 	struct child_process config_get = CHILD_PROCESS_INIT;
 	char *maintpath = get_maintpath();
 
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_maintenance_register_usage, 0);
+	if (argc)
+		usage_with_options(builtin_maintenance_register_usage,
+				   options);
+
 	/* Disable foreground maintenance */
 	git_config_set("maintenance.auto", "false");
 
@@ -1509,12 +1523,26 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 	return rc;
 }
 
+static char const * const builtin_maintenance_unregister_usage[] = {
+	N_("git maintenance unregister"),
+	NULL
+};
+
 static int maintenance_unregister(int argc, const char **argv, const char *prefix)
 {
+	struct option options[] = {
+		OPT_END(),
+	};
 	int rc;
 	struct child_process config_unset = CHILD_PROCESS_INIT;
 	char *maintpath = get_maintpath();
 
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_maintenance_unregister_usage, 0);
+	if (argc)
+		usage_with_options(builtin_maintenance_unregister_usage,
+				   options);
+
 	config_unset.git_cmd = 1;
 	strvec_pushl(&config_unset.args, "config", "--global", "--unset",
 		     "--fixed-value", "maintenance.repo", maintpath, NULL);
@@ -2496,6 +2524,7 @@ static int maintenance_start(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NONEG, maintenance_opt_scheduler),
 		OPT_END()
 	};
+	const char *register_args[] = { "register", NULL };
 
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_maintenance_start_usage, 0);
@@ -2505,13 +2534,25 @@ static int maintenance_start(int argc, const char **argv, const char *prefix)
 	opts.scheduler = resolve_scheduler(opts.scheduler);
 	validate_scheduler(opts.scheduler);
 
-	if (maintenance_register(0, NULL, NULL)) /* It doesn't take any args */
+	if (maintenance_register(ARRAY_SIZE(register_args)-1, register_args, NULL))
 		warning(_("failed to add repo to global config"));
 	return update_background_schedule(&opts, 1);
 }
 
+static const char *const builtin_maintenance_stop_usage[] = {
+	N_("git maintenance stop"),
+	NULL
+};
+
 static int maintenance_stop(int argc, const char **argv, const char *prefix)
 {
+	struct option options[] = {
+		OPT_END()
+	};
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_maintenance_stop_usage, 0);
+	if (argc)
+		usage_with_options(builtin_maintenance_stop_usage, options);
 	return update_background_schedule(NULL, 0);
 }
 
-- 
2.37.2.1034.gd926c9c740

