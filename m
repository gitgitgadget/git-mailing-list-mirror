Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B0D520960
	for <e@80x24.org>; Thu, 13 Apr 2017 19:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752423AbdDMTXq (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 15:23:46 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:38246 "EHLO
        homiemail-a22.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751808AbdDMTXp (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Apr 2017 15:23:45 -0400
Received: from homiemail-a22.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a22.g.dreamhost.com (Postfix) with ESMTP id 9386011406A;
        Thu, 13 Apr 2017 12:23:44 -0700 (PDT)
Received: from localhost.localdomain (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a22.g.dreamhost.com (Postfix) with ESMTPSA id 459FE114066;
        Thu, 13 Apr 2017 12:23:44 -0700 (PDT)
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH] xgethostname: handle long hostnames
Date:   Thu, 13 Apr 2017 15:23:35 -0400
Message-Id: <20170413192335.20679-1-dturner@twosigma.com>
X-Mailer: git-send-email 2.11.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the full hostname doesn't fit in the buffer supplied to
gethostname, POSIX does not specify whether the buffer will be
null-terminated, so to be safe, we should do it ourselves.  Introduce
new function, xgethostname, which ensures that there is always a \0
at the end of the buffer.

Signed-off-by: David Turner <dturner@twosigma.com>
---
 builtin/gc.c           |  2 +-
 builtin/receive-pack.c |  2 +-
 fetch-pack.c           |  2 +-
 git-compat-util.h      |  2 ++
 ident.c                |  2 +-
 wrapper.c              | 13 +++++++++++++
 6 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c2c61a57bb..5633483f56 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -250,7 +250,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 		/* already locked */
 		return NULL;
 
-	if (gethostname(my_host, sizeof(my_host)))
+	if (xgethostname(my_host, sizeof(my_host)))
 		xsnprintf(my_host, sizeof(my_host), "unknown");
 
 	pidfile_path = git_pathdup("gc.pid");
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index aca9c33d8d..fb62a94bc3 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1700,7 +1700,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		argv_array_pushl(&child.args, "index-pack",
 				 "--stdin", hdr_arg, NULL);
 
-		if (gethostname(hostname, sizeof(hostname)))
+		if (xgethostname(hostname, sizeof(hostname)))
 			xsnprintf(hostname, sizeof(hostname), "localhost");
 		argv_array_pushf(&child.args,
 				 "--keep=receive-pack %"PRIuMAX" on %s",
diff --git a/fetch-pack.c b/fetch-pack.c
index d07d85ce30..a899441c34 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -803,7 +803,7 @@ static int get_pack(struct fetch_pack_args *args,
 			argv_array_push(&cmd.args, "--fix-thin");
 		if (args->lock_pack || unpack_limit) {
 			char hostname[256];
-			if (gethostname(hostname, sizeof(hostname)))
+			if (xgethostname(hostname, sizeof(hostname)))
 				xsnprintf(hostname, sizeof(hostname), "localhost");
 			argv_array_pushf(&cmd.args,
 					"--keep=fetch-pack %"PRIuMAX " on %s",
diff --git a/git-compat-util.h b/git-compat-util.h
index 8a4a3f85e7..e49b65c235 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -884,6 +884,8 @@ static inline size_t xsize_t(off_t len)
 __attribute__((format (printf, 3, 4)))
 extern int xsnprintf(char *dst, size_t max, const char *fmt, ...);
 
+extern int xgethostname(char *buf, size_t len);
+
 /* in ctype.c, for kwset users */
 extern const unsigned char tolower_trans_tbl[256];
 
diff --git a/ident.c b/ident.c
index c0364fe3a1..7de9f47c41 100644
--- a/ident.c
+++ b/ident.c
@@ -122,7 +122,7 @@ static void add_domainname(struct strbuf *out, int *is_bogus)
 {
 	char buf[1024];
 
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

