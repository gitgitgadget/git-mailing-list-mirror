Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CA8C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 14:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C3E320781
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 14:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgHMO66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 10:58:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:57722 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgHMO65 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 10:58:57 -0400
Received: (qmail 19887 invoked by uid 109); 13 Aug 2020 14:58:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2020 14:58:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14170 invoked by uid 111); 13 Aug 2020 14:58:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2020 10:58:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Aug 2020 10:58:55 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/5] make credential helpers builtins
Message-ID: <20200813145855.GB891370@coredump.intra.peff.net>
References: <20200813145515.GA891139@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200813145515.GA891139@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no real reason for credential helpers to be separate binaries. I
did them this way originally under the notion that helper don't _need_
to be part of Git, and so can be built totally separately (and indeed,
the ones in contrib/credential are). But the ones in our main Makefile
build on libgit.a, and the resulting binaries are reasonably large.

We can slim down our total disk footprint by just making them builtins.
This reduces the size of:

  make strip install

from 29MB to 24MB on my Debian system.

Note that credential-cache can't operate without support for Unix
sockets. Currently we just don't build it at all when NO_UNIX_SOCKETS is
set. We could continue that with conditionals in the Makefile and our
list of builtins. But instead, let's build a dummy implementation that
dies with an informative message. That has two advantages:

  - it's simpler, because the conditional bits are all kept inside
    the credential-cache source

  - a user who is expecting it to exist will be told _why_ they can't
    use it, rather than getting the "credential-cache is not a git
    command" error which makes it look like the Git install is broken.

Note that our dummy implementation does still respond to "-h" in order
to appease t0012 (and this may be a little friendlier for users, as
well).

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile                                      |  8 ++---
 builtin.h                                     |  3 ++
 .../credential-cache--daemon.c                | 29 ++++++++++++++++---
 .../credential-cache.c                        | 29 ++++++++++++++++---
 .../credential-store.c                        |  6 ++--
 contrib/buildsystems/CMakeLists.txt           | 20 +------------
 git.c                                         |  3 ++
 7 files changed, 63 insertions(+), 35 deletions(-)
 rename credential-cache--daemon.c => builtin/credential-cache--daemon.c (91%)
 rename credential-cache.c => builtin/credential-cache.c (83%)
 rename credential-store.c => builtin/credential-store.c (96%)

diff --git a/Makefile b/Makefile
index 271b96348e..5b43c0fafb 100644
--- a/Makefile
+++ b/Makefile
@@ -672,7 +672,6 @@ EXTRA_PROGRAMS =
 PROGRAMS += $(EXTRA_PROGRAMS)
 
 PROGRAM_OBJS += bugreport.o
-PROGRAM_OBJS += credential-store.o
 PROGRAM_OBJS += daemon.o
 PROGRAM_OBJS += fast-import.o
 PROGRAM_OBJS += http-backend.o
@@ -1052,6 +1051,9 @@ BUILTIN_OBJS += builtin/checkout-index.o
 BUILTIN_OBJS += builtin/checkout.o
 BUILTIN_OBJS += builtin/clean.o
 BUILTIN_OBJS += builtin/clone.o
+BUILTIN_OBJS += builtin/credential-cache.o
+BUILTIN_OBJS += builtin/credential-cache--daemon.o
+BUILTIN_OBJS += builtin/credential-store.o
 BUILTIN_OBJS += builtin/column.o
 BUILTIN_OBJS += builtin/commit-graph.o
 BUILTIN_OBJS += builtin/commit-tree.o
@@ -1634,11 +1636,8 @@ ifdef NO_INET_PTON
 endif
 ifdef NO_UNIX_SOCKETS
 	BASIC_CFLAGS += -DNO_UNIX_SOCKETS
-	EXCLUDED_PROGRAMS += git-credential-cache git-credential-cache--daemon
 else
 	LIB_OBJS += unix-socket.o
-	PROGRAM_OBJS += credential-cache.o
-	PROGRAM_OBJS += credential-cache--daemon.o
 endif
 
 ifdef NO_ICONV
