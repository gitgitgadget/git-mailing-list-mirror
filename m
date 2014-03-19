From: szager@chromium.org (Stefan Zager)
Subject: [PATCH] Enable index-pack threading in msysgit.
Date: Wed, 19 Mar 2014 14:35:56 -0700 (PDT)
Message-ID: <20140319213556.2FC3D4062B@wince.sfo.corp.google.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Mar 19 22:36:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQO9b-0006jD-Gr
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 22:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754975AbaCSVf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 17:35:59 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:48868 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753953AbaCSVf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 17:35:57 -0400
Received: by mail-ob0-f201.google.com with SMTP id gq1so1799261obb.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 14:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:message-id:date:from;
        bh=FepUbB1m96otOshtTpF6yUal04x527haIBzreQikSgI=;
        b=Qsnp9CjvLrp4lROf+753u0piXKnshAR9ksnMZx8Vp74Sb3ant/6odVswLRq/I6VxHT
         PVDpBMxPwqFLzAhmxNp8N4jl+aZsP4rVb58hr8BZvusY1So8AKNyvfgNO+W/4507N9+T
         Urhk27JBRdG6TvdthWv6Dh3xBsJG6r9SM7JeQPgJOXsOEAeYiUCGr6UozZtUOOkNfxvb
         ms78DHdFnM1CuSWPbr7b7VCvt8KxCxI4RMhmEQLY7fsjpZI0Ibxu861XmmR3ezYQmBBQ
         N5VyMurVw3MTDrwJ+hLRqYmchklJoiMqq0qFtgfnR26P4jgvYLCfHV0AVvRr1sIcLn5/
         /Bvg==
X-Gm-Message-State: ALoCoQmJbdRpA7pQzaKGyFrtyVVu880+Q7lqGcxING98WytqnMBoW97pQFdcppdC/A4NuG1BuB9m
X-Received: by 10.43.4.4 with SMTP id oa4mr13584621icb.2.1395264957329;
        Wed, 19 Mar 2014 14:35:57 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id x29si3677192yha.0.2014.03.19.14.35.57
        for <git@vger.kernel.org>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Mar 2014 14:35:57 -0700 (PDT)
Received: from wince.sfo.corp.google.com (wince.sfo.corp.google.com [172.31.53.43])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1A0CE31C1F4
	for <git@vger.kernel.org>; Wed, 19 Mar 2014 14:35:57 -0700 (PDT)
Received: by wince.sfo.corp.google.com (Postfix, from userid 138314)
	id 2FC3D4062B; Wed, 19 Mar 2014 14:35:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244498>

This adds a Windows implementation of pread.  Note that it is NOT
safe to intersperse calls to read() and pread() on a file
descriptor.  According to the ReadFile spec, using the 'overlapped'
argument should not affect the implicit position pointer of the
descriptor.  Experiments have shown that this is, in fact, a lie.

To accomodate that fact, this change also incorporates:

http://article.gmane.org/gmane.comp.version-control.git/196042

... which gives each index-pack thread its own file descriptor.

Signed-off-by: Stefan Zager <szager@chromium.org>
---
 builtin/index-pack.c | 30 ++++++++++++++++++++----------
 compat/mingw.c       | 37 ++++++++++++++++++++++++++++++++++++-
 compat/mingw.h       |  3 +++
 config.mak.uname     |  1 -
 4 files changed, 59 insertions(+), 12 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2f37a38..63b8b0e 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -40,17 +40,17 @@ struct base_data {
 	int ofs_first, ofs_last;
 };
 
-#if !defined(NO_PTHREADS) && defined(NO_THREAD_SAFE_PREAD)
-/* pread() emulation is not thread-safe. Disable threading. */
-#define NO_PTHREADS
-#endif
-
 struct thread_local {
 #ifndef NO_PTHREADS
 	pthread_t thread;
 #endif
 	struct base_data *base_cache;
 	size_t base_cache_used;
+    /*
+     * To accomodate platforms that have pthreads, but don't have a
+     * thread-safe pread, give each thread its own file descriptor.
+     */
+	int pack_fd;
 };
 
 /*
@@ -91,7 +91,8 @@ static off_t consumed_bytes;
 static unsigned deepest_delta;
 static git_SHA_CTX input_ctx;
 static uint32_t input_crc32;
-static int input_fd, output_fd, pack_fd;
+static const char *curr_pack;
+static int input_fd, output_fd;
 
 #ifndef NO_PTHREADS
 
@@ -134,6 +135,7 @@ static inline void unlock_mutex(pthread_mutex_t *mutex)
  */
 static void init_thread(void)
 {
+	int i;
 	init_recursive_mutex(&read_mutex);
 	pthread_mutex_init(&counter_mutex, NULL);
 	pthread_mutex_init(&work_mutex, NULL);
@@ -141,11 +143,17 @@ static void init_thread(void)
 		pthread_mutex_init(&deepest_delta_mutex, NULL);
 	pthread_key_create(&key, NULL);
 	thread_data = xcalloc(nr_threads, sizeof(*thread_data));
+	for (i = 0; i < nr_threads; i++) {
+		thread_data[i].pack_fd = open(curr_pack, O_RDONLY);
+		if (thread_data[i].pack_fd == -1)
+			die_errno("unable to open %s", curr_pack);
+	}
 	threads_active = 1;
 }
 
 static void cleanup_thread(void)
 {
+	int i;
 	if (!threads_active)
 		return;
 	threads_active = 0;
@@ -155,6 +163,8 @@ static void cleanup_thread(void)
 	if (show_stat)
 		pthread_mutex_destroy(&deepest_delta_mutex);
 	pthread_key_delete(key);
+	for (i = 0; i < nr_threads; i++)
+		close(thread_data[i].pack_fd);
 	free(thread_data);
 }
 
