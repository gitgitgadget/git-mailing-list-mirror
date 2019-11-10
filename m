Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B5A11F454
	for <e@80x24.org>; Sun, 10 Nov 2019 20:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfKJUlv (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 15:41:51 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:55988 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbfKJUlv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 15:41:51 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 8FEDA34CB50
        for <git@vger.kernel.org>; Sun, 10 Nov 2019 20:41:49 +0000 (UTC)
Received: (qmail 13442 invoked by uid 129); 10 Nov 2019 20:41:42 -0000
X-HELO: thorne.orbis-terrarum.net
Authentication-Results: orbis-terrarum.net; auth=pass (cram-md5) smtp.auth=robbat2-thorne@orbis-terrarum.net; iprev=pass
Received: from d173-181-74-218.bchsia.telus.net (HELO thorne.orbis-terrarum.net) (173.181.74.218)
 by orbis-terrarum.net (qpsmtpd/0.95) with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted); Sun, 10 Nov 2019 20:41:41 +0000
Received: by thorne.orbis-terrarum.net (Postfix, from userid 10000)
        id 517A8198B0D; Sun, 10 Nov 2019 20:41:26 +0000 (UTC)
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     git@vger.kernel.org
Subject: [PATCH v3 1/3] bundle: framework for options before bundle file
Date:   Sun, 10 Nov 2019 12:41:24 -0800
Message-Id: <20191110204126.30553-1-robbat2@gentoo.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <1f7f0aa1e8fae54bf967ae83a160be2b30db634f.1573248640.git.gitgitgadget@gmail.com>
References: <1f7f0aa1e8fae54bf967ae83a160be2b30db634f.1573248640.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Checked: Checked by ClamAV on orbis-terrarum.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make it possible for any of the git-bundle subcommands to include
options:
- before the sub-command
- after the sub-command, before the bundle filename

There is an immediate gain in support for help with all of the
sub-commands, where 'git bundle list-heads -h' previously returned an
error.

Downside here is an increase in code duplication that cannot be
trivially avoided short of shared global static options.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 builtin/bundle.c | 190 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 145 insertions(+), 45 deletions(-)

I tried doing this via GitGitGadget initially as a test of that process,
as well as the CI integration side; however as noted in #git-devel and
elsewhere on the list, vger seems to swallow the mail to /dev/null

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 1ea4bfdfc1..09b989cfc0 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "parse-options.h"
 #include "cache.h"
 #include "bundle.h"
 
@@ -9,59 +10,158 @@
  * bundle supporting "fetch", "pull", and "ls-remote".
  */
 
-static const char builtin_bundle_usage[] =
-  "git bundle create <file> <git-rev-list args>\n"
-  "   or: git bundle verify <file>\n"
-  "   or: git bundle list-heads <file> [<refname>...]\n"
-  "   or: git bundle unbundle <file> [<refname>...]";
+static const char * const builtin_bundle_usage[] = {
+  N_("git bundle create <file> <git-rev-list args>"),
+  N_("git bundle verify <file>"),
+  N_("git bundle list-heads <file> [<refname>...]"),
+  N_("git bundle unbundle <file> [<refname>...]"),
+  NULL
+};
 
-int cmd_bundle(int argc, const char **argv, const char *prefix)
-{
+static const char * const builtin_bundle_create_usage[] = {
+  N_("git bundle create <file> <git-rev-list args>"),
+  NULL
+};
+
+static const char * const builtin_bundle_verify_usage[] = {
+  N_("git bundle verify <file>"),
+  NULL
+};
+
+static const char * const builtin_bundle_list_heads_usage[] = {
+  N_("git bundle list-heads <file> [<refname>...]"),
+  NULL
+};
+
+static const char * const builtin_bundle_unbundle_usage[] = {
+  N_("git bundle unbundle <file> [<refname>...]"),
+  NULL
+};
+
+static int verbose;
+
+static int parse_options_cmd_bundle(int argc,
+		const char **argv,
+		const char* prefix,
+		const char * const usagestr[],
+		const struct option options[],
+		const char **bundle_file) {
+	int newargc;
+	newargc = parse_options(argc, argv, NULL, options, usagestr,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	if (argc < 1)
+		usage_with_options(usagestr, options);
+	*bundle_file = prefix_filename(prefix, argv[0]);
+	return newargc;
+}
+
+static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
+	struct option options[] = {
+		OPT_END()
+	};
+	const char* bundle_file;
+
+	argc = parse_options_cmd_bundle(argc, argv, prefix,
+			builtin_bundle_create_usage, options, &bundle_file);
+	/* bundle internals use argv[1] as further parameters */
+
+	if (!startup_info->have_repository)
+		die(_("Need a repository to create a bundle."));
+	return !!create_bundle(the_repository, bundle_file, argc, argv);
+}
+
+static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
 	struct bundle_header header;
-	const char *cmd, *bundle_file;
 	int bundle_fd = -1;
 
-	if (argc < 3)
-		usage(builtin_bundle_usage);
+	struct option options[] = {
+		OPT_END()
+	};
+	const char* bundle_file;
 
-	cmd = argv[1];
-	bundle_file = prefix_filename(prefix, argv[2]);
-	argc -= 2;
-	argv += 2;
+	argc = parse_options_cmd_bundle(argc, argv, prefix,
+			builtin_bundle_verify_usage, options, &bundle_file);
+	/* bundle internals use argv[1] as further parameters */
 
 	memset(&header, 0, sizeof(header));
-	if (strcmp(cmd, "create") && (bundle_fd =
-				read_bundle_header(bundle_file, &header)) < 0)
+	if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0)
 		return 1;
