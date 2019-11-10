Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DCFE1F454
	for <e@80x24.org>; Sun, 10 Nov 2019 20:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfKJUlv (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 15:41:51 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:55986 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbfKJUlv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 15:41:51 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 89E2A34CB4F
        for <git@vger.kernel.org>; Sun, 10 Nov 2019 20:41:49 +0000 (UTC)
Received: (qmail 13444 invoked by uid 129); 10 Nov 2019 20:41:42 -0000
X-HELO: thorne.orbis-terrarum.net
Authentication-Results: orbis-terrarum.net; auth=pass (cram-md5) smtp.auth=robbat2-thorne@orbis-terrarum.net; iprev=pass
Received: from d173-181-74-218.bchsia.telus.net (HELO thorne.orbis-terrarum.net) (173.181.74.218)
 by orbis-terrarum.net (qpsmtpd/0.95) with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted); Sun, 10 Nov 2019 20:41:41 +0000
Received: by thorne.orbis-terrarum.net (Postfix, from userid 10000)
        id 5379B198B01; Sun, 10 Nov 2019 20:41:26 +0000 (UTC)
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     git@vger.kernel.org
Subject: [PATCH v3 2/3] bundle-create: progress output control
Date:   Sun, 10 Nov 2019 12:41:25 -0800
Message-Id: <20191110204126.30553-2-robbat2@gentoo.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191110204126.30553-1-robbat2@gentoo.org>
References: <1f7f0aa1e8fae54bf967ae83a160be2b30db634f.1573248640.git.gitgitgadget@gmail.com>
 <20191110204126.30553-1-robbat2@gentoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Checked: Checked by ClamAV on orbis-terrarum.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Support the progress output options from pack-objects in git-bundle's
create subcommand. Most notably, this provides --quiet as requested on
the git mailing list per [1]

Reference: https://www.mail-archive.com/git@vger.kernel.org/msg182844.html <robbat2-20190806T191156-796782357Z@orbis-terrarum.net>
Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 Documentation/git-bundle.txt | 33 +++++++++++++++++++++++++++++++--
 builtin/bundle.c             | 30 +++++++++++++++++++++++++++---
 bundle.c                     |  9 +++++----
 bundle.h                     |  3 ++-
 4 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 7d6c9dcd17..96bb94df7b 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -9,7 +9,7 @@ git-bundle - Move objects and refs by archive
 SYNOPSIS
 --------
 [verse]
-'git bundle' create <file> <git-rev-list-args>
+'git bundle' create [-q | --quiet | --progress | --all-progress] [--all-progress-implied] <file> <git-rev-list-args>
 'git bundle' verify <file>
 'git bundle' list-heads <file> [<refname>...]
 'git bundle' unbundle <file> [<refname>...]
@@ -33,9 +33,11 @@ destination repository.
 OPTIONS
 -------
 
-create <file>::
+create [options] <file> <git-rev-list-args>::
 	Used to create a bundle named 'file'.  This requires the
 	'git-rev-list-args' arguments to define the bundle contents.
+	'options' contains the options specific to the 'git bundle create'
+	subcommand.
 
 verify <file>::
 	Used to check that a bundle file is valid and will apply
@@ -75,6 +77,33 @@ unbundle <file>::
 	necessarily everything in the pack (in this case, 'git bundle' acts
 	like 'git fetch-pack').
 
+--progress::
+	Progress status is reported on the standard error stream
+	by default when it is attached to a terminal, unless -q
+	is specified. This flag forces progress status even if
+	the standard error stream is not directed to a terminal.
+
+--all-progress::
+	When --stdout is specified then progress report is
+	displayed during the object count and compression phases
+	but inhibited during the write-out phase. The reason is
+	that in some cases the output stream is directly linked
+	to another command which may wish to display progress
+	status of its own as it processes incoming pack data.
+	This flag is like --progress except that it forces progress
+	report for the write-out phase as well even if --stdout is
+	used.
+
+--all-progress-implied::
+	This is used to imply --all-progress whenever progress display
+	is activated.  Unlike --all-progress this flag doesn't actually
+	force any progress display by itself.
+
+-q::
+--quiet::
+	This flag makes the command not to report its progress
+	on the standard error stream.
+
 SPECIFYING REFERENCES
 ---------------------
 
diff --git a/builtin/bundle.c b/builtin/bundle.c
index 09b989cfc0..39b3e88d40 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "argv-array.h"
 #include "parse-options.h"
 #include "cache.h"
 #include "bundle.h"
