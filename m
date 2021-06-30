Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C4AC11F67
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 00:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C8961D5D
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 00:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbhF3AEA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 20:04:00 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:58426 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233056AbhF3AEA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 20:04:00 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5DF731F8C6;
        Wed, 30 Jun 2021 00:01:32 +0000 (UTC)
Date:   Wed, 30 Jun 2021 00:01:32 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v2] xmmap: inform Linux users of tuning knobs on ENOMEM
Message-ID: <20210630000132.GA2653@dcvr>
References: <20210629081108.28657-1-e@80x24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210629081108.28657-1-e@80x24.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is now down to a single patch.

I wanted to make things more transparent to users without
privileges to raise sys.vm.max_map_count and/or RLIMIT_DATA;
but it doesn't seem possible to account for libc/zlib/etc. doing
mmap() without our knowledge (usually via malloc).

So I think giving users some information to feed their sysadmins
is the best we can do in this situation:

--------------8<-----------
Subject: [PATCH] xmmap: inform Linux users of tuning knobs on ENOMEM

Linux users may benefit from additional information on how to
avoid ENOMEM from mmap despite the system having enough RAM to
accomodate them.  We can't reliably unmap pack windows to work
around the issue since malloc and other library routines may
mmap without our knowledge.

Signed-off-by: Eric Wong <e@80x24.org>
---
 config.c          |  3 ++-
 git-compat-util.h |  1 +
 object-file.c     | 16 +++++++++++++++-
 packfile.c        |  4 ++--
 read-cache.c      |  3 ++-
 5 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/config.c b/config.c
index f9c400ad30..79ae9f2dea 100644
--- a/config.c
+++ b/config.c
@@ -3051,7 +3051,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		if (contents == MAP_FAILED) {
 			if (errno == ENODEV && S_ISDIR(st.st_mode))
 				errno = EISDIR;
-			error_errno(_("unable to mmap '%s'"), config_filename);
+			error_errno(_("unable to mmap '%s'%s"),
+					config_filename, mmap_os_err());
 			ret = CONFIG_INVALID_FILE;
 			contents = NULL;
 			goto out_free;
diff --git a/git-compat-util.h b/git-compat-util.h
index fb6e9af76b..fa6dd92219 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -876,6 +876,7 @@ char *xstrndup(const char *str, size_t len);
 void *xrealloc(void *ptr, size_t size);
 void *xcalloc(size_t nmemb, size_t size);
 void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
+const char *mmap_os_err(void);
 void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_t offset);
 int xopen(const char *path, int flags, ...);
 ssize_t xread(int fd, void *buf, size_t len);
diff --git a/object-file.c b/object-file.c
index f233b440b2..b9c3219793 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1023,12 +1023,26 @@ void *xmmap_gently(void *start, size_t length,
 	return ret;
 }
 
+const char *mmap_os_err(void)
+{
+	static const char blank[] = "";
+#if defined(__linux__)
+	if (errno == ENOMEM) {
+		/* this continues an existing error message: */
+		static const char enomem[] =
+", check sys.vm.max_map_count and/or RLIMIT_DATA";
+		return enomem;
+	}
+#endif /* OS-specific bits */
+	return blank;
+}
+
 void *xmmap(void *start, size_t length,
 	int prot, int flags, int fd, off_t offset)
 {
 	void *ret = xmmap_gently(start, length, prot, flags, fd, offset);
 	if (ret == MAP_FAILED)
-		die_errno(_("mmap failed"));
+		die_errno(_("mmap failed%s"), mmap_os_err());
 	return ret;
 }
 
diff --git a/packfile.c b/packfile.c
index 755aa7aec5..9ef6d98292 100644
--- a/packfile.c
+++ b/packfile.c
@@ -652,8 +652,8 @@ unsigned char *use_pack(struct packed_git *p,
 				PROT_READ, MAP_PRIVATE,
 				p->pack_fd, win->offset);
 			if (win->base == MAP_FAILED)
-				die_errno("packfile %s cannot be mapped",
-					  p->pack_name);
+				die_errno(_("packfile %s cannot be mapped%s"),
+					  p->pack_name, mmap_os_err());
 			if (!win->offset && win->len == p->pack_size
 				&& !p->do_not_close)
 				close_pack_fd(p);
diff --git a/read-cache.c b/read-cache.c
index 77961a3885..a80902155c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2236,7 +2236,8 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 
 	mmap = xmmap_gently(NULL, mmap_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (mmap == MAP_FAILED)
-		die_errno(_("%s: unable to map index file"), path);
+		die_errno(_("%s: unable to map index file%s"), path,
+			mmap_os_err());
 	close(fd);
 
 	hdr = (const struct cache_header *)mmap;
-- 
It's probably not safe to feed sysadmins after midnight, though :>