@@ -288,13 +298,13 @@ static const char *open_pack_file(const char *pack_name)
 			output_fd = open(pack_name, O_CREAT|O_EXCL|O_RDWR, 0600);
 		if (output_fd < 0)
 			die_errno(_("unable to create '%s'"), pack_name);
-		pack_fd = output_fd;
+		nothread_data.pack_fd = output_fd;
 	} else {
 		input_fd = open(pack_name, O_RDONLY);
 		if (input_fd < 0)
 			die_errno(_("cannot open packfile '%s'"), pack_name);
 		output_fd = -1;
-		pack_fd = input_fd;
+		nothread_data.pack_fd = input_fd;
 	}
 	git_SHA1_Init(&input_ctx);
 	return pack_name;
@@ -542,7 +552,7 @@ static void *unpack_data(struct object_entry *obj,
 
 	do {
 		ssize_t n = (len < 64*1024) ? len : 64*1024;
-		n = pread(pack_fd, inbuf, n, from);
+		n = pread(get_thread_data()->pack_fd, inbuf, n, from);
 		if (n < 0)
 			die_errno(_("cannot pread pack file"));
 		if (!n)
@@ -1490,7 +1500,7 @@ static void show_pack_info(int stat_only)
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, fix_thin_pack = 0, verify = 0, stat_only = 0;
-	const char *curr_pack, *curr_index;
+	const char *curr_index;
 	const char *index_name = NULL, *pack_name = NULL;
 	const char *keep_name = NULL, *keep_msg = NULL;
 	char *index_name_buf = NULL, *keep_name_buf = NULL;
diff --git a/compat/mingw.c b/compat/mingw.c
index 383cafe..0efc570 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -329,7 +329,42 @@ int mingw_mkdir(const char *path, int mode)
 	return ret;
 }
 
-int mingw_open (const char *filename, int oflags, ...)
+
+/*
+ * Warning: contrary to the specificiation, when ReadFile() is called
+ * with an 'overlapped' argument, it *will* modify the implict position
+ * pointer for the file descriptor.  As a result, it is *not* safe to
+ * intersperse calls to read() and pread() on a single file descriptor.
+ */
+ssize_t mingw_pread(int fd, void *buf, size_t count, off64_t offset)
+{
+	HANDLE hand = (HANDLE)_get_osfhandle(fd);
+	if (hand == INVALID_HANDLE_VALUE) {
+		errno = EBADF;
+		return -1;
+	}
+
+	LARGE_INTEGER offset_value;
+	offset_value.QuadPart = offset;
+
+	DWORD bytes_read = 0;
+	OVERLAPPED overlapped = {0};
+	overlapped.Offset = offset_value.LowPart;
+	overlapped.OffsetHigh = offset_value.HighPart;
+	BOOL result = ReadFile(hand, buf, count, &bytes_read, &overlapped);
+
+	ssize_t ret = bytes_read;
+
+	if (!result && GetLastError() != ERROR_HANDLE_EOF)
+	{
+		errno = err_win_to_posix(GetLastError());
+		ret = -1;
+	}
+
+	return ret;
+}
+
+int mingw_open(const char *filename, int oflags, ...)
 {
 	va_list args;
 	unsigned mode;
diff --git a/compat/mingw.h b/compat/mingw.h
index 08b83fe..377ba50 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -174,6 +174,9 @@ int mingw_unlink(const char *pathname);
 int mingw_rmdir(const char *path);
 #define rmdir mingw_rmdir
 
+ssize_t mingw_pread(int fd, void *buf, size_t count, off64_t offset);
+#define pread mingw_pread
+
 int mingw_open (const char *filename, int oflags, ...);
 #define open mingw_open
 
diff --git a/config.mak.uname b/config.mak.uname
index e8acc39..b405524 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -474,7 +474,6 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 endif
 ifneq (,$(findstring MINGW,$(uname_S)))
 	pathsep = ;
-	NO_PREAD = YesPlease
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
 	NO_POLL = YesPlease
-- 
1.9.0.279.gdc9e3eb