@@ -2901,7 +2900,6 @@ ifdef MSVC
 	# because it is just a copy/hardlink of git.exe, rather than a unique binary.
 	$(INSTALL) git.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) git-shell.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
-	$(INSTALL) git-credential-store.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) git-daemon.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) git-fast-import.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) git-http-backend.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
diff --git a/builtin.h b/builtin.h
index a5ae15bfe5..4a0aed5448 100644
--- a/builtin.h
+++ b/builtin.h
@@ -138,6 +138,9 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix);
 int cmd_config(int argc, const char **argv, const char *prefix);
 int cmd_count_objects(int argc, const char **argv, const char *prefix);
 int cmd_credential(int argc, const char **argv, const char *prefix);
+int cmd_credential_cache(int argc, const char **argv, const char *prefix);
+int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix);
+int cmd_credential_store(int argc, const char **argv, const char *prefix);
 int cmd_describe(int argc, const char **argv, const char *prefix);
 int cmd_diff_files(int argc, const char **argv, const char *prefix);
 int cmd_diff_index(int argc, const char **argv, const char *prefix);
diff --git a/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
similarity index 91%
rename from credential-cache--daemon.c
rename to builtin/credential-cache--daemon.c
index ec1271f89c..c61f123a3b 100644
--- a/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -1,9 +1,12 @@
-#include "cache.h"
+#include "builtin.h"
+#include "parse-options.h"
+
+#ifndef NO_UNIX_SOCKETS
+
 #include "config.h"
 #include "tempfile.h"
 #include "credential.h"
 #include "unix-socket.h"
-#include "parse-options.h"
 
 struct credential_cache_entry {
 	struct credential item;
@@ -257,7 +260,7 @@ static void init_socket_directory(const char *path)
 	free(path_copy);
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
 {
 	struct tempfile *socket_file;
 	const char *socket_path;
@@ -275,7 +278,7 @@ int cmd_main(int argc, const char **argv)
 
 	git_config_get_bool("credentialcache.ignoresighup", &ignore_sighup);
 
-	argc = parse_options(argc, argv, NULL, options, usage, 0);
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
 	socket_path = argv[0];
 
 	if (!socket_path)
@@ -295,3 +298,21 @@ int cmd_main(int argc, const char **argv)
 
 	return 0;
 }
+
+#else
+
+int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
+{
+	const char * const usage[] = {
+		"git credential-cache--daemon [options] <action>",
+		"",
+		"credential-cache--daemon is disabled in this build of Git",
+		NULL
+	};
+	struct option options[] = { OPT_END() };
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	die(_("credential-cache--daemon unavailable; no unix socket support"));
+}
+
+#endif /* NO_UNIX_SOCKET */
diff --git a/credential-cache.c b/builtin/credential-cache.c
similarity index 83%
rename from credential-cache.c
rename to builtin/credential-cache.c
index 1cccc3a0b9..d0fafdeb9e 100644
--- a/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -1,7 +1,10 @@
-#include "cache.h"
+#include "builtin.h"
+#include "parse-options.h"
+
+#ifndef NO_UNIX_SOCKETS
+
 #include "credential.h"
 #include "string-list.h"
-#include "parse-options.h"
 #include "unix-socket.h"
 #include "run-command.h"
 
@@ -96,7 +99,7 @@ static char *get_socket_path(void)
 	return socket;
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd_credential_cache(int argc, const char **argv, const char *prefix)
 {
 	char *socket_path = NULL;
 	int timeout = 900;
@@ -113,7 +116,7 @@ int cmd_main(int argc, const char **argv)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, NULL, options, usage, 0);
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
 	if (!argc)
 		usage_with_options(usage, options);
 	op = argv[0];
@@ -134,3 +137,21 @@ int cmd_main(int argc, const char **argv)
 
 	return 0;
 }
+
+#else
+
+int cmd_credential_cache(int argc, const char **argv, const char *prefix)
+{
+	const char * const usage[] = {
+		"git credential-cache [options] <action>",
+		"",
+		"credential-cache is disabled in this build of Git",
+		NULL
+	};
+	struct option options[] = { OPT_END() };
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	die(_("credential-cache unavailable; no unix socket support"));
+}
+
+#endif /* NO_UNIX_SOCKETS */
diff --git a/credential-store.c b/builtin/credential-store.c
similarity index 96%
rename from credential-store.c
rename to builtin/credential-store.c
index 294e771681..5331ab151a 100644
--- a/credential-store.c
+++ b/builtin/credential-store.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "lockfile.h"
 #include "credential.h"
 #include "string-list.h"
