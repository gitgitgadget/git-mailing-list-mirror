Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C951FC433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 01:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiJRBFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 21:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiJRBFR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 21:05:17 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CA97DF52
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 18:05:13 -0700 (PDT)
Received: (qmail 28777 invoked by uid 109); 18 Oct 2022 01:05:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Oct 2022 01:05:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13409 invoked by uid 111); 18 Oct 2022 01:05:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Oct 2022 21:05:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Oct 2022 21:05:12 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 04/12] mark unused parameters in trivial compat functions
Message-ID: <Y037yNWgnAEhsL+k@coredump.intra.peff.net>
References: <Y036whEorZV0rOgB@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y036whEorZV0rOgB@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a platform feature isn't available or in use, we sometimes
conditionally compile empty or trivial functions to turn these into
noops. We need to annotate their parameters so that -Wunused-parameters
won't complain about them.

Note that there are many more of these in compat/mingw.h, but we'll
leave them for now, as there's some trickery required to get the UNUSED
macro available there.

Signed-off-by: Jeff King <peff@peff.net>
---
 compat/nonblock.c |  2 +-
 exec-cmd.c        |  2 +-
 git-compat-util.h | 16 ++++++++++------
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/compat/nonblock.c b/compat/nonblock.c
index 9694ebdb1d..5b51195c32 100644
--- a/compat/nonblock.c
+++ b/compat/nonblock.c
@@ -41,7 +41,7 @@ int enable_pipe_nonblock(int fd)
 
 #else
 
-int enable_pipe_nonblock(int fd)
+int enable_pipe_nonblock(int fd UNUSED)
 {
 	errno = ENOSYS;
 	return -1;
diff --git a/exec-cmd.c b/exec-cmd.c
index eeb2ee52b8..0232bbc990 100644
--- a/exec-cmd.c
+++ b/exec-cmd.c
@@ -252,7 +252,7 @@ static const char *system_prefix(void)
  * This is called during initialization, but No work needs to be done here when
  * runtime prefix is not being used.
  */
-void git_resolve_executable_dir(const char *argv0)
+void git_resolve_executable_dir(const char *argv0 UNUSED)
 {
 }
 
diff --git a/git-compat-util.h b/git-compat-util.h
index ea53ea4a78..a76d0526f7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -314,7 +314,9 @@ typedef unsigned long uintptr_t;
 #ifdef PRECOMPOSE_UNICODE
 #include "compat/precompose_utf8.h"
 #else
-static inline const char *precompose_argv_prefix(int argc, const char **argv, const char *prefix)
+static inline const char *precompose_argv_prefix(int argc UNUSED,
+						 const char **argv UNUSED,
+						 const char *prefix)
 {
 	return prefix;
 }
@@ -339,7 +341,9 @@ struct itimerval {
 #endif
 
 #ifdef NO_SETITIMER
-static inline int setitimer(int which, const struct itimerval *value, struct itimerval *newvalue) {
+static inline int setitimer(int which UNUSED,
+			    const struct itimerval *value UNUSED,
+			    struct itimerval *newvalue UNUSED) {
 	return 0; /* pretend success */
 }
 #endif
@@ -424,15 +428,15 @@ int lstat_cache_aware_rmdir(const char *path);
 #endif
 
 #ifndef has_dos_drive_prefix
-static inline int git_has_dos_drive_prefix(const char *path)
+static inline int git_has_dos_drive_prefix(const char *path UNUSED)
 {
 	return 0;
 }
 #define has_dos_drive_prefix git_has_dos_drive_prefix
 #endif
 
 #ifndef skip_dos_drive_prefix
-static inline int git_skip_dos_drive_prefix(char **path)
+static inline int git_skip_dos_drive_prefix(char **path UNUSED)
 {
 	return 0;
 }
@@ -1467,11 +1471,11 @@ int open_nofollow(const char *path, int flags);
 #endif
 
 #ifndef _POSIX_THREAD_SAFE_FUNCTIONS
-static inline void flockfile(FILE *fh)
+static inline void flockfile(FILE *fh UNUSED)
 {
 	; /* nothing */
 }
-static inline void funlockfile(FILE *fh)
+static inline void funlockfile(FILE *fh UNUSED)
 {
 	; /* nothing */
 }
-- 
2.38.0.371.g300879f34e

