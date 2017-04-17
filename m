Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9E2420A04
	for <e@80x24.org>; Mon, 17 Apr 2017 16:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756874AbdDQQSD convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 17 Apr 2017 12:18:03 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:42817 "EHLO
        homiemail-a18.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753549AbdDQQSB (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Apr 2017 12:18:01 -0400
Received: from homiemail-a18.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a18.g.dreamhost.com (Postfix) with ESMTP id 9AFBB258065;
        Mon, 17 Apr 2017 09:18:00 -0700 (PDT)
Received: from localhost.localdomain (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a18.g.dreamhost.com (Postfix) with ESMTPSA id 01F1C258062;
        Mon, 17 Apr 2017 09:17:59 -0700 (PDT)
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, l.s.r@web.de, jrnieder@gmail.com,
        David Turner <dturner@twosigma.com>
Subject: [PATCH v2] xgethostname: handle long hostnames
Date:   Mon, 17 Apr 2017 12:17:48 -0400
Message-Id: <20170417161748.31231-1-dturner@twosigma.com>
X-Mailer: git-send-email 2.11.GIT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the full hostname doesn't fit in the buffer supplied to
gethostname, POSIX does not specify whether the buffer will be
null-terminated, so to be safe, we should do it ourselves.  Introduce
new function, xgethostname, which ensures that there is always a \0
at the end of the buffer.

Always use a consistent buffer size when calling xgethostname.  We use
HOST_NAME_MAX + 1.  When this is unavailable, we fall back to 256, a
decision we previously made in daemon.c, but which we now move to
git-compat-util.h so that it can be used everywhere.

Signed-off-by: David Turner <dturner@twosigma.com>
---

This version addresses some comments by René Scharfe.  René, we're
still silently truncating, but as I noted in my message to Jonathan:
Looking at the users of this function, I think most would be happier
with a truncated buffer than an error:

* gc.c: used to see if we are the same machine as the machine that
locked the repo. it is unlikely that two machines have hostnames that
differ only in the 256th-or-above character, and it would be weird to
fail to gc just because our hostname is long.
* fetch-pack.c, receive-pack.c: similar to gc.c; the hostname is a note
in the .keep file for human consumption only
* ident.c: used to make up a fake email address. On my laptop,
gethostname returns "corey" (no domain part), so the email address is
not likely to be valid anyway.

 builtin/gc.c           |  6 +++---
 builtin/receive-pack.c |  4 ++--
 daemon.c               |  4 ----
 fetch-pack.c           |  4 ++--
 git-compat-util.h      |  6 ++++++
 ident.c                |  4 ++--
 wrapper.c              | 13 +++++++++++++
 7 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c2c61a57bb..5de0209c59 100644
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
@@ -250,14 +250,14 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 		/* already locked */
 		return NULL;
 
-	if (gethostname(my_host, sizeof(my_host)))
+	if (xgethostname(my_host, sizeof(my_host)))
 		xsnprintf(my_host, sizeof(my_host), "unknown");
 
 	pidfile_path = git_pathdup("gc.pid");
 	fd = hold_lock_file_for_update(&lock, pidfile_path,
 				       LOCK_DIE_ON_ERROR);
 	if (!force) {
-		static char locking_host[128];
+		static char locking_host[HOST_NAME_MAX + 1];
 		int should_exit;
 		fp = fopen(pidfile_path, "r");
 		memset(locking_host, 0, sizeof(locking_host));
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index aca9c33d8d..0ca423a711 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1695,12 +1695,12 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		if (status)
 			return "unpack-objects abnormal exit";
 	} else {
-		char hostname[256];
+		char hostname[HOST_NAME_MAX + 1];
 
 		argv_array_pushl(&child.args, "index-pack",
 				 "--stdin", hdr_arg, NULL);
 
-		if (gethostname(hostname, sizeof(hostname)))
+		if (xgethostname(hostname, sizeof(hostname)))
 			xsnprintf(hostname, sizeof(hostname), "localhost");
 		argv_array_pushf(&child.args,
 				 "--keep=receive-pack %"PRIuMAX" on %s",
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
index d07d85ce30..15d59a0440 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -802,8 +802,8 @@ static int get_pack(struct fetch_pack_args *args,
 		if (args->use_thin_pack)
 			argv_array_push(&cmd.args, "--fix-thin");
 		if (args->lock_pack || unpack_limit) {
-			char hostname[256];
-			if (gethostname(hostname, sizeof(hostname)))
+			char hostname[HOST_NAME_MAX + 1];
+			if (xgethostname(hostname, sizeof(hostname)))
 				xsnprintf(hostname, sizeof(hostname), "localhost");
 			argv_array_pushf(&cmd.args,
 					"--keep=fetch-pack %"PRIuMAX " on %s",
diff --git a/git-compat-util.h b/git-compat-util.h
index 8a4a3f85e7..bd04564a69 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -884,6 +884,12 @@ static inline size_t xsize_t(off_t len)
 __attribute__((format (printf, 3, 4)))
 extern int xsnprintf(char *dst, size_t max, const char *fmt, ...);
 
+#ifndef HOST_NAME_MAX
+#define HOST_NAME_MAX 256
+#endif
+
+extern int xgethostname(char *buf, size_t len);
+
 /* in ctype.c, for kwset users */
 extern const unsigned char tolower_trans_tbl[256];
 
diff --git a/ident.c b/ident.c
index c0364fe3a1..bea871c8e0 100644
--- a/ident.c
+++ b/ident.c
@@ -120,9 +120,9 @@ static int canonical_name(const char *host, struct strbuf *out)
 
 static void add_domainname(struct strbuf *out, int *is_bogus)
 {
-	char buf[1024];
+	char buf[HOST_NAME_MAX + 1];
 
-	if (gethostname(buf, sizeof(buf))) {
+	if (xgethostname(buf, sizeof(buf))) {
 		warning_errno("cannot get host name");
 		strbuf_addstr(out, "(none)");
 		*is_bogus = 1;
diff --git a/wrapper.c b/wrapper.c
index 0542fc7582..d837417709 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -655,3 +655,16 @@ void sleep_millisec(int millisec)
 {
 	poll(NULL, 0, millisec);
 }
+
+int xgethostname(char *buf, size_t len)
+{
+	/*
+	 * If the full hostname doesn't fit in buf, POSIX does not
+	 * specify whether the buffer will be null-terminated, so to
+	 * be safe, do it ourselves.
+	 */
+	int ret = gethostname(buf, len);
+	if (!ret)
+		buf[len - 1] = 0;
+	return ret;
+}
-- 
2.11.GIT