@@ -11,7 +12,7 @@
  */
 
 static const char * const builtin_bundle_usage[] = {
-  N_("git bundle create <file> <git-rev-list args>"),
+  N_("git bundle create [<options>] <file> <git-rev-list args>"),
   N_("git bundle verify <file>"),
   N_("git bundle list-heads <file> [<refname>...]"),
   N_("git bundle unbundle <file> [<refname>...]"),
@@ -19,7 +20,7 @@ static const char * const builtin_bundle_usage[] = {
 };
 
 static const char * const builtin_bundle_create_usage[] = {
-  N_("git bundle create <file> <git-rev-list args>"),
+  N_("git bundle create [<options>] <file> <git-rev-list args>"),
   NULL
 };
 
@@ -56,7 +57,20 @@ static int parse_options_cmd_bundle(int argc,
 }
 
 static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
+	int all_progress_implied = 0;
+	int progress = isatty(STDERR_FILENO);
+	struct argv_array pack_opts;
+
 	struct option options[] = {
+		OPT_SET_INT('q', "quiet", &progress,
+			    N_("do not show progress meter"), 0),
+		OPT_SET_INT(0, "progress", &progress,
+			    N_("show progress meter"), 1),
+		OPT_SET_INT(0, "all-progress", &progress,
+			    N_("show progress meter during object writing phase"), 2),
+		OPT_BOOL(0, "all-progress-implied",
+			 &all_progress_implied,
+			 N_("similar to --all-progress when progress meter is shown")),
 		OPT_END()
 	};
 	const char* bundle_file;
@@ -65,9 +79,19 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
 			builtin_bundle_create_usage, options, &bundle_file);
 	/* bundle internals use argv[1] as further parameters */
 
+	argv_array_init(&pack_opts);
+	if (progress == 0)
+		argv_array_push(&pack_opts, "--quiet");
+	else if (progress == 1)
+		argv_array_push(&pack_opts, "--progress");
+	else if (progress == 2)
+		argv_array_push(&pack_opts, "--all-progress");
+	if (progress && all_progress_implied)
+		argv_array_push(&pack_opts, "--all-progress-implied");
+
 	if (!startup_info->have_repository)
 		die(_("Need a repository to create a bundle."));
-	return !!create_bundle(the_repository, bundle_file, argc, argv);
+	return !!create_bundle(the_repository, bundle_file, argc, argv, &pack_opts);
 }
 
 static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
diff --git a/bundle.c b/bundle.c
index a85ed3f7bc..99439e07a1 100644
--- a/bundle.c
+++ b/bundle.c
@@ -249,15 +249,16 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 
 
 /* Write the pack data to bundle_fd */
-static int write_pack_data(int bundle_fd, struct rev_info *revs)
+static int write_pack_data(int bundle_fd, struct rev_info *revs, struct argv_array *pack_options)
 {
 	struct child_process pack_objects = CHILD_PROCESS_INIT;
 	int i;
 
 	argv_array_pushl(&pack_objects.args,
-			 "pack-objects", "--all-progress-implied",
+			 "pack-objects",
 			 "--stdout", "--thin", "--delta-base-offset",
 			 NULL);
+	argv_array_pushv(&pack_objects.args, pack_options->argv);
 	pack_objects.in = -1;
 	pack_objects.out = bundle_fd;
 	pack_objects.git_cmd = 1;
@@ -428,7 +429,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 }
 
 int create_bundle(struct repository *r, const char *path,
-		  int argc, const char **argv)
+		  int argc, const char **argv, struct argv_array *pack_options)
 {
 	struct lock_file lock = LOCK_INIT;
 	int bundle_fd = -1;
@@ -470,7 +471,7 @@ int create_bundle(struct repository *r, const char *path,
 		goto err;
 
 	/* write pack */
-	if (write_pack_data(bundle_fd, &revs))
+	if (write_pack_data(bundle_fd, &revs, pack_options))
 		goto err;
 
 	if (!bundle_to_stdout) {
diff --git a/bundle.h b/bundle.h
index 37c37d7f65..ceab0c7475 100644
--- a/bundle.h
+++ b/bundle.h
@@ -1,6 +1,7 @@
 #ifndef BUNDLE_H
 #define BUNDLE_H
 
+#include "argv-array.h"
 #include "cache.h"
 
 struct ref_list {
@@ -19,7 +20,7 @@ struct bundle_header {
 int is_bundle(const char *path, int quiet);
 int read_bundle_header(const char *path, struct bundle_header *header);
 int create_bundle(struct repository *r, const char *path,
-		  int argc, const char **argv);
+		  int argc, const char **argv, struct argv_array *pack_options);
 int verify_bundle(struct repository *r, struct bundle_header *header, int verbose);
 #define BUNDLE_VERBOSE 1
 int unbundle(struct repository *r, struct bundle_header *header,
-- 
2.23.0

