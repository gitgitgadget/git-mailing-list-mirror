Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F162D207B9
	for <e@80x24.org>; Tue, 18 Apr 2017 21:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755053AbdDRV6B convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 18 Apr 2017 17:58:01 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:48066 "EHLO
        homiemail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753045AbdDRV55 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 18 Apr 2017 17:57:57 -0400
Received: from homiemail-a12.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a12.g.dreamhost.com (Postfix) with ESMTP id E0C2C26206A;
        Tue, 18 Apr 2017 14:57:56 -0700 (PDT)
Received: from localhost.localdomain (207-38-252-131.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.252.131])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a12.g.dreamhost.com (Postfix) with ESMTPSA id 5E350262065;
        Tue, 18 Apr 2017 14:57:56 -0700 (PDT)
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org
Cc:     l.s.r@web.de, David Turner <dturner@twosigma.com>
Subject: [PATCH v3 1/2] use HOST_NAME_MAX to size buffers for gethostname(2)
Date:   Tue, 18 Apr 2017 17:57:42 -0400
Message-Id: <20170418215743.18406-2-dturner@twosigma.com>
X-Mailer: git-send-email 2.11.GIT
In-Reply-To: <20170418215743.18406-1-dturner@twosigma.com>
References: <20170418215743.18406-1-dturner@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: René Scharfe <l.s.r@web.de>

POSIX limits the length of host names to HOST_NAME_MAX.  Export the
fallback definition from daemon.c and use this constant to make all
buffers used with gethostname(2) big enough for any possible result
and a terminating NUL.

Inspired-by: David Turner <dturner@twosigma.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
Signed-off-by: David Turner <dturner@twosigma.com>
---
 builtin/gc.c           | 10 +++++++---
 builtin/receive-pack.c |  2 +-
 daemon.c               |  4 ----
 fetch-pack.c           |  2 +-
 git-compat-util.h      |  4 ++++
 ident.c                |  2 +-
 6 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c2c61a57bb..4c4a36e2b5 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -238,7 +238,7 @@ static int need_to_gc(void)
 static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 {
 	static struct lock_file lock;
-	char my_host[128];
+	char my_host[HOST_NAME_MAX + 1];
 	struct strbuf sb = STRBUF_INIT;
 	struct stat st;
 	uintmax_t pid;
@@ -257,8 +257,12 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	fd = hold_lock_file_for_update(&lock, pidfile_path,
 				       LOCK_DIE_ON_ERROR);
 	if (!force) {
-		static char locking_host[128];
+		static char locking_host[HOST_NAME_MAX + 1];
+		static char *scan_fmt;
 		int should_exit;
+
+		if (!scan_fmt)
+			scan_fmt = xstrfmt("%s %%%dc", "%"SCNuMAX, HOST_NAME_MAX);
 		fp = fopen(pidfile_path, "r");
 		memset(locking_host, 0, sizeof(locking_host));
 		should_exit =
@@ -274,7 +278,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 			 * running.
 			 */
 			time(NULL) - st.st_mtime <= 12 * 3600 &&
-			fscanf(fp, "%"SCNuMAX" %127c", &pid, locking_host) == 2 &&
+			fscanf(fp, scan_fmt, &pid, locking_host) == 2 &&
 			/* be gentle to concurrent "gc" on remote hosts */
 			(strcmp(locking_host, my_host) || !kill(pid, 0) || errno == EPERM);
 		if (fp != NULL)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index aca9c33d8d..2612efad3d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1695,7 +1695,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		if (status)
 			return "unpack-objects abnormal exit";
 	} else {
-		char hostname[256];
+		char hostname[HOST_NAME_MAX + 1];
 
 		argv_array_pushl(&child.args, "index-pack",
 				 "--stdin", hdr_arg, NULL);
diff --git a/daemon.c b/daemon.c
index 473e6b6b63..1503e1ed6f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -4,10 +4,6 @@
 #include "strbuf.h"
 #include "string-list.h"
 
-#ifndef HOST_NAME_MAX
-#define HOST_NAME_MAX 256
-#endif
-
 #ifdef NO_INITGROUPS
 #define initgroups(x, y) (0) /* nothing */
 #endif
diff --git a/fetch-pack.c b/fetch-pack.c
index d07d85ce30..055f568775 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -802,7 +802,7 @@ static int get_pack(struct fetch_pack_args *args,
 		if (args->use_thin_pack)
 			argv_array_push(&cmd.args, "--fix-thin");
 		if (args->lock_pack || unpack_limit) {
-			char hostname[256];
+			char hostname[HOST_NAME_MAX + 1];
 			if (gethostname(hostname, sizeof(hostname)))
 				xsnprintf(hostname, sizeof(hostname), "localhost");
 			argv_array_pushf(&cmd.args,
diff --git a/git-compat-util.h b/git-compat-util.h
index 8a4a3f85e7..46f3abe401 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -884,6 +884,10 @@ static inline size_t xsize_t(off_t len)
 __attribute__((format (printf, 3, 4)))
 extern int xsnprintf(char *dst, size_t max, const char *fmt, ...);
 
+#ifndef HOST_NAME_MAX
+#define HOST_NAME_MAX 256
+#endif
+
 /* in ctype.c, for kwset users */
 extern const unsigned char tolower_trans_tbl[256];
 
diff --git a/ident.c b/ident.c
index c0364fe3a1..556851cf94 100644
--- a/ident.c
+++ b/ident.c
@@ -120,7 +120,7 @@ static int canonical_name(const char *host, struct strbuf *out)
 
 static void add_domainname(struct strbuf *out, int *is_bogus)
 {
-	char buf[1024];
+	char buf[HOST_NAME_MAX + 1];
 
 	if (gethostname(buf, sizeof(buf))) {
 		warning_errno("cannot get host name");
-- 
2.11.GIT

