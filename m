Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89F8C433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 14:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5FE020781
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 14:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgHMO7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 10:59:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:57728 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgHMO7h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 10:59:37 -0400
Received: (qmail 19900 invoked by uid 109); 13 Aug 2020 14:59:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2020 14:59:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14190 invoked by uid 111); 13 Aug 2020 14:59:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2020 10:59:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Aug 2020 10:59:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH 3/5] make git-bugreport a builtin
Message-ID: <20200813145936.GC891370@coredump.intra.peff.net>
References: <20200813145515.GA891139@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200813145515.GA891139@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no reason that bugreport has to be a separate binary. And since
it links against libgit.a, it has a rather large disk footprint. Let's
make it a builtin, which reduces the size of a stripped installation
from 24MB to 22MB.

This also simplifies our Makefile a bit. And we can take advantage of
builtin niceties like RUN_SETUP_GENTLY.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile                            |  6 +-----
 builtin.h                           |  1 +
 bugreport.c => builtin/bugreport.c  | 10 +++-------
 contrib/buildsystems/CMakeLists.txt |  5 +----
 git.c                               |  1 +
 5 files changed, 7 insertions(+), 16 deletions(-)
 rename bugreport.c => builtin/bugreport.c (96%)

diff --git a/Makefile b/Makefile
index 5b43c0fafb..acaff6968b 100644
--- a/Makefile
+++ b/Makefile
@@ -671,7 +671,6 @@ EXTRA_PROGRAMS =
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS += $(EXTRA_PROGRAMS)
 
-PROGRAM_OBJS += bugreport.o
 PROGRAM_OBJS += daemon.o
 PROGRAM_OBJS += fast-import.o
 PROGRAM_OBJS += http-backend.o
@@ -1041,6 +1040,7 @@ BUILTIN_OBJS += builtin/archive.o
 BUILTIN_OBJS += builtin/bisect--helper.o
 BUILTIN_OBJS += builtin/blame.o
 BUILTIN_OBJS += builtin/branch.o
+BUILTIN_OBJS += builtin/bugreport.o
 BUILTIN_OBJS += builtin/bundle.o
 BUILTIN_OBJS += builtin/cat-file.o
 BUILTIN_OBJS += builtin/check-attr.o
@@ -2458,10 +2458,6 @@ endif
 git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
-git-bugreport$X: bugreport.o GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIBS)
-
 git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(IMAP_SEND_LDFLAGS) $(LIBS)
diff --git a/builtin.h b/builtin.h
index 4a0aed5448..1e78d6c142 100644
--- a/builtin.h
+++ b/builtin.h
@@ -119,6 +119,7 @@ int cmd_archive(int argc, const char **argv, const char *prefix);
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix);
 int cmd_blame(int argc, const char **argv, const char *prefix);
 int cmd_branch(int argc, const char **argv, const char *prefix);
+int cmd_bugreport(int argc, const char **argv, const char *prefix);
 int cmd_bundle(int argc, const char **argv, const char *prefix);
 int cmd_cat_file(int argc, const char **argv, const char *prefix);
 int cmd_checkout(int argc, const char **argv, const char *prefix);
diff --git a/bugreport.c b/builtin/bugreport.c
similarity index 96%
rename from bugreport.c
rename to builtin/bugreport.c
index 09579e268d..9c920cc065 100644
--- a/bugreport.c
+++ b/builtin/bugreport.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "parse-options.h"
 #include "strbuf.h"
 #include "help.h"
@@ -119,16 +119,14 @@ static void get_header(struct strbuf *buf, const char *title)
 	strbuf_addf(buf, "\n\n[%s]\n", title);
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd_bugreport(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buffer = STRBUF_INIT;
 	struct strbuf report_path = STRBUF_INIT;
 	int report = -1;
 	time_t now = time(NULL);
 	char *option_output = NULL;
 	char *option_suffix = "%Y-%m-%d-%H%M";
-	int nongit_ok = 0;
-	const char *prefix = NULL;
 	const char *user_relative_path = NULL;
 
 	const struct option bugreport_options[] = {
@@ -139,8 +137,6 @@ int cmd_main(int argc, const char **argv)
 		OPT_END()
 	};
 
-	prefix = setup_git_directory_gently(&nongit_ok);
-
 	argc = parse_options(argc, argv, prefix, bugreport_options,
 			     bugreport_usage, 0);
 
@@ -170,7 +166,7 @@ int cmd_main(int argc, const char **argv)
 	get_system_info(&buffer);
 
 	get_header(&buffer, _("Enabled Hooks"));
-	get_populated_hooks(&buffer, nongit_ok);
+	get_populated_hooks(&buffer, !startup_info->have_repository);
 
 	/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
 	report = open(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 4be61247e5..3e211606fd 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -501,7 +501,7 @@ unset(CMAKE_REQUIRED_INCLUDES)
 
 #programs
 set(PROGRAMS_BUILT
-	git git-bugreport git-daemon git-fast-import git-http-backend git-sh-i18n--envsubst
+	git git-daemon git-fast-import git-http-backend git-sh-i18n--envsubst
 	git-shell git-remote-testsvn)
 
 if(NOT CURL_FOUND)
@@ -624,9 +624,6 @@ list(TRANSFORM git_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_executable(git ${CMAKE_SOURCE_DIR}/git.c ${git_SOURCES})
 target_link_libraries(git common-main)
 
-add_executable(git-bugreport ${CMAKE_SOURCE_DIR}/bugreport.c)
-target_link_libraries(git-bugreport common-main)
-
 add_executable(git-daemon ${CMAKE_SOURCE_DIR}/daemon.c)
 target_link_libraries(git-daemon common-main)
 
diff --git a/git.c b/git.c
index 39a160fa52..bf790e7f4f 100644
--- a/git.c
+++ b/git.c
@@ -479,6 +479,7 @@ static struct cmd_struct commands[] = {
 	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
 	{ "blame", cmd_blame, RUN_SETUP },
 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
+	{ "bugreport", cmd_bugreport, RUN_SETUP_GENTLY },
 	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "cat-file", cmd_cat_file, RUN_SETUP },
 	{ "check-attr", cmd_check_attr, RUN_SETUP },
-- 
2.28.0.573.gec6564704b