@@ -143,7 +143,7 @@ static void lookup_credential(const struct string_list *fns, struct credential *
 			return; /* Found credential */
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd_credential_store(int argc, const char **argv, const char *prefix)
 {
 	const char * const usage[] = {
 		"git credential-store [<options>] <action>",
@@ -161,7 +161,7 @@ int cmd_main(int argc, const char **argv)
 
 	umask(077);
 
-	argc = parse_options(argc, (const char **)argv, NULL, options, usage, 0);
+	argc = parse_options(argc, (const char **)argv, prefix, options, usage, 0);
 	if (argc != 1)
 		usage_with_options(usage, options);
 	op = argv[0];
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 47215df25b..4be61247e5 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -501,15 +501,9 @@ unset(CMAKE_REQUIRED_INCLUDES)
 
 #programs
 set(PROGRAMS_BUILT
-	git git-bugreport git-credential-store git-daemon git-fast-import git-http-backend git-sh-i18n--envsubst
+	git git-bugreport git-daemon git-fast-import git-http-backend git-sh-i18n--envsubst
 	git-shell git-remote-testsvn)
 
-if(NO_UNIX_SOCKETS)
-	list(APPEND excluded_progs git-credential-cache git-credential-cache--daemon)
-else()
-	list(APPEND PROGRAMS_BUILT git-credential-cache git-credential-cache--daemon)
-endif()
-
 if(NOT CURL_FOUND)
 	list(APPEND excluded_progs git-http-fetch git-http-push)
 	add_compile_definitions(NO_CURL)
@@ -633,9 +627,6 @@ target_link_libraries(git common-main)
 add_executable(git-bugreport ${CMAKE_SOURCE_DIR}/bugreport.c)
 target_link_libraries(git-bugreport common-main)
 
-add_executable(git-credential-store ${CMAKE_SOURCE_DIR}/credential-store.c)
-target_link_libraries(git-credential-store common-main)
-
 add_executable(git-daemon ${CMAKE_SOURCE_DIR}/daemon.c)
 target_link_libraries(git-daemon common-main)
 
@@ -672,15 +663,6 @@ endif()
 add_executable(git-remote-testsvn ${CMAKE_SOURCE_DIR}/remote-testsvn.c)
 target_link_libraries(git-remote-testsvn common-main vcs-svn)
 
-if(NOT NO_UNIX_SOCKETS)
-	add_executable(git-credential-cache ${CMAKE_SOURCE_DIR}/credential-cache.c)
-	target_link_libraries(git-credential-cache common-main)
-
-	add_executable(git-credential-cache--daemon ${CMAKE_SOURCE_DIR}/credential-cache--daemon.c)
-	target_link_libraries(git-credential-cache--daemon common-main)
-endif()
-
-
 set(git_builtin_extra
 	cherry cherry-pick format-patch fsck-objects
 	init merge-subtree restore show
diff --git a/git.c b/git.c
index 8bd1d7551d..39a160fa52 100644
--- a/git.c
+++ b/git.c
@@ -499,6 +499,9 @@ static struct cmd_struct commands[] = {
 	{ "config", cmd_config, RUN_SETUP_GENTLY | DELAY_PAGER_CONFIG },
 	{ "count-objects", cmd_count_objects, RUN_SETUP },
 	{ "credential", cmd_credential, RUN_SETUP_GENTLY | NO_PARSEOPT },
+	{ "credential-cache", cmd_credential_cache },
+	{ "credential-cache--daemon", cmd_credential_cache_daemon },
+	{ "credential-store", cmd_credential_store },
 	{ "describe", cmd_describe, RUN_SETUP },
 	{ "diff", cmd_diff, NO_PARSEOPT },
 	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
-- 
2.28.0.573.gec6564704b

