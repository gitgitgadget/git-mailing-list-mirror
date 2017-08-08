Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6789920899
	for <e@80x24.org>; Tue,  8 Aug 2017 19:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752311AbdHHTc7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 15:32:59 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:37792 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752265AbdHHTc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 15:32:57 -0400
Received: by mail-pg0-f51.google.com with SMTP id y129so18622032pgy.4
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 12:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=P2swBv1soECalB0lHLz9Pp4UXHsYo91wz01n0H9/kUY=;
        b=fOILsla+1AmPUrmotlm80RklNLoslV63ny9+4egf6JlnBtLiOiirKEXx5e1i9nvMKb
         94GD3VZJmhctUFEa+Vz33sFLwsPc4tc60owAAeDgX6mf29XxYjZXp+bXAyVPWGs637th
         fKBR7oSNZqWMBf3UrXOhy6ODtGnnEOr2dJZBtgPG4zGfR4+qCi1UMJgzzK5UgJhcZBab
         NqGr30L78vbhDHcRz+B3k/Oz5V8bjZuGwvWXC2npBVGLSIlF3xwek8Fsoru0SQJAD31A
         w02v1VD+kpH0GQcKzC9rqrEGzYYIYdsZaY7mo/lJdP9AAVB+V776jjyDCmZXmezlgCyK
         7w9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=P2swBv1soECalB0lHLz9Pp4UXHsYo91wz01n0H9/kUY=;
        b=C7BSkmnesHyyyasXy0P59MuIZ/K+j/Fk1Nc0VjGmX44cwfRLnaElzgLt1nfJ/roTa9
         h41cUoLgpHPxFD4EXUzT68wEe28QF8jVV/TIFDaO9tyRCWOLqW6kan5lx0pbJgtReMSM
         C0pNIa3Eh9f+asofwrG1zkQLX2MePjVeJLTPghSENhIoRG+oyN80Um7CY1RaoUuo/dxh
         aIyntsRsJ8dS0tfM8RrdTUMaK0BhXo/N2/ghmtuGTbSelyE/qwvLUKmp3LIIKAtVK/tu
         c1Z3Uvmu2jC6fF4NPhmjQIsnf8Cl2y+pKinFdrVkDxyeJ+lD2mSUcgqIZ/HOq4lGBkgo
         IsHw==
X-Gm-Message-State: AHYfb5gBOrw1y2Ekm/INacHsdS00JFFDVXyIhpcK4euU+I6gGg1nJUPC
        nbTkMyFy3kXsez907Zws4w==
X-Received: by 10.99.100.193 with SMTP id y184mr5274092pgb.364.1502220776760;
        Tue, 08 Aug 2017 12:32:56 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id k186sm4332547pfc.173.2017.08.08.12.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 12:32:55 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC PATCH 06/10] pack: move pack-closing functions
Date:   Tue,  8 Aug 2017 12:32:36 -0700
Message-Id: <398f3284e21114a186400bd5c010823aa1ac72ef.1502220307.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502220307.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502220307.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function close_pack_fd() needs to be temporarily made global. Its
scope will be restored to static in a subsequent commit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
In doing this, I discovered that some builtins close the packs even
though they, in theory, should not know anything about how objects are
stored. Can we remove those calls? (The tests pass with those calls
removed.)
---
 builtin/am.c    |  1 +
 builtin/clone.c |  1 +
 builtin/fetch.c |  1 +
 builtin/merge.c |  1 +
 cache.h         |  8 --------
 pack.c          | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 pack.h          |  9 +++++++++
 sha1_file.c     | 55 -------------------------------------------------------
 8 files changed, 67 insertions(+), 63 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index c973bd96d..c38dd10a3 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -31,6 +31,7 @@
 #include "mailinfo.h"
 #include "apply.h"
 #include "string-list.h"
+#include "pack.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
diff --git a/builtin/clone.c b/builtin/clone.c
index 08b5cc433..53410a45d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -25,6 +25,7 @@
 #include "remote.h"
 #include "run-command.h"
 #include "connected.h"
+#include "pack.h"
 
 /*
  * Overall FIXMEs:
diff --git a/builtin/fetch.c b/builtin/fetch.c
index c87e59f3b..196a3bfc4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -17,6 +17,7 @@
 #include "connected.h"
 #include "argv-array.h"
 #include "utf8.h"
+#include "pack.h"
 
 static const char * const builtin_fetch_usage[] = {
 	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
diff --git a/builtin/merge.c b/builtin/merge.c
index 900bafdb4..9cff4b276 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -32,6 +32,7 @@
 #include "gpg-interface.h"
 #include "sequencer.h"
 #include "string-list.h"
+#include "pack.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
diff --git a/cache.h b/cache.h
index 5d6839525..25a21a61f 100644
--- a/cache.h
+++ b/cache.h
@@ -1637,15 +1637,7 @@ extern int odb_mkstemp(struct strbuf *template, const char *pattern);
  */
 extern int odb_pack_keep(const char *name);
 