+	close(bundle_fd);
+	if (verify_bundle(the_repository, &header, 1))
+		return 1;
+	fprintf(stderr, _("%s is okay\n"), bundle_file);
+	return 0;
+}
 
-	if (!strcmp(cmd, "verify")) {
-		close(bundle_fd);
-		if (argc != 1) {
-			usage(builtin_bundle_usage);
-			return 1;
-		}
-		if (verify_bundle(the_repository, &header, 1))
-			return 1;
-		fprintf(stderr, _("%s is okay\n"), bundle_file);
-		return 0;
-	}
-	if (!strcmp(cmd, "list-heads")) {
-		close(bundle_fd);
-		return !!list_bundle_refs(&header, argc, argv);
+static int cmd_bundle_list_heads(int argc, const char **argv, const char *prefix) {
+	struct bundle_header header;
+	int bundle_fd = -1;
+
+	struct option options[] = {
+		OPT_END()
+	};
+	const char* bundle_file;
+
+	argc = parse_options_cmd_bundle(argc, argv, prefix,
+			builtin_bundle_list_heads_usage, options, &bundle_file);
+	/* bundle internals use argv[1] as further parameters */
+
+	memset(&header, 0, sizeof(header));
+	if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0)
+		return 1;
+	close(bundle_fd);
+	return !!list_bundle_refs(&header, argc, argv);
+}
+
+static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix) {
+	struct bundle_header header;
+	int bundle_fd = -1;
+
+	struct option options[] = {
+		OPT_END()
+	};
+	const char* bundle_file;
+
+	argc = parse_options_cmd_bundle(argc, argv, prefix,
+			builtin_bundle_unbundle_usage, options, &bundle_file);
+	/* bundle internals use argv[1] as further parameters */
+
+	memset(&header, 0, sizeof(header));
+	if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0)
+		return 1;
+	if (!startup_info->have_repository)
+		die(_("Need a repository to unbundle."));
+	return !!unbundle(the_repository, &header, bundle_fd, 0) ||
+		list_bundle_refs(&header, argc, argv);
+}
+
+int cmd_bundle(int argc, const char **argv, const char *prefix)
+{
+	struct option options[] = {
+		OPT__VERBOSE(&verbose, N_("be verbose; must be placed before a subcommand")),
+		OPT_END()
+	};
+	int result;
+
+	argc = parse_options(argc, argv, prefix, options, builtin_bundle_usage,
+		PARSE_OPT_STOP_AT_NON_OPTION);
+
+	packet_trace_identity("bundle");
+
+	if (argc < 2)
+		usage_with_options(builtin_bundle_usage, options);
+
+	else if (!strcmp(argv[0], "create"))
+		result = cmd_bundle_create(argc, argv, prefix);
+	else if (!strcmp(argv[0], "verify"))
+		result = cmd_bundle_verify(argc, argv, prefix);
+	else if (!strcmp(argv[0], "list-heads"))
+		result = cmd_bundle_list_heads(argc, argv, prefix);
+	else if (!strcmp(argv[0], "unbundle"))
+		result = cmd_bundle_unbundle(argc, argv, prefix);
+	else {
+		error(_("Unknown subcommand: %s"), argv[0]);
+		usage_with_options(builtin_bundle_usage, options);
 	}
-	if (!strcmp(cmd, "create")) {
-		if (argc < 2) {
-			usage(builtin_bundle_usage);
-			return 1;
-		}
-		if (!startup_info->have_repository)
-			die(_("Need a repository to create a bundle."));
-		return !!create_bundle(the_repository, bundle_file, argc, argv);
-	} else if (!strcmp(cmd, "unbundle")) {
-		if (!startup_info->have_repository)
-			die(_("Need a repository to unbundle."));
-		return !!unbundle(the_repository, &header, bundle_fd, 0) ||
-			list_bundle_refs(&header, argc, argv);
-	} else
-		usage(builtin_bundle_usage);
+	return result ? 1 : 0;
 }
-- 
2.23.0

