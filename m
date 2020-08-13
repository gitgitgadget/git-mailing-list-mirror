Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BB9C433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 14:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 139E520791
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 14:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgHMO7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 10:59:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:57736 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbgHMO7r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 10:59:47 -0400
Received: (qmail 19909 invoked by uid 109); 13 Aug 2020 14:59:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2020 14:59:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14207 invoked by uid 111); 13 Aug 2020 14:59:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2020 10:59:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Aug 2020 10:59:45 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/5] make git-fast-import a builtin
Message-ID: <20200813145945.GD891370@coredump.intra.peff.net>
References: <20200813145515.GA891139@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200813145515.GA891139@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no reason that git-fast-import benefits from being a separate
binary. And as it links against libgit.a, it has a non-trivial disk
footprint. Let's make it a builtin, which reduces the size of a stripped
installation from 22MB to 21MB.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile                               | 3 +--
 builtin.h                              | 1 +
 fast-import.c => builtin/fast-import.c | 3 +--
 contrib/buildsystems/CMakeLists.txt    | 5 +----
 git.c                                  | 1 +
 5 files changed, 5 insertions(+), 8 deletions(-)
 rename fast-import.c => builtin/fast-import.c (99%)

diff --git a/Makefile b/Makefile
index acaff6968b..2b821fc762 100644
--- a/Makefile
+++ b/Makefile
@@ -672,7 +672,6 @@ EXTRA_PROGRAMS =
 PROGRAMS += $(EXTRA_PROGRAMS)
 
 PROGRAM_OBJS += daemon.o
-PROGRAM_OBJS += fast-import.o
 PROGRAM_OBJS += http-backend.o
 PROGRAM_OBJS += imap-send.o
 PROGRAM_OBJS += remote-testsvn.o
@@ -1069,6 +1068,7 @@ BUILTIN_OBJS += builtin/diff.o
 BUILTIN_OBJS += builtin/difftool.o
 BUILTIN_OBJS += builtin/env--helper.o
 BUILTIN_OBJS += builtin/fast-export.o
+BUILTIN_OBJS += builtin/fast-import.o
 BUILTIN_OBJS += builtin/fetch-pack.o
 BUILTIN_OBJS += builtin/fetch.o
 BUILTIN_OBJS += builtin/fmt-merge-msg.o
@@ -2897,7 +2897,6 @@ ifdef MSVC
 	$(INSTALL) git.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) git-shell.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) git-daemon.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) git-fast-import.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) git-http-backend.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) git-http-fetch.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) git-http-push.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
diff --git a/builtin.h b/builtin.h
index 1e78d6c142..ba954e180c 100644
--- a/builtin.h
+++ b/builtin.h
@@ -150,6 +150,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix);
 int cmd_difftool(int argc, const char **argv, const char *prefix);
 int cmd_env__helper(int argc, const char **argv, const char *prefix);
 int cmd_fast_export(int argc, const char **argv, const char *prefix);
+int cmd_fast_import(int argc, const char **argv, const char *prefix);
 int cmd_fetch(int argc, const char **argv, const char *prefix);
 int cmd_fetch_pack(int argc, const char **argv, const char *prefix);
 int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix);
diff --git a/fast-import.c b/builtin/fast-import.c
similarity index 99%
rename from fast-import.c
rename to builtin/fast-import.c
index ce47794db6..8cc5d09c64 100644
--- a/fast-import.c
+++ b/builtin/fast-import.c
@@ -3519,14 +3519,13 @@ static void parse_argv(void)
 	build_mark_map(&sub_marks_from, &sub_marks_to);
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd_fast_import(int argc, const char **argv, const char *prefix)
 {
 	unsigned int i;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(fast_import_usage);
 
-	setup_git_directory();
 	reset_pack_idx_option(&pack_idx_opts);
 	git_pack_config();
 
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 3e211606fd..4a6f135b16 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -501,7 +501,7 @@ unset(CMAKE_REQUIRED_INCLUDES)
 
 #programs
 set(PROGRAMS_BUILT
-	git git-daemon git-fast-import git-http-backend git-sh-i18n--envsubst
+	git git-daemon git-http-backend git-sh-i18n--envsubst
 	git-shell git-remote-testsvn)
 
 if(NOT CURL_FOUND)
@@ -627,9 +627,6 @@ target_link_libraries(git common-main)
 add_executable(git-daemon ${CMAKE_SOURCE_DIR}/daemon.c)
 target_link_libraries(git-daemon common-main)
 
-add_executable(git-fast-import ${CMAKE_SOURCE_DIR}/fast-import.c)
-target_link_libraries(git-fast-import common-main)
-
 add_executable(git-http-backend ${CMAKE_SOURCE_DIR}/http-backend.c)
 target_link_libraries(git-http-backend common-main)
 
diff --git a/git.c b/git.c
index bf790e7f4f..01c456edce 100644
--- a/git.c
+++ b/git.c
@@ -511,6 +511,7 @@ static struct cmd_struct commands[] = {
 	{ "difftool", cmd_difftool, RUN_SETUP_GENTLY },
 	{ "env--helper", cmd_env__helper },
 	{ "fast-export", cmd_fast_export, RUN_SETUP },
+	{ "fast-import", cmd_fast_import, RUN_SETUP | NO_PARSEOPT },
 	{ "fetch", cmd_fetch, RUN_SETUP },
 	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP | NO_PARSEOPT },
 	{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
-- 
2.28.0.573.gec6564704b