-/*
- * munmap the index file for the specified packfile (if it is
- * currently mmapped).
- */
-extern void close_pack_index(struct packed_git *);
-
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
-extern void close_pack_windows(struct packed_git *);
-extern void close_all_packs(void);
 extern void unuse_pack(struct pack_window **);
 extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
diff --git a/pack.c b/pack.c
index 8daa74ad1..c8e2dbdee 100644
--- a/pack.c
+++ b/pack.c
@@ -257,3 +257,57 @@ void release_pack_memory(size_t need)
 	while (need >= (cur - pack_mapped) && unuse_one_window(NULL))
 		; /* nothing */
 }
+
+void close_pack_windows(struct packed_git *p)
+{
+	while (p->windows) {
+		struct pack_window *w = p->windows;
+
+		if (w->inuse_cnt)
+			die("pack '%s' still has open windows to it",
+			    p->pack_name);
+		munmap(w->base, w->len);
+		pack_mapped -= w->len;
+		pack_open_windows--;
+		p->windows = w->next;
+		free(w);
+	}
+}
+
+int close_pack_fd(struct packed_git *p)
+{
+	if (p->pack_fd < 0)
+		return 0;
+
+	close(p->pack_fd);
+	pack_open_fds--;
+	p->pack_fd = -1;
+
+	return 1;
+}
+
+void close_pack_index(struct packed_git *p)
+{
+	if (p->index_data) {
+		munmap((void *)p->index_data, p->index_size);
+		p->index_data = NULL;
+	}
+}
+
+static void close_pack(struct packed_git *p)
+{
+	close_pack_windows(p);
+	close_pack_fd(p);
+	close_pack_index(p);
+}
+
+void close_all_packs(void)
+{
+	struct packed_git *p;
+
+	for (p = packed_git; p; p = p->next)
+		if (p->do_not_close)
+			die("BUG: want to close pack marked 'do-not-close'");
+		else
+			close_pack(p);
+}
diff --git a/pack.h b/pack.h
index c16220586..fd4668528 100644
--- a/pack.h
+++ b/pack.h
@@ -147,4 +147,13 @@ extern int unuse_one_window(struct packed_git *current);
 
 extern void release_pack_memory(size_t);
 
+extern void close_pack_windows(struct packed_git *);
+extern int close_pack_fd(struct packed_git *);
+/*
+ * munmap the index file for the specified packfile (if it is
+ * currently mmapped).
+ */
+extern void close_pack_index(struct packed_git *);
+extern void close_all_packs(void);
+
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index 644876e4e..e2927244f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -717,53 +717,6 @@ void *xmmap(void *start, size_t length,
 	return ret;
 }
 
-void close_pack_windows(struct packed_git *p)
-{
-	while (p->windows) {
-		struct pack_window *w = p->windows;
-
-		if (w->inuse_cnt)
-			die("pack '%s' still has open windows to it",
-			    p->pack_name);
-		munmap(w->base, w->len);
-		pack_mapped -= w->len;
-		pack_open_windows--;
-		p->windows = w->next;
-		free(w);
-	}
-}
-
-static int close_pack_fd(struct packed_git *p)
-{
-	if (p->pack_fd < 0)
-		return 0;
-
-	close(p->pack_fd);
-	pack_open_fds--;
-	p->pack_fd = -1;
-
-	return 1;
-}
-
-static void close_pack(struct packed_git *p)
-{
-	close_pack_windows(p);
-	close_pack_fd(p);
-	close_pack_index(p);
-}
-
-void close_all_packs(void)
-{
-	struct packed_git *p;
-
-	for (p = packed_git; p; p = p->next)
-		if (p->do_not_close)
-			die("BUG: want to close pack marked 'do-not-close'");
-		else
-			close_pack(p);
-}
-
-
 /*
  * The LRU pack is the one with the oldest MRU window, preferring packs
  * with no used windows, or the oldest mtime if it has no windows allocated.
@@ -846,14 +799,6 @@ void unuse_pack(struct pack_window **w_cursor)
 	}
 }
 
-void close_pack_index(struct packed_git *p)
-{
-	if (p->index_data) {
-		munmap((void *)p->index_data, p->index_size);
-		p->index_data = NULL;
-	}
-}
-
 static unsigned int get_max_fd_limit(void)
 {
 #ifdef RLIMIT_NOFILE
-- 
2.14.0.434.g98096fd7a8-goog

